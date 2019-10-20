Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D4FCA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 13:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA06520679
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 13:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="UXMk+GZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfJTNmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 09:42:40 -0400
Received: from vps.xff.cz ([195.181.215.36]:52644 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbfJTNme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 09:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1571578952; bh=BtDClttz5M6UQwuN1cXDgO69t2LNMtNj4UeiQxwnXFk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=UXMk+GZzyWOYR6YsUvZ+9KmlF3y7Dqzs7ZTFyd3aHNTranHgZaLV2488yFGtMmDgq
         sXsyyejKxXEwM3/TlHspv+ZPesHRQLH4FhvSCqmjjVx6qvxi2NMtaMjJnbOQuAmN2w
         3v0xXWr0S2bG/Fg2CWMnMRCu85Gf65Eb21r2b1tU=
From:   megous@megous.com
To:     linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Ondrej Jirman <megous@megous.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] arm64: dts: allwinner: orange-pi-3: Enable USB 3.0 host support
Date:   Sun, 20 Oct 2019 15:42:29 +0200
Message-Id: <20191020134229.1216351-5-megous@megous.com>
In-Reply-To: <20191020134229.1216351-1-megous@megous.com>
References: <20191020134229.1216351-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Enable Allwinner's USB 3.0 phy and the host controller. Orange Pi 3
board has GL3510 USB 3.0 4-port hub connected to the SoC's USB 3.0
port. All four ports are exposed via USB3-A connectors. VBUS is
always on, since it's powered directly from DCIN (VCC-5V) and
not switchable.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index eb379cd402ac..259af5b0f1a7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -94,6 +94,10 @@
 	status = "okay";
 };
 
+&dwc3 {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -285,3 +289,7 @@
 	usb3_vbus-supply = <&reg_vcc5v>;
 	status = "okay";
 };
+
+&usb3phy {
+	status = "okay";
+};
-- 
2.23.0

