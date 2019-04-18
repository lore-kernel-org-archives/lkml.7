Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FA2C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D278C20835
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dYp4PJHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388296AbfDRIi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:38:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37291 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRIi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:38:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so790393pfr.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 01:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2J/G+YDKHjKA1qZqXV86pFjVgW4CG2JHv9U1E6Kr4M0=;
        b=dYp4PJHFMRhFBebveYpeCkeKD0eK41MQ+C3YRUmi2sNi6wvWxgOe98/Pfme5KfDy8E
         RuUS/LawrPQ5mJAiDY7MWp3tA7zaxYGuYLpH/0ieumBHQh+F47gKmxkr2DsfA+xVr8+/
         1py7tPoQ2sOP+tFEtf/hysxGJ3R2+1+4waQ90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2J/G+YDKHjKA1qZqXV86pFjVgW4CG2JHv9U1E6Kr4M0=;
        b=VIas5/8VBVZzq3ge69zWHjtHvbXsTHFpTBPN3qUWn9hu76mBK7neVZzCQotr4ec+ff
         R3w84SKMF3tIFQqcqJAeC68tjRTdpU2OVyuWSZj0iV9NEHSKA6uK2y4JdDtaFcL+FCJk
         jNCDkn1ZXxPg0J8/0egm9zf4qLYV5L7+qhw47syxZZNCn4Htb5E5RR39XUa22z1b8qUO
         yKgyp/8iMMoJA8TgmtNSbWoJLy9qwraoLKzSewQ8Lcsgkvkad0yP8msZ6eQKUvp/BKRS
         fDZLMav8AMB6snLd7iSznv8O41Ji8s28xW8cyMQ6XoLXWc7CHrOtGm72QgVFbrv9Zp33
         taVg==
X-Gm-Message-State: APjAAAX6d6Hb6joEse9XpqXg9yX/FSDksbjo3z92EtBT4sZrznYscLlI
        7ZG+dnYkHcxxrLCXz9eW31/74w==
X-Google-Smtp-Source: APXvYqxLl5V7JjefPrMtRmYWVdlUNTFgdCy3NBRjDuiu2oYoLWBgewKgjk1fj86ZTdglY6PO/s90rw==
X-Received: by 2002:a62:62c3:: with SMTP id w186mr62368274pfb.73.1555576705545;
        Thu, 18 Apr 2019 01:38:25 -0700 (PDT)
Received: from localhost.localdomain ([115.97.185.144])
        by smtp.gmail.com with ESMTPSA id o81sm2075917pfa.156.2019.04.18.01.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 01:38:24 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/2] arm64: dts: allwinner: a64-amarula-relic: Add OV5640 camera node
Date:   Thu, 18 Apr 2019 14:08:13 +0530
Message-Id: <20190418083813.11776-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190418083813.11776-1-jagan@amarulasolutions.com>
References: <20190418083813.11776-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amarula A64-Relic board by default bound with OV5640 camera,
so add support for it with below pin information.

- PE13, PE12 via i2c-gpio bitbanging
- CLK_CSI_MCLK as external clock
- PE1 as external clock pin muxing
- ALDO1 as AVDD supply
- DLDO3 as DOVDD supply
- ELDO3 as DVDD supply
- PE14 gpio for reset pin
- PE15 gpio for powerdown pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---

 .../allwinner/sun50i-a64-amarula-relic.dts    | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 3819ce396073..56c76b712e3b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -22,6 +22,41 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	i2c-csi {
+		compatible = "i2c-gpio";
+		sda-gpios = <&pio 4 13 GPIO_ACTIVE_HIGH>; /* CSI-SDA: PE13 */
+		scl-gpios = <&pio 4 12 GPIO_ACTIVE_HIGH>; /* CSI-SCK: PE12 */
+		i2c-gpio,delay-us = <5>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ov5640: camera@3c {
+			compatible = "ovti,ov5640";
+			reg = <0x3c>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&csi_mclk_pin>;
+			clocks = <&ccu CLK_CSI_MCLK>;
+			clock-names = "xclk";
+
+			AVDD-supply = <&reg_aldo1>;
+			DOVDD-supply = <&reg_dldo3>;
+			DVDD-supply = <&reg_eldo3>;
+			reset-gpios = <&pio 4 14 GPIO_ACTIVE_LOW>; /* CSI-RST-R: PE14 */
+			powerdown-gpios = <&pio 4 15 GPIO_ACTIVE_HIGH>; /* CSI-STBY-R: PE15 */
+
+			port {
+				ov5640_ep: endpoint {
+					remote-endpoint = <&csi_ep>;
+					bus-width = <8>;
+					hsync-active = <1>; /* Active high */
+					vsync-active = <0>; /* Active low */
+					data-active = <1>;  /* Active high */
+					pclk-sample = <1>;  /* Rising */
+				};
+			};
+		};
+	};
+
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rtc 1>;
@@ -30,6 +65,24 @@
 	};
 };
 
+&csi {
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		csi_ep: endpoint {
+			remote-endpoint = <&ov5640_ep>;
+			bus-width = <8>;
+			hsync-active = <1>; /* Active high */
+			vsync-active = <0>; /* Active low */
+			data-active = <1>;  /* Active high */
+			pclk-sample = <1>;  /* Rising */
+		};
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.18.0.321.gffc6fa0e3

