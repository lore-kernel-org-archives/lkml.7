Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D304C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698FC21911
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfGXQgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:36:50 -0400
Received: from foss.arm.com ([217.140.110.172]:43732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfGXQgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:36:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3690E28;
        Wed, 24 Jul 2019 09:36:49 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C337C3F71F;
        Wed, 24 Jul 2019 09:36:46 -0700 (PDT)
Subject: Re: [PATCH v9 19/21] mm: Add generic ptdump
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20190722154210.42799-1-steven.price@arm.com>
 <20190722154210.42799-20-steven.price@arm.com>
 <20190723095747.GB8085@lakrids.cambridge.arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <ee707646-0196-63bb-45cc-6b949ae9530e@arm.com>
Date:   Wed, 24 Jul 2019 17:36:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723095747.GB8085@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2019 10:57, Mark Rutland wrote:
> On Mon, Jul 22, 2019 at 04:42:08PM +0100, Steven Price wrote:
>> Add a generic version of page table dumping that architectures can
>> opt-in to
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
> 
> [...]
> 
>> +#ifdef CONFIG_KASAN
>> +/*
>> + * This is an optimization for KASAN=y case. Since all kasan page tables
>> + * eventually point to the kasan_early_shadow_page we could call note_page()
>> + * right away without walking through lower level page tables. This saves
>> + * us dozens of seconds (minutes for 5-level config) while checking for
>> + * W+X mapping or reading kernel_page_tables debugfs file.
>> + */
>> +static inline bool kasan_page_table(struct ptdump_state *st, void *pt,
>> +				    unsigned long addr)
>> +{
>> +	if (__pa(pt) == __pa(kasan_early_shadow_pmd) ||
>> +#ifdef CONFIG_X86
>> +	    (pgtable_l5_enabled() &&
>> +			__pa(pt) == __pa(kasan_early_shadow_p4d)) ||
>> +#endif
>> +	    __pa(pt) == __pa(kasan_early_shadow_pud)) {
>> +		st->note_page(st, addr, 5, pte_val(kasan_early_shadow_pte[0]));
>> +		return true;
>> +	}
>> +	return false;
> 
> Having you tried this with CONFIG_DEBUG_VIRTUAL?
> 
> The kasan_early_shadow_pmd is a kernel object rather than a linear map
> object, so you should use __pa_symbol for that.

Thanks for pointing that out - it is indeed broken on arm64. This was
moved from x86 where CONFIG_DEBUG_VIRTUAL doesn't seem to pick this up.
There is actually a problem here that 'pt' might not be in the linear
map (so __pa(pt) barfs on arm64 as well as kasan_early_shadow_p?d).

It looks like having the comparisons of the form "pt ==
lm_alias(kasan_early_shadow_p?d)" is probably best.

> It's a bit horrid to have to test multiple levels in one function; can't
> we check the relevant level inline in each of the test_p?d funcs?
> 
> They're optional anyway, so they only need to be defined for
> CONFIG_KASAN.

Good point - removing the test_p?d callbacks when !CONFIG_KASAN
simplifies the code.

Thanks,

Steve
