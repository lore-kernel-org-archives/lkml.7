Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF2FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC0C21855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368624;
	bh=jknPlMK3zruLuWLgSr2M9pFe0YvwXgN/y0AaoCGFUTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m3ERaOSlh9/+NnZuLgIoh1ApDK94TfKsf8nic9aMsVr48WlU7xVizsCKtSk0iNncs
	 drSB1AtpVXq1ZODSVOyDG5qqu2mik4APEQTZT5260NRaPmwA+ZrDi30AMGWUCN6TwS
	 aCdlCM7uDZUCUPLwbd+dAx1pphieqTXyHOOCvS9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbfDDJDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731831AbfDDJDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:03:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9918B21872;
        Thu,  4 Apr 2019 09:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368619;
        bh=jknPlMK3zruLuWLgSr2M9pFe0YvwXgN/y0AaoCGFUTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qVUs44oWKUJuQ8h9ez3DNbiNFzDwJQYN5AYNo8XHTZ0llBinxZ3XzsHtN8RUOqoLa
         ui7cFVKH2b3vKC21koG+ApfpIIPCiW3kpBFg0Cf1n0WmgVtAfvg73URVbJJSUQNHwS
         4LZGn1+ZMWTLttjlD75p3gZ59XdjzDtw4pU4s/Ko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 106/187] ARM: dts: meson8b: fix the Ethernet data line signals in eth_rgmii_pins
Date:   Thu,  4 Apr 2019 10:47:23 +0200
Message-Id: <20190404084608.248584879@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



