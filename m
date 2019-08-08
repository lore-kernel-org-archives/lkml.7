Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E933C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 04:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3512171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 04:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="fON8ouhh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A6tjv9iz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfHIEh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 00:37:27 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36433 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbfHIEh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 00:37:26 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3917E21BA9;
        Fri,  9 Aug 2019 00:37:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 09 Aug 2019 00:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=4FHimcbCMY+I1omIJBES7VgYGl
        5XckWciRYWJ2MmcAw=; b=fON8ouhh32YfvctwQ7EYsmF3/de9yGe4ATZOIb25CI
        7roQEEXRAN3EirUs2SpHNT6vQF8kY+sNA9tP5g1BDuuQA61nGLdnI5U3knxydU5r
        MbQi7m07YUK2w32d9WcyPvDX951poVxixgQVv8LlmDrV0ip6ZXBsmy753s3jdXVZ
        7w1u9QfEeYPnUZuBd4NOxJdsF/Ncx8ZgZHNtthCGNt5nNJYKQOjJdDW+sXpnRjJO
        KZoVzTBJ+VA+CwONbAAgBeIN1kcRHbBxv2EtIH+cAT7auhjBa6GhfJXKCWt82dkD
        mbv4ocC74L/boGfSRqI2LlAZQt+0Z/zQJo0o7mL2BsEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4FHimcbCMY+I1omIJ
        BES7VgYGl5XckWciRYWJ2MmcAw=; b=A6tjv9izKyBCaGWFB0zFHjATk9PY8nCLp
        3YDDrKsHkA8ey7bWbeN0a3B5hYxCGK7D/z1IuPx5C9LzB60v3G8jprdCyvwo7NZ6
        ewOAC2KjuE9ag8qua1wEIQ5n1HIchiTUMSqgMHoz6PtIeguH+TOR3XsV1gBlRwGR
        tkN6N4jLrkWCXeshHWflmYfmVBJSC9f1NCbmb2oIXVP/Ltgx9NgjUcoDT9KWLfff
        fwew5SqhK7yJgAvbsHbCX/V+ZhTSodue9+CZ3Vpr3ZMS8IMvIqK/ObCHn9WeeuaF
        9UIICAjdzGdjScHt1YUxXIkzW/VfkuaAjHuJVdTsjD9q1qULbvtmg==
X-ME-Sender: <xms:hPhMXYwtpj1cqZkaiehzLUpg6rAeA4v2gw8WxmIq1xWb89Cu4-0V9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduiedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucfkphepjeefrdelfedrkeegrddvtdeknecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhm
    vgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:hPhMXWRKpmbCqrKSU00f5l9oODJck_Fj3RwAQkF4IGSLndIctrcHiA>
    <xmx:hPhMXQ8TEpDh7BunhOoaZekUvQFVYS0Ct_-ByVUMPo9mUHaqis14EA>
    <xmx:hPhMXUuVXQlP3sc5y0WCTFUW9x5rR9JwUNkLHibjRo15uztaA7m0qg>
    <xmx:hfhMXTzY40mTLryCTlPQIj9mtagsYbYqiXA-vXfAgF89gO7rDMpXng>
Received: from alistair-xps-14z.alistair23.me (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9F950380075;
        Fri,  9 Aug 2019 00:37:23 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     alistair23@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 1/2] arm64: defconfig: Cleanup the defconfig
Date:   Thu,  8 Aug 2019 14:37:17 -0700
Message-Id: <20190808213718.12270-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-run savedefconfig to cleanup the defconfig.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm64/configs/defconfig | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0e58ef02880c..b17ed20e1754 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -88,7 +88,6 @@ CONFIG_ARM_TEGRA186_CPUFREQ=y
 CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_INTEL_STRATIX10_SERVICE=y
-CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_IMX_SCU=y
 CONFIG_IMX_SCU_PD=y
@@ -193,7 +192,6 @@ CONFIG_PCIE_QCOM=y
 CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCIE_KIRIN=y
 CONFIG_PCIE_HISI_STB=y
-CONFIG_PCIE_TEGRA194=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_HISILICON_LPC=y
@@ -260,18 +258,12 @@ CONFIG_HNS3_ENET=y
 CONFIG_E1000E=y
 CONFIG_IGB=y
 CONFIG_IGBVF=y
-CONFIG_MLX4_EN=m
-CONFIG_MLX4_CORE=m
-CONFIG_MLX4_DEBUG=y
-CONFIG_MLX4_CORE_GEN2=y
-CONFIG_MLX5_CORE=m
-CONFIG_MLX5_CORE_EN=y
-CONFIG_MLX5_EN_ARFS=y
-CONFIG_MLX5_EN_RXNFC=y
-CONFIG_MLX5_MPFS=y
 CONFIG_MVNETA=y
 CONFIG_MVPP2=y
 CONFIG_SKY2=y
+CONFIG_MLX4_EN=m
+CONFIG_MLX5_CORE=m
+CONFIG_MLX5_CORE_EN=y
 CONFIG_QCOM_EMAC=m
 CONFIG_RAVB=y
 CONFIG_SMC91X=y
@@ -386,8 +378,8 @@ CONFIG_SPI_PL022=y
 CONFIG_SPI_ROCKCHIP=y
 CONFIG_SPI_QUP=y
 CONFIG_SPI_S3C64XX=y
-CONFIG_SPI_SPIDEV=m
 CONFIG_SPI_SUN6I=y
+CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MAX77620=y
@@ -593,7 +585,6 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=m
 CONFIG_USB_RENESAS_USB3=m
 CONFIG_TYPEC=m
-CONFIG_TYPEC_HD3SS3220=m
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
@@ -648,9 +639,9 @@ CONFIG_RTC_DRV_SNVS=m
 CONFIG_RTC_DRV_IMX_SC=m
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
-CONFIG_FSL_EDMA=y
 CONFIG_DMA_BCM2835=m
 CONFIG_DMA_SUN6I=m
+CONFIG_FSL_EDMA=y
 CONFIG_K3_DMA=y
 CONFIG_MV_XOR=y
 CONFIG_MV_XOR_V2=y
@@ -696,7 +687,6 @@ CONFIG_ARM_MHU=y
 CONFIG_IMX_MBOX=y
 CONFIG_PLATFORM_MHU=y
 CONFIG_BCM2835_MBOX=y
-CONFIG_TI_MESSAGE_MANAGER=y
 CONFIG_QCOM_APCS_IPC=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_SMMU=y
@@ -736,9 +726,7 @@ CONFIG_ARCH_TEGRA_186_SOC=y
 CONFIG_ARCH_TEGRA_194_SOC=y
 CONFIG_ARCH_K3_AM6_SOC=y
 CONFIG_ARCH_K3_J721E_SOC=y
-CONFIG_SOC_TI=y
 CONFIG_TI_SCI_PM_DOMAINS=y
-CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_EXTCON_USBC_CROS_EC=y
 CONFIG_MEMORY=y
@@ -783,11 +771,11 @@ CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_HISI_PMU=y
 CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
-CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_IMX_OCOTP=y
 CONFIG_NVMEM_IMX_OCOTP_SCU=y
 CONFIG_QCOM_QFPROM=y
 CONFIG_ROCKCHIP_EFUSE=y
+CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_UNIPHIER_EFUSE=y
 CONFIG_MESON_EFUSE=m
 CONFIG_FPGA=y
-- 
2.22.0

