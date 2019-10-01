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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8163CECE589
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 07:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DF621783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 07:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/7FT9kK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbfJAHjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 03:39:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34964 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJAHjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 03:39:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so7309010pfw.2;
        Tue, 01 Oct 2019 00:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vQloSqq1S1f6ce47ZLYZIYgNVEPsLkyayY9R9KD8bAM=;
        b=q/7FT9kKIawKa1EBPyh1LsnnoopEuNjbwgs50LHVEtRTpkYEPn+9BY0bzXafTZpvt8
         7m5gedVizYhbr7JZWT/WLie/T6VeRToFKhclltU1miC65fzVRkVwwjcn6Mlt+OJZxbCQ
         E6H2AX4Ttq1IVO020AZUAoBzfqhZQZycalnchZEHpX0RP+L1fiV28FQfBV/JGJXp9Rrl
         QODr3fvLDrrdXeY4lchqjXs3cnrcS526xFwyfUFlTY07fZYGVu0Ro2EkL6+oRkPeQ6L0
         znX93JEiCeKqzZm2BovvM4mHaVsLZlr4BuA4+6n8GRBGzSWolVLR9zBIINHuOus03u1n
         VUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vQloSqq1S1f6ce47ZLYZIYgNVEPsLkyayY9R9KD8bAM=;
        b=KMAQ6dpx0ABbJQPTQcAftAcuskAo6I/JQRLDd2mOdq8qtjrotmWBLJ8r+dnPv32Gy2
         HZqxOmTlHho4p1e92U5vCQYBd6uEQ+Uhjh01yWdj/imfKvcqV/dnbjDR2lteqL0ydcdh
         KF+cpqLCWjth0vR6kIYpPOBo5v+ysQmcw47GpH6ppub4slmbUioB0LhUyj+SWm+iz8SY
         sjUgCjKHX6jCn8Z2Ao7Obxvn8/MlIQXJ93soZHhBT5OItMdq1YpZ8nWetUfYJwQ2P2ea
         MggSqWV+oI/TEtbIBUuDVjyi/jKlyheb4ztZo8FcdAkBzkcRzgnqb4URRJaHQCJavwNX
         jdpA==
X-Gm-Message-State: APjAAAVQI0PgiNjjtdWRLKIQEZgVe6OCFYaWeZiKKuENu0Ig7+Cm57Y0
        3B7FyePdDvHTH7rAoNPyQlA=
X-Google-Smtp-Source: APXvYqxBMtMsHNzBojXilm1cDMZW20T1tAm6GRhg+JhAzVY7k5dkLHYhRFuRz12q5hw6dx24DkuiPg==
X-Received: by 2002:a63:4749:: with SMTP id w9mr28794659pgk.153.1569915560688;
        Tue, 01 Oct 2019 00:39:20 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.191])
        by smtp.gmail.com with ESMTPSA id g19sm23133024pgm.63.2019.10.01.00.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:39:20 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3 RESEND-next 1/3] arm64: dts: meson: odroid-c2: Add missing regulator linked to P5V0 regulator
Date:   Tue,  1 Oct 2019 07:38:59 +0000
Message-Id: <20191001073901.372-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001073901.372-1-linux.amoon@gmail.com>
References: <20191001073901.372-1-linux.amoon@gmail.com>
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
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index e739f10f9442..5adecdf3b175 100644
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

