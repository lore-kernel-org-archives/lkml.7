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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CE6C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 07:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8E221906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 07:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNZoDGRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733079AbfJAHja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 03:39:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33372 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJAHj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 03:39:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so7313962pfl.0;
        Tue, 01 Oct 2019 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FPppnx0pHg/e5NQNVYHCSHLYJt27O7a0A615YGrLKc8=;
        b=RNZoDGRHpt/Wdb8dG1PMcaHqUo2VhanExRHm03EBTnxrfHRrlr1pSkkQgLSxVUEUUj
         Z6vB/F0ywZolrgx5IPX/8yng0MwAwu/DPV1rK3B4nL3+IoLa/eyhI7VjU/KSAMG8BlbP
         RCpDMtcc4aJ6aXqynVOxr6jaLN8pjcwS8Aq0e1fx4Kq79/y/wTCWyI1BAbAnG814e6QO
         mHOV8XCaLn4wjFnALqV/WTzNS3w5bP4Gx/jukPlzMZ9IdJmWPUu8r/Pp92GAUVnL+KTL
         uvstGokKaNAAVqVYsf8vzoGr2P1RkbVDt+Nm5gfzle0pA6YidHLShRRME3soF4usyYRj
         zRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FPppnx0pHg/e5NQNVYHCSHLYJt27O7a0A615YGrLKc8=;
        b=araj51OmRlZXWv6mUow0DZmPwJICk8qzfSexey1ymhVOrAJFK6AgQkMdr2totLqxOm
         rn2GJipiRyoEei80opmPh1jo9JrOlPxkML1fYGaZdC826QXmLjaPXRJsY+iGsGZbuZHo
         zXH2XlWv5Rrd7bMCQvwGhQnM8G0Px6LquxvUS6uSC4iv6GU9bN1zsveAVP0a/Vs2PglL
         N0eIf+U11gQOuSC7cr+oSHnJE5D0SWNS8dUILLq/65LXBTjQpsxX1Ep85htwXTS6cPXB
         L6SdpCRjSekNqUVG4Psjukxg/hEOOxLDUNIVkBAyBXx7fMwMmqXESjq+6OQFqvHQ0P6Z
         PDsA==
X-Gm-Message-State: APjAAAXyCRYNOC2+luUCt7C9rztJECIPCjBlr4dJXZa4qglpssGhiZtF
        mzKw8m0KVDEPF9TciKGNnyE8/GIF
X-Google-Smtp-Source: APXvYqwf/R8vsuDMrsHPW7AAcObC7akqhTa6ONGQou6OgWL5Xr1mJECAx9MceH6tA5EtUlPFROrz4Q==
X-Received: by 2002:a63:cf4e:: with SMTP id b14mr29075889pgj.109.1569915567708;
        Tue, 01 Oct 2019 00:39:27 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.191])
        by smtp.gmail.com with ESMTPSA id g19sm23133024pgm.63.2019.10.01.00.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:39:27 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3 RESEND-next 3/3] arm64: dts: meson: odroid-c2: Add missing regulator linked to HDMI supply
Date:   Tue,  1 Oct 2019 07:39:01 +0000
Message-Id: <20191001073901.372-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001073901.372-1-linux.amoon@gmail.com>
References: <20191001073901.372-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per schematics HDMI_P5V0 is supplied by P5V0 so add missing link.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes from previous
Patchv1
- As per Martin's suggestion added the HDMI_P5V0 fix regulator node.
Patchv2
- Added Matrin's and Neil's Reviewed-by.
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 2fcd512373a3..6ded279c40c8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -66,6 +66,15 @@
 		regulator-always-on;
 	};
 
+	hdmi_p5v0: regulator-hdmi_p5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "HDMI_P5V0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		/* AP2331SA-7 */
+		vin-supply = <&p5v0>;
+	};
+
 	tflash_vdd: regulator-tflash_vdd {
 		compatible = "regulator-fixed";
 
@@ -220,6 +229,7 @@
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	hdmi-supply = <&hdmi_p5v0>;
 };
 
 &hdmi_tx_tmds_port {
-- 
2.23.0

