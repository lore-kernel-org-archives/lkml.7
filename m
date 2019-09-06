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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B25C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B96208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bdt98gm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404711AbfIFMdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:33:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43671 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404687AbfIFMdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:33:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so3080534pld.10;
        Fri, 06 Sep 2019 05:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vGfjddqvpRFJCrBIPxEpBGcV3pVBssJwGgtFL9Le0kA=;
        b=Bdt98gm5oqea5uLdu8RYPixSg1ZQwKdmeABnC6snkO69Jlb7mS5e8vFkpHhE1x0dyi
         HhON2KNE6ylCWbUYp3PXFTLtZ7qtKxMAWUVSXTlszuD9dJ+MeIVkaRRWwTEkQ2WVRmDc
         Ek6EWmGrDD8Xym8avPsGdl88FlQFFvqUu52LrEqVfzU1Sjd5r2PNHded82c1qpY1mE6O
         OhOQg7bjI4DXA8IWCVgEyMU54p+1frp/fyDbWIPDVRD6EvyVd5eZhs6hZHEh/Lhof0HH
         nPpEL+R14Hym2/rvvn5RdKIjEXVmSws13/cHSKoyALu5x/xIKkaaJUAndl1cnXIZ7IXo
         yPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGfjddqvpRFJCrBIPxEpBGcV3pVBssJwGgtFL9Le0kA=;
        b=OzqvKN6kD52mz1dxqk6WSWmmw+ef3q0MT2qpM22KGGkIUj/j7juD9sslwD5/o+AjUY
         9agzncC+SKTuDruvlBbssueN2G09vbiYinDTTRKHrLBBqsLk+fcBI3ePidjZuId3vLfY
         dCcC05XvQ3hvZOrWfdfswRerid/f5FwEBpLo4KWewq36WdhAtUuXdyeCfNZlfNk/foDK
         AzIeNqebmlWCP+9dsMQCEBmU9ubbSBlaeRGTfFT82jF9bnlk2ZPb+WwPBpW9xeKOZF/O
         UugWVxs3ErM0TrdUWWfPcXZdjM4ZIqOzYu0ha7PPlzYVLmp8HdLqcAsMV/LoN2I8TG6V
         JBbA==
X-Gm-Message-State: APjAAAWHBQ9nklyLqONozzxOflKGcGIueV2gj4ESHRFwMRw9Qya9q3G8
        7FlypOdVrQDOoEXKxBmeuEQ=
X-Google-Smtp-Source: APXvYqxPoCY0Iputq8fkikyBk2Nk0t4gfljXTYb5kbWgW/LosC9l/1+fqNEgth+XX7w5vr2UL9TNIA==
X-Received: by 2002:a17:902:e60d:: with SMTP id cm13mr8790686plb.178.1567773203464;
        Fri, 06 Sep 2019 05:33:23 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.203])
        by smtp.gmail.com with ESMTPSA id h70sm4752933pgc.36.2019.09.06.05.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 05:33:23 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3-next 1/3] arm64: dts: meson: odroid-c2: Add missing regulator linked to P5V0 regulator
Date:   Fri,  6 Sep 2019 12:32:57 +0000
Message-Id: <20190906123259.351-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190906123259.351-1-linux.amoon@gmail.com>
References: <20190906123259.351-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per schematics VDDIO_AO18, VDDIO_AO3V3/VDD3V3 DDR3_1V5/DDR_VDDC:
fixed regulator output which is supplied by P5V0.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes from previous.
patchv1.
- drop the rename and linking vcc3v3 regulator node.
- fix the typo spelling.
patchv2.
- change the vddc_ddr node name to ddr3_1v5 as per Martin's suggestion
- Added Matrin's and Neil's Reviewed-by.
---
---
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 3e51f0835c8d..9ea336c33d00 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -111,6 +111,36 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	vddio_ao1v8: regulator-vddio-ao1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		/* U17 RT9179GB */
+		vin-supply = <&p5v0>;
+	};
+
+	vddio_ao3v3: regulator-vddio-ao3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		/* U11 MP2161GJ-C499 */
+		vin-supply = <&p5v0>;
+	};
+
+	ddr3_1v5: regulator-ddr3_1v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "DDR3_1V5";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+		/* U15 MP2161GJ-C499 */
+		vin-supply = <&p5v0>;
+	};
+
 	emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
-- 
2.23.0

