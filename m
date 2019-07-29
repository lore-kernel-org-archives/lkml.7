Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E747C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D4A214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="McTn4QAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfG2N03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:26:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43002 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387540AbfG2N02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:26:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so11944917wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YbnyzPyXWl1eZNV2k+kZ6P9lVCAjQouqQ6UbFSEsR+E=;
        b=McTn4QAK5Y8+kC+tAswOQHte57UIRh64u69oCDKhluhwLj6i5hW56hYzvWMzktfas7
         uTrppQZmd8F8Ji2C4wMh1ssx3iILN/pYHALYQthpxmKdLqkGkwgET4Z8D/FE9Dnb9+1z
         vz4UsOaCGgTd8Ox9E82TCHjY251sq03lFaT/n50WVnqXacp3H6fse4AhjVCN1KeOvc3a
         6ebEkGPX+2nb+NVQ5ELVmkURXVBLm1Qc66gN9hdHGzbUtAq9kXErEP2wXTnS2qld5zCQ
         CbHEqUL4avvLeHC2UtswTPYy1/NTxbJHlForQvccXGj9+JmPfYRsUfadEP9BFvPEEm8A
         IXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YbnyzPyXWl1eZNV2k+kZ6P9lVCAjQouqQ6UbFSEsR+E=;
        b=rVSgh6G3AS6y0vTxlX9GndsmkQxD1jv1J8RoFm6Fc5YWmc9sN5/S5VWvkFFJ2WTZVA
         PsFxIyiidPzPwhmefMPOtjYHkgEXCfwaMBSdqzkigLnM3M5DToJeFdCifb4At8ds9LNj
         9X5iSbau6Bcs9F6OkSSczodtxQqeyTcn/uOzmBBaSeoYERLJYCbC7qCrjTr0GaVVQiSv
         9KOXSq8eOjN4pwwWIe+xHySZB69cELA0aZ5ctBAFPkOnUjAcV5yuqcDeZPt4nlKa3mZf
         L0xR45sJnWu2fvRuz28opp0tn/z8bmrU2iqYLHVFzewKR0uQBpdXuZCfRmznAj33Lnet
         fB0g==
X-Gm-Message-State: APjAAAXrfW+QICIQnQBYOPii0jyige5aeOX68c7uKoLkoaFMa9Tjrma6
        DgV1ztS4oqA2V/Wnl3d0dS1RIg==
X-Google-Smtp-Source: APXvYqxOVxv7hzBEczo6QBsd6n+qCueWZLH0Qtizk4W35djZW+vaI1LxwLE6MUGBvZYloUY1Z5c/dA==
X-Received: by 2002:adf:ea45:: with SMTP id j5mr45573344wrn.11.1564406786840;
        Mon, 29 Jul 2019 06:26:26 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y2sm50270053wrl.4.2019.07.29.06.26.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 06:26:26 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] arm64: dts: meson-g12a: add cpus OPP table
Date:   Mon, 29 Jul 2019 15:26:19 +0200
Message-Id: <20190729132622.7566-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729132622.7566-1-narmstrong@baylibre.com>
References: <20190729132622.7566-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the OPP table taken from the vendor u200 and u211 DTS.

The Amlogic G12A SoC seems to available in 3 types :
- low-speed: up to 1,8GHz
- mid-speed: up to 1,908GHz
- high-speed: up to 2.1GHz

And the S905X2 opp voltages are slightly higher than the S905D2
OPP voltages for the low-speed table.

This adds the conservative OPP table with the S905X2 higher voltages
and the maximum low-speed OPP frequency.

The values were tested to be stable on an Amlogic U200 Reference Board,
SeiRobotics SEI510 and X96 Max Set-Top-Boxes running the arm64 cpuburn
at [1] and cycling between all the possible cpufreq translations and
checking the final frequency using the clock-measurer, script at [2].

[1] https://github.com/ssvb/cpuburn-arm/blob/master/cpuburn-a53.S
[2] https://gist.github.com/superna9999/d4de964dbc0f84b7d527e1df2ddea25f

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 60 +++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index ac15967bb7fa..733a9d46fc4b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -48,6 +48,66 @@
 			compatible = "cache";
 		};
 	};
+
+	cpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-250000000 {
+			opp-hz = /bits/ 64 <250000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-667000000 {
+			opp-hz = /bits/ 64 <666666666>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <731000>;
+		};
+
+		opp-1398000000 {
+			opp-hz = /bits/ 64 <1398000000>;
+			opp-microvolt = <761000>;
+		};
+
+		opp-1512000000 {
+			opp-hz = /bits/ 64 <1512000000>;
+			opp-microvolt = <791000>;
+		};
+
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <831000>;
+		};
+
+		opp-1704000000 {
+			opp-hz = /bits/ 64 <1704000000>;
+			opp-microvolt = <861000>;
+		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <981000>;
+		};
+	};
 };
 
 &sd_emmc_a {
-- 
2.22.0

