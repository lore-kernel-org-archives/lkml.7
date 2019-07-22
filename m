Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B9FC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232CC2229B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cbhYIp6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfGVJbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:31:50 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:47944 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbfGVJbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:31:49 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E3E31C1215;
        Mon, 22 Jul 2019 09:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563787909; bh=6crldOoHtXOlHRVDTRlZeONbt5sG9NEHGdcIS27ReBo=;
        h=From:To:Cc:Subject:Date:From;
        b=cbhYIp6jMNP1TrSdJkRC7hkP4aga+CCPg0vA7nIzxIim6Ur+/f54J0sPT1Xj1S7Oi
         Xr0qF9LF9pf9DzNH2DFUIQ27gH8jnH1Id4acVSAI/TL+AB+4VtiLIUaTfyn0KoVATv
         K6NR5DPMytA6H/kF1ws0BZlk5vxTl29PlLJcFnHAeEVpwbxqC3DTCeJeesrDVlx456
         g9tiusMc4HNt1FkP9mDT8weCO7LTUztcJIsBxzmcilecGj5ws54cLwI4s0CfaTV9q9
         ufb3ZV1/cBe3lPOaE6NnQMWg/KI/46Z8K+YWrjAK+vbsU+wIHsqie7iu3U4cZ7zB5u
         9SJT1ay2snP1Q==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3ED7BA0057;
        Mon, 22 Jul 2019 09:31:46 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2] ARC: [plat-hsdk]: allow to switch between AXI DMAC port configurations
Date:   Mon, 22 Jul 2019 12:31:45 +0300
Message-Id: <20190722093145.4626-1-Eugeniy.Paltsev@synopsys.com>
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
Changes v1->v2:
 * Force putting arc_hsdk_axi_dmac_coherent to data section
 * Add missed __init to hsdk_tweak_node_coherency

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
index 7dd2dd335cf6..0b961a2a10b8 100644
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
 
+int arc_hsdk_axi_dmac_coherent __section(.data) = 0;
+
 #define ARC_CCM_UNUSED_ADDR	0x60000000
 
 static void __init hsdk_init_per_cpu(unsigned int cpu)
@@ -97,6 +101,42 @@ static void __init hsdk_enable_gpio_intc_wire(void)
 	iowrite32(GPIO_INT_CONNECTED_MASK, (void __iomem *) GPIO_INTEN);
 }
 
+static int __init hsdk_tweak_node_coherency(const char *path, bool coherent)
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
+	 * Don't tweak memory bridge configuration if we failed to tweak DTB
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

