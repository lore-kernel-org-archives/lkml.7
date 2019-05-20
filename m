Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4251CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1879E21479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BlmF8OfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389954AbfETNsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:48:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54522 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389905AbfETNsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:48:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id i3so13400047wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IJ6PDvd1zdmsPjGfyJ9WREQUngSXET91i7YITSNB1Gg=;
        b=BlmF8OfIcqMoG4U4PbeqQ6bWHYV9dzB4Z+s1Xvnmb4E2lp14Jb83c2F6pQOXDQFA1F
         x2RscsAV7V/wv6O3TAJ0f7778RXtBb9EEPhmBlL8Ph9y0ZyE0ZTWILqMI4y2SIPhxn+J
         TtzOpQKOn3SRazhB2hlLH0VmsVhicLKVkNqOO47a2sFE6BkOCX1Nlny/6qOae7xw7aOs
         yJ3Si08KV1PAk8dKQH+qnihHg+lTgfEqBJHAmS1Y6G+ah9eBKxw5TtIbG3zt4WfxGxhP
         aUyNuD9Um74AE7W2cD9Y29U4cII5TMqTCXizOVQaU2Qvgd7G9IGvyvfU2+UJq95oNlOt
         Uy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IJ6PDvd1zdmsPjGfyJ9WREQUngSXET91i7YITSNB1Gg=;
        b=i4jNaq3H8hov7sTKXr/T4Sdc0wJSG5AOcSsgLcTdbR0rBWAi4VXNbGffzzISlMkcsG
         ABVrx/YhJSMWF6Yl5RX9PI7oxal6aPtqAc1JfW8nD6+fcbNp9vnxc0X/YDluX11Y6cha
         Du9sM0+oBJXlOUsqG5iYaPqmtmrSqZvQfgLpSFZ+F4E8rQGyV+Zc3EduhmUCZQQFoeeR
         b99KVjJcZne4gdJGKuGWBWwTHtValVEAE9H33RJwYCnrtt367xH6/yzGfGdeRHufEMG6
         KKmfCds1xwEaZe2wcILCyIM8s7uLn5FfB2F+84tCCh5WKqQTDDOmfwMlRSUyY4UO0Aj3
         CjYA==
X-Gm-Message-State: APjAAAW0O542wHe2SfwlZWZZOGoXmxL7Z1v6+JpekwXGu9UMVJkg2j3V
        rKcTHAdgNkxFXqiIMHArE9ywAA==
X-Google-Smtp-Source: APXvYqx4EmUVUeO2iGJEI0i4hROwnTejxwInKELZ5O3tIe4sAshnsNkeSJA4T6ZYg3DFdgF1s2qYFw==
X-Received: by 2002:a1c:9a14:: with SMTP id c20mr25110254wme.104.1558360108754;
        Mon, 20 May 2019 06:48:28 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h12sm12091358wre.14.2019.05.20.06.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 06:48:27 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: meson: g12a: Add hwrng node
Date:   Mon, 20 May 2019 15:48:17 +0200
Message-Id: <20190520134817.25435-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520134817.25435-1-narmstrong@baylibre.com>
References: <20190520134817.25435-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A has the hwrng module in an unknown "EFUSE" bus.

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
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 8fcdd12f684a..19ef6a467d63 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -197,6 +197,19 @@
 				};
 			};
 
+			apb_efuse: bus@30000 {
+				compatible = "simple-bus";
+				reg = <0x0 0x30000 0x0 0x1000>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges = <0x0 0x0 0x0 0x30000 0x0 0x1000>;
+
+				hwrng: rng {
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

