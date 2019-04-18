Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5D4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581C12184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="E7ePRdEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbfDRIgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:36:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44872 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388277AbfDRIgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:36:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so774726pfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 01:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sQCAZaAXBkJK3V2xhT9DV7p/g0whMniNBsAqfvNfq5A=;
        b=E7ePRdEua5Y/nKFph532lVLSrx6qVjP8UuCT3vkJAS3D8lnvwkih9LU7/oE5K2Lz14
         rtJ81wIkKNRZ/q5PD8Ri2KohELOHA/HRw2Uh+fGY74mUoLRYkqXnrqu45N+X74Rgmjn6
         Ss0TgOl7ISMQE+RVI4Mh9r1KWvzXakUZcjOas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sQCAZaAXBkJK3V2xhT9DV7p/g0whMniNBsAqfvNfq5A=;
        b=AxT/aXTcHx4VmWyYlZdzJuvo6MxjZjlWEXYP9RsDIN6kURRjepKPptkm3QhFyFa8yO
         hNA52EG6Tgb1NasUBmryyOA9/g1LGLmmV699ixz4cmafjBhqAoEYjzjUTXdtEWDjccNg
         JP1VtYv+VZs6xjhB4pWupxZgL47b71lw2KW4d2eVnLmjoxcD01Y7qd6r8QYCbIaD+Ork
         MZvD7BLSFfN+/+4rR6Gk+pr1bjHMwLIQTK90MzPFY5yi1fgfF6XwFDaIs/Lg8fNluIy6
         5enL27RPO9Xh3tpIAOO/ASHOJXhIvA+EqgKTs6dTcAV+YfkE1JblkiaiyZeJQP43s8CR
         613g==
X-Gm-Message-State: APjAAAUw1EHxcM0xEhpuX8EHvneG64YBMm9MlW2zeZfZEZz7YKe6TykL
        P0ZCzKdNEWUGlxelNn0dga+sQw==
X-Google-Smtp-Source: APXvYqxbKutK9zqdMhdY2AOWz1u0TnXORNhyXKh6+kpHXUqCTPriBxJYw8MpLcxIrWDSOOdatm9IEw==
X-Received: by 2002:a63:c112:: with SMTP id w18mr88519262pgf.200.1555576561226;
        Thu, 18 Apr 2019 01:36:01 -0700 (PDT)
Received: from localhost.localdomain ([115.97.185.144])
        by smtp.gmail.com with ESMTPSA id s12sm3166255pgc.28.2019.04.18.01.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 01:36:00 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 2/2] arm64: dts: allwinner: a64-oceanic-5205-5inmfd: Enable GT911 CTP
Date:   Thu, 18 Apr 2019 14:05:43 +0530
Message-Id: <20190418083543.11695-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190418083543.11695-1-jagan@amarulasolutions.com>
References: <20190418083543.11695-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goodix GT911 CTP is bound with Oceanic 5205 5inMFD board.

The CTP connected to board with,
- SDA, SCK from i2c0
- GPIO-LD0 as AVDD28 supply
- PH4 gpio as interrupt pin
- PH11 gpio as reset pin
- X axis is inverted
- Y axis is inverted

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- drop i2c1, bias-pull-up 

 .../sun50i-a64-oceanic-5205-5inmfd.dts        | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
index 6a2154525d1e..02c1a04cc7eb 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
@@ -37,6 +37,24 @@
 	status = "okay";
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+
+	touchscreen@5d {
+		compatible = "goodix,gt911";
+		reg = <0x5d>;
+		AVDD28-supply = <&reg_ldo_io0>;			/* VDD_CTP: GPIO0-LDO */
+		interrupt-parent = <&pio>;
+		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
+		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
+		reset-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH11 */
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+};
+
 &mdio {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
@@ -52,6 +70,13 @@
 	regulator-name = "vcc-phy";
 };
 
+&reg_ldo_io0 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vdd-ctp";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.18.0.321.gffc6fa0e3

