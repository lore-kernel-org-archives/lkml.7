Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBC8C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 17:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4B821872
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 17:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bf3BClET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbfGSRys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 13:54:48 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:46224 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727497AbfGSRys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 13:54:48 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 85E63C0163;
        Fri, 19 Jul 2019 17:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563558887; bh=xfMJh6liO4fii+92mxTSjQb5mrKZeVXSQXRG9ALjwLA=;
        h=From:To:Cc:Subject:Date:From;
        b=bf3BClETu+mE9kWUsBogQ8PZQ9IeUpOz+lZua8nkCYZfFjkk0UVCkFgbO+IULYpUY
         k9peBj7qztq1ss6uBbphNZ61O8i6IqC2crF+MF4W+ID3VLwxLtimjl2xblmTobLl+l
         1NLTMZxJ7dcSPCleF1rIFW6CvgGuh0LHX1mMZhmU1VPNRDNo6COSTgW2V5ZXLAi9ye
         5K2/IjHPUlU9JpurG5onaigUo618EiKTE1pER9MQhnf/C92585w/AgEEtOnfdfEEoK
         gyg/QtSVLwxhWeztMUnaGlMvvzrvbuSt/0y9y/eApNRBulMFM14ITycOUNaBJncgjD
         icDOczE3o1Nqw==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id C30E9A0057;
        Fri, 19 Jul 2019 17:54:45 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: [plat-hsdk]: allow to switch between AXI DMAC port configurations
Date:   Fri, 19 Jul 2019 20:54:44 +0300
Message-Id: <20190719175444.21809-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to use DW AXI DMAC on HSDK board in our automated verification
to test cache & dma kernel code changes. This is perfect candidate
as we don't depend on any external peripherals like MMC card / USB
storage / etc.
To increase test coverage we want to test both options:
 * DW AXI DMAC is connected through IOC port & dma direct ops used
 * DW AXI DMAC is connected to DDR port & dma noncoherent ops used

Introduce 'arc_hsdk_axi_dmac_coherent' global variable which can be
modified by debugger (same way as we patch 'ioc_enable') to switch
between these options without recompiling the kernel.
Depend on this value we tweak memory bridge configuration and
"dma-coherent" DTS property of DW AXI DMAC.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/boot/dts/Makefile    |  3 ++
 arch/arc/plat-hsdk/platform.c | 87 ++++++++++++++++++++++++++++++-----
 2 files changed, 78 insertions(+), 12 deletions(-)

diff --git a/arch/arc/boot/dts/Makefile b/arch/arc/boot/dts/Makefile
index a83c4f5e928b..8483a86c743d 100644
--- a/arch/arc/boot/dts/Makefile
+++ b/arch/arc/boot/dts/Makefile
@@ -12,3 +12,6 @@ dtb-y := $(builtindtb-y).dtb
 # for CONFIG_OF_ALL_DTBS test
 dtstree	:= $(srctree)/$(src)
 dtb-	:= $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
+
+# board-specific dtc flags
+DTC_FLAGS_hsdk += --pad 20
diff --git a/arch/arc/plat-hsdk/platform.c b/arch/arc/plat-hsdk/platform.c
index 7dd2dd335cf6..ab8f93e7468e 100644
--- a/arch/arc/plat-hsdk/platform.c
+++ b/arch/arc/plat-hsdk/platform.c
@@ -6,11 +6,15 @@
  */
 
 #include <linux/init.h>
+#include <linux/of_fdt.h>
+#include <linux/libfdt.h>
 #include <linux/smp.h>
 #include <asm/arcregs.h>
 #include <asm/io.h>
 #include <asm/mach_desc.h>
 
+int arc_hsdk_axi_dmac_coherent = 0;
+
 #define ARC_CCM_UNUSED_ADDR	0x60000000
 
 static void __init hsdk_init_per_cpu(unsigned int cpu)
@@ -97,6 +101,42 @@ static void __init hsdk_enable_gpio_intc_wire(void)
 	iowrite32(GPIO_INT_CONNECTED_MASK, (void __iomem *) GPIO_INTEN);
 }
 
+static int hsdk_tweak_node_coherency(const char *path, bool coherent)
+{
+	void *fdt = initial_boot_params;
+	const void *prop;
+	int node, ret;
+	bool dt_coh_set;
+
+	node = fdt_path_offset(fdt, path);
+	if (node < 0)
+		goto tweak_fail;
+
+	prop = fdt_getprop(fdt, node, "dma-coherent", &ret);
+	if (!prop && ret != -FDT_ERR_NOTFOUND)
+		goto tweak_fail;
+
+	dt_coh_set = ret != -FDT_ERR_NOTFOUND;
+	ret = 0;
+
+	/* need to remove "dma-coherent" property */
+	if (dt_coh_set && !coherent)
+		ret = fdt_delprop(fdt, node, "dma-coherent");
+
+	/* need to set "dma-coherent" property */
+	if (!dt_coh_set && coherent)
+		ret = fdt_setprop(fdt, node, "dma-coherent", NULL, 0);
+
+	if (ret < 0)
+		goto tweak_fail;
+
+	return 0;
+
+tweak_fail:
+	pr_err("failed to tweak %s to %scoherent\n", path, coherent ? "" : "non");
+	return -EFAULT;
+}
+
 enum hsdk_axi_masters {
 	M_HS_CORE = 0,
 	M_HS_RTT,
@@ -162,6 +202,39 @@ enum hsdk_axi_masters {
 #define CREG_PAE		((void __iomem *)(CREG_BASE + 0x180))
 #define CREG_PAE_UPDT		((void __iomem *)(CREG_BASE + 0x194))
 
+static void __init hsdk_init_memory_bridge_axi_dmac(void)
+{
+	bool coherent = !!arc_hsdk_axi_dmac_coherent;
+	u32 axi_m_slv1, axi_m_oft1;
+
+	/*
+	 * Don't tweak memory bridge configuration we we failed to tweak DTB
+	 * as we will end up in a inconsistent state.
+	 */
+	if (hsdk_tweak_node_coherency("/soc/dmac@80000", coherent))
+		return;
+
+	if (coherent) {
+		axi_m_slv1 = 0x77999999;
+		axi_m_oft1 = 0x76DCBA98;
+	} else {
+		axi_m_slv1 = 0x77777777;
+		axi_m_oft1 = 0x76543210;
+	}
+
+	writel(0x77777777, CREG_AXI_M_SLV0(M_DMAC_0));
+	writel(0xFEDCBA98, CREG_AXI_M_OFT0(M_DMAC_0));
+	writel(axi_m_slv1, CREG_AXI_M_SLV1(M_DMAC_0));
+	writel(axi_m_oft1, CREG_AXI_M_OFT1(M_DMAC_0));
+	writel(UPDATE_VAL, CREG_AXI_M_UPDT(M_DMAC_0));
+
+	writel(0x77777777, CREG_AXI_M_SLV0(M_DMAC_1));
+	writel(0xFEDCBA98, CREG_AXI_M_OFT0(M_DMAC_1));
+	writel(axi_m_slv1, CREG_AXI_M_SLV1(M_DMAC_1));
+	writel(axi_m_oft1, CREG_AXI_M_OFT1(M_DMAC_1));
+	writel(UPDATE_VAL, CREG_AXI_M_UPDT(M_DMAC_1));
+}
+
 static void __init hsdk_init_memory_bridge(void)
 {
 	u32 reg;
@@ -227,24 +300,14 @@ static void __init hsdk_init_memory_bridge(void)
 	writel(0x76543210, CREG_AXI_M_OFT1(M_GPU));
 	writel(UPDATE_VAL, CREG_AXI_M_UPDT(M_GPU));
 
-	writel(0x77777777, CREG_AXI_M_SLV0(M_DMAC_0));
-	writel(0x77777777, CREG_AXI_M_SLV1(M_DMAC_0));
-	writel(0xFEDCBA98, CREG_AXI_M_OFT0(M_DMAC_0));
-	writel(0x76543210, CREG_AXI_M_OFT1(M_DMAC_0));
-	writel(UPDATE_VAL, CREG_AXI_M_UPDT(M_DMAC_0));
-
-	writel(0x77777777, CREG_AXI_M_SLV0(M_DMAC_1));
-	writel(0x77777777, CREG_AXI_M_SLV1(M_DMAC_1));
-	writel(0xFEDCBA98, CREG_AXI_M_OFT0(M_DMAC_1));
-	writel(0x76543210, CREG_AXI_M_OFT1(M_DMAC_1));
-	writel(UPDATE_VAL, CREG_AXI_M_UPDT(M_DMAC_1));
-
 	writel(0x00000000, CREG_AXI_M_SLV0(M_DVFS));
 	writel(0x60000000, CREG_AXI_M_SLV1(M_DVFS));
 	writel(0x00000000, CREG_AXI_M_OFT0(M_DVFS));
 	writel(0x00000000, CREG_AXI_M_OFT1(M_DVFS));
 	writel(UPDATE_VAL, CREG_AXI_M_UPDT(M_DVFS));
 
+	hsdk_init_memory_bridge_axi_dmac();
+
 	/*
 	 * PAE remapping for DMA clients does not work due to an RTL bug, so
 	 * CREG_PAE register must be programmed to all zeroes, otherwise it
-- 
2.21.0

