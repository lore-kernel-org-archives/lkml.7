Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC1EC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D48621E6B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dXFWXOFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbfHGNcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:32:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388624AbfHGNcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=68Yhf2iDyVKzYLQ2UV2u0cZ6dqKHM7rKNUQXbO+5I0I=; b=dXFWXOFYR808khgteyw+aEjGBO
        /LIixTa5asafxBMyqX2NOdWDYDIzMRcTx2W0mZuWKDu9rIH0cSd5+ZY7UaYOiQex4BqpJ2Ei4l00P
        HO6r/cYCvU8ZOOBdULk9DXu9jJF3LRuCwBaZP3E11lKvvQtR21OWweIUycCtRFwAnI6Y2foweRByr
        gi4/ZN4sxp3ZBuW5oAFJiMJ4809KJx1MKCBWQziswKmZByxg/xNv5uyf05YPRXAkesvyVHirwhKn9
        wvgFppgJPtCYX3xV5f4elpSuBQynANmORMtw/DNXoVrFXktp4f6hhBioQqTb7f3ZcoIvtg2CPUsPK
        ttz4fjaA==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvM38-0008G5-NS; Wed, 07 Aug 2019 13:32:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/29] ia64: remove CONFIG_ACPI_NUMA ifdefs
Date:   Wed,  7 Aug 2019 16:30:48 +0300
Message-Id: <20190807133049.20893-29-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807133049.20893-1-hch@lst.de>
References: <20190807133049.20893-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_ACPI_NUMA is now unconditionally selected on ia64, so remove the
ifdefs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/include/asm/acpi.h |  5 -----
 arch/ia64/kernel/acpi.c      | 17 -----------------
 arch/ia64/kernel/setup.c     |  2 --
 3 files changed, 24 deletions(-)

diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
index f886d4dc9d55..9598f998a94f 100644
--- a/arch/ia64/include/asm/acpi.h
+++ b/arch/ia64/include/asm/acpi.h
@@ -55,7 +55,6 @@ extern int additional_cpus;
 #define additional_cpus 0
 #endif
 
-#ifdef CONFIG_ACPI_NUMA
 #if MAX_NUMNODES > 256
 #define MAX_PXM_DOMAINS MAX_NUMNODES
 #else
@@ -63,7 +62,6 @@ extern int additional_cpus;
 #endif
 extern int pxm_to_nid_map[MAX_PXM_DOMAINS];
 extern int __initdata nid_to_pxm_map[MAX_NUMNODES];
-#endif
 
 static inline bool arch_has_acpi_pdc(void) { return true; }
 static inline void arch_acpi_set_pdc_bits(u32 *buf)
@@ -73,7 +71,6 @@ static inline void arch_acpi_set_pdc_bits(u32 *buf)
 
 #define acpi_unlazy_tlb(x)
 
-#ifdef CONFIG_ACPI_NUMA
 extern cpumask_t early_cpu_possible_map;
 #define for_each_possible_early_cpu(cpu)  \
 	for_each_cpu((cpu), &early_cpu_possible_map)
@@ -102,8 +99,6 @@ static inline void per_cpu_scan_finalize(int min_cpus, int reserve_cpus)
 
 extern void acpi_numa_fixup(void);
 
-#endif /* CONFIG_ACPI_NUMA */
-
 #endif /*__KERNEL__*/
 
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 70d1587ddcd4..f681e8068c8d 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -316,8 +316,6 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI_NUMA
-
 #undef SLIT_DEBUG
 
 #define PXM_FLAG_LEN ((MAX_PXM_DOMAINS + 1)/32)
@@ -517,7 +515,6 @@ void __init acpi_numa_fixup(void)
 	}
 #endif
 }
-#endif				/* CONFIG_ACPI_NUMA */
 
 /*
  * success: return IRQ number (>=0)
@@ -668,7 +665,6 @@ int __init acpi_boot_init(void)
 	if (acpi_table_parse(ACPI_SIG_FADT, acpi_parse_fadt))
 		printk(KERN_ERR PREFIX "Can't find FADT\n");
 
-#ifdef CONFIG_ACPI_NUMA
 #ifdef CONFIG_SMP
 	if (srat_num_cpus == 0) {
 		int cpu, i = 1;
@@ -680,7 +676,6 @@ int __init acpi_boot_init(void)
 	}
 #endif
 	build_cpu_to_node_map();
-#endif
 	return 0;
 }
 
@@ -713,7 +708,6 @@ int acpi_isa_irq_to_gsi(unsigned isa_irq, u32 *gsi)
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
 {
-#ifdef CONFIG_ACPI_NUMA
 	/*
 	 * We don't have cpu-only-node hotadd. But if the system equips
 	 * SRAT table, pxm is already found and node is ready.
@@ -723,7 +717,6 @@ int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
 	 */
 	node_cpuid[cpu].phys_id = physid;
 	node_cpuid[cpu].nid = acpi_get_node(handle);
-#endif
 	return 0;
 }
 
@@ -813,17 +806,11 @@ int acpi_unmap_cpu(int cpu)
 {
 	ia64_cpu_to_sapicid[cpu] = -1;
 	set_cpu_present(cpu, false);
-
-#ifdef CONFIG_ACPI_NUMA
-	/* NUMA specific cleanup's */
-#endif
-
 	return (0);
 }
 EXPORT_SYMBOL(acpi_unmap_cpu);
 #endif				/* CONFIG_ACPI_HOTPLUG_CPU */
 
-#ifdef CONFIG_ACPI_NUMA
 static acpi_status acpi_map_iosapic(acpi_handle handle, u32 depth,
 				    void *context, void **ret)
 {
@@ -877,7 +864,6 @@ acpi_map_iosapics (void)
 }
 
 fs_initcall(acpi_map_iosapics);
-#endif				/* CONFIG_ACPI_NUMA */
 
 int __ref acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base)
 {
@@ -886,10 +872,7 @@ int __ref acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base)
 	if ((err = iosapic_init(phys_addr, gsi_base)))
 		return err;
 
-#ifdef CONFIG_ACPI_NUMA
 	acpi_map_iosapic(handle, 0, NULL, NULL);
-#endif				/* CONFIG_ACPI_NUMA */
-
 	return 0;
 }
 
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 18de565d5825..6dbb58bb4c8c 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -569,7 +569,6 @@ setup_arch (char **cmdline_p)
 	/* Initialize the ACPI boot-time table parser */
 	acpi_table_init();
 	early_acpi_boot_init();
-#ifdef CONFIG_ACPI_NUMA
 	acpi_numa_init();
 	acpi_numa_fixup();
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
@@ -578,7 +577,6 @@ setup_arch (char **cmdline_p)
 	per_cpu_scan_finalize((cpumask_weight(&early_cpu_possible_map) == 0 ?
 		32 : cpumask_weight(&early_cpu_possible_map)),
 		additional_cpus > 0 ? additional_cpus : 0);
-#endif /* CONFIG_ACPI_NUMA */
 
 #ifdef CONFIG_SMP
 	smp_build_cpu_map();
-- 
2.20.1

