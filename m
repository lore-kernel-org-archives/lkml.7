Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A23CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70C6233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="CLBm2jf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405052AbfHWKbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:31:50 -0400
Received: from vps.xff.cz ([195.181.215.36]:52622 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733308AbfHWKbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1566556306; bh=yUYphsfGd/2aYDGopZa37BQyG22wCozSNaBWz/Gf3VA=;
        h=From:To:Cc:Subject:Date:From;
        b=CLBm2jf8h4JtgS5SxCdnyB2k5v8MbkLorcykkkZZPMcfFyOYh8pAvI9yMkkJw4NGU
         mqsWw8GoynR+GBSYaUVHdBRcRQwBvHHLND7+NgL963Bh7n32Mzfe2iyE4G9Whqdn+/
         +M3v7tWKaN4Xieu16idwAgjEUyowSPLPrarww1V4=
From:   megous@megous.com
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, Ondrej Jirman <megous@megous.com>
Subject: [RESEND PATCH 0/5] Add bluetooth support for Orange Pi 3
Date:   Fri, 23 Aug 2019 12:31:34 +0200
Message-Id: <20190823103139.17687-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

(Resend to add missing lists, sorry for the noise.)

This series implements bluetooth support for Xunlong Orange Pi 3 board.

The board uses AP6256 WiFi/BT 5.0 chip.

Summary of changes:

- add more delay to let initialize the chip
- let the kernel detect firmware file path
- add new compatible and update dt-bindings
- update Orange Pi 3 / H6 DTS

Please take a look.

thank you and regards,
  Ondrej Jirman

Ondrej Jirman (5):
  dt-bindings: net: Add compatible for BCM4345C5 bluetooth device
  bluetooth: bcm: Add support for loading firmware for BCM4345C5
  bluetooth: hci_bcm: Give more time to come out of reset
  arm64: dts: allwinner: h6: Add pin configs for uart1
  arm64: dts: allwinner: orange-pi-3: Enable UART1 / Bluetooth

 .../bindings/net/broadcom-bluetooth.txt       |  1 +
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 19 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 10 ++++++++++
 drivers/bluetooth/btbcm.c                     |  3 +++
 drivers/bluetooth/hci_bcm.c                   |  3 ++-
 5 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.23.0

