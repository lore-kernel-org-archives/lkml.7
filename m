Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BDCC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333132075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HQy04UfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfE0MvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:51:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40260 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0MvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:51:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id 15so15716906wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 05:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sTM6dI5akQRWyNgshoI8vJ70uGaHk1NWByvSbK/496E=;
        b=HQy04UfWNW9dML5RFNiHSPiHWbiHch9VJA0/kr8ZsG5AJy4HW3qHLodnmxMOIWWWAM
         vkrZYEN/RVRTBumIpSbSXbRVMsqD0j0nzWNVa5JPu4cZbCECd2D5ZQ17PvS+f3+V6v/K
         0UwVysKMNwcaD+/4Q1OIOuElhaKFklzIIY9+29kp9HwvV8EI1FOQKSbdcfRpslJCW/+R
         1K5ihrCWppU6/L829dra29fnIKGhI+eXSBtLJsZYwtkLvonbTSjNLWLzuCLh4ncKIndh
         QDwmp3e4LykgL5uBnpaQ9xuDvQVqBQKrXsSYGNBNbxRe3omLNMKeGnmRsmVEiLJYquyR
         lhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sTM6dI5akQRWyNgshoI8vJ70uGaHk1NWByvSbK/496E=;
        b=r5XKwEaGc9T+jy0NhXWOhUf+ZxNW45u1Vkx7aHr8O73sIcloagYG/heK9MAuMChU35
         jWfJrzAlvaBJndGTi/MqVantWaWJwC93KkZZuFjQUCoEbabR/fOC3xpN/ulnG+bAqgIS
         yJIgAShJGe7vez9NBpp8LCmx26y/mgwz11qv1aFuR2CIW3Ykjdp++yuNQWz3e/AcnppM
         owbZ56gbl1FMLveqvMCzAeMbMsJkpeDAYPcL172BwWDhbieSyDNZX+x/bSCfK3QY2qvs
         7YqTArbuOgA6Li7ZA927GYVRJZv2tp8VUFG3928loDG8GjxXgkTF4LjujWCjFDufsiYc
         Bh0g==
X-Gm-Message-State: APjAAAXoSAm/k0jKZHTaLUv7c7/4xWdjLJVRbUCoVSzYsMir4Q3wDvKE
        oF6vAukiK4sszrNNVUyi0C53gA==
X-Google-Smtp-Source: APXvYqxiQ+nNr1phuOgLrd40qhnD2k4Qu4xZOHnd9BuI8akHep+S8GBmuTUWpWihkDwWS3NEQtK/2w==
X-Received: by 2002:a1c:1bc5:: with SMTP id b188mr9381743wmb.174.1558961461729;
        Mon, 27 May 2019 05:51:01 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g127sm8911462wme.21.2019.05.27.05.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 05:51:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: meson: g12a: Add hwrng node
Date:   Mon, 27 May 2019 14:50:59 +0200
Message-Id: <20190527125059.32010-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A has the hwrng module at the end of an unknown
"EFUSE" bus.

The hwrng is not enabled on the vendor G12A DTs, but is enabled on
next generation SM1 SoC family sharing the exact same memory mapping.

Let's add the "EFUSE" bus and the hwrng node.

This hwrng has been checked with the rng-tools rngtest FIPS tool :
rngtest: starting FIPS tests...
rngtest: bits received from input: 1630240032
rngtest: FIPS 140-2 successes: 81436
rngtest: FIPS 140-2 failures: 76
rngtest: FIPS 140-2(2001-10-10) Monobit: 10
rngtest: FIPS 140-2(2001-10-10) Poker: 6
rngtest: FIPS 140-2(2001-10-10) Runs: 26
rngtest: FIPS 140-2(2001-10-10) Long run: 34
rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
rngtest: input channel speed: (min=3.784; avg=5687.521; max=19073.486)Mibits/s
rngtest: FIPS tests speed: (min=47.684; avg=52.348; max=52.835)Mibits/s
rngtest: Program run time: 30000987 microseconds

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Changes since v1:
- fixes efuse bus size to 2000
- add @218 suffix to rng node name

 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index cbd05e537cd2..881d0f9a2112 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -197,6 +197,19 @@
 				};
 			};
 
+			apb_efuse: bus@30000 {
+				compatible = "simple-bus";
+				reg = <0x0 0x30000 0x0 0x2000>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges = <0x0 0x0 0x0 0x30000 0x0 0x2000>;
+
+				hwrng: rng@218 {
+					compatible = "amlogic,meson-rng";
+					reg = <0x0 0x218 0x0 0x4>;
+				};
+			};
+
 			periphs: bus@34400 {
 				compatible = "simple-bus";
 				reg = <0x0 0x34400 0x0 0x400>;
-- 
2.21.0

