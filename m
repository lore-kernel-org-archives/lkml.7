Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84284C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCD12087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt8cxJxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfEQSrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:47:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39223 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbfEQSrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:47:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so7272424wmk.4;
        Fri, 17 May 2019 11:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ip1Ip/bBaI3oGl08+c/jPOf0AEvNzRwc1Jgyw/gygxk=;
        b=Qt8cxJxOi8qJ77aqBKyjG/lWcVYYzL6/07gSZutuPuFlBoJoe9yuGAZwcmZZLSHMl2
         YwyJMeCaJwKKUK1oUilHidMuNNn0Z34/PaJSaoJemKOp4QhfVOlfxz+PFpJrrGLq6jCY
         T/n2HF9paCpLR/Ig0BTK8cH/fuJDirjiXDPsAk7Wp63GSaUMyoCoLuFHXO2iVULQNFX1
         4BUDjbYEVkDAO9DHEKgRrqi5eUWO7JB3owY86c3Q4pqYmdntLGXl99w2B1l2PMQXy7gs
         numgqR10zZKf9niYesBego+VhtkRJsOHyd6hdIANTCeHgY5UvNhdC3i7b6JTR72z0ghq
         BukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ip1Ip/bBaI3oGl08+c/jPOf0AEvNzRwc1Jgyw/gygxk=;
        b=Itnk39tTq57FP28d7B4pILysMrUvxvG/XjdNKNGFXGYG9RpGqJzgJGrSIM4FwkoWE3
         xDSK7EUqlF0Onbmalc9ycjwVOOgQDUBO9xcWmc8mPqQA9i+u9+f+YHNI5h3MkTikW9Yy
         ygZeTRDJV8OpGN7So4QVg4RDSnEOlHxa5lrSRjnU0AcLgAHKCNw0FNzX2tavq1OL8nVK
         TTb+alq+5G/Qp80cYITwX6dYqmGQ6JDjzYkZ6ECXLJJzBVuNpmZBEsSFasZHllqyHcKh
         INhOInZ4KGx3Sb7WQ4KKi0+v5mgxUpLEpyzabcqmDyS1OoE03zTP27PY6+Kvicpq8s0j
         IIFw==
X-Gm-Message-State: APjAAAViHl8nUu18wb7xFZXBbFqgKzyQlcyf4NCWkSxCKGoWBX09GlRD
        9/wIlvEjFJu7xe6pozhYSPM=
X-Google-Smtp-Source: APXvYqysPSutaA4puP30zGOzEsfbUgHw1Z4xAikm5f80rIquhXkmO9Pv2pFIkeYXnsuBeQvRIr5jOQ==
X-Received: by 2002:a1c:1f47:: with SMTP id f68mr22674115wmf.57.1558118833163;
        Fri, 17 May 2019 11:47:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id v20sm5801112wmj.10.2019.05.17.11.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:47:12 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 6/6] arm64: dts: allwinner: Add mali GPU supply for H6 boards
Date:   Fri, 17 May 2019 20:46:59 +0200
Message-Id: <20190517184659.18828-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517184659.18828-1-peron.clem@gmail.com>
References: <20190517184659.18828-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable and add supply to the Mali GPU node on all the
H6 boards.

Regarding the datasheet the maximum time for supply to reach
its voltage is 32ms.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 6 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts  | 6 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi   | 6 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts    | 6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 0dc33c90dd60..fe36c6588d8e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -70,6 +70,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
@@ -206,6 +211,7 @@
 			};
 
 			reg_dcdcc: dcdcc {
+				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
 				regulator-name = "vdd-gpu";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 17d496990108..ea4866b0fa7a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -58,6 +58,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
@@ -165,6 +170,7 @@
 			};
 
 			reg_dcdcc: dcdcc {
+				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
 				regulator-name = "vdd-gpu";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 62e27948a3fa..ec770f07aa82 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -55,6 +55,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
@@ -163,6 +168,7 @@
 			};
 
 			reg_dcdcc: dcdcc {
+				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
 				regulator-name = "vdd-gpu";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 4802902e128f..625a29a25c52 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -85,6 +85,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
@@ -215,6 +220,7 @@
 			};
 
 			reg_dcdcc: dcdcc {
+				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
 				regulator-name = "vdd-gpu";
-- 
2.17.1

