Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7C4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27AF2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710188;
	bh=vG6mr5HjJrOKWpnJsCXMlIkEuLUeJNVieoZsEXIZBts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q879o0Nd0gJR81fRPUsPuwwOKod+MHmB18ZX0PX1jdPYxhPH9amxj1+zSfloS81Cc
	 iYESEMKK6Z0kJTVA2E6ZasMBRFYziyt2nglDXRRQ7hDWDwCBj5WKpCd9jkR4h4ptK2
	 it4qIp/ea9sO+667PfYzOtLvzH/4Tm4JXaXfpwfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388644AbfC0SJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388631AbfC0SJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:09:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A21A21741;
        Wed, 27 Mar 2019 18:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710183;
        bh=vG6mr5HjJrOKWpnJsCXMlIkEuLUeJNVieoZsEXIZBts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iIr7oWo4A6/mcCnklTU1HnMJSmqlZ4oiG2QxAHxnBky8lx07Rb9jpnwHgIuzXNlC3
         av9qV73Tu4j9NUXVcDDIsPcJwCL+xo3ZtrzsDyUwzXOxfomdHAyK2PmOfrkreplvNk
         Ymfn+MG0qvOE5CZ2okHgrPnX5jyU9FFp4vokXIZQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 5.0 240/262] pinctrl: meson: meson8b: add the eth_rxd2 and eth_rxd3 pins
Date:   Wed, 27 Mar 2019 14:01:35 -0400
Message-Id: <20190327180158.10245-240-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 6daae00243e622dd3feec7965bfe421ad6dd317e ]

Gigabit Ethernet requires the Ethernet TXD0..3 and RXD0..3 data lines.
Add the missing eth_rxd2 and eth_rxd3 definitions so we don't have to
rely on the bootloader to set them up correctly.

The vendor u-boot sources for Odroid-C1 use the following Ethernet
pinmux configuration:
  SET_CBUS_REG_MASK(PERIPHS_PIN_MUX_6, 0x3f4f);
  SET_CBUS_REG_MASK(PERIPHS_PIN_MUX_7, 0xf00000);
This translates to the following pin groups in the mainline kernel:
- register 6 bit  0: eth_rxd1 (DIF_0_P)
- register 6 bit  1: eth_rxd0 (DIF_0_N)
- register 6 bit  2: eth_rx_dv (DIF_1_P)
- register 6 bit  3: eth_rx_clk (DIF_1_N)
- register 6 bit  6: eth_tx_en (DIF_3_P)
- register 6 bit  8: eth_ref_clk (DIF_3_N)
- register 6 bit  9: eth_mdc (DIF_4_P)
- register 6 bit 10: eth_mdio_en (DIF_4_N)
- register 6 bit 11: eth_tx_clk (GPIOH_9)
- register 6 bit 12: eth_txd2 (GPIOH_8)
- register 6 bit 13: eth_txd3 (GPIOH_7)
- register 7 bit 20: eth_txd0_0 (GPIOH_6)
- register 7 bit 21: eth_txd1_0 (GPIOH_5)
- register 7 bit 22: eth_rxd3 (DIF_2_P)
- register 7 bit 23: eth_rxd2 (DIF_2_N)

All functions except eth_rxd2 and eth_rxd3 are already supported by the
pinctrl-meson8b driver.

Suggested-by: Jianxin Pan <jianxin.pan@amlogic.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Emiliano Ingrassia <ingrassia@epigenesys.com>
Reviewed-by: Emiliano Ingrassia <ingrassia@epigenesys.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/meson/pinctrl-meson8b.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index 0f140a802137..7f76000cc12e 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -346,6 +346,8 @@ static const unsigned int eth_rx_dv_pins[]	= { DIF_1_P };
 static const unsigned int eth_rx_clk_pins[]	= { DIF_1_N };
 static const unsigned int eth_txd0_1_pins[]	= { DIF_2_P };
 static const unsigned int eth_txd1_1_pins[]	= { DIF_2_N };
+static const unsigned int eth_rxd3_pins[]	= { DIF_2_P };
+static const unsigned int eth_rxd2_pins[]	= { DIF_2_N };
 static const unsigned int eth_tx_en_pins[]	= { DIF_3_P };
 static const unsigned int eth_ref_clk_pins[]	= { DIF_3_N };
 static const unsigned int eth_mdc_pins[]	= { DIF_4_P };
@@ -599,6 +601,8 @@ static struct meson_pmx_group meson8b_cbus_groups[] = {
 	GROUP(eth_ref_clk,	6,	8),
 	GROUP(eth_mdc,		6,	9),
 	GROUP(eth_mdio_en,	6,	10),
+	GROUP(eth_rxd3,		7,	22),
+	GROUP(eth_rxd2,		7,	23),
 };
 
 static struct meson_pmx_group meson8b_aobus_groups[] = {
@@ -748,7 +752,7 @@ static const char * const ethernet_groups[] = {
 	"eth_tx_clk", "eth_tx_en", "eth_txd1_0", "eth_txd1_1",
 	"eth_txd0_0", "eth_txd0_1", "eth_rx_clk", "eth_rx_dv",
 	"eth_rxd1", "eth_rxd0", "eth_mdio_en", "eth_mdc", "eth_ref_clk",
-	"eth_txd2", "eth_txd3"
+	"eth_txd2", "eth_txd3", "eth_rxd3", "eth_rxd2"
 };
 
 static const char * const i2c_a_groups[] = {
-- 
2.19.1

