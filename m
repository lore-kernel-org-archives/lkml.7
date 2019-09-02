Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558AAC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D33B215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZSjtEc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbfIBI6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:58:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38750 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbfIBI6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:58:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so2121421pfe.5;
        Mon, 02 Sep 2019 01:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Evc5Oocb4Bzm/ej/oCNbe7g2Kw/0/LCaIG/fqce+EF4=;
        b=YZSjtEc9my+Zw5OYisr9t38RV2Ii6+D8ie4L8pPbYsDAVb+zlcz5b2PZHhtKhzsadA
         Q/q70gecmRu1o5gzfudJdASqtiSKf3O2+ULNZzy1Qj02blosRLcnkzYThmEY6B4VIhcS
         U7QveRl5LADdmiLcvQur4QWXZ98/Kx54zOgMZQHeePm8M0LvVnvDWM7aV6KyNjoMf3d5
         eIZFWwnGzaMqP24Eccspd0GjKIR06mNVqp63SCDnx6F7PuWjzKqLNInmYHV+dvl2q19m
         MlO+xrPE2zkiF1HzdqpndD2HeQAUTVifo+xNXmKxAyAeYKmZZh0+QGtXcxaX4wdWlXDq
         s8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Evc5Oocb4Bzm/ej/oCNbe7g2Kw/0/LCaIG/fqce+EF4=;
        b=Im/5dWZp0od3cYQDXsislJ/e5g1GkbpYyVlN1mGYfW1fu99Bw93fJEKnB63/OCsad4
         BRcC8cenm7vn/PTiZT12+Cee1gevezk4oIncAwha5rFBiDIlB6EXdTKfuwuwH/FPQoG+
         zS6QB1Vmr3yS8UYbtDt26t8d1fNjA9aXAC+8Nd4ZWuxCV95OmW9Xy9VMI0NY0EFigTJZ
         hiXr3cao/ly9vNmW1eltDF4liCuAOmrO5XmRKeF9ahERnKOD+QOxC46rGKYI3HJWTjp7
         9uaJGGkTDml4wDYHcRUnXFqro7XLTaKpfMxPSCUL5tMUcEe9aw1fJMuailPvMo8vSJqa
         CpUA==
X-Gm-Message-State: APjAAAXLJuFtwcIVgTucCnXMtkF/A7R2K8LKox6JpDOa4VfPbz/sBUTz
        J892PyHWIHeSFjZTf54aXN4=
X-Google-Smtp-Source: APXvYqylOpDpihTs4Yfbu+0WeAi5mvhaQO6NnrVMoTglbxIZFpO1NtjwH1v0mc7Axr7ak3OLF5U7Mw==
X-Received: by 2002:a63:5765:: with SMTP id h37mr23673532pgm.183.1567414721301;
        Mon, 02 Sep 2019 01:58:41 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.203])
        by smtp.gmail.com with ESMTPSA id y6sm6313117pfp.82.2019.09.02.01.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 01:58:40 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2-next 2/3] arm64: dts: meson: odroid-c2: Add missing regulator linked to VDDIO_AO3V3 regulator
Date:   Mon,  2 Sep 2019 08:58:20 +0000
Message-Id: <20190902085821.1263-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190902085821.1263-1-linux.amoon@gmail.com>
References: <20190902085821.1263-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per schematics TFLASH_VDD, TF_IO, VCC3V3 fixed regulator output which
is supplied by VDDIO_AO3V3.

While here, move the comment name with the signal name in the
schematics above the gpio property to make it consistent with other
regulators.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
changes from previous.
- Fix the typo.
- Add the comment as per Martin's suggestion.
- Added Martin's review tags
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index b763b76820ba..ef2c3b74415b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -67,17 +67,19 @@
 	};
 
 	tflash_vdd: regulator-tflash_vdd {
-		/*
-		 * signal name from schematics: TFLASH_VDD_EN
-		 */
 		compatible = "regulator-fixed";
 
 		regulator-name = "TFLASH_VDD";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
+		/*
+		 * signal name from schematics: TFLASH_VDD_EN
+		 */
 		gpio = <&gpio GPIOY_12 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		/* U16 RT9179GB */
+		vin-supply = <&vddio_ao3v3>;
 	};
 
 	tf_io: gpio-regulator-tf_io {
@@ -95,6 +97,8 @@
 
 		states = <3300000 0>,
 			 <1800000 1>;
+		/* U12/U13 RT9179GB */
+		vin-supply = <&vddio_ao3v3>;
 	};
 
 	vcc1v8: regulator-vcc1v8 {
@@ -102,6 +106,9 @@
 		regulator-name = "VCC1V8";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		/* U18 RT9179GB */
+		vin-supply = <&vddio_ao3v3>;
 	};
 
 	vcc3v3: regulator-vcc3v3 {
-- 
2.23.0

