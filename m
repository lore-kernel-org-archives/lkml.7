Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9369C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735C321743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+NTyOQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfEUQLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:11:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40928 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbfEUQLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:11:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id f10so3873742wre.7;
        Tue, 21 May 2019 09:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ip1Ip/bBaI3oGl08+c/jPOf0AEvNzRwc1Jgyw/gygxk=;
        b=h+NTyOQl+TEZLatjt6/a4g2R3AMJacJWXFbf2ZmYrIGSFQCJi4uPljnwGSwgmmGSXh
         q+dpQUWud2oF76sb6BcbO5jnr/hX3M+t2lyopkcBTBo4zTkdZy1e+2qt+fzrMJ9zTofB
         aNReptxCaUUZiuLivNOiJlF6U2eWDnpacZ+APXCdXzFQcfHNVF+QQaHhauHH53xiECI6
         mhH/uPN2t54FSMwNEL+0ki3T1hOCvQkochF3w7oMvtDXDvpCJnwbboa0KJBiJCrTSAA9
         PLx83f6WUo1tjNIJjNkeNLzwfPMLQADkQqUiUP3Ga5iaUjDId+FULk5SV1wSczYgTf5p
         acVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ip1Ip/bBaI3oGl08+c/jPOf0AEvNzRwc1Jgyw/gygxk=;
        b=DRmjwgixnJKCqLUsslvuNJavLbI6N7xowuTGlS6CYhDsl8VjJ2KeS15wDEADRL5sZV
         7s5k9fNA2NsYCIlhNRMpsWuRz7UYuwNcwYmaaZAdpkJFczcMs9kfPJSVid5thg/trQpq
         Fb0BY2Vq6bl7TyoTturzuJrLqx6tzeYCwBtQiO1OAw3a12O2rZ85D1NB3SnkXWl5KDpJ
         sjA4MGX5gZ8YKGdn1GB8uVP2DjugiygUeOEsqOI+YPTM81puLKybi2cQsf812l2Y0ghT
         RUrVu30KAHyYeDIyDDswhezd7dOfoCCAWxM03OkmSOc9/cTyZgBeruXnb/b/sp0000FX
         CIrA==
X-Gm-Message-State: APjAAAX9NLC+v3mgXC4qUW5ig6QaCZcYyQmqp1Y7jzROkW8Lsko3KAay
        uudUyH/XZs7nD75fiR+ENAk=
X-Google-Smtp-Source: APXvYqy20A9dEOCcgXXitDLonYuo4h0Gko7h5PXdbB6eJStF5KSNRpJPD3LRRJAFRt/SXZ1+Ym8Efg==
X-Received: by 2002:adf:e80a:: with SMTP id o10mr22701577wrm.79.1558455075148;
        Tue, 21 May 2019 09:11:15 -0700 (PDT)
Received: from localhost.localdomain (18.189-60-37.rdns.acropolistelecom.net. [37.60.189.18])
        by smtp.gmail.com with ESMTPSA id n63sm3891094wmn.38.2019.05.21.09.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 09:11:14 -0700 (PDT)
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
Subject: [PATCH v6 6/6] arm64: dts: allwinner: Add mali GPU supply for H6 boards
Date:   Tue, 21 May 2019 18:11:02 +0200
Message-Id: <20190521161102.29620-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521161102.29620-1-peron.clem@gmail.com>
References: <20190521161102.29620-1-peron.clem@gmail.com>
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

