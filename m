Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4901C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827C5206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfEGVJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 17:09:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:59650 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727137AbfEGVJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:09:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23B39ADE1;
        Tue,  7 May 2019 21:09:27 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] MIPS: SGI-IP27: move IP27 specific code out of pci-ip27.c into new file
Date:   Tue,  7 May 2019 23:09:13 +0200
Message-Id: <20190507210917.4691-2-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190507210917.4691-1-tbogendoerfer@suse.de>
References: <20190507210917.4691-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code in pci-ip27.c will be moved to drivers/pci/controller therefore
platform specific needs to be extracted and put to the right place.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/pci/pci-ip27.c      | 23 -----------------------
 arch/mips/sgi-ip27/Makefile   |  4 ++--
 arch/mips/sgi-ip27/ip27-pci.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 25 deletions(-)
 create mode 100644 arch/mips/sgi-ip27/ip27-pci.c

diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
index 3c177b4d0609..0b0f9c4eaf04 100644
--- a/arch/mips/pci/pci-ip27.c
+++ b/arch/mips/pci/pci-ip27.c
@@ -164,19 +164,6 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	return 0;
 }
 
-dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct bridge_controller *bc = BRIDGE_CONTROLLER(pdev->bus);
-
-	return bc->baddr + paddr;
-}
-
-phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr & ~(0xffUL << 56);
-}
-
 /*
  * Device might live on a subordinate PCI bus.	XXX Walk up the chain of buses
  * to find the slot number in sense of the bridge device register.
@@ -200,15 +187,5 @@ static void pci_fixup_ioc3(struct pci_dev *d)
 	pci_disable_swapping(d);
 }
 
-#ifdef CONFIG_NUMA
-int pcibus_to_node(struct pci_bus *bus)
-{
-	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
-
-	return bc->nasid;
-}
-EXPORT_SYMBOL(pcibus_to_node);
-#endif /* CONFIG_NUMA */
-
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3,
 	pci_fixup_ioc3);
diff --git a/arch/mips/sgi-ip27/Makefile b/arch/mips/sgi-ip27/Makefile
index 27c14ede191e..f9694f2b20b1 100644
--- a/arch/mips/sgi-ip27/Makefile
+++ b/arch/mips/sgi-ip27/Makefile
@@ -3,8 +3,8 @@
 # Makefile for the IP27 specific kernel interface routines under Linux.
 #
 
-obj-y	:= ip27-berr.o ip27-irq.o ip27-init.o ip27-klconfig.o \
-	   ip27-klnuma.o ip27-memory.o ip27-nmi.o ip27-reset.o ip27-timer.o \
+obj-y	:= ip27-berr.o ip27-irq.o ip27-init.o ip27-klconfig.o ip27-klnuma.o \
+	   ip27-memory.o ip27-nmi.o ip27-pci.o ip27-reset.o ip27-timer.o \
 	   ip27-hubio.o ip27-xtalk.o
 
 obj-$(CONFIG_EARLY_PRINTK)	+= ip27-console.o
diff --git a/arch/mips/sgi-ip27/ip27-pci.c b/arch/mips/sgi-ip27/ip27-pci.c
new file mode 100644
index 000000000000..d3efa5fbe8a3
--- /dev/null
+++ b/arch/mips/sgi-ip27/ip27-pci.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ip27-pci.c: misc PCI related helper code for IP27 architecture
+ */
+
+#include <asm/pci/bridge.h>
+
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct bridge_controller *bc = BRIDGE_CONTROLLER(pdev->bus);
+
+	return bc->baddr + paddr;
+}
+
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr & ~(0xffUL << 56);
+}
+
+#ifdef CONFIG_NUMA
+int pcibus_to_node(struct pci_bus *bus)
+{
+	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
+
+	return bc->nasid;
+}
+EXPORT_SYMBOL(pcibus_to_node);
+#endif /* CONFIG_NUMA */
+
-- 
2.13.7

