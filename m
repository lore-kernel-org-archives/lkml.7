Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31761C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 20:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D870F208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 20:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXSmSfYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfHKUb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 16:31:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34892 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHKUb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 16:31:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so10035934wmg.0;
        Sun, 11 Aug 2019 13:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VmJANs6ADrzmj7CF2pwPHk66RmEAqBp61/Sj+xq22Nc=;
        b=oXSmSfYFRVvVK9HlfrUEv/VpPMEzztyoEuPkETohNSxYvim/+DIFnl4roDjE4M+Q7C
         pM1GWR5ea4sg3sA5Urj8lLcwC/4wrt9HGUM9wu3ukdZrg9PM/T2AnU7PeL2jS+Yd9qmk
         C+I46kDxvxT9ZLL7aAmVXOUxzzrWfhBZImGF3EwNOobu0O1H+SkMec/i35IXDeDsNDap
         Pvh6xpJS596vjLoSVUpaX8uv7FraOaV6E6zziqDrvOP5vAmWV85V9RYikAjAxVHp+S1J
         a5APp4StEx+4Z8QwY83WduuxACFSqRMP/SDgLT7V8erZRCQRQMBIWiYZQY6s/OeT/YyG
         FfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VmJANs6ADrzmj7CF2pwPHk66RmEAqBp61/Sj+xq22Nc=;
        b=X03zpLDML+xaU104dVhqkCZjUIfMgQ50TrSEbTBe3WW4C9zyVLDWg3wWsFapCwR9Xz
         hFL76ihXOwlqmJbbOmb2u05iaRyUovOwJhtmMzO3rY05x6hplesmBLdEEvwWaMdVlchf
         0yPrRDzn0vVanEgrT2Bqcj7q87Irxmns3mRrsvrCWmwvLDWfQb2Uv+rPgjyvnX5/zy3v
         /Yc2dyBrg+YB1lwcFfBfJzKcANtVG0ymtiy6KDR+TZ5586cZHnD8+o2CwAZ61Xe6u4RU
         fqUbbg6elR2Wz2KjA3cOnJmo4W2SFyQBOnxh03rHRcw2Q7U3gayTUZ9A7RtWnMRFpKn+
         iIrA==
X-Gm-Message-State: APjAAAV47SKPIX7Hmy2yUBLa83feErIBGS7AhOUpBjagcPP4UowHagtK
        FyjBEqHrUfEhJImOCpcbqFs=
X-Google-Smtp-Source: APXvYqz5EW5ZeCJAojOp6CW/ocpmh260LXSUmp5dYTFVkvKIjvNHd65nG3jLSSoKZIhate3Y+4Eksg==
X-Received: by 2002:a1c:9a95:: with SMTP id c143mr10613581wme.2.1565555515436;
        Sun, 11 Aug 2019 13:31:55 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id a8sm11063269wma.31.2019.08.11.13.31.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 13:31:55 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 1/3] arm64: dts: allwinner: Add SPDIF node for Allwinner H6
Date:   Sun, 11 Aug 2019 22:31:42 +0200
Message-Id: <20190811203144.5999-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190811203144.5999-1-peron.clem@gmail.com>
References: <20190811203144.5999-1-peron.clem@gmail.com>
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
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 7628a7c83096..677eb374678d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -83,6 +83,24 @@
 		method = "smc";
 	};
 
+	sound-spdif {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sun50i-h6-spdif";
+
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_out>;
+		};
+	};
+
+	spdif_out: spdif-out {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
@@ -282,6 +300,11 @@
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
@@ -411,6 +434,21 @@
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

