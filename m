Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9E7C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD47B218AF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="r6QxrJ3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfDMQgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 12:36:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38997 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfDMQgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 12:36:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so14550793wmk.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kBXO1uZlskj4auakSoYtNTreOLcLzWrlcJFWLgQwR7A=;
        b=r6QxrJ3RXltfeqSjUG/3ikq36RJSQtldcfRD+Sf4NCMbkal3+xTwF2uWL6bGX4iOzw
         VR+XMb2JWqoqfoOLQJuQ8TbUX4G+WWFonRn16BWbg87dKQaebrCGFur+3IE+VrXrJZZG
         WWXADlAf+0p1O7SfPUsCSnkLT+PGVy1ypErRUjQDKXU45W7AIi7MGZ1mffFsPMc1Cjss
         xi5d06ydb8Rgl6IgMrxeLrhP/JzOH4nrS/N/EWH9ZcN9Cn1m0mG+vDq4aSXHH86U4jpM
         ZcsbfuFWAy/wD+lT9wmaNoRtbBWO/EBO9+WIB9nfjU2PUH7wvikMy06ySwmFaMkCwe3A
         4mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kBXO1uZlskj4auakSoYtNTreOLcLzWrlcJFWLgQwR7A=;
        b=s4V0MpsW/TEevZx6dwjXEkkMwNTU3CUWRcVKGH68L12b05FWxuhC4fgVsNnaU2K60x
         rciWAS852Iozr93fu0w9LDmWFZVKmphK3NnHRwuxZsXFZ0P4z8M/D6ZsdppB5FJxHX8q
         oaIE0Fq78jf+ti+qtetz9gPPtpexbeOVL/WvVZ1G4llQdWXSyoXSMLuuXkds3Sn+RFCB
         s2CIN/MP/L8O6/h4UDnbvk+MnMn1Hx1lXUSdXjXgCGEMKcQSOjJ8eufstYkm1ss4F76I
         5NLVNySiBq8isQTrQdCdDAmYrpma3SZ2/WkOfAWYley0+Us6x2IPtf0IfgiafVpTvjtk
         7YNw==
X-Gm-Message-State: APjAAAVAW5AwBKfnMb9yS774Bjj7EhZYPPe8jwn4TGOV0oUg8l6hZ+7L
        FSazCf3V2/gryReb8TPLt5o=
X-Google-Smtp-Source: APXvYqwiMXRIGA3sRw1d5JsyiSyE4RLl25K8bEL529FrgTJ0lQCzV6Ja5TnQ9bMJY+b7wt18hxZO0w==
X-Received: by 2002:a1c:480b:: with SMTP id v11mr15222305wma.25.1555173399396;
        Sat, 13 Apr 2019 09:36:39 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD00714E418F6C82D049.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:714e:418f:6c82:d049])
        by smtp.googlemail.com with ESMTPSA id j3sm106200069wre.51.2019.04.13.09.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 09:36:38 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jianxin.pan@amlogic.com, ccaione@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/3] ARM: dts: meson8b: odroid-c1: prepare support for the RTC
Date:   Sat, 13 Apr 2019 18:34:23 +0200
Message-Id: <20190413163423.15149-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413163423.15149-1-martin.blumenstingl@googlemail.com>
References: <20190413163423.15149-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Odroid-C1 has the 32.768 kHz oscillator (X3 in the schematics) which
is required for the RTC. A battery can be connected separately (to the
BT1 header) - then the "rtc" node can be enabled manually. By default
the RTC is disabled because the boards typically come without the RTC
battery.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 0157646e3a89..f3ad9397f670 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -124,6 +124,14 @@
 		io-channels = <&saradc 8>;
 	};
 
+	rtc32k_xtal: rtc32k-xtal-clk {
+		/* X3 in the schematics */
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "RTC32K";
+		#clock-cells = <0>;
+	};
+
 	vcc_1v8: regulator-vcc-1v8 {
 		/*
 		 * RICHTEK RT9179 configured for a fixed output voltage of
@@ -345,6 +353,12 @@
 	clock-names = "clkin0";
 };
 
+&rtc {
+	/* needs to be enabled manually when a battery is connected */
+	clocks = <&rtc32k_xtal>;
+	vdd-supply = <&vdd_rtc>;
+};
+
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.21.0

