Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16968C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D656B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714494;
	bh=KOGOp3ldPjr4JtCcwcVP85HBy2aF0BSnCQGL2u0y3aA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AVf/YMPzdqkiSWfznB08hY3QSLdt6P8kcRDz/bcoDcGLyKXUoIxTh1KsPmKZITMbC
	 YaKPQ2ZCPH+Jnp9glwuKO0AUsNU20omOVIUYe9GBtdORw6703lWxB04A86OFkqHM53
	 zhfsCrNVNS2lHrC1r2sOY00v58QkT/TO9MtSr8XE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbfC0TVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732699AbfC0SGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:06:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47513217F9;
        Wed, 27 Mar 2019 18:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710012;
        bh=KOGOp3ldPjr4JtCcwcVP85HBy2aF0BSnCQGL2u0y3aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7pa/XExevGRpbRdZHTzrzrMLBp0QSXOviaTxXEuQ5sXCh/cDL8q7+LRJIIGpIgQB
         PVm+BpMAu2iwoMWV3VY0ZQmTNaQ1QNtLSpbkuDnKvEGrmq7G1Wq/Wfd2lriKr9lChu
         3ORJY9WvYGny/i/bTpgOdRkO647HzJBGFRWXPUkY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 5.0 155/262] ARM: dts: meson8b: fix the Ethernet data line signals in eth_rgmii_pins
Date:   Wed, 27 Mar 2019 14:00:10 -0400
Message-Id: <20190327180158.10245-155-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
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
index 22d775460767..dc125769fe85 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -270,9 +270,7 @@
 				groups = "eth_tx_clk",
 					 "eth_tx_en",
 					 "eth_txd1_0",
-					 "eth_txd1_1",
 					 "eth_txd0_0",
-					 "eth_txd0_1",
 					 "eth_rx_clk",
 					 "eth_rx_dv",
 					 "eth_rxd1",
@@ -281,7 +279,9 @@
 					 "eth_mdc",
 					 "eth_ref_clk",
 					 "eth_txd2",
-					 "eth_txd3";
+					 "eth_txd3",
+					 "eth_rxd3",
+					 "eth_rxd2";
 				function = "ethernet";
 				bias-disable;
 			};
-- 
2.19.1

