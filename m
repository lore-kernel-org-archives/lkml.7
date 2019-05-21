Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F86C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048EC217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eloylbcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfEURzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 13:55:09 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:52602 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729179AbfEURzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:55:08 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8089CC01AB;
        Tue, 21 May 2019 17:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558461314; bh=j4xujey4oHXPlAqqw8enUk4zgpaPtQQZ7GJiAvqvb5U=;
        h=From:To:Cc:Subject:Date:From;
        b=eloylbcnJ5MpMfQi3KVwoX5gi5BDGCqQPL8z4WMUQcXQHnMQOVApwjnTEeFez0qmB
         d6NJqsP0wb5smfnJ6XhiXvzisPlCWIokP2AMecXdPzgRaR6QHo++0d3Bs51SiGYiIu
         j8ZP/V2gni2nGmExJZoWo+wD9oCoajeM9sVFCDS39xXEjX+4MfhmVFe2e60wuDqSA0
         11/9hUwL1yvzUafjjGSken9CgX8TXK5P+reyKlRZvLPnuZyY3IFcyOTdthXuSBQvOi
         8hFyqFec8nE4WhXEBYeIVzn0F14im7y4r6ZbTlWAbp9NT0Nz51JjHe2lTJvcdB6i5f
         24PZOehyvdr2w==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.106])
        by mailhost.synopsys.com (Postfix) with ESMTP id 240D6A0067;
        Tue, 21 May 2019 17:55:03 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v3] ARC: [plat-hsdk]: Add support of Vivante GPU
Date:   Tue, 21 May 2019 20:54:39 +0300
Message-Id: <20190521175439.15723-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HSDK board has built-in Vivante GPU IP which works perfectly fine
with Etnaviv driver, so let's use it.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v2->v3:
 * Rebase onto latest kernel. No functional change intended.

Changes v1->v2:
 * Add clock inputs to etnaviv device tree node (reported by Lucas Stach)

 arch/arc/boot/dts/hsdk.dts      | 29 +++++++++++++++++++++++++++++
 arch/arc/configs/hsdk_defconfig |  2 +-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index 7425bb0f2d1b..32b3974ae4e2 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -167,6 +167,24 @@
 			#clock-cells = <0>;
 		};
 
+		gpu_core_clk: gpu-core-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <400000000>;
+			#clock-cells = <0>;
+		};
+
+		gpu_dma_clk: gpu-dma-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <400000000>;
+			#clock-cells = <0>;
+		};
+
+		gpu_cfg_clk: gpu-cfg-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <200000000>;
+			#clock-cells = <0>;
+		};
+
 		dmac_core_clk: dmac-core-clk {
 			compatible = "fixed-clock";
 			clock-frequency = <400000000>;
@@ -252,6 +270,17 @@
 			};
 		};
 
+		gpu_3d: gpu@90000 {
+			compatible = "vivante,gc";
+			reg = <0x90000 0x4000>;
+			clocks = <&gpu_dma_clk>,
+				 <&gpu_cfg_clk>,
+				 <&gpu_core_clk>,
+				 <&gpu_core_clk>;
+			clock-names = "bus", "reg", "core", "shader";
+			interrupts = <28>;
+		};
+
 		dmac: dmac@80000 {
 			compatible = "snps,axi-dma-1.01a";
 			reg = <0x80000 0x400>;
diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 0e5fd29ed238..643b58be022d 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -53,6 +53,7 @@ CONFIG_GPIO_DWAPB=y
 CONFIG_DRM=y
 # CONFIG_DRM_FBDEV_EMULATION is not set
 CONFIG_DRM_UDL=y
+CONFIG_DRM_ETNAVIV=y
 CONFIG_FB=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_USB_EHCI_HCD=y
@@ -64,7 +65,6 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_DW=y
-# CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT3_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-- 
2.14.5

