Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD1EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9C220700
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="bFeGQLpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbfCaKHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:07:44 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:13632 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfCaKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 06:07:44 -0400
X-Greylist: delayed 50207 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Mar 2019 06:07:43 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554026859;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=n9Y1lkgt7qHuD9W5cjttkRD2gn2A1tRKU+WvyQtEdto=;
        b=bFeGQLpy3rFxy5hckLBlJYUzwdpnhiUmlXt7W10D4Jd9snZvJv58N56FvbSW1i7phl
        jmsdq7MT4GEjAkhajNsWT9Skobc0N57TKIP2AlSUBJQaY9wFKUPfB/Crwp+Aj1vdUn2O
        qN+nmFHrkOOYhmXV4N7YxvO4Ra/NW732hgb078mj17wyWiWmVGhnyGGSGVZaon0Fbl+k
        LeXKg4quV8ocIb/3ndqNBbRwSxxt46BOmGRYzCaIuxuBla3e3OY6rrlGt/qAxF6g4HbR
        EUWPMUPKQo73BIiyGGgxfb/FI3utGRM0b7ngoy9Y5u+tWVYM0ZVkHcB3qJ9eCIGxhScU
        B46A==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2AyPQjXtNgX"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id K07648v2VA7PX1o
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 31 Mar 2019 12:07:25 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [BUG/PATCH 2/4] REVERT: DTS: GTA04: SPI / gpiolib: no no no, we do not want to "fix" our device tree file
Date:   Sun, 31 Mar 2019 12:07:21 +0200
Message-Id: <6b09a3a40bba24179d5f3620cd2ca2840f1654dd.1554026842.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1554026842.git.hns@goldelico.com>
References: <cover.1554026842.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

just because some legacy boards seem to require changes in the gpio-lib
which make our so far correct DTS/DTB being wrongly interpreted.

A better solution seems to make the legacy handler optional so that DTS/DTB
developed without legacy modes are not harmed.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 1e134dfab428..04f2b53d4d3d 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -114,7 +114,6 @@
 		gpio-miso = <&gpio1 18 GPIO_ACTIVE_HIGH>;
 		gpio-mosi = <&gpio1 20 GPIO_ACTIVE_HIGH>;
 		cs-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
-		spi-cs-high;	/* make the legacy handler in gpiolib not intervene */
 		num-chipselects = <1>;
 
 		/* lcd panel */
@@ -124,7 +123,6 @@
 			spi-max-frequency = <100000>;
 			spi-cpol;
 			spi-cpha;
-			spi-cs-high;	/* here is where it should be but this is ignored by a bug in the gpiolib handler */
 
 			backlight= <&backlight>;
 			label = "lcd";
-- 
2.19.1

