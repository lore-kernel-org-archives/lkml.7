Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8560BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5672085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="l4m+kGEh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OsXmAoic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfCACUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:20:51 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50453 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725896AbfCACUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:20:50 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0A27523209;
        Thu, 28 Feb 2019 21:20:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 28 Feb 2019 21:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=4OL5qrvlzxo/cQgz0/lXsuyWQ5
        pSfUCyDnpxpoIrC18=; b=l4m+kGEhj3jUtGekVhStjNdEBe12PwM0hMZNXvvkkr
        iInu7M7IqwJ0pGrmVmbjvCW1yfyyrYPyvNykDkCgczvYtx3mi0kE1MomDBYyfRvE
        YhVyvHs+LrBF3AcICPW/7GJBg1ssJxABvKnwoMt3U4SKSK/VgYQm72d5gVjkgSLA
        mKLHH5xoIWkV8rxtl/sk3ZCSyom3IfKDBv5vcgrDxj9dd9/hbTAOm0wl+iXHXg8Z
        TDqyRWtDP0UjaVWH4QlIUzPaQXf3LBNlttOO3WilTY0GcTCh+C81O07YfiqZxgBi
        tvmQR6Byk9VtFHTwfr+AwhMafJr7oF0Me2mQPH54PM1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4OL5qrvlzxo/cQgz0
        /lXsuyWQ5pSfUCyDnpxpoIrC18=; b=OsXmAoicAk9HgjuTttkJweXRp+YfzzvE5
        5cBwuNE8jttyP7jsqMYm6AmztRWB0h2eSPbb67aVOeEoeKXHCeQ9PMBUng7yAtzG
        e/zbLcQcJ1gzipeprGZRwEMhmTc7+HxY+ObgduRMlrLzaBa3kMkhbu0TExW2Qg4F
        ZwqULEljmhI8GIHx1GH9U8ZRhCVHrDcS2td4qY9ONv1QMM5/JttN0rBvBGlAyYNs
        kgSEFeirwKg8jW9RoLHCVy+s3p7fxQxQVin2D+N74nkfHskab22daHwiqNpeZ9Bj
        gCN4WlanUoZrnHcdb84bpHY7CGuhZkWC1YETtlraqG/9BjXrt4R1A==
X-ME-Sender: <xms:_ZZ4XGWuA77g-MhmTBHS7OyZGWhKRjOiE0oA_XQ1TvFKRdG4aO7hdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeggdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppeejtd
    drudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghl
    sehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:_ZZ4XJxEN1Tj9Q3ucqMF3hAGsVOb6xbsSxy5apK4W-3FgcvGOAXRMA>
    <xmx:_ZZ4XOxUW7MnO69qEEoAdeZGr4nB2OJmeka6Ul_y-gACp4FCPYxoxw>
    <xmx:_ZZ4XGCaQXiBxDjolfqkvvN5ealJVqtQprOy504LjQybv8kRudi4xQ>
    <xmx:_5Z4XPkAYPYmL5ZpyJnNCH2Cv2MabuLXq0U-zR7FIQcHtTWM2Fopow>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C5E07E40C1;
        Thu, 28 Feb 2019 21:20:44 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Bin Liu <b-liu@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH] soc: sunxi: Fix missing dependency on REGMAP_MMIO
Date:   Thu, 28 Feb 2019 20:20:44 -0600
Message-Id: <20190301022044.24431-1-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabling ARCH_SUNXI from allnoconfig, SUNXI_SRAM is enabled, but
not REGMAP_MMIO, so the kernel fails to link with an undefined reference
to __devm_regmap_init_mmio_clk. Select REGMAP_MMIO, as suggested in
drivers/base/regmap/Kconfig.

This creates the following dependency loop:

  drivers/of/Kconfig:68:                symbol OF_IRQ depends on IRQ_DOMAIN
  kernel/irq/Kconfig:63:                symbol IRQ_DOMAIN is selected by REGMAP
  drivers/base/regmap/Kconfig:7:        symbol REGMAP default is visible depending on REGMAP_MMIO
  drivers/base/regmap/Kconfig:39:       symbol REGMAP_MMIO is selected by SUNXI_SRAM
  drivers/soc/sunxi/Kconfig:4:          symbol SUNXI_SRAM is selected by USB_MUSB_SUNXI
  drivers/usb/musb/Kconfig:63:          symbol USB_MUSB_SUNXI depends on GENERIC_PHY
  drivers/phy/Kconfig:7:                symbol GENERIC_PHY is selected by PHY_BCM_NS_USB3
  drivers/phy/broadcom/Kconfig:29:      symbol PHY_BCM_NS_USB3 depends on MDIO_BUS
  drivers/net/phy/Kconfig:12:           symbol MDIO_BUS default is visible depending on PHYLIB
  drivers/net/phy/Kconfig:181:          symbol PHYLIB is selected by ARC_EMAC_CORE
  drivers/net/ethernet/arc/Kconfig:18:  symbol ARC_EMAC_CORE is selected by ARC_EMAC
  drivers/net/ethernet/arc/Kconfig:24:  symbol ARC_EMAC depends on OF_IRQ

To fix the circular dependency, make USB_MUSB_SUNXI select GENERIC_PHY
instead of depending on it. This matches the use of GENERIC_PHY by all
but two other drivers.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/soc/sunxi/Kconfig | 1 +
 drivers/usb/musb/Kconfig  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/sunxi/Kconfig b/drivers/soc/sunxi/Kconfig
index 353b07e40176..e84eb4e59f58 100644
--- a/drivers/soc/sunxi/Kconfig
+++ b/drivers/soc/sunxi/Kconfig
@@ -4,6 +4,7 @@
 config SUNXI_SRAM
 	bool
 	default ARCH_SUNXI
+	select REGMAP_MMIO
 	help
 	  Say y here to enable the SRAM controller support. This
 	  device is responsible on mapping the SRAM in the sunXi SoCs
diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index ad08895e78f9..c3dae7d5cb6e 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -66,7 +66,7 @@ config USB_MUSB_SUNXI
 	depends on NOP_USB_XCEIV
 	depends on PHY_SUN4I_USB
 	depends on EXTCON
-	depends on GENERIC_PHY
+	select GENERIC_PHY
 	select SUNXI_SRAM
 
 config USB_MUSB_DAVINCI
-- 
2.19.2

