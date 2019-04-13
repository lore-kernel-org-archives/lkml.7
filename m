Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52F8C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7C72084D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="UUWBBd25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfDMQzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 12:55:20 -0400
Received: from vps.xff.cz ([195.181.215.36]:49096 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbfDMQyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 12:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1555174461; bh=5+OjQouhgetk0y/4ZBia+F3DXqvQz0nw2INENoiUABo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UUWBBd25esUjrCgsfjE67v7dkEy5BhMpn5D9u4+mOb8Soe6vfs4/nHnnWsv4xOtlT
         RAukk2EdXUglwPInp1w9kTKjUHDeURgSXAo13c3RApJq81aRYXd2ynZ05A/nWnbEsu
         S3+db7KpmR3e5YBpBd4BI4VqUGrF94uGVa90jRow=
From:   megous@megous.com
To:     linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Ondrej Jirman <megous@megous.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-gpio@vger.kernel.org
Subject: [PATCH v4 4/9] pinctrl: sunxi: Support I/O bias voltage setting on H6
Date:   Sat, 13 Apr 2019 18:54:13 +0200
Message-Id: <20190413165418.27880-5-megous@megous.com>
In-Reply-To: <20190413165418.27880-1-megous@megous.com>
References: <20190413165418.27880-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

H6 SoC has a "pio group withstand voltage mode" register (datasheet
description), that needs to be used to select either 1.8V or 3.3V I/O mode,
based on what voltage is powering the respective pin banks and is thus used
for I/O signals.

Add support for configuring this register according to the voltage of the
pin bank regulator (if enabled).

This is similar to the support for I/O bias voltage setting patch for A80
and the same concerns apply. See:

  commit 402bfb3c1352 ("Support I/O bias voltage setting on A80")

Signed-off-by: Ondrej Jirman <megous@megous.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c |  1 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c     | 11 +++++++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.h     |  7 +++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
index ef4268cc6227..3cc1121589c9 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
@@ -591,6 +591,7 @@ static const struct sunxi_pinctrl_desc h6_pinctrl_data = {
 	.irq_banks = 4,
 	.irq_bank_map = h6_irq_bank_map,
 	.irq_read_needs_mux = true,
+	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
 };
 
 static int h6_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 98c4de5f4019..0cbca30b75dc 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -614,6 +614,8 @@ static int sunxi_pinctrl_set_io_bias_cfg(struct sunxi_pinctrl *pctl,
 					 unsigned pin,
 					 struct regulator *supply)
 {
+	unsigned short bank = pin / PINS_PER_BANK;
+	unsigned long flags;
 	u32 val, reg;
 	int uV;
 
@@ -651,6 +653,15 @@ static int sunxi_pinctrl_set_io_bias_cfg(struct sunxi_pinctrl *pctl,
 		reg &= ~IO_BIAS_MASK;
 		writel(reg | val, pctl->membase + sunxi_grp_config_reg(pin));
 		return 0;
+	case BIAS_VOLTAGE_PIO_POW_MODE_SEL:
+		val = uV <= 1800000 ? 1 : 0;
+
+		raw_spin_lock_irqsave(&pctl->lock, flags);
+		reg = readl(pctl->membase + PIO_POW_MOD_SEL_REG);
+		reg &= ~(1 << bank);
+		writel(reg | val << bank, pctl->membase + PIO_POW_MOD_SEL_REG);
+		raw_spin_unlock_irqrestore(&pctl->lock, flags);
+		return 0;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index a62b81357136..44e30deeee38 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -95,6 +95,8 @@
 #define PINCTRL_SUN7I_A20	BIT(7)
 #define PINCTRL_SUN8I_R40	BIT(8)
 
+#define PIO_POW_MOD_SEL_REG	0x340
+
 enum sunxi_desc_bias_voltage {
 	BIAS_VOLTAGE_NONE,
 	/*
@@ -102,6 +104,11 @@ enum sunxi_desc_bias_voltage {
 	 * Pn_GRP_CONFIG registers, as seen on A80 SoC.
 	 */
 	BIAS_VOLTAGE_GRP_CONFIG,
+	/*
+	 * Bias voltage is set through PIO_POW_MOD_SEL_REG
+	 * register, as seen on H6 SoC, for example.
+	 */
+	BIAS_VOLTAGE_PIO_POW_MODE_SEL,
 };
 
 struct sunxi_desc_function {
-- 
2.21.0

