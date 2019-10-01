Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9361BC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 07:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B7621855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 07:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdT8HQ33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfJAHj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 03:39:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46732 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJAHj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 03:39:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so7276013pfg.13;
        Tue, 01 Oct 2019 00:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fNc5aCo2FNNct4zlj4DcbJphk7+e/9lUuXxqxufNkHM=;
        b=CdT8HQ33dsPzUsXPrl2pUysW+nAUIfYSBw5M/dw2jbw9tTwfuq6w8ox0zRwcNwFPfh
         3NhFDaeIFn2/nMCZePcYXFKQveCrQAmIANCCb7D1qedvb1mdK5fFIh4TYxpK6OkkrvOw
         z74bDX8y0nmtWeAXMs+hT+g7PzWnsX+BEjA083HT1S7d9q/znrbZGixkTnHLhuRWDrUp
         2aJYPGjluhi3+ylADb+R2T7avwkxXhdbuU8rDVvO91rL2VL4mWWcdfW4lbC+258taKey
         vC/fb0cSxX6bTlVjWHEuJi8zgHk/iIeT2IGeqJmR7TQhMPLJj224om5QQhetW9vdfPRO
         u3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNc5aCo2FNNct4zlj4DcbJphk7+e/9lUuXxqxufNkHM=;
        b=Vl9+kRWpNuar6RvnWDXHXS4muY56J6Uw8J3vJFzOHpJClWD8xr6ks/l/U4DTqOu3CY
         P9VH2Bj8srjPZJEEXMO8dqgTic4eiuqaObZD7qCyiFL/YfXafHoN4TfthcPx7miI91JV
         2vsKyXCHU7frAFe4E/dXfSs6HSdWS6Pd1tQlYK0I8p/kqjGvbf2ZGuRojx6G4ztGTKC/
         sM0JzUxih8vkQcgA7ikQPKBboeAX2FX8xS8PDf6O2YhD2OMrq0Tf6FukyYWNjjL8vdRI
         Dh9cLeS+mX8ixC+uqrtRndo0iQjl9u4TREKvJPgn34EB/YeRVU3XKIUtvwjKb19fiB3s
         0u3g==
X-Gm-Message-State: APjAAAVYfptV+MyqL/pZ+QJzSudGOlt7dVyK7B4MZFucGvix8ERoShch
        tvt7A8Mb2kpbXqekzaWYixWO01dA
X-Google-Smtp-Source: APXvYqwgtK/7jldY+PAliS3rvplMP8Emk6WfbG3i1Hz6v+88R0MQjrfRwFI6nYy3omOa+rOI8cd5lA==
X-Received: by 2002:a63:5144:: with SMTP id r4mr5888508pgl.339.1569915564230;
        Tue, 01 Oct 2019 00:39:24 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.191])
        by smtp.gmail.com with ESMTPSA id g19sm23133024pgm.63.2019.10.01.00.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:39:23 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3 RESEND-next 2/3] arm64: dts: meson: odroid-c2: Add missing regulator linked to VDDIO_AO3V3 regulator
Date:   Tue,  1 Oct 2019 07:39:00 +0000
Message-Id: <20191001073901.372-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001073901.372-1-linux.amoon@gmail.com>
References: <20191001073901.372-1-linux.amoon@gmail.com>
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
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
changes from previous.
Patchv1
- Fix the typo.
- Add the comment as per Martin's suggestion.
- Added Martin's review tags
Patchv2
- Added missing Neil's Reviewed-by tags.
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 5adecdf3b175..2fcd512373a3 100644
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

