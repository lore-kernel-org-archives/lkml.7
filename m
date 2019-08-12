Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FBBC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B030820663
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFXOj+d+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfHLKv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:51:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40284 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbfHLKvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:51:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so11339131wmj.5;
        Mon, 12 Aug 2019 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E6tk82k5TW54Tmi+3csD4OKmu7+dtwlB6O+wvC9mbyU=;
        b=FFXOj+d+O9qgInIVXb+Sftndtm05JphCPhcUol3hrBE+2Q+2OuhLTyMNJmheL0djcD
         gbuQJs8q9565e+PIwD7RxJ62El0N2FEi6Buo6yjREUkvPyxDraK0pbon0NhGJla+6r1z
         lerT5NsDc33Ih7WN7RXKWZ2hQhhaHFuvsbo8yjOIh6vzeNe5BncMwRy5P81G34DzB10q
         u6xhvJW3J/gsKIzhC2RV/4kcuDgmOBcQlrLdCAPc3ivPdDgZUf2iKh73IYJ2Dv96c6LP
         1OqlPXvjt5xnl4AU1/oHN0m+GLRP/zaYn//65jYOm09yj8roL+9bTUxpMcEcpieKHxbx
         m8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E6tk82k5TW54Tmi+3csD4OKmu7+dtwlB6O+wvC9mbyU=;
        b=UiCMCYKX1LS+p3XR2KlVbd6hOJmARuLmJTd8kDapm3MvwyFAQAVuhGE0Q851BIMpx7
         tHTDxKfFSlNWm1e1SIkqePBKWSiUnrxUFj18zU3eLU0FBZN4gDutVyF8v9CdHdziW+f5
         ix+rTlvdmu25ulIKBqWI1X2PxGsqO59U0+vbPly5tz5oK3KUO/OMWT3xb4U1gV+WIQB0
         F3zPbEFsZ0IAFUQvupfl+zIVcYN4TK8cpYzFehzoEj2Lo+Paya5Y58J4QImUzweMiUok
         47XD0bKP/QM4UACXQbZFYKz5TTbgiKkFtLYbUFecY3ul/TKGyFf0YBe8/i+/SWcjx+QQ
         xHuA==
X-Gm-Message-State: APjAAAVlbf0dOeP7xBKucgwoRMQ5EyGoaf+j+IMZT+jgRDMkpfM5Wxv1
        myNzoHm4QdByqTLcXvJRFB4=
X-Google-Smtp-Source: APXvYqz3iWhMUmifg53tK3NRpq7zKWmNYACZQgK+R7BpcssqngYhmlMV2tEFxt29aLSzmCM7t5zo1Q==
X-Received: by 2002:a1c:9d8c:: with SMTP id g134mr7086261wme.174.1565607082211;
        Mon, 12 Aug 2019 03:51:22 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id z8sm22797916wru.13.2019.08.12.03.51.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 03:51:21 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v6 1/2] arm64: dts: allwinner: Add SPDIF node for Allwinner H6
Date:   Mon, 12 Aug 2019 12:51:14 +0200
Message-Id: <20190812105115.26676-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812105115.26676-1-peron.clem@gmail.com>
References: <20190812105115.26676-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner H6 has a SPDIF controller called OWA (One Wire Audio).

Only one pinmuxing is available so set it as default.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 7628a7c83096..2ba9ab9e0924 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -282,6 +282,11 @@
 				bias-pull-up;
 			};
 
+			spdif_tx_pin: spdif-tx-pin {
+				pins = "PH7";
+				function = "spdif";
+			};
+
 			uart0_ph_pins: uart0-ph-pins {
 				pins = "PH0", "PH1";
 				function = "uart0";
@@ -411,6 +416,21 @@
 			};
 		};
 
+		spdif: spdif@5093000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun50i-h6-spdif";
+			reg = <0x05093000 0x400>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPDIF>, <&ccu CLK_SPDIF>;
+			clock-names = "apb", "spdif";
+			resets = <&ccu RST_BUS_SPDIF>;
+			dmas = <&dma 2>;
+			dma-names = "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spdif_tx_pin>;
+			status = "disabled";
+		};
+
 		usb2otg: usb@5100000 {
 			compatible = "allwinner,sun50i-h6-musb",
 				     "allwinner,sun8i-a33-musb";
-- 
2.20.1

