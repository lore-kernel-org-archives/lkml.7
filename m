Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F28DC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9BB20675
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rC6MRUoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfENJQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 05:16:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39232 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfENJQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:16:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id w8so15872510wrl.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 02:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kpOWVi+iL5/F7dUkDp6tEgosj6/Jy76yQKEnOVON8t8=;
        b=rC6MRUoAeXcZYcOl6WnfStMHiWZp73qbyzqDaXJhKatvwz034xBBPVSbzBOeGvhVUo
         0I7dXKeLRZjy2RMWxuKHIuwHB4Zmk0lwjL933lY/A4z1MFE0YkUCgvhLMKntIkLbVoQJ
         EGhLsHDVR3k75PjeUUMf0aZW4lC3cdppsh3UkMoaWkloqxFdqoeNY2nixkE1TdKWLwZw
         pV3LhspPkKbSoJ0rBs/mCPk+BnU3nw1+na3WcjIkJSvyqPH4skrYLCJUPUQ05c3EwHA7
         kMVqJ9I81KGv9SBllGHrxT+DK6C/wpQJ80BaEfsI3N14WnPJydqvxtuL/ByvIlJCWV2l
         CAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kpOWVi+iL5/F7dUkDp6tEgosj6/Jy76yQKEnOVON8t8=;
        b=AWCgv0TR8zEVWmLeJ1iBXlVLMpJZGJ0tBm8edqmnlYWaId+bGvIKSgt1Z4UWYB8n7b
         LPHKnSVXhlIQ78ecWbov1qXyc1hUg41VY+mvL2pRM4nGQvpN9CByYRrwk9Y41fnglbC0
         N/k18q098sXBfqln8g0IIqYnuWJJCUwWkOPc3tyX43tZ0axG/+dN0zfZN1QH62f//aNa
         OAdH9XsWxF22uOF+wF+R+93Wt4Y7u7f7FecxJYACmsAEbsUX5sp/AyAVIO7S7fEdoIZb
         DLfdjlbuGh9lCTMmP2OPfxann9Ocm5HL/RniUXmoUX9oyvBqSde87Wc1aQNpky05XbwC
         hK6w==
X-Gm-Message-State: APjAAAXCLOYxMHeA3OSE7jxUNlc5BYgK/BBRn/NJzqBGO2NzTT8rfV1j
        VUvKiVWMvZp0XCzTPD95uigVcg==
X-Google-Smtp-Source: APXvYqwn4L/qAqXXygIl8woXOselHRrB8K6ajymSdfj0F4Co9xtqHutEwQGEp2tYMAKog9vShqA6bA==
X-Received: by 2002:adf:ee01:: with SMTP id y1mr2274845wrn.51.1557825377292;
        Tue, 14 May 2019 02:16:17 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id y40sm17737158wrd.96.2019.05.14.02.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 02:16:16 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: meson: sei510: add sd and emmc
Date:   Tue, 14 May 2019 11:16:11 +0200
Message-Id: <20190514091611.15278-4-jbrunet@baylibre.com>
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

Enable eMMC and SDCard on the g12a sei510 board

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 61fb30047d7f..bb45e3577ff5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -45,6 +45,11 @@
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
@@ -161,6 +166,43 @@
 	vref-supply = <&vddio_ao1v8>;
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
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&emmc_1v8>;
+};
+
 &uart_A {
 	status = "okay";
 	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
-- 
2.20.1

