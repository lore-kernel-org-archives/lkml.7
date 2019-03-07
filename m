Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA186C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB0E20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="M0/9j5+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfCGPOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:14:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42796 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCGPNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:13:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id r5so17851447wrg.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5vLPLHD1u8ZKSzf8/MNIriNP/bQNhz6kTsOhKPAebg=;
        b=M0/9j5+ktnBXtm9Y3+kdp2HiDFOK3F8lvKtWoJsEBoSLGk0lcKV9olvxIgFpDV41kW
         8f2VuawmWRPYSI5fN/w7hb/Dmi/JN32VIRxPAn8/vKp0WMyeXLrBUWSBgbcmyhWNa6jS
         nicp5lAM/G224vGGmwapFtQhLGsSSy0uRmgNSsA75wM8UYXltedl/t1IaKIgtu7qgtmF
         EWlUOBsb0lkMxlyedFpfu+QseJc695GbpFb6QHnXOqHAMFBG4ed+yPzr0gYTtYnkp5pl
         cDas9vkVwkRYPTzAXJ9vwhLIAKxpd9r/NcJNggnneSElHczzMWKWtLVD6vmC9qbSAuht
         DPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5vLPLHD1u8ZKSzf8/MNIriNP/bQNhz6kTsOhKPAebg=;
        b=DrmUc/mSkj/mHsRU2FGM4mqJ2Kvx4IhraMymk9FZqRzWHr3KbUSkkLwc1fMqmOv8a9
         psEeWbeBSgSIw9vtLdRGcF1sJ94V9MW82rOYHnL2aboHOKTx5/HfB69hGPd0pppw6utH
         fxUvFrD5btMVuFzWuNp66fmdHnUq6UT6un97ydPn/qjCUsTppygt/DpikYRuot5UalQV
         cGVe8wb4rY2AF8FwaaeIJzziODBEGzKdGioYGvjf7jq22qXRG3aE1BLuDyvnd+vd2FdZ
         vFHYu1MarbxvWqU0Llj8aVztq5HNroOdNjRPYrvDo+z6Qp+QMdFvub60cdXOPrfBEa2n
         6mQA==
X-Gm-Message-State: APjAAAUcKe8Ge5ayG05nKzo2iWMUlQwy/xZXNQshMcFw1xjyn7Ry+CCu
        plXKAKiKb6kjThVZelptmUP3BQ==
X-Google-Smtp-Source: APXvYqwgmx0WDwSidnP2KR1Czind1bkHzqSxfAgLdwZ1QVm1YlPCf529X8abJGgQJOMDywgb0liRAA==
X-Received: by 2002:a5d:668b:: with SMTP id l11mr7139662wru.116.1551971626321;
        Thu, 07 Mar 2019 07:13:46 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r15sm5756563wrt.37.2019.03.07.07.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 07:13:45 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/9] arm64: dts: meson: g12a: add pinctrl support controllers
Date:   Thu,  7 Mar 2019 16:13:35 +0100
Message-Id: <20190307151342.7381-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307151342.7381-1-narmstrong@baylibre.com>
References: <20190307151342.7381-1-narmstrong@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 41 +++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index f2fc0f654150..c141cc7f6b09 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -91,6 +91,28 @@
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
 			};
 
 			hiu: bus@3c000 {
@@ -137,6 +159,25 @@
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

