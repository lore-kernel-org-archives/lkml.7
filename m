Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A67DC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A922589C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfE3MBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:01:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34990 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbfE3MBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:01:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3F10374;
        Thu, 30 May 2019 05:01:09 -0700 (PDT)
Received: from [10.162.40.143] (p8cg001049571a15.blr.arm.com [10.162.40.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2F953F5AF;
        Thu, 30 May 2019 05:01:02 -0700 (PDT)
Subject: Re: [RFC] mm: Generalize notify_page_fault()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Konovalov <andreyknvl@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>
References: <1559195713-6956-1-git-send-email-anshuman.khandual@arm.com>
 <20190530110639.GC23461@bombadil.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <4f9a610d-e856-60f6-4467-09e9c3836771@arm.com>
Date:   Thu, 30 May 2019 17:31:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190530110639.GC23461@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/30/2019 04:36 PM, Matthew Wilcox wrote:
> On Thu, May 30, 2019 at 11:25:13AM +0530, Anshuman Khandual wrote:
>> Similar notify_page_fault() definitions are being used by architectures
>> duplicating much of the same code. This attempts to unify them into a
>> single implementation, generalize it and then move it to a common place.
>> kprobes_built_in() can detect CONFIG_KPROBES, hence notify_page_fault()
>> must not be wrapped again within CONFIG_KPROBES. Trap number argument can
> 
> This is a funny quirk of the English language.  "must not" means "is not
> allowed to be", not "does not have to be".

You are right. Noted for future. Thanks !

> 
>> @@ -141,6 +142,19 @@ static int __init init_zero_pfn(void)
>>  core_initcall(init_zero_pfn);
>>  
>>  
>> +int __kprobes notify_page_fault(struct pt_regs *regs, unsigned int trap)
>> +{
>> +	int ret = 0;
>> +
>> +	if (kprobes_built_in() && !user_mode(regs)) {
>> +		preempt_disable();
>> +		if (kprobe_running() && kprobe_fault_handler(regs, trap))
>> +			ret = 1;
>> +		preempt_enable();
>> +	}
>> +	return ret;
>> +}
>> +
>>  #if defined(SPLIT_RSS_COUNTING)
> 
> Comparing this to the canonical implementation (ie x86), it looks similar.
> 
> static nokprobe_inline int kprobes_fault(struct pt_regs *regs)
> {
>         if (!kprobes_built_in())
>                 return 0;
>         if (user_mode(regs))
>                 return 0;
>         /*
>          * To be potentially processing a kprobe fault and to be allowed to call
>          * kprobe_running(), we have to be non-preemptible.
>          */
>         if (preemptible())
>                 return 0;
>         if (!kprobe_running())
>                 return 0;
>         return kprobe_fault_handler(regs, X86_TRAP_PF);
> }
> 
> The two handle preemption differently.  Why is x86 wrong and this one
> correct?

Here it expects context to be already non-preemptible where as the proposed
generic function makes it non-preemptible with a preempt_[disable|enable]()
pair for the required code section, irrespective of it's present state. Is
not this better ?
