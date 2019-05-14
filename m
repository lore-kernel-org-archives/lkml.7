Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AC1C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DBC21473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Lk/FFnVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfENLPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 07:15:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41979 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfENLPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 07:15:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id d12so18706752wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 04:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gae07lBu9X36c//OvWVMnu82pCf/Je6diEnl+g7t/sk=;
        b=Lk/FFnVf/iGSa2v/X1AaSZFnOjN3FFHkOpkDgYsBPzDGLG5fW199Bg6EHKYpQHbvjG
         upN08jO7GvIFe2EFL3qDC2RJqy2TdNrtzIXXiv6xy9UFSgM0jxcIRzdvWI2sWGKsqlIx
         f1FNKOeB8BiZDD13ASg+6nlip0H+I0QRBS3uEKND5i+XYaf1Jvk5Ne2LebHswLDXkVyj
         8Go9ZgiXGSDJqUFQEWVrerJtnmdPyaeYOXDmVdM38EKnIq94sL95YDdWFwi/mjZMzv4A
         YH4CboxUd6ys6wXhor8w5BZchx2mLkGxjbIMSDTvcO+tr1lAszMQFh+mmHz8NZH0K+KL
         3ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gae07lBu9X36c//OvWVMnu82pCf/Je6diEnl+g7t/sk=;
        b=Vo31zwmbTCntpav/kG3XjHdvWcqyUxpo3IXWwr6LznDbWwLJt/x0M2f6+5gobwDd64
         CAs/SFM0Fz2Xe3qCOCzuy8XT7pYmtPv4vllsb+UEqICnMxD6LXZaJyGXlSHNo1e+v/gE
         +F0mTnquO+Sal1A/xnxHIhPfel7NLYWhQXzsT1icYCl8YO+9VBWVkwsW800z2GEYyqhp
         yHFpw/qiaPTBiCLeOubd99RiLUlyI0yY+9pXISvcfvlcBiOsoCNdqUMhv1c6+RwgPAJR
         mErjs7itl9NaWzsWF8k3s8+rKRJD/k08t+bmnDo2v/tDu0VaUoKrej4MVenFwRNjOctW
         VgSg==
X-Gm-Message-State: APjAAAUOKWo+YWBsORj8Bg//JuK1B9uEwL9r5Tel0B3b+JYCHZ/MFWDX
        BMwdquNvuSkoKrxtvuE4EvNLPw==
X-Google-Smtp-Source: APXvYqzlC183SHnKjSaghskfF+EG7B/2w/h+SldZ1DKv2VV2E6PqUDkoF5QXkNsJz67vA4mPDya+rg==
X-Received: by 2002:adf:9221:: with SMTP id 30mr21785833wrj.110.1557832523412;
        Tue, 14 May 2019 04:15:23 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c130sm7289922wmf.47.2019.05.14.04.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 04:15:22 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] arm64: dts: meson: g12a: add pdm
Date:   Tue, 14 May 2019 13:15:08 +0200
Message-Id: <20190514111510.23299-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514111510.23299-1-jbrunet@baylibre.com>
References: <20190514111510.23299-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pdm device node and the pinctrl definition for this capture
interface g12a SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 177 ++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index fa10d6fbf370..37119564274b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -497,6 +497,170 @@
 						};
 					};
 
+					pdm_din0_a_pins: pdm_din0_a {
+						mux {
+							groups = "pdm_din0_a";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din0_c_pins: pdm_din0_c {
+						mux {
+							groups = "pdm_din0_c";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din0_x_pins: pdm_din0_x {
+						mux {
+							groups = "pdm_din0_x";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din0_z_pins: pdm_din0_z {
+						mux {
+							groups = "pdm_din0_z";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din1_a_pins: pdm_din1_a {
+						mux {
+							groups = "pdm_din1_a";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din1_c_pins: pdm_din1_c {
+						mux {
+							groups = "pdm_din1_c";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din1_x_pins: pdm_din1_x {
+						mux {
+							groups = "pdm_din1_x";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din1_z_pins: pdm_din1_z {
+						mux {
+							groups = "pdm_din1_z";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din2_a_pins: pdm_din2_a {
+						mux {
+							groups = "pdm_din2_a";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din2_c_pins: pdm_din2_c {
+						mux {
+							groups = "pdm_din2_c";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din2_x_pins: pdm_din2_x {
+						mux {
+							groups = "pdm_din2_x";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din2_z_pins: pdm_din2_z {
+						mux {
+							groups = "pdm_din2_z";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din3_a_pins: pdm_din3_a {
+						mux {
+							groups = "pdm_din3_a";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din3_c_pins: pdm_din3_c {
+						mux {
+							groups = "pdm_din3_c";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din3_x_pins: pdm_din3_x {
+						mux {
+							groups = "pdm_din3_x";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_din3_z_pins: pdm_din3_z {
+						mux {
+							groups = "pdm_din3_z";
+							function = "pdm";
+							bias-disable;
+						};
+					};
+
+					pdm_dclk_a_pins: pdm_dclk_a {
+						mux {
+							groups = "pdm_dclk_a";
+							function = "pdm";
+							bias-disable;
+							drive-strength-microamp = <500>;
+						};
+					};
+
+					pdm_dclk_c_pins: pdm_dclk_c {
+						mux {
+							groups = "pdm_dclk_c";
+							function = "pdm";
+							bias-disable;
+							drive-strength-microamp = <500>;
+						};
+					};
+
+					pdm_dclk_x_pins: pdm_dclk_x {
+						mux {
+							groups = "pdm_dclk_x";
+							function = "pdm";
+							bias-disable;
+							drive-strength-microamp = <500>;
+						};
+					};
+
+					pdm_dclk_z_pins: pdm_dclk_z {
+						mux {
+							groups = "pdm_dclk_z";
+							function = "pdm";
+							bias-disable;
+							drive-strength-microamp = <500>;
+						};
+					};
+
 					pwm_a_pins: pwm-a {
 						mux {
 							groups = "pwm_a";
@@ -1164,6 +1328,19 @@
 				};
 			};
 
+			pdm: audio-controller@40000 {
+				compatible = "amlogic,g12a-pdm",
+					     "amlogic,axg-pdm";
+				reg = <0x0 0x40000 0x0 0x34>;
+				#sound-dai-cells = <0>;
+				sound-name-prefix = "PDM";
+				clocks = <&clkc_audio AUD_CLKID_PDM>,
+					 <&clkc_audio AUD_CLKID_PDM_DCLK>,
+					 <&clkc_audio AUD_CLKID_PDM_SYSCLK>;
+				clock-names = "pclk", "dclk", "sysclk";
+				status = "disabled";
+			};
+
 			audio: bus@42000 {
 				compatible = "simple-bus";
 				reg = <0x0 0x42000 0x0 0x2000>;
-- 
2.20.1

