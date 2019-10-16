Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A76CFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B89620872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389956AbfJPJfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:35:18 -0400
Received: from foss.arm.com ([217.140.110.172]:33898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbfJPJfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:35:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9CFA142F;
        Wed, 16 Oct 2019 02:35:17 -0700 (PDT)
Received: from [10.1.196.105] (unknown [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8E053F6C4;
        Wed, 16 Oct 2019 02:35:14 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: entry.S: Do not preempt from IRQ before all
 cpufeatures are enabled
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>
References: <20191015172544.186627-1-james.morse@arm.com>
 <20191015200755.aavtyhq56lewazah@willie-the-truck>
From:   James Morse <james.morse@arm.com>
Message-ID: <e6d58ed6-2d5e-8c78-c824-d0d5abff8394@arm.com>
Date:   Wed, 16 Oct 2019 10:35:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015200755.aavtyhq56lewazah@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 15/10/2019 21:07, Will Deacon wrote:
> Patch looks good apart from one thing...
> 
> On Tue, Oct 15, 2019 at 06:25:44PM +0100, James Morse wrote:
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 2c2e56bd8913..67a1d86981a9 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -223,6 +223,7 @@ extern long schedule_timeout_uninterruptible(long timeout);
>>  extern long schedule_timeout_idle(long timeout);
>>  asmlinkage void schedule(void);
>>  extern void schedule_preempt_disabled(void);
>> +asmlinkage void preempt_schedule_irq(void);
> 
> I don't understand the need for this hunk, since we're only calling the
> function from C now. Please could you explain?

(A prototype is needed to make the thing build[0], but)

you mean the asmlinkage?

The definition in kernel/sched/core.c has asmlinkage. It does nothing on arm64, but if
another architecture does add a C call, and uses asmlinkage to tinker with the calling
convention, it would need to be here so callers use the correct convention.

e.g. for X86_32 defines asmlinkage in arch/x86/include/asm/linkage.h:
| #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))

This forces all arguments out of registers and onto the stack [1].

Without this annotation, asm->preempt_schedule_irq() callers would put arguments on the
stack, but C->preempt_schedule_irq() callers would use whatever the C->C calling
convention is, which might not match.

schedule() further up the hunk does the same.

I agree it doesn't matter today, but omitting it would be a bug for the next user to debug!


Thanks,

James

[0] Without that hunk,
../arch/arm64/kernel/process.c: In function ‘arm64_preempt_schedule_irq’:
../arch/arm64/kernel/process.c:650:3: error: implicit declaration of function
‘preempt_schedule_irq’; did you mean ‘preempt_schedule’?
[-Werror=implicit-function-declaration]
   preempt_schedule_irq();
   ^~~~~~~~~~~~~~~~~~~~
   preempt_schedule
cc1: some warnings being treated as errors
make[3]: *** [../scripts/Makefile.build:266: arch/arm64/kernel/process.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [../scripts/Makefile.build:509: arch/arm64/kernel] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/home/morse/kernel/linux/Makefile:1649: arch/arm64] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [../Makefile:179: sub-make] Error 2

[1] https://gcc.gnu.org/onlinedocs/gcc/x86-Function-Attributes.html
