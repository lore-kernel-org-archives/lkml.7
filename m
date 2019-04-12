Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E9DC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3612F206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="daCDizCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfDLJXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:23:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37463 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfDLJXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:23:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so10117490wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 02:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6YLFvpKSspedOVUfA5GjHiMzd1X8HqEXPIfolwrN8PQ=;
        b=daCDizCgO1w6vqWcI7Yhg057xu6pSsZPI3MZiKHzWJ7/0gm93Jc+fwmgbHpRwGKpiO
         v73/Zg8w04muMKJp7Oc40mMbq84fzlgBdG7O0MSFABVxBHtT4R+LkrAmKK+Ng2x+EpjZ
         5ahr1uv8Za/fLoN7ksQaKxMga9BCm0jEByzAOha57qb8YDbhYxrkFH04l8QhtNuNJeb6
         YfE12ziy2S4yBwl3P6Zk/eaF/lixVJNy4AUDwD5npp24rpBARpMzsQRvXsgnFUeQav8y
         E/uA74/jFnGbwcgxkVEGLD7r4lXZHN2qT6wMwIuAx94ER1GzkUY+FX/ZTfJEuPzFArJf
         bunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6YLFvpKSspedOVUfA5GjHiMzd1X8HqEXPIfolwrN8PQ=;
        b=HGkavX1mKa4s4SIN7/OsAX3qyEncza7dORJY1INWDiQWSo+QCrH9J0ef9tpsdGJ3U3
         UwDOSmr+ZLygk/YQPQpqKLKmLXFOUu7i0h1aLVn/93ghKJ7/6oPGRQ3XOpUqERb1g1PS
         zBaVF3Dl8DnSnW2F5oiKbYaBQlN2mpKRX94eOSPmXpuy/hPaSRfHR0BBw9WlsEqVfMs8
         7W236w/12m2G0yGFmZHW4kHXT5yU1Na/f8w1gepLycwR53pkY7/qnihcBuG71sO78Y9l
         bMWobE3vz5MjkwmboFz6qjuSGkbnaEdSsv0nkWP9KKgfg1XAu2qb5zF/5e1Jaf+DSQAu
         VAhQ==
X-Gm-Message-State: APjAAAWnmoo2G2/Y4LXu5iuda+kilslq20f6sR52D5P9wcJoaWJUS1Kf
        8qOB7lf+YuCNx6wm0Ny5USQAQA==
X-Google-Smtp-Source: APXvYqwil90u4HyUI0LZT8D+4OGQi3Mfriy+Xr2ZwpOvFONoeDPY2ZG4JFwxVjFFi5eu9eEDZEqj9w==
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr9869697wmb.23.1555061022314;
        Fri, 12 Apr 2019 02:23:42 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s21sm6630224wmh.22.2019.04.12.02.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 02:23:41 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: meson-g12a: Add PWM nodes
Date:   Fri, 12 Apr 2019 11:23:37 +0200
Message-Id: <20190412092337.6941-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412092337.6941-1-narmstrong@baylibre.com>
References: <20190412092337.6941-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the EE and AO PWM nodes and the possible pinctrl settings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 179 ++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 501496eb34c6..5b7c9076e2d1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -355,6 +355,94 @@
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
@@ -632,6 +720,62 @@
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
 
@@ -659,6 +803,13 @@
 				status = "disabled";
 			};
 
+			pwm_AO_cd: pwm@2000 {
+				compatible = "amlogic,meson-g12a-ao-pwm";
+				reg = <0x0 0x2000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			uart_AO: serial@3000 {
 				compatible = "amlogic,meson-gx-uart",
 					     "amlogic,meson-ao-uart";
@@ -681,6 +832,13 @@
 				status = "disabled";
 			};
 
+			pwm_AO_ab: pwm@7000 {
+				compatible = "amlogic,meson-g12a-ao-pwm";
+				reg = <0x0 0x7000 0x0 0x20>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			ir: ir@8000 {
 				compatible = "amlogic,meson-gxbb-ir";
 				reg = <0x0 0x8000 0x0 0x20>;
@@ -774,6 +932,27 @@
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

