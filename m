Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91293C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A38C21BE3
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387965AbfHGM60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 08:58:26 -0400
Received: from foss.arm.com ([217.140.110.172]:47950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387476AbfHGM6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 08:58:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9E2B28;
        Wed,  7 Aug 2019 05:58:24 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 493D93F575;
        Wed,  7 Aug 2019 05:58:22 -0700 (PDT)
Subject: Re: [PATCH v10 20/22] x86: mm: Convert dump_pagetables to use
 walk_page_range
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
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
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20190731154603.41797-1-steven.price@arm.com>
 <20190731154603.41797-21-steven.price@arm.com>
 <20190806165823.3f735b45a7c4163aca20a767@linux-foundation.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <066fa4ca-5a46-ba86-607f-9c3e16f79cde@arm.com>
Date:   Wed, 7 Aug 2019 13:58:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806165823.3f735b45a7c4163aca20a767@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2019 00:58, Andrew Morton wrote:
> On Wed, 31 Jul 2019 16:46:01 +0100 Steven Price <steven.price@arm.com> wrote:
> 
>> Make use of the new functionality in walk_page_range to remove the
>> arch page walking code and use the generic code to walk the page tables.
>>
>> The effective permissions are passed down the chain using new fields
>> in struct pg_state.
>>
>> The KASAN optimisation is implemented by including test_p?d callbacks
>> which can decide to skip an entire tree of entries
>>
>> ...
>>
>> +static const struct ptdump_range ptdump_ranges[] = {
>> +#ifdef CONFIG_X86_64
>>  
>> -#define pgd_large(a) (pgtable_l5_enabled() ? pgd_large(a) : p4d_large(__p4d(pgd_val(a))))
>> -#define pgd_none(a)  (pgtable_l5_enabled() ? pgd_none(a) : p4d_none(__p4d(pgd_val(a))))
>> +#define normalize_addr_shift (64 - (__VIRTUAL_MASK_SHIFT + 1))
>> +#define normalize_addr(u) ((signed long)(u << normalize_addr_shift) \
>> +				>> normalize_addr_shift)
>>  
>> -static inline bool is_hypervisor_range(int idx)
>> -{
>> -#ifdef CONFIG_X86_64
>> -	/*
>> -	 * A hole in the beginning of kernel address space reserved
>> -	 * for a hypervisor.
>> -	 */
>> -	return	(idx >= pgd_index(GUARD_HOLE_BASE_ADDR)) &&
>> -		(idx <  pgd_index(GUARD_HOLE_END_ADDR));
>> +	{0, PTRS_PER_PGD * PGD_LEVEL_MULT / 2},
>> +	{normalize_addr(PTRS_PER_PGD * PGD_LEVEL_MULT / 2), ~0UL},
> 
> This blows up because PGD_LEVEL_MULT is sometimes not a constant.
> 
> x86_64 allmodconfig:
> 
> In file included from ./arch/x86/include/asm/pgtable_types.h:249:0,
>                  from ./arch/x86/include/asm/paravirt_types.h:45,
>                  from ./arch/x86/include/asm/ptrace.h:94,
>                  from ./arch/x86/include/asm/math_emu.h:5,
>                  from ./arch/x86/include/asm/processor.h:12,
>                  from ./arch/x86/include/asm/cpufeature.h:5,
>                  from ./arch/x86/include/asm/thread_info.h:53,
>                  from ./include/linux/thread_info.h:38,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/spinlock.h:51,
>                  from ./include/linux/wait.h:9,
>                  from ./include/linux/wait_bit.h:8,
>                  from ./include/linux/fs.h:6,
>                  from ./include/linux/debugfs.h:15,
>                  from arch/x86/mm/dump_pagetables.c:11:
> ./arch/x86/include/asm/pgtable_64_types.h:56:22: error: initializer element is not constant
>  #define PTRS_PER_PGD 512
>                       ^

This is very unhelpful of GCC - it's actually PTRS_PER_P4D which isn't
constant!

> arch/x86/mm/dump_pagetables.c:363:6: note: in expansion of macro ‘PTRS_PER_PGD’
>   {0, PTRS_PER_PGD * PGD_LEVEL_MULT / 2},
>       ^~~~~~~~~~~~
> ./arch/x86/include/asm/pgtable_64_types.h:56:22: note: (near initialization for ‘ptdump_ranges[0].end’)
>  #define PTRS_PER_PGD 512
>                       ^
> arch/x86/mm/dump_pagetables.c:363:6: note: in expansion of macro ‘PTRS_PER_PGD’
>   {0, PTRS_PER_PGD * PGD_LEVEL_MULT / 2},
>       ^~~~~~~~~~~~
> arch/x86/mm/dump_pagetables.c:360:27: error: initializer element is not constant
>  #define normalize_addr(u) ((signed long)(u << normalize_addr_shift) \
>                            ^
> arch/x86/mm/dump_pagetables.c:364:3: note: in expansion of macro ‘normalize_addr’
>   {normalize_addr(PTRS_PER_PGD * PGD_LEVEL_MULT / 2), ~0UL},
>    ^~~~~~~~~~~~~~
> arch/x86/mm/dump_pagetables.c:360:27: note: (near initialization for ‘ptdump_ranges[1].start’)
>  #define normalize_addr(u) ((signed long)(u << normalize_addr_shift) \
>                            ^
> arch/x86/mm/dump_pagetables.c:364:3: note: in expansion of macro ‘normalize_addr’
>   {normalize_addr(PTRS_PER_PGD * PGD_LEVEL_MULT / 2), ~0UL},
> 
> I don't know what to do about this so I'll drop the series.

My best solution to this is to simply make ptdump_ranges dynamic (see
below). But there are other problems with this series (thanks for
spotting them), so I'll send out another version later.

Thanks,

Steve

----8<-----
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 998c7f46763c..8fc129ff985e 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -353,7 +353,10 @@ static void note_page(struct ptdump_state *pt_st,
unsigned long addr, int level,
        }
 }

-static const struct ptdump_range ptdump_ranges[] = {
+static void ptdump_walk_pgd_level_core(struct seq_file *m, struct
mm_struct *mm,
+                                      bool checkwx, bool dmesg)
+{
+       const struct ptdump_range ptdump_ranges[] = {
 #ifdef CONFIG_X86_64

 #define normalize_addr_shift (64 - (__VIRTUAL_MASK_SHIFT + 1))
@@ -368,9 +371,6 @@ static const struct ptdump_range ptdump_ranges[] = {
        {0, 0}
 };

-static void ptdump_walk_pgd_level_core(struct seq_file *m, struct
mm_struct *mm,
-                                      bool checkwx, bool dmesg)
-{
        struct pg_state st = {
                .ptdump = {
                        .note_page      = note_page,
