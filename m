Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFEAC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6451820673
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="dY/DWHhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAHP2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:28:31 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:3495 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbgAHP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:28:19 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jan 2020 10:28:18 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1578497299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ZJuSUJ02rylweO0QTHeZK87XYdE2eEfNMSYEfZ4ISFU=;
  b=dY/DWHhYkkxgjmkULTxYvRMfaZA3Jglr4+ai0bo1e0ndy2jdRPGmS5bg
   iOeukYOWlrd6a4uWoBMP4u2in+AZ5ypO9e7xX5WMpXE9E81o0KOk9nU79
   rVHRlIrjMpTOMRsJ8/MqQiEqC0kPcz23sPGnEuwMqNpWS0eCFFfmDBxA/
   I=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=sergey.dyasli@citrix.com; spf=Pass smtp.mailfrom=sergey.dyasli@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  sergey.dyasli@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  sergey.dyasli@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: DX+ggOVcUV+qjAM+GH2sUSi46yljxph9UiDZ5OvdtBvqC5kMO1PziVlbeWDiErFsikLJupbr6j
 e1GJp5zCy/6F3zEoqeeNBUnp1jCorCX2Lv0Aiur8r6exMyKmwDqJuw2jGva+/nJJXFvTQ2Ugl7
 MsXEecRWjr/VWKfr79oqpWhGuobCwHKJmBbBKn4tqnGTrqWdR7mqh2Qt3c/YNqtAyzHNee9e/R
 zXaizezM7fqVpwm8zpKNd8k535daqotbAfc1B7wEgWYPCbpvlXlweSc7xS8pQwblpvCKKTD4np
 1yI=
X-SBRS: 2.7
X-MesageID: 11004137
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,410,1571716800"; 
   d="scan'208";a="11004137"
From:   Sergey Dyasli <sergey.dyasli@citrix.com>
To:     <xen-devel@lists.xen.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Dyasli <sergey.dyasli@citrix.com>
Subject: [PATCH v1 2/4] x86/xen: add basic KASAN support for PV kernel
Date:   Wed, 8 Jan 2020 15:20:58 +0000
Message-ID: <20200108152100.7630-3-sergey.dyasli@citrix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108152100.7630-1-sergey.dyasli@citrix.com>
References: <20200108152100.7630-1-sergey.dyasli@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables to use Outline instrumentation for Xen PV kernels.

KASAN_INLINE and KASAN_VMALLOC options currently lead to boot crashes
and hence disabled.

Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
---
RFC --> v1:
- New functions with declarations in xen/xen-ops.h
- Fixed the issue with free_kernel_image_pages() with the help of
  xen_pv_kasan_unpin_pgd()
---
 arch/x86/mm/kasan_init_64.c | 12 ++++++++++++
 arch/x86/xen/Makefile       |  7 +++++++
 arch/x86/xen/enlighten_pv.c |  3 +++
 arch/x86/xen/mmu_pv.c       | 39 +++++++++++++++++++++++++++++++++++++
 drivers/xen/Makefile        |  2 ++
 include/xen/xen-ops.h       |  4 ++++
 kernel/Makefile             |  2 ++
 lib/Kconfig.kasan           |  3 ++-
 8 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index cf5bc37c90ac..902a6a152d33 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -13,6 +13,9 @@
 #include <linux/sched/task.h>
 #include <linux/vmalloc.h>
 
+#include <xen/xen.h>
+#include <xen/xen-ops.h>
+
 #include <asm/e820/types.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -332,6 +335,11 @@ void __init kasan_early_init(void)
 	for (i = 0; pgtable_l5_enabled() && i < PTRS_PER_P4D; i++)
 		kasan_early_shadow_p4d[i] = __p4d(p4d_val);
 
+	if (xen_pv_domain()) {
+		pgd_t *pv_top_pgt = xen_pv_kasan_early_init();
+		kasan_map_early_shadow(pv_top_pgt);
+	}
+
 	kasan_map_early_shadow(early_top_pgt);
 	kasan_map_early_shadow(init_top_pgt);
 }
@@ -369,6 +377,8 @@ void __init kasan_init(void)
 				__pgd(__pa(tmp_p4d_table) | _KERNPG_TABLE));
 	}
 
+	xen_pv_kasan_pin_pgd(early_top_pgt);
+
 	load_cr3(early_top_pgt);
 	__flush_tlb_all();
 
@@ -433,6 +443,8 @@ void __init kasan_init(void)
 	load_cr3(init_top_pgt);
 	__flush_tlb_all();
 
+	xen_pv_kasan_unpin_pgd(early_top_pgt);
+
 	/*
 	 * kasan_early_shadow_page has been used as early shadow memory, thus
 	 * it may contain some garbage. Now we can clear and write protect it,
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
index c8dbee62ec2a..cf6ff214d9ea 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1771,6 +1771,36 @@ static void __init set_page_prot(void *addr, pgprot_t prot)
 {
 	return set_page_prot_flags(addr, prot, UVMF_NONE);
 }
+
+pgd_t * __init xen_pv_kasan_early_init(void)
+{
+	/* PV page tables must be read-only */
+	set_page_prot(kasan_early_shadow_pud, PAGE_KERNEL_RO);
+	set_page_prot(kasan_early_shadow_pmd, PAGE_KERNEL_RO);
+	set_page_prot(kasan_early_shadow_pte, PAGE_KERNEL_RO);
+
+	/* Return a pointer to the initial PV page tables */
+	return (pgd_t *)xen_start_info->pt_base;
+}
+
+void __init xen_pv_kasan_pin_pgd(pgd_t *pgd)
+{
+	if (!xen_pv_domain())
+		return;
+
+	set_page_prot(pgd, PAGE_KERNEL_RO);
+	pin_pagetable_pfn(MMUEXT_PIN_L4_TABLE, PFN_DOWN(__pa_symbol(pgd)));
+}
+
+void __init xen_pv_kasan_unpin_pgd(pgd_t *pgd)
+{
+	if (!xen_pv_domain())
+		return;
+
+	pin_pagetable_pfn(MMUEXT_UNPIN_TABLE, PFN_DOWN(__pa_symbol(pgd)));
+	set_page_prot(pgd, PAGE_KERNEL);
+}
+
 #ifdef CONFIG_X86_32
 static void __init xen_map_identity_early(pmd_t *pmd, unsigned long max_pfn)
 {
@@ -1943,6 +1973,15 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
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
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index d89969aa9942..91d66520f0a3 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -241,4 +241,8 @@ static inline void xen_preemptible_hcall_end(void)
 
 #endif /* CONFIG_PREEMPT */
 
+pgd_t *xen_pv_kasan_early_init(void);
+void xen_pv_kasan_pin_pgd(pgd_t *pgd);
+void xen_pv_kasan_unpin_pgd(pgd_t *pgd);
+
 #endif /* INCLUDE_XEN_OPS_H */
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

