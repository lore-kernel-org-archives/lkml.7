Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B8BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C6820700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713373;
	bh=JxLXit/T9/yTVJD/bDaWlJaU2Wa8dmz2mtJ5EawYd30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gfDFx+pJLK/QiYwPHyb9QjV422qYueEOtBs0NB7fRRfCuRuafXdySsjMbuLbjivHh
	 kpCSnj/kSE+VhU0PDDXOjy2tyTZ95KEDN13i3NFK4KkOjvU3wIHjmLlsF8/dkOPzjt
	 Xl5MHWhZ3ggpQMCCpJC5PfhEYmdGIIm/hRikHqo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389917AbfC0TCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387729AbfC0SNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:13:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B133217F9;
        Wed, 27 Mar 2019 18:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710415;
        bh=JxLXit/T9/yTVJD/bDaWlJaU2Wa8dmz2mtJ5EawYd30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yeey/Uk/3zVW0cq7NgRm5UXuxm7mIGAaQAnrX+iYbBi8xTcGkguh3t0p/mck1rW9t
         UlLHWaMjgfzKMjT5f+F8bvUlTMx7y24sQvXVxa7GvVhIaM9IS18zjZtgkHT8g5ptxd
         Q3Bv4It+rlwW0VKWib3FiWZ+q0NI5s6sRp1E+FrQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 108/192] ARM: dts: meson8b: fix the Ethernet data line signals in eth_rgmii_pins
Date:   Wed, 27 Mar 2019 14:09:00 -0400
Message-Id: <20190327181025.13507-108-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 29f0023d01f063feacfc404f0446905aee4f82ee ]

According to the Odroid-C1+ schematics the Ethernet TXD1 signal is
routed to GPIOH_5 and the TXD0 signal is routed to GPIOH_6.
The public S805 datasheet shows that TXD0 can be routed to DIF_2_P and
TXD1 can be routed to DIF_2_N instead.

The pin groups eth_txd0_0 (GPIOH_6) and eth_txd0_1 (DIF_2_P) are both
configured as Ethernet TXD0 and TXD1 data lines in meson8b.dtsi. At the
same time eth_txd1_0 (GPIOH_5) and eth_txd1_1 (DIF_2_N) are configured
as TXD0 and TXD1 data lines as well.
This results in a bad Ethernet receive performance. Presumably this is
due to the eth_txd0 and eth_txd1 signal being routed to the wrong pins.
As a result of that data can only be transmitted on eth_txd2 and
eth_txd3. However, I have no scope to fully confirm this assumption.

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

Drop the eth_txd0_1 and eth_txd1_1 groups from eth_rgmii_pins to fix the
Ethernet transmit performance on Odroid-C1. Also add the eth_rxd2 and
eth_rxd3 groups so we don't rely on the bootloader to set them up.

iperf3 statistics before this change:
- transmitting from Odroid-C1: 741 Mbits/sec (0 retries)
- receiving on Odroid-C1: 199 Mbits/sec (1713 retries)

iperf3 statistics after this change:
- transmitting from Odroid-C1: 667 Mbits/sec (0 retries)
- receiving on Odroid-C1: 750 Mbits/sec (0 retries)

Fixes: b96446541d8390 ("ARM: dts: meson8b: extend ethernet controller description")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Emiliano Ingrassia <ingrassia@epigenesys.com>
Cc: Linus Lüssing <linus.luessing@c0d3.blue>
Tested-by: Emiliano Ingrassia <ingrassia@epigenesys.com>
Reviewed-by: Emiliano Ingrassia <ingrassia@epigenesys.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/meson8b.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 08f7f6be7254..5b3e5c50c72f 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -207,9 +207,7 @@
 				groups = "eth_tx_clk",
 					 "eth_tx_en",
 					 "eth_txd1_0",
-					 "eth_txd1_1",
 					 "eth_txd0_0",
-					 "eth_txd0_1",
 					 "eth_rx_clk",
 					 "eth_rx_dv",
 					 "eth_rxd1",
@@ -218,7 +216,9 @@
 					 "eth_mdc",
 					 "eth_ref_clk",
 					 "eth_txd2",
-					 "eth_txd3";
+					 "eth_txd3",
+					 "eth_rxd3",
+					 "eth_rxd2";
 				function = "ethernet";
 			};
 		};
-- 
2.19.1

