Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35435C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E3020675
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xc26U9Tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfENJQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 05:16:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37036 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfENJQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:16:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so2001241wmo.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 02:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBB80kSucULdDTNJYI8igseB69Y8j2lI/J0kpwbCBx0=;
        b=xc26U9TjeXoczIN1/bNqF4ptrZV+tHSHp/rkfz3AO0zPAh1SCwFrkmrm7aGk7SnG7B
         7iAH6MWu3gW2vsM1AjElpXvZdW+mN6dOwLdvX/04LxZrZ+v8NDDSHRE6NGbc/9dEgbUa
         RHA4YJeX+uVhj8XhpiD1jYoClkJ90D3WUwqn5ihjcUaBN+ZwDII5ivOsr/gI69NJi+dn
         BstGRfIXuMwnOuKuSgHY+aDtkUjRjyC54qoAwYpswpZlPkZosX8x1gPZ3OsM8PTOStTo
         IZhfto2a3OebGynN38qUnXV5NpekhN1+8Yb/gf0ugmPlBzWdJKpC2fdwCGXAcAnrZDdp
         8C3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBB80kSucULdDTNJYI8igseB69Y8j2lI/J0kpwbCBx0=;
        b=umyjr6ZBKK5N6CnI0z/keuKQuK0XquGh5bGVlCJ7pEsEW4tqVSFlWDli49nRUKiI53
         t3tg7tCaweH4Ws6YRHBkK4oxejGH+RW97we/85bfZgP9b2FIj/23uJwJk9BKqxPt3dPW
         nN/RZ80ENPM4zlvulqte0lxMrO25nhf/S5rZaKG76QlCxWUcP2Sr8ma3ATcbjHrARbIe
         flDpRA2xcVPNwQ33Jhk6lp0BOKCCq8fzPzkp+/3PG/a83u7vlAC38rYFlenmsAjmVO72
         N/i+vb3MT+2sKcj+1p9StMwoWcr70ElMEkqvtnZXiVIxd+VZrAfC9JWjxPFO7gH8Qyqy
         CBRg==
X-Gm-Message-State: APjAAAW7zLGztq9Mgcaff3jHayyw2oCfW27OzFiNjXHh8LNUb+UT+jsb
        n3cw0IfqC86oa9Y1SEbwQDY7XA==
X-Google-Smtp-Source: APXvYqyT6ZXLbPx0I5XItLqQauM2l+Hgn/0MBaqV7V/d67845C9AKKxuWBgrvAKPlt8+JpfN6RL14Q==
X-Received: by 2002:a1c:4145:: with SMTP id o66mr19288496wma.68.1557825376492;
        Tue, 14 May 2019 02:16:16 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id y40sm17737158wrd.96.2019.05.14.02.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 02:16:15 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: meson: u200: add sd and emmc
Date:   Tue, 14 May 2019 11:16:10 +0200
Message-Id: <20190514091611.15278-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514091611.15278-1-jbrunet@baylibre.com>
References: <20190514091611.15278-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable eMMC and SDCard on the g12a u200 board

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-u200.dts      | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index 7cc3e2d6a4f1..972926121beb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -31,6 +31,11 @@
 		};
 	};
 
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
+	};
+
 	hdmi-connector {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -164,6 +169,43 @@
 	pinctrl-names = "default";
 };
 
+/* SD card */
+&sd_emmc_b {
+	status = "okay";
+	pinctrl-0 = <&sdcard_c_pins>;
+	pinctrl-1 = <&sdcard_clk_gate_c_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <50000000>;
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
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	max-frequency = <200000000>;
+	non-removable;
+	disable-wp;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&flash_1v8>;
+};
+
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.20.1

