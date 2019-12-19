Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4F3C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AECD227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="gnqSHSFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfLSQmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:42:31 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:57027 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfLSQmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576773750;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EPO5fv2WKrvJSWAuNcqMHWjJKNmB6sQ6aa41Q3HBU6w=;
  b=gnqSHSFHoRvKOQl4k33u8eNpFnndIu145xD9E0JwoA1+mrixVBJ8n9qD
   7MQuVpktqECJhrr+vffjJZfwcUN5gnAMFxa1PN3fbrycatODCP8I10rFc
   nVRpCOp9OFxt1kfuxhRB6My3F0bBfPl62MFKODgA2aN3eEKefHMhW0Vtq
   g=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=sergey.dyasli@citrix.com; spf=Pass smtp.mailfrom=sergey.dyasli@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  sergey.dyasli@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
  sergey.dyasli@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: PhxFWajh3PHyW3lkt6fACcwqqJ602mwhtS+p5T33XXGBBbipDbCHgbWVCb4dMrqevx7L7l9slv
 JwdLX+qZU/uK0xiu+JN5mGs4knLuv/JznuGQkjCqFJIyZRcA2BFo6bocuxrBCVk+/qofy0gNjb
 Sd9IQDfQE91HQCEMnu46ZcHvmVzf1n5FbtJY89fMs+vVHHSjgJJ1B5++ssk1frSvmcDiwZyLoQ
 kIymEsXUD+mxZMHYOXjZFz44hYmfI8l0C3QoYQDlqadUJOh7rgm+Snsjc4M6FPmWpXlJ+JvysO
 E9Y=
X-SBRS: 2.7
X-MesageID: 9933639
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,332,1571716800"; 
   d="scan'208";a="9933639"
Subject: Re: [RFC PATCH 1/3] x86/xen: add basic KASAN support for PV kernel
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        <xen-devel@lists.xen.org>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        "sergey.dyasli@citrix.com >> Sergey Dyasli" 
        <sergey.dyasli@citrix.com>
References: <20191217140804.27364-1-sergey.dyasli@citrix.com>
 <20191217140804.27364-2-sergey.dyasli@citrix.com>
 <934a2950-9079-138d-5476-5eabd84dfec5@suse.com>
From:   Sergey Dyasli <sergey.dyasli@citrix.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sergey.dyasli@citrix.com; keydata=
 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
Message-ID: <0844c8f9-3dd3-2313-5c23-bd967b218af2@citrix.com>
Date:   Thu, 19 Dec 2019 16:42:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <934a2950-9079-138d-5476-5eabd84dfec5@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2019 09:24, Jürgen Groß wrote:
> On 17.12.19 15:08, Sergey Dyasli wrote:
>> This enables to use Outline instrumentation for Xen PV kernels.
>>
>> KASAN_INLINE and KASAN_VMALLOC options currently lead to boot crashes
>> and hence disabled.
>>
>> Rough edges in the patch are marked with XXX.
>>
>> Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
>> ---
>>   arch/x86/mm/init.c          | 14 ++++++++++++++
>>   arch/x86/mm/kasan_init_64.c | 28 ++++++++++++++++++++++++++++
>>   arch/x86/xen/Makefile       |  7 +++++++
>>   arch/x86/xen/enlighten_pv.c |  3 +++
>>   arch/x86/xen/mmu_pv.c       | 13 +++++++++++--
>>   arch/x86/xen/multicalls.c   | 10 ++++++++++
>>   drivers/xen/Makefile        |  2 ++
>>   kernel/Makefile             |  2 ++
>>   lib/Kconfig.kasan           |  3 ++-
>>   9 files changed, 79 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
>> index e7bb483557c9..0c98a45eec6c 100644
>> --- a/arch/x86/mm/init.c
>> +++ b/arch/x86/mm/init.c
>> @@ -8,6 +8,8 @@
>>   #include <linux/kmemleak.h>
>>   #include <linux/sched/task.h>
>>   +#include <xen/xen.h>
>> +
>>   #include <asm/set_memory.h>
>>   #include <asm/e820/api.h>
>>   #include <asm/init.h>
>> @@ -835,6 +837,18 @@ void free_kernel_image_pages(const char *what, void *begin, void *end)
>>       unsigned long end_ul = (unsigned long)end;
>>       unsigned long len_pages = (end_ul - begin_ul) >> PAGE_SHIFT;
>>   +    /*
>> +     * XXX: skip this for now. Otherwise it leads to:
>> +     *
>> +     * (XEN) mm.c:2713:d157v0 Bad type (saw 8c00000000000001 != exp e000000000000000) for mfn 36f40 (pfn 02f40)
>> +     * (XEN) mm.c:1043:d157v0 Could not get page type PGT_writable_page
>> +     * (XEN) mm.c:1096:d157v0 Error getting mfn 36f40 (pfn 02f40) from L1 entry 8010000036f40067 for l1e_owner d157, pg_owner d157
>> +     *
>> +     * and further #PF error: [PROT] [WRITE] in the kernel.
>> +     */
>> +    if (xen_pv_domain() && IS_ENABLED(CONFIG_KASAN))
>> +        return;
>> +
> 
> I guess this is related to freeing some kasan page tables without
> unpinning them?

Your guess was correct. Turned out that early_top_pgt which I pinned and made RO
is located in .init section and that was causing issues. Unpinning it and making
RW again right after kasan_init() switches to use init_top_pgt seem to fix this
issue.

> 
>>       free_init_pages(what, begin_ul, end_ul);
>>         /*
>> diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
>> index cf5bc37c90ac..caee2022f8b0 100644
>> --- a/arch/x86/mm/kasan_init_64.c
>> +++ b/arch/x86/mm/kasan_init_64.c
>> @@ -13,6 +13,8 @@
>>   #include <linux/sched/task.h>
>>   #include <linux/vmalloc.h>
>>   +#include <xen/xen.h>
>> +
>>   #include <asm/e820/types.h>
>>   #include <asm/pgalloc.h>
>>   #include <asm/tlbflush.h>
>> @@ -20,6 +22,9 @@
>>   #include <asm/pgtable.h>
>>   #include <asm/cpu_entry_area.h>
>>   +#include <xen/interface/xen.h>
>> +#include <asm/xen/hypervisor.h>
>> +
>>   extern struct range pfn_mapped[E820_MAX_ENTRIES];
>>     static p4d_t tmp_p4d_table[MAX_PTRS_PER_P4D] __initdata __aligned(PAGE_SIZE);
>> @@ -305,6 +310,12 @@ static struct notifier_block kasan_die_notifier = {
>>   };
>>   #endif
>>   +#ifdef CONFIG_XEN
>> +/* XXX: this should go to some header */
>> +void __init set_page_prot(void *addr, pgprot_t prot);
>> +void __init pin_pagetable_pfn(unsigned cmd, unsigned long pfn);
>> +#endif
>> +
> 
> Instead of exporting those, why don't you ...
> 
>>   void __init kasan_early_init(void)
>>   {
>>       int i;
>> @@ -332,6 +343,16 @@ void __init kasan_early_init(void)
>>       for (i = 0; pgtable_l5_enabled() && i < PTRS_PER_P4D; i++)
>>           kasan_early_shadow_p4d[i] = __p4d(p4d_val);
>>   +    if (xen_pv_domain()) {
>> +        /* PV page tables must have PAGE_KERNEL_RO */
>> +        set_page_prot(kasan_early_shadow_pud, PAGE_KERNEL_RO);
>> +        set_page_prot(kasan_early_shadow_pmd, PAGE_KERNEL_RO);
>> +        set_page_prot(kasan_early_shadow_pte, PAGE_KERNEL_RO);
> 
> add a function doing that to mmu_pv.c (e.g. xen_pv_kasan_early_init())?

Sounds like a good suggestion, but new functions still need some header for
declarations (xen/xen.h?). And kasan_map_early_shadow() will need exporting
through kasan.h as well, but that's probably not an issue.

> 
>> +
>> +        /* Add mappings to the initial PV page tables */
>> +        kasan_map_early_shadow((pgd_t *)xen_start_info->pt_base);
>> +    }
>> +
>>       kasan_map_early_shadow(early_top_pgt);
>>       kasan_map_early_shadow(init_top_pgt);
>>   }
>> @@ -369,6 +390,13 @@ void __init kasan_init(void)
>>                   __pgd(__pa(tmp_p4d_table) | _KERNPG_TABLE));
>>       }
>>   +    if (xen_pv_domain()) {
>> +        /* PV page tables must be pinned */
>> +        set_page_prot(early_top_pgt, PAGE_KERNEL_RO);
>> +        pin_pagetable_pfn(MMUEXT_PIN_L4_TABLE,
>> +                  PFN_DOWN(__pa_symbol(early_top_pgt)));
> 
> and another one like xen_pv_kasan_init() here.

Now there needs to be a 3rd function to unpin early_top_pgt.

> 
>> +    }
>> +
>>       load_cr3(early_top_pgt);
>>       __flush_tlb_all();
>>   diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
>> index 084de77a109e..102fad0b0bca 100644
>> --- a/arch/x86/xen/Makefile
>> +++ b/arch/x86/xen/Makefile
>> @@ -1,3 +1,10 @@
>> +KASAN_SANITIZE_enlighten_pv.o := n
>> +KASAN_SANITIZE_enlighten.o := n
>> +KASAN_SANITIZE_irq.o := n
>> +KASAN_SANITIZE_mmu_pv.o := n
>> +KASAN_SANITIZE_p2m.o := n
>> +KASAN_SANITIZE_multicalls.o := n
>> +
>>   # SPDX-License-Identifier: GPL-2.0
>>   OBJECT_FILES_NON_STANDARD_xen-asm_$(BITS).o := y
>>   diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
>> index ae4a41ca19f6..27de55699f24 100644
>> --- a/arch/x86/xen/enlighten_pv.c
>> +++ b/arch/x86/xen/enlighten_pv.c
>> @@ -72,6 +72,7 @@
>>   #include <asm/mwait.h>
>>   #include <asm/pci_x86.h>
>>   #include <asm/cpu.h>
>> +#include <asm/kasan.h>
>>     #ifdef CONFIG_ACPI
>>   #include <linux/acpi.h>
>> @@ -1231,6 +1232,8 @@ asmlinkage __visible void __init xen_start_kernel(void)
>>       /* Get mfn list */
>>       xen_build_dynamic_phys_to_machine();
>>   +    kasan_early_init();
>> +
>>       /*
>>        * Set up kernel GDT and segment registers, mainly so that
>>        * -fstack-protector code can be executed.
>> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
>> index c8dbee62ec2a..eaf63f1f26af 100644
>> --- a/arch/x86/xen/mmu_pv.c
>> +++ b/arch/x86/xen/mmu_pv.c
>> @@ -1079,7 +1079,7 @@ static void xen_exit_mmap(struct mm_struct *mm)
>>     static void xen_post_allocator_init(void);
>>   -static void __init pin_pagetable_pfn(unsigned cmd, unsigned long pfn)
>> +void __init pin_pagetable_pfn(unsigned cmd, unsigned long pfn)
>>   {
>>       struct mmuext_op op;
>>   @@ -1767,7 +1767,7 @@ static void __init set_page_prot_flags(void *addr, pgprot_t prot,
>>       if (HYPERVISOR_update_va_mapping((unsigned long)addr, pte, flags))
>>           BUG();
>>   }
>> -static void __init set_page_prot(void *addr, pgprot_t prot)
>> +void __init set_page_prot(void *addr, pgprot_t prot)
>>   {
>>       return set_page_prot_flags(addr, prot, UVMF_NONE);
>>   }
>> @@ -1943,6 +1943,15 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
>>       if (i && i < pgd_index(__START_KERNEL_map))
>>           init_top_pgt[i] = ((pgd_t *)xen_start_info->pt_base)[i];
>>   +#ifdef CONFIG_KASAN
>> +    /*
>> +     * Copy KASAN mappings
>> +     * ffffec0000000000 - fffffbffffffffff (=44 bits) kasan shadow memory (16TB)
>> +     */
>> +    for (i = 0xec0 >> 3; i < 0xfc0 >> 3; i++)
>> +        init_top_pgt[i] = ((pgd_t *)xen_start_info->pt_base)[i];
>> +#endif
>> +
>>       /* Make pagetable pieces RO */
>>       set_page_prot(init_top_pgt, PAGE_KERNEL_RO);
>>       set_page_prot(level3_ident_pgt, PAGE_KERNEL_RO);
>> diff --git a/arch/x86/xen/multicalls.c b/arch/x86/xen/multicalls.c
>> index 07054572297f..5e4729efbbe2 100644
>> --- a/arch/x86/xen/multicalls.c
>> +++ b/arch/x86/xen/multicalls.c
>> @@ -99,6 +99,15 @@ void xen_mc_flush(void)
>>                   ret++;
>>       }
>>   +    /*
>> +     * XXX: Kasan produces quite a lot (~2000) of warnings in a form of:
>> +     *
>> +     *     (XEN) mm.c:3222:d155v0 mfn 3704b already pinned
>> +     *
>> +     * during kasan_init(). They are benign, but silence them for now.
>> +     * Otherwise, booting takes too long due to printk() spam.
>> +     */
>> +#ifndef CONFIG_KASAN
> 
> It might be interesting to identify the problematic page tables.
> 
> I guess this would require some hacking to avoid the multicalls in order
> to identify which page table should not be pinned again.

I tracked this down to xen_alloc_ptpage() in mmu_pv.c:

			if (level == PT_PTE && USE_SPLIT_PTE_PTLOCKS)
				__pin_pagetable_pfn(MMUEXT_PIN_L1_TABLE, pfn);

kasan_populate_early_shadow() is doing lots pmd_populate_kernel() with
kasan_early_shadow_pte (mfn of which is reported by Xen). Currently I'm not
sure how to fix that. Is it possible to check that pfn has already been pinned
from Linux kernel? xen_page_pinned() seems to be an incorrect way to check that.

--
Thanks,
Sergey
