Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73047C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E5420863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbfEWOxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:53:18 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:56239 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730672AbfEWOxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:53:16 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTp5m-0005Tv-Qv; Thu, 23 May 2019 08:53:14 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTp5l-0004Kl-Ui; Thu, 23 May 2019 08:53:14 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-arch\@vger.kernel.org" <linux-arch@vger.kernel.org>,
        James Morse <James.Morse@arm.com>,
        Will Deacon <Will.Deacon@arm.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
        <20190523003916.20726-4-ebiederm@xmission.com>
        <20190523102101.GW28398@e103592.cambridge.arm.com>
Date:   Thu, 23 May 2019 09:53:06 -0500
In-Reply-To: <20190523102101.GW28398@e103592.cambridge.arm.com> (Dave Martin's
        message of "Thu, 23 May 2019 11:21:04 +0100")
Message-ID: <87r28pgr3h.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hTp5l-0004Kl-Ui;;;mid=<87r28pgr3h.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+THGiZIT6lV3EfwGpihTf9JNTesyMd/TY=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [REVIEW][PATCH 03/26] signal/arm64: Use force_sig not force_sig_fault for SIGKILL
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Martin <Dave.Martin@arm.com> writes:

> On Thu, May 23, 2019 at 01:38:53AM +0100, Eric W. Biederman wrote:
>> It really only matters to debuggers but the SIGKILL does not have any
>> si_codes that use the fault member of the siginfo union.  Correct this
>> the simple way and call force_sig instead of force_sig_fault when the
>> signal is SIGKILL.
>
> I haven't fully understood the context for this, but why does it matter
> what's in siginfo for SIGKILL?  My understanding is that userspace
> (including ptrace) never gets to see it anyway for the SIGKILL case.

Yes.  In practice I think it would take tracing or something very
exotic to notice anything going wrong because the task will be killed.

> Here it feels like SIGKILL is logically a synchronous, thread-targeted
> fault: we must ensure that no subsequent insn in current executes (just
> like other fault signal).  In this case, I thought we fall back to
> SIGKILL not because there is no fault, but because we failed to
> properly diagnose or report the type of fault that occurred.
>
> So maybe handling it consistently with other faults signals makes
> sense.  The fact that delivery of this signal destroys the process
> before anyone can look at the resulting siginfo feels like a
> side-effect rather than something obviously wrong.
>
> The siginfo is potentially useful diagnostic information, that we could
> subsequently provide a means to access post-mortem.
>
> I just dived in on this single patch, so I may be missing something more
> fundamental, or just being pedantic...

Not really.  I was working on another cleanup and this usage of SIGKILL
came up.

A synchronous thread synchronous fault gets us as far as the forc_sig
family of functions.  That only leaves the question of which union
member in struct siginfo we are using.  The union members are _kill,
_fault, _timer, _rt, _sigchld, _sigfault, _sigpoll, and _sigsys.

As it has prove quite error prone for people to fill out struct siginfo
in the past by hand, I have provided a couple of helper functions for
the common cases that come up such as: force_sig_fault,
force_sig_mceerr, force_sig_bnderr, force_sig_pkuerr.  Each of those
helper functions takes the information needed to fill out the union
member of struct siginfo that kind of fault corresponds to.

For the SIGKILL case the only si_code I see being passed SI_KERNEL.
The SI_KERNEL si_code corresponds to the _kill union member while
force_sig_fault fills in fields for the _fault union member.

Because of the mismatch of which union member SIGKILL should be using
and the union member force_sig_fault applies alarm bells ring in my head
when I read the current arm64 kernel code.  Somewhat doubly so because
the other fields in passed to force_sig_fault appear to be somewhat
random when SIGKILL is the signal.

So I figured let's preserve the usage of SIGKILL as a synchronous
exception.  That seems legitimate and other folks do that as well but
let's use force_sig instead of force_sig_fault instead.  I don't know if
userspace will notice but at the very least we won't be providing a bad
example for other kernel code to follow and we won't wind up be making
assumptions that are true today and false tomorrow when some
implementation detail changes.

For imformation on what signals and si_codes correspond to which
union members you can look at siginfo_layout.  That function
is the keeper of the magic decoder key.  Currently the only two
si_codes defined for SIGKILL are SI_KERNEL and SI_USER both of which
correspond to a _kill union member.

Eric


> Cheers
> ---Dave
>
>> Cc: stable@vger.kernel.org
>> Cc: Dave Martin <Dave.Martin@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Fixes: af40ff687bc9 ("arm64: signal: Ensure si_code is valid for all fault signals")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  arch/arm64/kernel/traps.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index ade32046f3fe..0feb17bdcaa0 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -282,6 +282,11 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
>>  		current->thread.fault_address = 0;
>>  		current->thread.fault_code = err;
>>  
>> +		if (signo == SIGKILL) {
>> +			arm64_show_signal(signo, str);
>> +			force_sig(signo, current);
>> +			return;
>> +		}
>>  		arm64_force_sig_fault(signo, sicode, addr, str);
>>  	} else {
>>  		die(str, regs, err);
>> -- 
>> 2.21.0
>> 
