Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F59C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 09:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F6B206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 09:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmXZX4Sf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfLaJdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 04:33:16 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33049 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLaJdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 04:33:16 -0500
Received: by mail-pj1-f68.google.com with SMTP id u63so777579pjb.0;
        Tue, 31 Dec 2019 01:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WLmpXZu1vud7niRdK/VtHaBa6VMJDe67/Y7KA6ocmug=;
        b=fmXZX4SfoxETf2w1B/4tGkarGFv7V3B1rBT4L7cKOM0uOfYwVoT8NemY1iv5USjWhS
         2N5AQOUusc+2plTic4C2yxN6eicH/4EKqjjqHv7dTKQaph+TAZvJivTy6OTaMvjpwNJd
         T86EDvLDw4NYsfOWNxMc6c2nY+DJO/kzoaTdIQJPMB5mHxfYJR6n2xjoTGMyA90sx/8d
         IHCcooO2LtVaEiP1cv6Cu0IPjkW21NH05Nd9Xxumh54Bmo/18y+Vp+pID4Tv/NO2+6Fi
         Cgc+YIMb9gGc6uPRwo2Nqzsfm2pAFTg5gRhb4tRX4U08nljz7REvEg3dl5BPQP66nLqt
         K4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WLmpXZu1vud7niRdK/VtHaBa6VMJDe67/Y7KA6ocmug=;
        b=GrTXsUiIZaZ4uKF0B6XprVU9AC8xwv4+IdbzzmebW9tsytHa/GdaZzJtWpcMsjFnca
         mpszwiv3Hqs9y9ORk5UZxlOrCeTtvrM26JIn/EqOlzm3I/MbizCA3w12Z7ZcE7YDG9F/
         QrVpIVKPuEFTIK4t6JIcN9IJx2EkbpWEcEWO325QNbrk/PojCZtOtNJlep/EcP1FR7Ed
         jv4EhpMiasomHRyDDTx+yxGH6Aeb4R1YemM4TMPeELoLVmi945TRme81Fr99yvpnIRcT
         uVIIm5lSpaAkbHK+xXAk9inhHV8nVyI+5keaS3l4g0HtcVvx6WFoRSFPqc9pDgdZkJPn
         vgcQ==
X-Gm-Message-State: APjAAAVaiYkmUMfFS4kSSyxsczRzRUjr70nSCTLVFURT+TvHgCG3aUNl
        tcV5IPKbFcd0nShieS+z920=
X-Google-Smtp-Source: APXvYqypGvF/jJ1bRnmW1uoYV7HZivjXfwr5oWriguEXgE6O+r9cRO5TMc5/K6ie5WKI7dxBkWODqA==
X-Received: by 2002:a17:90a:d807:: with SMTP id a7mr5294156pjv.15.1577784795223;
        Tue, 31 Dec 2019 01:33:15 -0800 (PST)
Received: from ruantu.dev.localdomain ([103.103.128.212])
        by smtp.gmail.com with ESMTPSA id h12sm39870970pfo.12.2019.12.31.01.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 01:33:14 -0800 (PST)
From:   YuDong Zhang <mtwget@gmail.com>
To:     robh+dt@kernel.org
Cc:     mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, YuDong Zhang <mtwget@gmail.com>
Subject: [PATCH] dt-bindings: iio: adc: vf610-adc: Remove redundant property from vf610_adc
Date:   Tue, 31 Dec 2019 17:33:05 +0800
Message-Id: <20191231093305.1629390-1-mtwget@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the num-channels property that vf610_adc driver will not use.

Signed-off-by: YuDong Zhang <mtwget@gmail.com>
---
 arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi | 1 -
 arch/arm/boot/dts/imx6ul-phytec-segin.dtsi    | 5 -----
 arch/arm/boot/dts/imx6ul.dtsi                 | 1 -
 arch/arm/boot/dts/imx6ull-colibri.dtsi        | 1 -
 4 files changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
index f05e91841202..4394e1370d34 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
@@ -72,7 +72,6 @@ reg_vref_adc: regulator-vref-adc {
 &adc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_adc1>;
-	num-channels = <3>;
 	vref-supply = <&reg_vref_adc>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi b/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
index 8d5f8dc6ad58..e7198c2922c6 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
@@ -83,11 +83,6 @@ &adc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_adc1>;
 	vref-supply = <&reg_adc1_vref_3v3>;
-	/*
-	 * driver can not separate a specific channel so we request 4 channels
-	 * here - we need only the fourth channel
-	 */
-	num-channels = <4>;
 	status = "disabled";
 };
 
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index d9fdca12819b..458a301be215 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -892,7 +892,6 @@ adc1: adc@2198000 {
 				reg = <0x02198000 0x4000>;
 				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_ADC1>;
-				num-channels = <2>;
 				clock-names = "adc";
 				fsl,adck-max-frequency = <30000000>, <40000000>,
 							 <20000000>;
diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 9145c536d71a..1e70c9da9e36 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -50,7 +50,6 @@ reg_sd1_vmmc: regulator-sd1-vmmc {
 };
 
 &adc1 {
-	num-channels = <10>;
 	vref-supply = <&reg_module_3v3_avdd>;
 };
 
-- 
2.24.1

