Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C0FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 04:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863B321743
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 04:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfHGE7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 00:59:09 -0400
Received: from foss.arm.com ([217.140.110.172]:42666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfHGE7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 00:59:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF7D8344;
        Tue,  6 Aug 2019 21:59:07 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.40.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B07553F706;
        Tue,  6 Aug 2019 21:59:04 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>, Qian Cai <cai@lca.pw>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jia He <justin.he@arm.com>
Subject: [PATCH] arm64: mm: add missing PTE_SPECIAL in pte_mkdevmap on arm64
Date:   Wed,  7 Aug 2019 12:58:51 +0800
Message-Id: <20190807045851.10772-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, the MAP_SYNC test case will cause a print_bad_pte
warning on arm64 as follows:
[   25.542693] BUG: Bad page map in process mapdax333
pte:2e8000448800f53 pmd:41ff5f003
[   25.546360] page:ffff7e0010220000 refcount:1 mapcount:-1
mapping:ffff8003e29c7440 index:0x0
[   25.550281] ext4_dax_aops
[   25.550282] name:"__aaabbbcccddd__"
[   25.551553] flags: 0x3ffff0000001002(referenced|reserved)
[   25.555802] raw: 03ffff0000001002 ffff8003dfffa908 0000000000000000
ffff8003e29c7440
[   25.559446] raw: 0000000000000000 0000000000000000 00000001fffffffe
0000000000000000
[   25.563075] page dumped because: bad pte
[   25.564938] addr:0000ffffbe05b000 vm_flags:208000fb
anon_vma:0000000000000000 mapping:ffff8003e29c7440 index:0
[   25.574272] file:__aaabbbcccddd__ fault:ext4_dax_fault
mmmmap:ext4_file_mmap readpage:0x0
[   25.578799] CPU: 1 PID: 1180 Comm: mapdax333 Not tainted 5.2.0+ #21
[   25.581702] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
02/06/2015
[   25.585624] Call trace:
[   25.587008]  dump_backtrace+0x0/0x178
[   25.588799]  show_stack+0x24/0x30
[   25.590328]  dump_stack+0xa8/0xcc
[   25.591901]  print_bad_pte+0x18c/0x218
[   25.593628]  unmap_page_range+0x778/0xc00
[   25.595506]  unmap_single_vma+0x94/0xe8
[   25.597304]  unmap_vmas+0x90/0x108
[   25.598901]  unmap_region+0xc0/0x128
[   25.600566]  __do_munmap+0x284/0x3f0
[   25.602245]  __vm_munmap+0x78/0xe0
[   25.603820]  __arm64_sys_munmap+0x34/0x48
[   25.605709]  el0_svc_common.constprop.0+0x78/0x168
[   25.607956]  el0_svc_handler+0x34/0x90
[   25.609698]  el0_svc+0x8/0xc
[   25.611103] Disabling lock debugging due to kernel taint
[   25.613573] BUG: Bad page state in process mapdax333  pfn:448800
[   25.616359] page:ffff7e0010220000 refcount:0 mapcount:-1
mapping:ffff8003e29c7440 index:0x1
[   25.620236] ext4_dax_aops
[   25.620237] name:"__aaabbbcccddd__"
[   25.621495] flags: 0x3ffff0000000000()
[   25.624912] raw: 03ffff0000000000 dead000000000100 dead000000000200
ffff8003e29c7440
[   25.628502] raw: 0000000000000001 0000000000000000 00000000fffffffe
0000000000000000
[   25.632097] page dumped because: non-NULL mapping
[...]
[   25.656567] CPU: 1 PID: 1180 Comm: mapdax333 Tainted: G    B
5.2.0+ #21
[   25.660131] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
02/06/2015
[   25.663324] Call trace:
[   25.664466]  dump_backtrace+0x0/0x178
[   25.666163]  show_stack+0x24/0x30
[   25.667721]  dump_stack+0xa8/0xcc
[   25.669270]  bad_page+0xf0/0x150
[   25.670772]  free_pages_check_bad+0x84/0xa0
[   25.672724]  free_pcppages_bulk+0x45c/0x708
[   25.674675]  free_unref_page_commit+0xcc/0x100
[   25.676751]  free_unref_page_list+0x13c/0x200
[   25.678801]  release_pages+0x350/0x420
[   25.680539]  free_pages_and_swap_cache+0xf8/0x128
[   25.682738]  tlb_flush_mmu+0x164/0x2b0
[   25.684485]  unmap_page_range+0x648/0xc00
[   25.686349]  unmap_single_vma+0x94/0xe8
[   25.688131]  unmap_vmas+0x90/0x108
[   25.689739]  unmap_region+0xc0/0x128
[   25.691392]  __do_munmap+0x284/0x3f0
[   25.693079]  __vm_munmap+0x78/0xe0
[   25.694658]  __arm64_sys_munmap+0x34/0x48
[   25.696530]  el0_svc_common.constprop.0+0x78/0x168
[   25.698772]  el0_svc_handler+0x34/0x90
[   25.700512]  el0_svc+0x8/0xc

The root cause is in _vm_normal_page, without the PTE_SPECIAL bit,
the return value will be incorrectly set to pfn_to_page(pfn) instead
of NULL. Besides, this patch also rewrite the pmd_mkdevmap to avoid
setting PTE_SPECIAL for pmd

The MAP_SYNC test case is as follows(Provided by Yibo Cai)
$#include <stdio.h>
$#include <string.h>
$#include <unistd.h>
$#include <sys/file.h>
$#include <sys/mman.h>

$#ifndef MAP_SYNC
$#define MAP_SYNC 0x80000
$#endif

/* mount -o dax /dev/pmem0 /mnt */
$#define F "/mnt/__aaabbbcccddd__"

int main(void)
{
    int fd;
    char buf[4096];
    void *addr;

    if ((fd = open(F, O_CREAT|O_TRUNC|O_RDWR, 0644)) < 0) {
        perror("open1");
        return 1;
    }

    if (write(fd, buf, 4096) != 4096) {
        perror("lseek");
        return 1;
    }

    addr = mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_SYNC,
fd, 0);
    if (addr == MAP_FAILED) {
        perror("mmap");
        printf("did you mount with '-o dax'?\n");
        return 1;
    }

    memset(addr, 0x55, 4096);

    if (munmap(addr, 4096) == -1) {
        perror("munmap");
        return 1;
    }

    close(fd);

    return 0;
}

Fixes: 73b20c84d42d ("arm64: mm: implement pte_devmap support")
Reported-by: Yibo Cai <Yibo.Cai@arm.com>
Signed-off-by: Jia He <justin.he@arm.com>
Acked-by: Robin Murphy <Robin.Murphy@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 5fdcfe237338..e09760ece844 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -209,7 +209,7 @@ static inline pmd_t pmd_mkcont(pmd_t pmd)
 
 static inline pte_t pte_mkdevmap(pte_t pte)
 {
-	return set_pte_bit(pte, __pgprot(PTE_DEVMAP));
+	return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
 }
 
 static inline void set_pte(pte_t *ptep, pte_t pte)
@@ -396,7 +396,10 @@ static inline int pmd_protnone(pmd_t pmd)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_devmap(pmd)		pte_devmap(pmd_pte(pmd))
 #endif
-#define pmd_mkdevmap(pmd)	pte_pmd(pte_mkdevmap(pmd_pte(pmd)))
+static inline pmd_t pmd_mkdevmap(pmd_t pmd)
+{
+	return pte_pmd(set_pte_bit(pmd_pte(pmd), __pgprot(PTE_DEVMAP)));
+}
 
 #define __pmd_to_phys(pmd)	__pte_to_phys(pmd_pte(pmd))
 #define __phys_to_pmd_val(phys)	__phys_to_pte_val(phys)
-- 
2.17.1

