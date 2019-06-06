Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D95C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7AE2070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfFFCeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:34:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39924 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbfFFCeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:34:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4CC980D;
        Wed,  5 Jun 2019 19:34:15 -0700 (PDT)
Received: from [10.162.43.122] (p8cg001049571a15.blr.arm.com [10.162.43.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0AA13F690;
        Wed,  5 Jun 2019 19:34:05 -0700 (PDT)
Subject: Re: [RFC V2] mm: Generalize notify_page_fault()
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Konovalov <andreyknvl@google.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <1559630046-12940-1-git-send-email-anshuman.khandual@arm.com>
 <87sgsomg91.fsf@concordia.ellerman.id.au>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <6fdf7c1f-822b-22ec-f48c-cc0efc850644@arm.com>
Date:   Thu, 6 Jun 2019 08:04:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87sgsomg91.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2019 04:49 PM, Michael Ellerman wrote:
> Anshuman Khandual <anshuman.khandual@arm.com> writes:
>> Similar notify_page_fault() definitions are being used by architectures
>> duplicating much of the same code. This attempts to unify them into a
>> single implementation, generalize it and then move it to a common place.
>> kprobes_built_in() can detect CONFIG_KPROBES, hence notify_page_fault()
>> need not be wrapped again within CONFIG_KPROBES. Trap number argument can
>> now contain upto an 'unsigned int' accommodating all possible platforms.
> ...
>> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
>> index 58f69fa..1bc3b18 100644
>> --- a/arch/arm/mm/fault.c
>> +++ b/arch/arm/mm/fault.c
>> @@ -30,28 +30,6 @@
>>  
>>  #ifdef CONFIG_MMU
>>  
>> -#ifdef CONFIG_KPROBES
>> -static inline int notify_page_fault(struct pt_regs *regs, unsigned int fsr)
>> -{
>> -	int ret = 0;
>> -
>> -	if (!user_mode(regs)) {
>> -		/* kprobe_running() needs smp_processor_id() */
>> -		preempt_disable();
>> -		if (kprobe_running() && kprobe_fault_handler(regs, fsr))
>> -			ret = 1;
>> -		preempt_enable();
>> -	}
>> -
>> -	return ret;
>> -}
>> -#else
> 
> You've changed several of the architectures from something like above,
> where it disables preemption around the call into the below:
> 
>> +int __kprobes notify_page_fault(struct pt_regs *regs, unsigned int trap)
>> +{
>> +	int ret = 0;
>> +
>> +	/*
>> +	 * To be potentially processing a kprobe fault and to be allowed
>> +	 * to call kprobe_running(), we have to be non-preemptible.
>> +	 */
>> +	if (kprobes_built_in() && !preemptible() && !user_mode(regs)) {
>> +		if (kprobe_running() && kprobe_fault_handler(regs, trap))
>> +			ret = 1;
>> +	}
>> +	return ret;
>> +}
> 
> Which skips everything if we're preemptible. Is that an equivalent

Right.

> change? If so can you please explain why in more detail.

It is probably not an equivalent change. The following explanation is extracted from
RFC V1 discussions (https://patchwork.kernel.org/patch/10968273/). Will explain the
rational for this behavior change in the commit message next time around.

----------------------------
a980c0ef9f6d ("x86/kprobes: Refactor kprobes_fault() like kprobe_exceptions_notify()")
b506a9d08bae ("x86: code clarification patch to Kprobes arch code")

In particular the later one (b506a9d08bae). It explains how the invoking context
in itself should be non-preemptible for the kprobes processing context irrespective
of whether kprobe_running() or perhaps smp_processor_id() is safe or not. Hence it
does not make much sense to continue when original invoking context is preemptible.
Instead just bail out earlier. This seems to be making more sense than preempt
disable-enable pair. If there are no concerns about this change from other platforms,
I will change the preemption behavior in proposed generic function next time around.
----------------------------

Do you see any concern changing preempt behavior in the x86 way ?

> 
> Also why not have it return bool?

Just that all architectures (except powerpc) had 'int' as return type. But we can
change that to 'bool'.
