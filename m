Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F97C46470
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 19:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E192085A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 19:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DFZwmXQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfEYTCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 15:02:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53942 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfEYTCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 15:02:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id 198so12388370wme.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hY4EIUIoxiYvaBszmOR28DF6dFcPx/awzYZQzheAKOs=;
        b=DFZwmXQ/WZsUQ8790l/6LLAUvVGJsQLtKP+hM/Tx6KqV4CvLbK0CftcSe3GvzigTpv
         qYDRqflxgNvukMWNLI9E+gp9qdoy8kuo2DgpBv6cJT+kfQTCgksyj25VtKWsFnEC64R9
         TIoZFTYPmUbZ2eDirtgK8RdeDQ1XLxitqvXKWS7z817uW+x5stjJpaQuHF3tBt6fgovj
         DnMXNCz7Y8YovDM+vmJA1EGss2MleIi8qPTPhL8oFsQKvQkW3+ycu21EgY3lswrtmz9u
         ngBHsDAYK+/6XqLjEOZtKqpT1z3LWF+2Uc+K9H/LJirb06BPJ4cVkhq0JF962OjwoHyp
         rLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hY4EIUIoxiYvaBszmOR28DF6dFcPx/awzYZQzheAKOs=;
        b=D35corh1IIW+0F0C6bJL2Bi2xMWTBhs8eH+G0VOQs3Xj2YfHVWZxSaYz85DWOz62gA
         Qp9WcvYdWfAYaU5qfrLFg0sxuVLf4BAc8aV/kjhcT7mp8QNmVFa8r9Bah1afp5WxTBEi
         IQNd+RhaDRcmgw8rrbwQCqw0U2NY02s58evpr5uafMDkwZDxbeARMa9pgDAtsHe03ilr
         NyOW9zs6+x4FTEO1kPphHRs5jsHOmJ17fwsxiF8sCa0LGz56qaYVFVWeWIgNnAlC5x3J
         wnGHJJp2RSEp+OFLlo2R9hlIhNkFeOOBH8OhrrRnbg9R4qEriFHSqp1TLi4uH/SNCYES
         0VLA==
X-Gm-Message-State: APjAAAWTnYDlTPd3S3+3YFki2nmX1cHI+O4AYTcmxNnX5CihUb/wfwnM
        0jxS2TlB2x3LiELyfKQ2xxk=
X-Google-Smtp-Source: APXvYqzmjBfdzJH/hUQysMgtf43ZkY9RhyN22HEKGjOHDwOy9AMBulBsqjRe0cWrYmkC5ZBKrC4zmg==
X-Received: by 2002:a1c:3287:: with SMTP id y129mr4303123wmy.153.1558810933099;
        Sat, 25 May 2019 12:02:13 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id f2sm6870426wme.12.2019.05.25.12.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 12:02:12 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/4] ARM: dts: meson8b: odroidc1: add the VDDEE regulator
Date:   Sat, 25 May 2019 21:02:03 +0200
Message-Id: <20190525190204.7897-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525190204.7897-1-martin.blumenstingl@googlemail.com>
References: <20190525190204.7897-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VDDEE regulator is basically a copy of the VCCK regulator. VDDEE
supplies for example the Mali GPU and is controlled by PWM_D instead of
PWM_C.

Add the VDDEE PWM regulator and make it the supply of the Mali GPU.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 27 +++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index f3ad9397f670..893a3aa5ec36 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -194,6 +194,23 @@
 		vin-supply = <&p5v0>;
 	};
 
+	vddee: regulator-vcck {
+		/* Monolithic Power Systems MP2161 */
+		compatible = "pwm-regulator";
+
+		regulator-name = "VDDEE";
+		regulator-min-microvolt = <860000>;
+		regulator-max-microvolt = <1140000>;
+
+		vin-supply = <&p5v0>;
+
+		pwms = <&pwm_cd 1 12218 0>;
+		pwm-dutycycle-range = <91 0>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	vdd_rtc: regulator-vdd-rtc {
 		/*
 		 * Torex Semiconductor XC6215 configured for a fixed output of
@@ -315,6 +332,10 @@
 	pinctrl-names = "default";
 };
 
+&mali {
+	mali-supply = <&vddee>;
+};
+
 &saradc {
 	status = "okay";
 	vref-supply = <&vcc_1v8>;
@@ -347,10 +368,10 @@
 
 &pwm_cd {
 	status = "okay";
-	pinctrl-0 = <&pwm_c1_pins>;
+	pinctrl-0 = <&pwm_c1_pins>, <&pwm_d_pins>;
 	pinctrl-names = "default";
-	clocks = <&clkc CLKID_XTAL>;
-	clock-names = "clkin0";
+	clocks = <&clkc CLKID_XTAL>, <&clkc CLKID_XTAL>;
+	clock-names = "clkin0", "clkin1";
 };
 
 &rtc {
-- 
2.21.0

