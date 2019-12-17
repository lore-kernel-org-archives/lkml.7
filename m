Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D209CC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CED224682
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="CzVAf7iJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfLQOPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:15:45 -0500
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:49040 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbfLQOPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576592140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=u2UPCwCRKdLZ5GeCl7b3ekyiD3VnQVvAIq0xoa4hsrU=;
  b=CzVAf7iJwUNqviRK2PArIk9Mr7UtfNNMJWXS/fX2IIftNnipkmgMWT00
   EHa3sTvwLpuXzVR9jpfQ1C3LSj26TeAYki1ghTBRWAn4RKSMNE2RohmiH
   zp1P0ck7OmURrHdrUQFaQiaK6heuQ6VzzAdzSFyBg9VMA9epOxeLo3d7c
   s=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=sergey.dyasli@citrix.com; spf=Pass smtp.mailfrom=sergey.dyasli@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  sergey.dyasli@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
  sergey.dyasli@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: vTNHCHh/5quroKztrA/VQaZHeqhEeaqLFGVh7RsQIpPaIn2P5hLV2/P8ElTYM1ye+vK8PdN4vI
 EM/B4CNPsHIZJNfn5D98SRqCeY8dQ4iY2x0rNpsawnWgBMMUrR5Wd4lx8MFY4GB6/h/RnxX5Rh
 DXzoFiKbulmk9Thb6ePUROwDYo6FOg7veYQ3GEGS4q3xYkJf2pN8df6mCUJWToiiOZtwDa252J
 iCpOdkz8HNA0AgnQqnehmxFc0zj5ZzL3HU8VRrCRxr7VpjtGgQKWKk3+E7jDrZFER7AKWUM9M8
 5PE=
X-SBRS: 2.7
X-MesageID: 9817032
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,325,1571716800"; 
   d="scan'208";a="9817032"
From:   Sergey Dyasli <sergey.dyasli@citrix.com>
To:     <xen-devel@lists.xen.org>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Sergey Dyasli <sergey.dyasli@citrix.com>
Subject: [RFC PATCH 1/3] x86/xen: add basic KASAN support for PV kernel
Date:   Tue, 17 Dec 2019 14:08:02 +0000
Message-ID: <20191217140804.27364-2-sergey.dyasli@citrix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217140804.27364-1-sergey.dyasli@citrix.com>
References: <20191217140804.27364-1-sergey.dyasli@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables to use Outline instrumentation for Xen PV kernels.

KASAN_INLINE and KASAN_VMALLOC options currently lead to boot crashes
and hence disabled.

Rough edges in the patch are marked with XXX.

Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
---
 arch/x86/mm/init.c          | 14 ++++++++++++++
 arch/x86/mm/kasan_init_64.c | 28 ++++++++++++++++++++++++++++
 arch/x86/xen/Makefile       |  7 +++++++
 arch/x86/xen/enlighten_pv.c |  3 +++
 arch/x86/xen/mmu_pv.c       | 13 +++++++++++--
 arch/x86/xen/multicalls.c   | 10 ++++++++++
 drivers/xen/Makefile        |  2 ++
 kernel/Makefile             |  2 ++
 lib/Kconfig.kasan           |  3 ++-
 9 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index e7bb483557c9..0c98a45eec6c 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -8,6 +8,8 @@
 #include <linux/kmemleak.h>
 #include <linux/sched/task.h>
 
+#include <xen/xen.h>
+
 #include <asm/set_memory.h>
 #include <asm/e820/api.h>
 #include <asm/init.h>
@@ -835,6 +837,18 @@ void free_kernel_image_pages(const char *what, void *begin, void *end)
 	unsigned long end_ul = (unsigned long)end;
 	unsigned long len_pages = (end_ul - begin_ul) >> PAGE_SHIFT;
 
+	/*
+	 * XXX: skip this for now. Otherwise it leads to:
+	 *
+	 * (XEN) mm.c:2713:d157v0 Bad type (saw 8c00000000000001 != exp e000000000000000) for mfn 36f40 (pfn 02f40)
+	 * (XEN) mm.c:1043:d157v0 Could not get page type PGT_writable_page
+	 * (XEN) mm.c:1096:d157v0 Error getting mfn 36f40 (pfn 02f40) from L1 entry 8010000036f40067 for l1e_owner d157, pg_owner d157
+	 *
+	 * and further #PF error: [PROT] [WRITE] in the kernel.
+	 */
+	if (xen_pv_domain() && IS_ENABLED(CONFIG_KASAN))
+		return;
+
 	free_init_pages(what, begin_ul, end_ul);
 
 	/*
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index cf5bc37c90ac..caee2022f8b0 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -13,6 +13,8 @@
 #include <linux/sched/task.h>
 #include <linux/vmalloc.h>
 
+#include <xen/xen.h>
+
 #include <asm/e820/types.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -20,6 +22,9 @@
 #include <asm/pgtable.h>
 #include <asm/cpu_entry_area.h>
 
+#include <xen/interface/xen.h>
+#include <asm/xen/hypervisor.h>
+
 extern struct range pfn_mapped[E820_MAX_ENTRIES];
 
 static p4d_t tmp_p4d_table[MAX_PTRS_PER_P4D] __initdata __aligned(PAGE_SIZE);
@@ -305,6 +310,12 @@ static struct notifier_block kasan_die_notifier = {
 };
 #endif
 
+#ifdef CONFIG_XEN
+/* XXX: this should go to some header */
+void __init set_page_prot(void *addr, pgprot_t prot);
+void __init pin_pagetable_pfn(unsigned cmd, unsigned long pfn);
+#endif
+
 void __init kasan_early_init(void)
 {
 	int i;
@@ -332,6 +343,16 @@ void __init kasan_early_init(void)
 	for (i = 0; pgtable_l5_enabled() && i < PTRS_PER_P4D; i++)
 		kasan_early_shadow_p4d[i] = __p4d(p4d_val);
 
+	if (xen_pv_domain()) {
+		/* PV page tables must have PAGE_KERNEL_RO */
+		set_page_prot(kasan_early_shadow_pud, PAGE_KERNEL_RO);
+		set_page_prot(kasan_early_shadow_pmd, PAGE_KERNEL_RO);
+		set_page_prot(kasan_early_shadow_pte, PAGE_KERNEL_RO);
+
+		/* Add mappings to the initial PV page tables */
+		kasan_map_early_shadow((pgd_t *)xen_start_info->pt_base);
+	}
+
 	kasan_map_early_shadow(early_top_pgt);
 	kasan_map_early_shadow(init_top_pgt);
 }
@@ -369,6 +390,13 @@ void __init kasan_init(void)
 				__pgd(__pa(tmp_p4d_table) | _KERNPG_TABLE));
 	}
 
+	if (xen_pv_domain()) {
+		/* PV page tables must be pinned */
+		set_page_prot(early_top_pgt, PAGE_KERNEL_RO);
+		pin_pagetable_pfn(MMUEXT_PIN_L4_TABLE,
+				  PFN_DOWN(__pa_symbol(early_top_pgt)));
+	}
+
 	load_cr3(early_top_pgt);
 	__flush_tlb_all();
 
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index 084de77a109e..102fad0b0bca 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -1,3 +1,10 @@
+KASAN_SANITIZE_enlighten_pv.o := n
+KASAN_SANITIZE_enlighten.o := n
+KASAN_SANITIZE_irq.o := n
+KASAN_SANITIZE_mmu_pv.o := n
+KASAN_SANITIZE_p2m.o := n
+KASAN_SANITIZE_multicalls.o := n
+
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD_xen-asm_$(BITS).o := y
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index ae4a41ca19f6..27de55699f24 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -72,6 +72,7 @@
 #include <asm/mwait.h>
 #include <asm/pci_x86.h>
 #include <asm/cpu.h>
+#include <asm/kasan.h>
 
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
@@ -1231,6 +1232,8 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	/* Get mfn list */
 	xen_build_dynamic_phys_to_machine();
 
+	kasan_early_init();
+
 	/*
 	 * Set up kernel GDT and segment registers, mainly so that
 	 * -fstack-protector code can be executed.
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index c8dbee62ec2a..eaf63f1f26af 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1079,7 +1079,7 @@ static void xen_exit_mmap(struct mm_struct *mm)
 
 static void xen_post_allocator_init(void);
 
-static void __init pin_pagetable_pfn(unsigned cmd, unsigned long pfn)
+void __init pin_pagetable_pfn(unsigned cmd, unsigned long pfn)
 {
 	struct mmuext_op op;
 
@@ -1767,7 +1767,7 @@ static void __init set_page_prot_flags(void *addr, pgprot_t prot,
 	if (HYPERVISOR_update_va_mapping((unsigned long)addr, pte, flags))
 		BUG();
 }
-static void __init set_page_prot(void *addr, pgprot_t prot)
+void __init set_page_prot(void *addr, pgprot_t prot)
 {
 	return set_page_prot_flags(addr, prot, UVMF_NONE);
 }
@@ -1943,6 +1943,15 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
 	if (i && i < pgd_index(__START_KERNEL_map))
 		init_top_pgt[i] = ((pgd_t *)xen_start_info->pt_base)[i];
 
+#ifdef CONFIG_KASAN
+	/*
+	 * Copy KASAN mappings
+	 * ffffec0000000000 - fffffbffffffffff (=44 bits) kasan shadow memory (16TB)
+	 */
+	for (i = 0xec0 >> 3; i < 0xfc0 >> 3; i++)
+		init_top_pgt[i] = ((pgd_t *)xen_start_info->pt_base)[i];
+#endif
+
 	/* Make pagetable pieces RO */
 	set_page_prot(init_top_pgt, PAGE_KERNEL_RO);
 	set_page_prot(level3_ident_pgt, PAGE_KERNEL_RO);
diff --git a/arch/x86/xen/multicalls.c b/arch/x86/xen/multicalls.c
index 07054572297f..5e4729efbbe2 100644
--- a/arch/x86/xen/multicalls.c
+++ b/arch/x86/xen/multicalls.c
@@ -99,6 +99,15 @@ void xen_mc_flush(void)
 				ret++;
 	}
 
+	/*
+	 * XXX: Kasan produces quite a lot (~2000) of warnings in a form of:
+	 *
+	 *     (XEN) mm.c:3222:d155v0 mfn 3704b already pinned
+	 *
+	 * during kasan_init(). They are benign, but silence them for now.
+	 * Otherwise, booting takes too long due to printk() spam.
+	 */
+#ifndef CONFIG_KASAN
 	if (WARN_ON(ret)) {
 		pr_err("%d of %d multicall(s) failed: cpu %d\n",
 		       ret, b->mcidx, smp_processor_id());
@@ -121,6 +130,7 @@ void xen_mc_flush(void)
 			}
 		}
 	}
+#endif /* CONFIG_KASAN */
 
 	b->mcidx = 0;
 	b->argidx = 0;
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 0c4efa6fe450..1e9e1e41c0a8 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+KASAN_SANITIZE_features.o := n
+
 obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
 obj-y	+= grant-table.o features.o balloon.o manage.o preempt.o time.o
 obj-y	+= mem-reservation.o
diff --git a/kernel/Makefile b/kernel/Makefile
index f2cc0d118a0b..1da6fd93c00c 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -12,6 +12,8 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
 	    async.o range.o smpboot.o ucount.o
 
+KASAN_SANITIZE_cpu.o := n
+
 obj-$(CONFIG_MODULES) += kmod.o
 obj-$(CONFIG_MULTIUSER) += groups.o
 
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 81f5464ea9e1..429a638625ea 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -98,6 +98,7 @@ config KASAN_OUTLINE
 
 config KASAN_INLINE
 	bool "Inline instrumentation"
+	depends on !XEN_PV
 	help
 	  Compiler directly inserts code checking shadow memory before
 	  memory accesses. This is faster than outline (in some workloads
@@ -147,7 +148,7 @@ config KASAN_SW_TAGS_IDENTIFY
 
 config KASAN_VMALLOC
 	bool "Back mappings in vmalloc space with real shadow memory"
-	depends on KASAN && HAVE_ARCH_KASAN_VMALLOC
+	depends on KASAN && HAVE_ARCH_KASAN_VMALLOC && !XEN_PV
 	help
 	  By default, the shadow region for vmalloc space is the read-only
 	  zero page. This means that KASAN cannot detect errors involving
-- 
2.17.1

