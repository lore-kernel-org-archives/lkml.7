Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FE6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029E72084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Kd8dsrB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDHFyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 01:54:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34315 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfDHFyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 01:54:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so6655138pgq.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 22:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6l0dSdFF4WCYp2QwS6OTopGcAlUv8JXieQgw4XEpynM=;
        b=Kd8dsrB8YqUg/j253TMFqmXt7tisBy7WbuhlOt7NnV9zbai8rqQFguV8xUfcAxAODZ
         IL4VZnmDQFncbGNpfzVHV8i2ftPShwkKFLHYeD7+MuYiHRCYvUeqJ+GIACkm5GOb2FFj
         MGVWzruNcJj2GSzwnOCz1Mxg7FOA7YH2Micic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6l0dSdFF4WCYp2QwS6OTopGcAlUv8JXieQgw4XEpynM=;
        b=iyaneIovtLfPFLHAocfbJ2+zbmnoOrgn72P+YuP7+STuZrfk+Yv6STiobYeOefw4iG
         SaNekOuurZPYkdudnmjdG/C/auhDpCy+8u8KnctYoYEIS98kOX2AMnAtJ+NH17dclw53
         I7Vln9kEPDlw/lzJsw9Ae6nr13SIOXqv1G+x/ki/Rt/u8nNXiCjQMUEdnyj8ivjr1N5p
         X9eWglThn+wVmMGYDQ2MLQ4cQUxKBsepM4izfx23Q70y7Pcsvmoq8E++X+wLBzH0Ombd
         ZoewkKlQHub5DBPsQNnRCE2oirMTbmP9ayGxLbdrW0FtibfY9H2NpMap6DlTABJJWXcU
         g8iA==
X-Gm-Message-State: APjAAAX+sQfKWJgbW7Ms3gMuJfHyQAIxKPFNIih2i61f8hVIrGv6/JsA
        Jw2TE/UFcXfLln3nM/aXzbms8A==
X-Google-Smtp-Source: APXvYqzE3XCiuI0FWVAcXMd/+gXXx7NwcuMXdaTbvD2EBFHwZl1kve3WJ3hqOchBK1U9179Syz51Pw==
X-Received: by 2002:a62:6c43:: with SMTP id h64mr28593142pfc.123.1554702874291;
        Sun, 07 Apr 2019 22:54:34 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.217])
        by smtp.gmail.com with ESMTPSA id l1sm31076164pgp.9.2019.04.07.22.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 22:54:33 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/2] arm64: dts: allwinner: a64-amarula-relic: Add GT5663 CTP node
Date:   Mon,  8 Apr 2019 11:24:14 +0530
Message-Id: <20190408055415.1374-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Goodix GT5663 capacitive touch controller node on
Amarula A64-Relic board.

The CTP connected to board with,
- SDA, SCK from i2c1
- GPIO-LD0 as AVDD28 supply
- PH4 gpio as interrupt pin
- PH8 gpio as reset pin
- X axis is inverted
- Y axis is inverted

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../allwinner/sun50i-a64-amarula-relic.dts    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 3575db216016..a76353d59aaa 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -49,6 +49,28 @@
 	bias-pull-up;
 };
 
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	status = "okay";
+
+	touchscreen@5d {
+		compatible = "goodix,gt5663";
+		reg = <0x5d>;
+		AVDD28-supply = <&reg_ldo_io0>;			/* VCC-CTP: GPIO0-LDO */
+		interrupt-parent = <&pio>;
+		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
+		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
+		reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH8 */
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+};
+
+&i2c1_pins {
+	bias-pull-up;
+};
+
 &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
@@ -212,6 +234,13 @@
 	regulator-name = "vdd-cpus";
 };
 
+&reg_ldo_io0 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-ctp";
+	status = "okay";
+};
+
 &reg_rtc_ldo {
 	regulator-name = "vcc-rtc";
 };
-- 
2.18.0.321.gffc6fa0e3

