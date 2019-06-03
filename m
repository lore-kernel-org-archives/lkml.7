Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9A2C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AAF2806D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mQjf4XGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfFCKEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:04:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44429 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbfFCKEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:04:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id w13so11328981wru.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 03:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4v96Sj0Qqu2ejZctq3FfqZCKiRWA7yMLpPyqtKhrPu8=;
        b=mQjf4XGRiMhjsw15YSdxSbc4D532wGUB1SC1JiM96Iuh4ExSD4X4vMaXYztqMT1xUc
         GF6Ez8SgjvVVD5eP6GKe87SrgMMDrTJdO5e7VKnX5hWXYkhlc3lDcX5AIlILYf8wtePK
         +m/w6M19ox54sQdzt6EZzaeMP/cf3NbfmpaZG4J3VWjt2DC61rKdAevIQkt2oVk61GO0
         kSWAeo/ulhesWM/Zea3Y7cxS4r/umA3QotghlhN8CTOCJc1Rr6S76lp9WahxPiDbfgDV
         OiEy/ZsnSjOMCbwzHzpaRJm2oT1flAJO5GVRcASt9aG2JmOHpgK36PdkZChnqsqGt94T
         +hqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4v96Sj0Qqu2ejZctq3FfqZCKiRWA7yMLpPyqtKhrPu8=;
        b=hQ7jD4aN5ySOODfXFAuRRmVk5gY99MZ9XRyXSElVUk5b/FHQacsHgbR+F/cxZANygc
         /y9+sZqIdnvxIBWec4lG25jgorILGicNYSS2ha1jHQ+0kU0RBTyuDNp73Nx95qo0BpvZ
         UbkRbnGLbsdsO1dJEWocZ6f6MFnu1NLE4DoLf/7/QeF9C3736SuwcswWAzgif5GXVXkC
         QvXuWlRm4o7n+tHLWpg0YTmiM+r3mhxd/PfZHpPyeOZGhWgz6iC/QOcIjO5lc/pexhZ8
         g10nb/ndp1V9inlqMWXCKDhU/J1MIfsOK74vLeYKVil1eW14VhKivn72mkYN4tJsbjPn
         dT2A==
X-Gm-Message-State: APjAAAWJZ7cLUY+GHMbLZxgL2eKDB5k2+rojyg3/BqkdeMIn8FpjVF7S
        OmyDs7A10EbezwtgKWL1bZfqYA==
X-Google-Smtp-Source: APXvYqzlpNzQaH9IoXOQExNqojzpEeThG85jB71pNzHO58lbsxgDEDHdv44UZx74BlqdIfJdRiKwtw==
X-Received: by 2002:a5d:6b12:: with SMTP id v18mr15831689wrw.306.1559556240934;
        Mon, 03 Jun 2019 03:04:00 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o3sm11282098wrv.94.2019.06.03.03.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jun 2019 03:04:00 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/4] arm64: dts: meson-g12a-x96-max: add support for sdcard and emmc
Date:   Mon,  3 Jun 2019 12:03:55 +0200
Message-Id: <20190603100357.16799-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603100357.16799-1-narmstrong@baylibre.com>
References: <20190603100357.16799-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume La Roque <glaroque@baylibre.com>

Add nodes to support SDCard and onboard eMMC on the X96 Max.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 5cdc263b03e6..69aae6c03dc5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -45,6 +45,11 @@
 		};
 	};
 
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
+	};
+
 	flash_1v8: regulator-flash_1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "FLASH_1V8";
@@ -172,3 +177,38 @@
 	status = "okay";
 	dr_mode = "host";
 };
+
+/* SD card */
+&sd_emmc_b {
+	status = "okay";
+	pinctrl-0 = <&sdcard_c_pins>;
+	pinctrl-1 = <&sdcard_clk_gate_c_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <100000000>;
+	disable-wp;
+
+	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&vddao_3v3>;
+};
+
+/* eMMC */
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	max-frequency = <100000000>;
+	non-removable;
+	disable-wp;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&flash_1v8>;
+};
-- 
2.21.0

