Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3B1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F58521773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gJzTtPJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfDWNhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:37:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55779 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfDWNg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:36:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so79319wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 06:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gRRPPW+odTXhFAsU3nebrJ3pOmtPg3fz+kt7pkJ+hYg=;
        b=gJzTtPJglsNGltcuceOwdXvOWFbCDbmX747W7KKaMS3ah7BRPXloumV42Gcz31twrI
         vLF3guTu/Gj9LL9+JRBnnPynnexpUE3RM2MtyZ/at+BWmm/Oo1eWoYXHGw8LrpDcp8vp
         zafctJYCwhDa37OgvOcEKGEl7pww7qYgX+P666OtM8SUn2AM8XdTyT++njYpMGakVh5N
         2bxEiYcjA+WGB0cwnkT/t9ATkkFqfSY3fswWO6XI5Wl5/jIzyUR7MCHbcRcyzMbUm6n4
         7zxDLrrAbSXwsdMRBi0/VHKwW90VrV0D22+bk4EevE2u7VsupA/qlfmNcX3nYQvngd8b
         4cQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gRRPPW+odTXhFAsU3nebrJ3pOmtPg3fz+kt7pkJ+hYg=;
        b=XnLyZ87we5G7cKpqriqsB8Dqltf7dPZmqeyHaePQ3l7OdnaToFuGjj42kWQEkuB7Tt
         aLQLDpJJZ9fLY+eGZFfoGZUPTZeSgKA0aLpV5oJPI2en05xYXBKZ6zN9gIva8uUyUkOr
         QAXC1KrtTvY/7U/hKuCqGolaXWalEVlywCpqiCsB/vwFLZGqduFF5pDnmBqryXOfAAZC
         dKi1ctec7OlRCUI2/K8ViqmaCbbT5NicUz9t8MUdi8x2cKFbinzI7yYWiPI97Bj0av9c
         pAD5L0rv2//8a+MmBuXoHf3crqTB42nTfCsL7Ya/5MN579xMDJwOhBOGQfvdIEpNVFm5
         09rA==
X-Gm-Message-State: APjAAAVGp97Vmj4Qmz5Doy5N1agSvRkJOsOBI/nzLQg44pfmI7O3czcx
        osPcBv308CI7Jy9cjC+LKHXN2g==
X-Google-Smtp-Source: APXvYqwUIV2m/OArUl29VTuMNyASRUnqvFVA1Fu4IdEoT3PxqLHfOe86tDQJBu9mpqHGoGeury9v9Q==
X-Received: by 2002:a1c:20c1:: with SMTP id g184mr2464872wmg.137.1556026615465;
        Tue, 23 Apr 2019 06:36:55 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z20sm13509543wmf.34.2019.04.23.06.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 06:36:54 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/3] arm64: dts: meson-g12a: Add PWM nodes
Date:   Tue, 23 Apr 2019 15:36:46 +0200
Message-Id: <20190423133646.5705-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423133646.5705-1-narmstrong@baylibre.com>
References: <20190423133646.5705-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the EE and AO PWM nodes and the possible pinctrl settings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 179 ++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 9f72396ba710..efadd78aa747 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -202,6 +202,94 @@
 						};
 					};
 
+					pwm_a_pins: pwm-a {
+						mux {
+							groups = "pwm_a";
+							function = "pwm_a";
+							bias-disable;
+						};
+					};
+
+					pwm_b_x7_pins: pwm-b-x7 {
+						mux {
+							groups = "pwm_b_x7";
+							function = "pwm_b";
+							bias-disable;
+						};
+					};
+
+					pwm_b_x19_pins: pwm-b-x19 {
+						mux {
+							groups = "pwm_b_x19";
+							function = "pwm_b";
+							bias-disable;
+						};
+					};
+
+					pwm_c_c_pins: pwm-c-c {
+						mux {
+							groups = "pwm_c_c";
+							function = "pwm_c";
+							bias-disable;
+						};
+					};
+
+					pwm_c_x5_pins: pwm-c-x5 {
+						mux {
+							groups = "pwm_c_x5";
+							function = "pwm_c";
+							bias-disable;
+						};
+					};
+
+					pwm_c_x8_pins: pwm-c-x8 {
+						mux {
+							groups = "pwm_c_x8";
+							function = "pwm_c";
+							bias-disable;
+						};
+					};
+
+					pwm_d_x3_pins: pwm-d-x3 {
+						mux {
+							groups = "pwm_d_x3";
+							function = "pwm_d";
+							bias-disable;
+						};
+					};
+
+					pwm_d_x6_pins: pwm-d-x6 {
+						mux {
+							groups = "pwm_d_x6";
+							function = "pwm_d";
+							bias-disable;
+						};
+					};
+
+					pwm_e_pins: pwm-e {
+						mux {
+							groups = "pwm_e";
+							function = "pwm_e";
+							bias-disable;
+						};
+					};
+
+					pwm_f_x_pins: pwm-f-x {
+						mux {
+							groups = "pwm_f_x";
+							function = "pwm_f";
+							bias-disable;
+						};
+					};
+
+					pwm_f_h_pins: pwm-f-h {
+						mux {
+							groups = "pwm_f_h";
+							function = "pwm_f";
+							bias-disable;
+						};
+					};
+
 					uart_a_pins: uart-a {
 						mux {
 							groups = "uart_a_tx",
@@ -418,6 +506,62 @@
 							bias-disable;
 						};
 					};
+
+					pwm_ao_a_pins: pwm-ao-a {
+						mux {
+							groups = "pwm_ao_a";
+							function = "pwm_ao_a";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_b_pins: pwm-ao-b {
+						mux {
+							groups = "pwm_ao_b";
+							function = "pwm_ao_b";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_c_4_pins: pwm-ao-c-4 {
+						mux {
+							groups = "pwm_ao_c_4";
+							function = "pwm_ao_c";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_c_6_pins: pwm-ao-c-6 {
+						mux {
+							groups = "pwm_ao_c_6";
+							function = "pwm_ao_c";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_d_5_pins: pwm-ao-d-5 {
+						mux {
+							groups = "pwm_ao_d_5";
+							function = "pwm_ao_d";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_d_10_pins: pwm-ao-d-10 {
+						mux {
+							groups = "pwm_ao_d_10";
+							function = "pwm_ao_d";
+							bias-disable;
+						};
+					};
+
+					pwm_ao_d_e_pins: pwm-ao-d-e {
+						mux {
+							groups = "pwm_ao_d_e";
+							function = "pwm_ao_d";
+							bias-disable;
+						};
+					};
 				};
 			};
 
@@ -445,6 +589,13 @@
 				status = "disabled";
 			};
 
+			pwm_AO_cd: pwm@2000 {
+				compatible = "amlogic,meson-g12a-ao-pwm-cd";
+				reg = <0x0 0x2000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			uart_AO: serial@3000 {
 				compatible = "amlogic,meson-gx-uart",
 					     "amlogic,meson-ao-uart";
@@ -465,6 +616,13 @@
 				status = "disabled";
 			};
 
+			pwm_AO_ab: pwm@7000 {
+				compatible = "amlogic,meson-g12a-ao-pwm-ab";
+				reg = <0x0 0x7000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			saradc: adc@9000 {
 				compatible = "amlogic,meson-g12a-saradc",
 					     "amlogic,meson-saradc";
@@ -533,6 +691,27 @@
 				#reset-cells = <1>;
 			};
 
+			pwm_ef: pwm@19000 {
+				compatible = "amlogic,meson-g12a-ee-pwm";
+				reg = <0x0 0x19000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_cd: pwm@1a000 {
+				compatible = "amlogic,meson-g12a-ee-pwm";
+				reg = <0x0 0x1a000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_ab: pwm@1b000 {
+				compatible = "amlogic,meson-g12a-ee-pwm";
+				reg = <0x0 0x1b000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			clk_msr: clock-measure@18000 {
 				compatible = "amlogic,meson-g12a-clk-measure";
 				reg = <0x0 0x18000 0x0 0x10>;
-- 
2.21.0

