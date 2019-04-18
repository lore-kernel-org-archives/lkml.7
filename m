Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4104AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1203A21850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YXL7gweD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389271AbfDRNww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:52:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36378 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389103AbfDRNws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:52:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id ck15so1220327plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 06:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=usMx7S8Zw6gUlsfBkvTuHsgMXBMVM7qEmvo3v4uBHU8=;
        b=YXL7gweDXtyBn6HCEMv5zezevn3zKx1r9RxsCN+kGRWRZ/BCciT0yab8Su19+d5hAm
         efPab9f5PtMz1K1brSqSOSaOOUlBsEOOmgnmyhNLoQGO4wNXPfx2jspLbxarjLMBm19Q
         3jkzIalz1N8t85FkiZSdGaEUwQyqtIRmnj0SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=usMx7S8Zw6gUlsfBkvTuHsgMXBMVM7qEmvo3v4uBHU8=;
        b=gZ5zkZ42klLmNvP1gxgmMNytq2GVlabi+VDi1+klXZ2luKAeVMWl0AhpSV2e8LhPnF
         et/lrtdJwxA0oz/As3+8YrTFPqObdK9Og5Ple7HHN0FiG4qk5+77T/9SoMqvmx4BYdW3
         ox+Kcw+8zZyV1QPtzzHMGEeb+KSyaOA0dJPAKcxQrtLJGCe8Cn84flX6GhP3ghrY+hp6
         6biS7KRdJA/hbGo89Ag5cyeB6Vk12dnRJMTSvI8bFzkveQHN9FfhwGsl96Ty5tzsiohy
         tFwPgKsHcUlTunWl9XlyI3ORRQeJOPFWDGr7t9y8WLoc61hJGqNe7E/teJcrQaVwr/oN
         3U3Q==
X-Gm-Message-State: APjAAAV4tPmZKAFun7qNO51OvIW5K4ynxBZLEsAmf9ncKUqEIg9lEOgn
        UGdGjtMEM3Jf7K7nD4LdGn3aIQ==
X-Google-Smtp-Source: APXvYqyGJ82XUBGXpACu4ZVxlsUvxlhcMlAGp9G3WbMyBK9fkNeI3B4zt44VTr7vl8Ei51IdBuHCVw==
X-Received: by 2002:a17:902:784d:: with SMTP id e13mr96739166pln.152.1555595567749;
        Thu, 18 Apr 2019 06:52:47 -0700 (PDT)
Received: from localhost.localdomain ([115.97.185.144])
        by smtp.gmail.com with ESMTPSA id c5sm2357861pgh.5.2019.04.18.06.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 06:52:47 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 2/2] arm64: dts: allwinner: a64-amarula-relic: Add OV5640 camera node
Date:   Thu, 18 Apr 2019 19:22:32 +0530
Message-Id: <20190418135232.9368-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190418135232.9368-1-jagan@amarulasolutions.com>
References: <20190418135232.9368-1-jagan@amarulasolutions.com>
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
Changes for v2:
- use node name as i2c instead of i2c-csi
- drop i2c gpio pin documentation
- drop unneeded address, size properties 

 .../allwinner/sun50i-a64-amarula-relic.dts    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index bd31a4385bc1..7bb1d93f5e65 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -22,6 +22,41 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	i2c {
+		compatible = "i2c-gpio";
+		sda-gpios = <&pio 4 13 GPIO_ACTIVE_HIGH>;
+		scl-gpios = <&pio 4 12 GPIO_ACTIVE_HIGH>;
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
@@ -30,6 +65,21 @@
 	};
 };
 
+&csi {
+	status = "okay";
+
+	port {
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

