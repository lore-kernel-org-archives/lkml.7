Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66304C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFE420644
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfD3RJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:09:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50578 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3RJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:09:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B845374;
        Tue, 30 Apr 2019 10:09:55 -0700 (PDT)
Received: from [10.1.196.42] (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66A103F5C1;
        Tue, 30 Apr 2019 10:09:52 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, X86 ML <x86@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
To:     Andy Lutomirski <luto@kernel.org>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-4-sudeep.holla@arm.com>
 <CALCETrXEebRqX0W8MuS0SeaMDpEO5KdS3k7id279hZgHrmc8yA@mail.gmail.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <a1de9e18-95f6-c9a4-0d60-9f61b5a2f108@arm.com>
Date:   Tue, 30 Apr 2019 18:09:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALCETrXEebRqX0W8MuS0SeaMDpEO5KdS3k7id279hZgHrmc8yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/04/2019 17:46, Andy Lutomirski wrote:
> On Mon, Mar 18, 2019 at 3:49 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>> Now that we have a new hook ptrace_syscall_enter that can be called from
>> syscall entry code and it handles PTRACE_SYSEMU in generic code, we
>> can do some cleanup using the same in syscall_trace_enter.
>>
>> Further the extra logic to find single stepping PTRACE_SYSEMU_SINGLESTEP
>> in syscall_slow_exit_work seems unnecessary. Let's remove the same.
>>
> 
> Unless the patch set contains a selftest that exercises all the
> interesting cases here, NAK.  To be clear, there needs to be a test
> that passes on an unmodified kernel and still passes on a patched
> kernel.  And that test case needs to *fail* if, for example, you force
> "emulated" to either true or false rather than reading out the actual
> value.
> 

Tested using tools/testing/selftests/x86/ptrace_syscall.c

Also v3 doesn't change any logic or additional call to new function as
in v2. It's just simple cleanup as suggested by Oleg.

-- 
Regards,
Sudeep
