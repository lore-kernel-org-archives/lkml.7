Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AE4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AF220700
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="naX/JBrr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GA9p1tUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDAWLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:11:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34593 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbfDAWLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:11:38 -0400
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Apr 2019 18:11:37 EDT
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2CD43221D1;
        Mon,  1 Apr 2019 18:03:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 01 Apr 2019 18:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=BXEr0btx0pVKqiQhP0RxJgKwnB
        vm2dhUTHHFjil8Ugk=; b=naX/JBrrF1qRjqQR0vjrbzQUZErdqZrymCXE4vaMVF
        ydOE1YgrxvWdsms/5oqfcMRXfHda4XyV0GVWdDmGvgXudlLIYHPYuGsqPstKnOoM
        g5OztS0dvZfZZkMD/XOYzSICwDBgncfbQy6uF8odUfoEaW4AK5m4BqZRO63CLnz/
        9AyJszwPoV2sl7ysP3+l04r3LEQKkYyEvOgsl+oWfmuDQVBrOqI2w6C+58Jw8Wgq
        2w/TAPmjbCc6tDRRTTZND4i0xCgtf93ESMthXHkpk8c6mHCMcMTjnhpkO1eo9hxI
        TwUA1B6JriL44iuLqwsfpyXih4vEXoFy7CNe1QQVBNlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=BXEr0btx0pVKqiQhP
        0RxJgKwnBvm2dhUTHHFjil8Ugk=; b=GA9p1tUEPQ8WR4/OHEa8p8VTcYI1D6v2y
        NXvvITXo7gIutu+2jyMV5zmgWE/RPyBcvWnWcaWQO7vWdab4z3tWN+lypQPer/Co
        beYGGmx1LK7x/l1IyI+dU5aFGyxWMSEvNSovKHeJyU7SsROQZw/svWvUld0TO/xv
        rnOhDb9KBBiY19A7ad1/WuozwHvvqpsWiEewt5ENqtLoU4PYDyMFg5vyMJOIfyfS
        Ln01jI0x0UzaFioPeWuaY7yr4IzF160HAu+gJwWJv8E0nyOG9Ltp7dtJ4azlYGJD
        hooQWnepslyczTq9ciTj10l6VpvncjhIGQq3SWo56IWSyZxRyS3og==
X-ME-Sender: <xms:tIqiXHiKHKNDZhmToEQ57UleAqpO5RMn2mLaoe5XbxSowjYKvEoXpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrleehgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppeejtd
    drudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghl
    sehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:tIqiXPv7XZzA6VuX-pm3vfIp5Cfr2A0cOTHqO2BcFhOds0QSolGvvQ>
    <xmx:tIqiXPG_e2rxzN4n60eRaXxKzheBsL62KH3eoK3dT4j_NpUhjxZbSw>
    <xmx:tIqiXCbPCbqeOBtYel2nqlJpsyDwRSwh3rbOhnLvhkhGnmVvtWseig>
    <xmx:toqiXOth5NIpni1O2bEmTpr7ELeIQi78zd9yaLVjQjckvcbLJIAgkQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2F42D10311;
        Mon,  1 Apr 2019 18:03:32 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Bin Liu <b-liu@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>, stable@vger.kernel.org
Subject: [PATCH v2] soc: sunxi: Fix missing dependency on REGMAP_MMIO
Date:   Mon,  1 Apr 2019 17:03:31 -0500
Message-Id: <20190401220331.44720-1-samuel@sholland.org>
X-Mailer: git-send-email 2.21.0
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

Cc: <stable@vger.kernel.org> # 4.19
Fixes: 5828729bebbb ("soc: sunxi: export a regmap for EMAC clock reg on A64")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
changes from v1:
 - add stable@ and Fixes: tag

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
2.21.0

