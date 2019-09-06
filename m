Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB884C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2566208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNvSL3ZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404723AbfIFMd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:33:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39206 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404687AbfIFMd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:33:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id s12so4380690pfe.6;
        Fri, 06 Sep 2019 05:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1q69QNZwyCxZwRo3C/LHJfNu0oJxZkgoeKYpJf6LVDA=;
        b=BNvSL3ZAzGJGTokL2No8cyUTNZDT9TLKYOXlxXKNruvFhYssGfuEQ3aLx2wb9tCUCH
         PHEiprtHlcmHALDN+Z2UxkBm6fwd/Sh6O5GfDaLl5t/4UsgQ4UMt6GjfA1NNDYRznHkX
         CxUCbLZfyCDtEOy5GOxF82yE0F6NHMFfkQ3l+8EXYHw+FlQu45TrE+I1LEbID02ILP6k
         xS1Ov+EHQucQadlGMLtKHCwXpmKIFDLCcQvRRfw2G8HnxsRlfioA6uD4gtM+5t1CfA6Q
         tEAJnA4AmoTM6TTOFf6wh1ZdNZvLPPcAkyO4AWut2vrYYZsTKZZrATRqfutNsl8axAxz
         mQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1q69QNZwyCxZwRo3C/LHJfNu0oJxZkgoeKYpJf6LVDA=;
        b=NLv/Djmehjh9t0cq6jCvECT/tPYl2ICJZRNHJxI+Y6zwd69isREYtwVf6N7ZZdXSPJ
         r9oaiYv8V6c3jGbaTUWfdMGmf4WgVrdmzouHyc9fB0Ry4RxFazhvpADe1p3lBmymSLO1
         nI19av/8fXOl0YMVa3ndG9DbNUCmf53wCv75JLccC5uzMma6Z/7ZiObOzNpZ5s/xNVW+
         vnYDOhP8lx6aDHo1vUkOB1NFjnRHI9axl4JtiqarBLjYABHGMfjreYznEOKSXKA3T76G
         wlYblJIxAdwcNSYOnripKkAbRb++CSEnpNsxSSmyflbQ5Nep9YLDLjHakg0wFqHtDfnm
         HpWg==
X-Gm-Message-State: APjAAAUafp1FUP5e1bBn9vve5aSAg5Y9HS5br6AdqoABVsWvcv+UJFcp
        RcYBwlDq4fO74EWkqQw9gPE=
X-Google-Smtp-Source: APXvYqxUij3K9fJKMk7ZoMDBdfQ/kF2Eu75kBlo9YQSPuiiSdwawYEpUrkHNhhBGqKO+v8oRXbr1oQ==
X-Received: by 2002:a65:654d:: with SMTP id a13mr7600875pgw.196.1567773206808;
        Fri, 06 Sep 2019 05:33:26 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.203])
        by smtp.gmail.com with ESMTPSA id h70sm4752933pgc.36.2019.09.06.05.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 05:33:26 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3-next 2/3] arm64: dts: meson: odroid-c2: Add missing regulator linked to VDDIO_AO3V3 regulator
Date:   Fri,  6 Sep 2019 12:32:58 +0000
Message-Id: <20190906123259.351-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190906123259.351-1-linux.amoon@gmail.com>
References: <20190906123259.351-1-linux.amoon@gmail.com>
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
index 9ea336c33d00..5624ff034659 100644
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

