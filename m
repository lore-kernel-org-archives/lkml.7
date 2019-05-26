Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA2BC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 09:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851482075C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 09:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="AbJFSzTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfEZJsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 05:48:16 -0400
Received: from mx1.riseup.net ([198.252.153.129]:41888 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbfEZJsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 05:48:16 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id EB5721A0CAF;
        Sun, 26 May 2019 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1558864095; bh=8OaqU8bvZuIXA7nF3gCJ4vUP6PXw6ku0VUrbHfqjHAQ=;
        h=From:To:Cc:Subject:Date:From;
        b=AbJFSzTpy+q0/Tly14xp4E0gE66+KV+sX4Pv4MNcTkczonBjKea1eclojC481a33W
         QOsKILLMLBykNx9COt9boiw+h1qp6Gtwjv8cCxpRQn8dWlrHhQNkMUsxetjKuWqGq+
         GNNatU64LAdFB/pti6KAlFD1dEXZXTG/Ytl2Magc=
X-Riseup-User-ID: F570A3085F3311A36801C4EC41F2616F67BF4FC43DF8360ACC0A436D2EF42768
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 4C351120896;
        Sun, 26 May 2019 02:48:11 -0700 (PDT)
From:   Yegor Timoshenko <yegortimoshenko@riseup.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yegor Timoshenko <yegortimoshenko@riseup.net>
Subject: [PATCH] arm64: dts: allwinner: a64: bananapi-m64: enable UART2
Date:   Sun, 26 May 2019 12:47:15 +0300
Message-Id: <20190526094715.12289-1-yegortimoshenko@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BananaPi M64 exposes UART2 interface that is supposed to be enabled
by default (see "Default Function" in the pin definition table from
the manufacturer [1]).

[1]: https://bananapi.gitbooks.io/bpi-m64/en/bpi-m64gpiopindefine.html

Signed-off-by: Yegor Timoshenko <yegortimoshenko@riseup.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 094cfed13df9..100d1a8fd292 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -54,6 +54,7 @@
 		ethernet0 = &emac;
 		serial0 = &uart0;
 		serial1 = &uart1;
+		serial2 = &uart2;
 	};
 
 	chosen {
@@ -312,6 +313,12 @@
 	status = "okay";
 };
 
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "okay";
+};
+
 &usb_otg {
 	dr_mode = "otg";
 	status = "okay";
-- 
2.20.1

