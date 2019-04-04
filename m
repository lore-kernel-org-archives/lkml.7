Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B4FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85864206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369882;
	bh=qjdjYuC5ZD0JsXhDy0n8xbDTy2T3um1Iau8xbEUzi+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CAXTtQoXVrrgivXyRbCMBxTpKiDt3uKkTuyeAllu9gXJ/e/pvxvX4Y56EjqauMmCH
	 X6LuOSe7zHnu5ImuMVlqKosnR3/mRrcfqu/MW/mjR82WrX9iROPBqaOfwAc1onK7gR
	 QiZ77WMar20BVVQleEOsNhnznUY+my2vD60tvI9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387950AbfDDJYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387715AbfDDJOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:14:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 018CC2147C;
        Thu,  4 Apr 2019 09:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369264;
        bh=qjdjYuC5ZD0JsXhDy0n8xbDTy2T3um1Iau8xbEUzi+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YmK3GEou44jK5W6rdlt4zWd1tmOIgF8fG6PxBZnH8NdAmrcKM2QqkfRc6ZhKvZTqQ
         c4bcA3QSJ12Rz1DoO19BNqllKj9T+PFAEbCS8OPXMgxmwLxUvn5lm6QPvPORPV7RWT
         MavypqROJAHqvXK9ZRZ+JiejLZu5qEdfMDpLChVI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 145/246] ARM: dts: meson8b: fix the Ethernet data line signals in eth_rgmii_pins
Date:   Thu,  4 Apr 2019 10:47:25 +0200
Message-Id: <20190404084624.245196057@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



