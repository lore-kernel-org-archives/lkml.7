Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE59C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382DB21773
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="sPNKZFI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfCaKHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:07:41 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:23531 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfCaKHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 06:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554026858;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=WWZalGAHQUHeT7WX3zQ1/dfR05CU96A7kCwVlJkXlOg=;
        b=sPNKZFI+fcu2wxb7oWmZn6XMkFF8fWxcyIdxNLosRYVxAOmbJcxtNk8TSXzUfNOwdw
        Lx6AjMrRFe+oRIT1YixkcHxvMEOtrpyIF+CrJ7EvjjkbkSaHgg7HrzZoUAcYgYP9p1zL
        qZV94G+O/cUl21dOKCj9F1XcJ7TPEls2gpAlSbAm5GKMunF1o1qWLGNsy322FjIxJMQE
        1K+XiYgTlZsVnm7CkIkN9IHzeBtkgXwL5zMR/LLcxHKqIx5N1Kl3VrCHGys0rZTjo6fp
        0FJC/pq3WLMkWG/s9gO8mjNGqTrWaqhTbTTBq0ja+kdkf9QrC3MNJJXpU6HsmqrDVnyd
        RRtg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2AyPQjXtNgX"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id K07648v2VA7OX1n
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 31 Mar 2019 12:07:24 +0200 (CEST)
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
Subject: [BUG/PATCH 1/4] DTS: GTA04: SPI / gpiolib: work around a regression that unhides a broken legacy handler, which makes the gta04 display inoperable
Date:   Sun, 31 Mar 2019 12:07:20 +0200
Message-Id: <e8d784f7fb06fd3a6a92bc730f919352c4ad4411.1554026842.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1554026842.git.hns@goldelico.com>
References: <cover.1554026842.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an ugly workaround for a regression introduced into v5.1-rc1 by

<c1c04cea13dc234ce9a4504879ddd36ea524d880>

The GTA04 board uses a bitbanged SPI interface to control the LCD and it did work
right from the introduction of the cs-gpios 5 years ago by <c2e138bc8ed80ae291d689917e88d2d09bf1d478>
but unexpectedly stopped with v5.1-rc1.

Since we already use the gpio-flags for high level CS, we did not add spi-cs-high,
which is listed in the bindings documentation as optional and indicative and not
described as required to make it work. And it worked without this flag until now.

Now the newly introduced patch to gpiolib-of.c removes a bug which prevented an
ugly legacy handler for of SPI active high chip select to run. This now suddenly
requires spi-cs-high to be defined in addition to the gpio flags.

Trying to find a workaround in DTS shows that there seems to be another bug in the
legacy handler code in gpiolib-of.c because it checks for the spi-cs-high flag not
in the individual slave node (as one could expect from bindings documentation) but
the spi controller node.

Unfortunately it requires us to add legacy flags to a DTS to make the workaround
code functioning.

I would prefer that the workaround code and the spi-cs-high property is completely
removed from gpiolib-of.c and all DTS which still use legacy gpio flags are fixed.

fgrep spi-cs-high arch/*/boot/dts/*.dts* shows only a handful of board candidates.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 04f2b53d4d3d..1e134dfab428 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -114,6 +114,7 @@
 		gpio-miso = <&gpio1 18 GPIO_ACTIVE_HIGH>;
 		gpio-mosi = <&gpio1 20 GPIO_ACTIVE_HIGH>;
 		cs-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
+		spi-cs-high;	/* make the legacy handler in gpiolib not intervene */
 		num-chipselects = <1>;
 
 		/* lcd panel */
@@ -123,6 +124,7 @@
 			spi-max-frequency = <100000>;
 			spi-cpol;
 			spi-cpha;
+			spi-cs-high;	/* here is where it should be but this is ignored by a bug in the gpiolib handler */
 
 			backlight= <&backlight>;
 			label = "lcd";
-- 
2.19.1

