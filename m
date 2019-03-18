Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47D5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F322063F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0yQyXf+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfCRJ7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:59:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55927 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCRJ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:58:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so12251496wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x3eHeD7NoqoSXtftkvb/ote82xUCD6KJ4VjSqqVyBww=;
        b=0yQyXf+/gZAHiHFv8dS1dlc2q2pFMl8jLkkS6WcZLV9by/P5q6Xdb2NRu/Lw00Pa0P
         fPAFDRjhK0S6VibqKfS+K2UHyJ7EtWUVkVk8zzyxSYWzauAArR2Ve73f6pV8IKqCPOKk
         5WVDkhwZ+I5aNzt5VbHZGwTlH+AQ6Dk6JnLFG5Gdb73riQmBrMF6TEzy6Sss8Ww1xER2
         AuiFyqcAcbj3AMjqmoIi/7no+mJlXFoG7kfeVQs5BOw8QWv2I0d3SQhdc/fHcguqNoba
         Bi654ZZ49k/SxQv7ko1kjI3TUr1HAPe1jJtBwMhuy3YoZn/3h0Apo6Sw9oeEV670wBqM
         SMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x3eHeD7NoqoSXtftkvb/ote82xUCD6KJ4VjSqqVyBww=;
        b=r3ofKdVoXKD6PnMMC76orl/KUjoodhfmHkR+TotpYgRMiYHu8v43XJ5/LKYmRAEcUn
         PMl7psiPzvsepKb31lgOJCGBJTaYvJ6QWHI1kYWoyz/AzxSLLuOjgdnYP73cDedgflA7
         noV4jRexnCfGnhJYjdA44ZOBaQLzGP+uiXEDzykxPApvjgJe+vaOoQBKvyVpDcFUAkv1
         HhZmH2D8PoANw4GHVzTuch1ICLFtzee+kwZmBs9EPEjLpMTcGDohEgPpXoELgOsGYFCy
         J+FtcmRA3Auo7pU1Rf2CuxXiVbCEScT1v7qs/iILz44OVxF6n0xWT0B918OCt1DHXWiS
         C/bw==
X-Gm-Message-State: APjAAAUNk64V8nTVb6YQcm0nGZPLBfcOUf2Uk398BP5aVqOP4QpTYlfI
        t0u1hXIBKZqn6Pr88xyszX5owgQLPgqETg==
X-Google-Smtp-Source: APXvYqwEHorPmBfm+wkGN58C/2JKLA4lZebmb/32rMaYKe0Q0ROvwExRiyD/GdvNIVsq1qoT2isbsQ==
X-Received: by 2002:a1c:8112:: with SMTP id c18mr10736870wmd.41.1552903136279;
        Mon, 18 Mar 2019 02:58:56 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g8sm5459034wro.77.2019.03.18.02.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 02:58:55 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 2/8] arm64: dts: meson: g12a: add pinctrl support controllers
Date:   Mon, 18 Mar 2019 10:58:45 +0100
Message-Id: <20190318095851.4062-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318095851.4062-1-narmstrong@baylibre.com>
References: <20190318095851.4062-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

Add the peripheral and always-on pinctrl controllers to the g12a soc.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 42 +++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 5c0983edf837..e050737a1b3e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -92,6 +92,29 @@
 				#address-cells = <2>;
 				#size-cells = <2>;
 				ranges = <0x0 0x0 0x0 0x34400 0x0 0x400>;
+
+				periphs_pinctrl: pinctrl@40 {
+					compatible = "amlogic,meson-g12a-periphs-pinctrl";
+					#address-cells = <2>;
+					#size-cells = <2>;
+					ranges;
+
+					gpio: bank@40 {
+						reg = <0x0 0x40  0x0 0x4c>,
+						      <0x0 0xe8  0x0 0x18>,
+						      <0x0 0x120 0x0 0x18>,
+						      <0x0 0x2c0 0x0 0x40>,
+						      <0x0 0x340 0x0 0x1c>;
+						reg-names = "gpio",
+							    "pull",
+							    "pull-enable",
+							    "mux",
+							    "ds";
+						gpio-controller;
+						#gpio-cells = <2>;
+						gpio-ranges = <&periphs_pinctrl 0 0 86>;
+					};
+				};
 			};
 
 			hiu: bus@3c000 {
@@ -138,6 +161,25 @@
 					clocks = <&xtal>, <&clkc CLKID_CLK81>;
 					clock-names = "xtal", "mpeg-clk";
 				};
+
+				ao_pinctrl: pinctrl@14 {
+					compatible = "amlogic,meson-g12a-aobus-pinctrl";
+					#address-cells = <2>;
+					#size-cells = <2>;
+					ranges;
+
+					gpio_ao: bank@14 {
+						reg = <0x0 0x14 0x0 0x8>,
+						      <0x0 0x1c 0x0 0x8>,
+						      <0x0 0x24 0x0 0x14>;
+						reg-names = "mux",
+							    "ds",
+							    "gpio";
+						gpio-controller;
+						#gpio-cells = <2>;
+						gpio-ranges = <&ao_pinctrl 0 0 15>;
+					};
+				};
 			};
 
 			sec_AO: ao-secure@140 {
-- 
2.20.1

