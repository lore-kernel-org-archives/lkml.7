Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01781C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD0E2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfDYSw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:52:56 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40849 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDYSwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:52:55 -0400
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.12] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BA8EC2000B;
        Thu, 25 Apr 2019 18:52:47 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>, mike.kravetz@oracle.com,
        catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>,
        aou@eecs.berkeley.edu, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/2] riscv: Introduce huge page support for 32/64bit
 kernel
References: <20190409061449.5083-3-alex@ghiti.fr>
 <mhng-93b2f3e1-b7a9-4ae7-b271-fa52fa55b0e0@palmer-si-x1e>
Message-ID: <3eff0e3b-c569-6f4d-d27f-2018492e6a44@ghiti.fr>
Date:   Thu, 25 Apr 2019 14:52:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <mhng-93b2f3e1-b7a9-4ae7-b271-fa52fa55b0e0@palmer-si-x1e>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/19 1:42 PM, Palmer Dabbelt wrote:
> On Mon, 08 Apr 2019 23:14:49 PDT (-0700), alex@ghiti.fr wrote:
>> This patch implements both 4MB huge page support for 32bit kernel
>> and 2MB/1GB huge pages support for 64bit kernel.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>  arch/riscv/Kconfig               |  8 ++++++
>>  arch/riscv/include/asm/hugetlb.h | 18 +++++++++++++
>>  arch/riscv/include/asm/page.h    | 10 ++++++++
>>  arch/riscv/include/asm/pgtable.h |  8 ++++--
>>  arch/riscv/mm/Makefile           |  2 ++
>>  arch/riscv/mm/hugetlbpage.c      | 44 ++++++++++++++++++++++++++++++++
>>  6 files changed, 88 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/riscv/include/asm/hugetlb.h
>>  create mode 100644 arch/riscv/mm/hugetlbpage.c
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index eb56c82d8aa1..a400d4b4e1b3 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -49,6 +49,8 @@ config RISCV
>>      select GENERIC_IRQ_MULTI_HANDLER
>>      select ARCH_HAS_PTE_SPECIAL
>>      select HAVE_EBPF_JIT if 64BIT
>> +    select ARCH_HAS_GIGANTIC_PAGE
>> +    select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>>
>>  config MMU
>>      def_bool y
>> @@ -63,6 +65,12 @@ config PAGE_OFFSET
>>      default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
>>      default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
>>
>> +config ARCH_WANT_GENERAL_HUGETLB
>> +    def_bool y
>> +
>> +config SYS_SUPPORTS_HUGETLBFS
>> +    def_bool y
>> +
>>  config STACKTRACE_SUPPORT
>>      def_bool y
>>
>> diff --git a/arch/riscv/include/asm/hugetlb.h 
>> b/arch/riscv/include/asm/hugetlb.h
>> new file mode 100644
>> index 000000000000..728a5db66597
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/hugetlb.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_RISCV_HUGETLB_H
>> +#define _ASM_RISCV_HUGETLB_H
>> +
>> +#include <asm-generic/hugetlb.h>
>> +#include <asm/page.h>
>> +
>> +static inline int is_hugepage_only_range(struct mm_struct *mm,
>> +                     unsigned long addr,
>> +                     unsigned long len) {
>> +    return 0;
>> +}
>> +
>> +static inline void arch_clear_hugepage_flags(struct page *page)
>> +{
>> +}
>> +
>> +#endif /* _ASM_RISCV_HUGETLB_H */
>> diff --git a/arch/riscv/include/asm/page.h 
>> b/arch/riscv/include/asm/page.h
>> index 2a546a52f02a..4ef2936295aa 100644
>> --- a/arch/riscv/include/asm/page.h
>> +++ b/arch/riscv/include/asm/page.h
>> @@ -24,6 +24,16 @@
>>  #define PAGE_SIZE    (_AC(1, UL) << PAGE_SHIFT)
>>  #define PAGE_MASK    (~(PAGE_SIZE - 1))
>>
>> +#ifdef CONFIG_64BIT
>> +#define HUGE_MAX_HSTATE        2
>> +#else
>> +#define HUGE_MAX_HSTATE        1
>> +#endif
>> +#define HPAGE_SHIFT        PMD_SHIFT
>> +#define HPAGE_SIZE        (_AC(1, UL) << HPAGE_SHIFT)
>> +#define HPAGE_MASK              (~(HPAGE_SIZE - 1))
>> +#define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)
>> +
>>  /*
>>   * PAGE_OFFSET -- the first address of the first page of memory.
>>   * When not using MMU this corresponds to the first free page in
>> diff --git a/arch/riscv/include/asm/pgtable.h 
>> b/arch/riscv/include/asm/pgtable.h
>> index 1141364d990e..f3456fcdff92 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -121,7 +121,6 @@ static inline void pmd_clear(pmd_t *pmdp)
>>      set_pmd(pmdp, __pmd(0));
>>  }
>>
>> -
>>  static inline pgd_t pfn_pgd(unsigned long pfn, pgprot_t prot)
>>  {
>>      return __pgd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
>> @@ -258,6 +257,11 @@ static inline pte_t pte_mkspecial(pte_t pte)
>>      return __pte(pte_val(pte) | _PAGE_SPECIAL);
>>  }
>>
>> +static inline pte_t pte_mkhuge(pte_t pte)
>> +{
>> +    return pte;
>> +}
>> +
>>  /* Modify page protection bits */
>>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>>  {
>> @@ -417,7 +421,7 @@ static inline void pgtable_cache_init(void)
>>  #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
>>
>>  /*
>> - * Task size is 0x40000000000 for RV64 or 0xb800000 for RV32.
>> + * Task size is 0x4000000000 for RV64 or 0xb800000 for RV32.
>>   * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
>>   */
>>  #ifdef CONFIG_64BIT
>> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
>> index b68aac701803..7bbe533d92f5 100644
>> --- a/arch/riscv/mm/Makefile
>> +++ b/arch/riscv/mm/Makefile
>> @@ -9,3 +9,5 @@ obj-y += fault.o
>>  obj-y += extable.o
>>  obj-y += ioremap.o
>>  obj-y += cacheflush.o
>> +
>> +obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
>> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
>> new file mode 100644
>> index 000000000000..0d4747e9d5b5
>> --- /dev/null
>> +++ b/arch/riscv/mm/hugetlbpage.c
>> @@ -0,0 +1,44 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/hugetlb.h>
>> +#include <linux/err.h>
>> +
>> +int pud_huge(pud_t pud)
>> +{
>> +    return pud_present(pud) &&
>> +        (pud_val(pud) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
>> +}
>> +
>> +int pmd_huge(pmd_t pmd)
>> +{
>> +    return pmd_present(pmd) &&
>> +        (pmd_val(pmd) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
>> +}
>> +
>> +static __init int setup_hugepagesz(char *opt)
>> +{
>> +    unsigned long ps = memparse(opt, &opt);
>> +
>> +    if (ps == HPAGE_SIZE) {
>> +        hugetlb_add_hstate(HPAGE_SHIFT - PAGE_SHIFT);
>> +    } else if (IS_ENABLED(CONFIG_64BIT) && ps == PUD_SIZE) {
>> +        hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
>> +    } else {
>> +        hugetlb_bad_size();
>> +        pr_err("hugepagesz: Unsupported page size %lu M\n", ps >> 20);
>> +        return 0;
>> +    }
>> +
>> +    return 1;
>> +}
>> +__setup("hugepagesz=", setup_hugepagesz);
>> +
>> +#ifdef CONFIG_CONTIG_ALLOC
>> +static __init int gigantic_pages_init(void)
>> +{
>> +    /* With CONTIG_ALLOC, we can allocate gigantic pages at runtime */
>> +    if (IS_ENABLED(CONFIG_64BIT) && !size_to_hstate(1UL << PUD_SHIFT))
>> +        hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
>> +    return 0;
>> +}
>> +arch_initcall(gigantic_pages_init);
>> +#endif
>
> I'm getting some build errors when this is applied to 5.1-c6.  I think 
> all I've
> done is turn on hugetlb:

Hi Palmer,

This patchset is based on linux-next where my series "Fix 
free/allocation of runtime gigantic pages"
was merged, it is not yet present in v5.1-rc*.

Thanks,

Alex
>
>    $ diff -u arch/riscv/configs/defconfig defconfig
>    --- arch/riscv/configs/defconfig        2019-04-24 
> 16:23:39.027994174 -0700
>    +++ defconfig   2019-04-25 10:39:34.722544413 -0700
>    @@ -5,6 +5,7 @@
>     CONFIG_CGROUPS=y
>     CONFIG_CGROUP_SCHED=y
>     CONFIG_CFS_BANDWIDTH=y
>    +CONFIG_CGROUP_HUGETLB=y
>     CONFIG_CGROUP_BPF=y
>     CONFIG_NAMESPACES=y
>     CONFIG_USER_NS=y
>    @@ -72,6 +73,7 @@
>     CONFIG_VFAT_FS=y
>     CONFIG_TMPFS=y
>     CONFIG_TMPFS_POSIX_ACL=y
>    +CONFIG_HUGETLBFS=y
>     CONFIG_NFS_FS=y
>     CONFIG_NFS_V4=y
>     CONFIG_NFS_V4_1=y
