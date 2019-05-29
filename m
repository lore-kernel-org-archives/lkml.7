Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D663DC28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B994D238C5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfE2Ped (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:34:33 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:50759 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2Pec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:34:32 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hW0b1-00060s-1p; Wed, 29 May 2019 09:34:31 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hW0b0-0003Kb-7Q; Wed, 29 May 2019 09:34:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>,
        James Morse <james.morse@arm.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
        <20190523003916.20726-4-ebiederm@xmission.com>
        <20190523101702.GG26646@fuggles.cambridge.arm.com>
        <875zq1gnh4.fsf_-_@xmission.com>
        <20190523161509.GE31896@fuggles.cambridge.arm.com>
        <8736l4evkn.fsf@xmission.com>
        <20190524100008.GE3432@fuggles.cambridge.arm.com>
        <87o93rcwee.fsf@xmission.com>
        <20190529151227.GF11154@fuggles.cambridge.arm.com>
Date:   Wed, 29 May 2019 10:34:25 -0500
In-Reply-To: <20190529151227.GF11154@fuggles.cambridge.arm.com> (Will Deacon's
        message of "Wed, 29 May 2019 16:12:27 +0100")
Message-ID: <87muj51dha.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hW0b0-0003Kb-7Q;;;mid=<87muj51dha.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+JWnDMTAC4U8y81mkWSmRaxfqYNr09zag=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [REVIEW][PATCHv2 03/26] signal/arm64: Use force_sig not force_sig_fault for SIGKILL
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon <will.deacon@arm.com> writes:

> On Fri, May 24, 2019 at 05:36:41PM -0500, Eric W. Biederman wrote:
>> Will Deacon <will.deacon@arm.com> writes:
>> 
>> > On Thu, May 23, 2019 at 03:59:20PM -0500, Eric W. Biederman wrote:
>> >> Will Deacon <will.deacon@arm.com> writes:
>> >> 
>> >> > On Thu, May 23, 2019 at 11:11:19AM -0500, Eric W. Biederman wrote:
>> >> >> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> >> >> index ade32046f3fe..e45d5b440fb1 100644
>> >> >> --- a/arch/arm64/kernel/traps.c
>> >> >> +++ b/arch/arm64/kernel/traps.c
>> >> >> @@ -256,7 +256,10 @@ void arm64_force_sig_fault(int signo, int code, void __user *addr,
>> >> >>  			   const char *str)
>> >> >>  {
>> >> >>  	arm64_show_signal(signo, str);
>> >> >> -	force_sig_fault(signo, code, addr, current);
>> >> >> +	if (signo == SIGKILL)
>> >> >> +		force_sig(SIGKILL, current);
>> >> >> +	else
>> >> >> +		force_sig_fault(signo, code, addr, current);
>> >> >>  }
>> >> >
>> >> > Acked-by: Will Deacon <will.deacon@arm.com>
>> >> >
>> >> > Are you planning to send this series on, or would you like me to pick this
>> >> > into the arm64 tree?
>> >> 
>> >> I am planning on taking this through siginfo tree, unless it causes
>> >> problems.
>> >
>> > Okey doke, it would just be nice to see this patch land in 5.2, that's
>> > all.
>> 
>> As this does not appear to have any real world consequences I am aiming
>> at 5.3.  If someone else would like to take it and feed it to Linus
>> sooner I won't object.
>
> Thanks. I've picked this patch up as part of the arm64 fixes I plan to send
> for -rc3.

Sounds good.

We might have a trivial conflict between our branches as I am also
including this in my for-next branch, as I have further patches that go
on to remove the task argument from force_sig and force_sig_fault.

But I don't think it is anything to worry about.

Eric


