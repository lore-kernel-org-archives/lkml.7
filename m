Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0762FC072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EF42182B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jfXEHCzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfEUUco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:32:44 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34211 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfEUUcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:32:41 -0400
Received: by mail-it1-f195.google.com with SMTP id g23so3671625iti.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 13:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQ2r5PQ0vvjlMI5kpOVHnGlsdtagsJZCtwtZAIF6wsM=;
        b=jfXEHCzvUcv7X9RSwEbvGDRkOdVJyAJuHgS/ha5PpxQEQxLd7aI8p8zITCJWQYvgWv
         kY0qQaJLquIEjt40FFKt/TRlAG0EAlfPnMWQeYOCx6yiphf4mROdATbunECkw4YwxI1W
         varGpt1jUIIahlRNDo0ElzGp4fcD0Hx+V3FYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQ2r5PQ0vvjlMI5kpOVHnGlsdtagsJZCtwtZAIF6wsM=;
        b=SRIFLr6ozl2zKEs/EMXskVGN5UU4ENWLbB80o4wccOh4ofU2ALP++lSiQToVvkYQdd
         tgrULWayBgkrhGnB94hHfM9XbHL4PJoT0Aa8AAVHozjNXWHPJiIwOYPvlmZjt+m+bv89
         zswv9L/xvXB7iY5KrGITV8OAsOX8gSc2+1nni58/IYAGAmWWXj+/6/OxoBHA2aVXgLGi
         1Co1WqXkyT6NF5wfU/6w8ghdTFTCyDpYteAlzdA2AfFOBzmCFgeQPot8w0A1eYcbrqA0
         vQBfD8wm7xFQ3eJThb90v9Ux7HE7oqVfo3ZNoE88U2PB5jBdnzy7qHwinG1ikt8x7foS
         F2oA==
X-Gm-Message-State: APjAAAWc5b/HcZNb+SwIfNW2WfYh2aHiwHuT9VZyCW37hbJSqOAsAHWc
        X15oS9g6AMpgX/7ER99btZUQTcjaodg=
X-Google-Smtp-Source: APXvYqxSz/8n9XxlYkdxr6ciXmid1JAcD9hFZpzXZV5KyhgrDbitGBVY4l2Wvb/tr6ZfkWjRGGs9ZQ==
X-Received: by 2002:a02:80e:: with SMTP id 14mr53391656jac.71.1558470760572;
        Tue, 21 May 2019 13:32:40 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id e22sm7205710ioe.45.2019.05.21.13.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 13:32:40 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     briannorris@chromium.org, ryandcase@chromium.org, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] ARM: dts: rockchip: Add pin names for rk3288-veyron-jerry
Date:   Tue, 21 May 2019 13:32:15 -0700
Message-Id: <20190521203215.234898-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190521203215.234898-1-dianders@chromium.org>
References: <20190521203215.234898-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is like the same change for rk3288-veyron-minnie.  See that patch
for more details.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288-veyron-jerry.dts | 207 ++++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-jerry.dts b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
index b1613af83d5d..164561f04c1d 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jerry.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
@@ -103,6 +103,213 @@
 	pinctrl-0 = <&vcc50_hdmi_en>;
 };
 
+&gpio0 {
+	gpio-line-names = "PMIC_SLEEP_AP",
+			  "DDRIO_PWROFF",
+			  "DDRIO_RETEN",
+			  "TS3A227E_INT_L",
+			  "PMIC_INT_L",
+			  "PWR_KEY_L",
+			  "AP_LID_INT_L",
+			  "EC_IN_RW",
+
+			  "AC_PRESENT_AP",
+			  /*
+			   * RECOVERY_SW_L is Chrome OS ABI.  Schematics call
+			   * it REC_MODE_L.
+			   */
+			  "RECOVERY_SW_L",
+			  "OTP_OUT",
+			  "HOST1_PWR_EN",
+			  "USBOTG_PWREN_H",
+			  "AP_WARM_RESET_H",
+			  "nFAULT2",
+			  "I2C0_SDA_PMIC",
+
+			  "I2C0_SCL_PMIC",
+			  "SUSPEND_L",
+			  "USB_INT";
+};
+
+&gpio2 {
+	gpio-line-names = "CONFIG0",
+			  "CONFIG1",
+			  "CONFIG2",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "CONFIG3",
+
+			  "",
+			  "EMMC_RST_L",
+			  "",
+			  "",
+			  "BL_PWR_EN",
+			  "AVDD_1V8_DISP_EN";
+};
+
+&gpio3 {
+	gpio-line-names = "FLASH0_D0",
+			  "FLASH0_D1",
+			  "FLASH0_D2",
+			  "FLASH0_D3",
+			  "FLASH0_D4",
+			  "FLASH0_D5",
+			  "FLASH0_D6",
+			  "FLASH0_D7",
+
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  "FLASH0_CS2/EMMC_CMD",
+			  "",
+			  "FLASH0_DQS/EMMC_CLKO";
+};
+
+&gpio4 {
+	gpio-line-names = "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  "UART0_RXD",
+			  "UART0_TXD",
+			  "UART0_CTS",
+			  "UART0_RTS",
+			  "SDIO0_D0",
+			  "SDIO0_D1",
+			  "SDIO0_D2",
+			  "SDIO0_D3",
+
+			  "SDIO0_CMD",
+			  "SDIO0_CLK",
+			  "BT_DEV_WAKE",
+			  "",
+			  "WIFI_ENABLE_H",
+			  "BT_ENABLE_L",
+			  "WIFI_HOST_WAKE",
+			  "BT_HOST_WAKE";
+};
+
+&gpio5 {
+	gpio-line-names = "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SPI0_CLK",
+			  "SPI0_CS0",
+			  "SPI0_TXD",
+			  "SPI0_RXD",
+
+			  "",
+			  "",
+			  "",
+			  "VCC50_HDMI_EN";
+};
+
+&gpio6 {
+	gpio-line-names = "I2S0_SCLK",
+			  "I2S0_LRCK_RX",
+			  "I2S0_LRCK_TX",
+			  "I2S0_SDI",
+			  "I2S0_SDO0",
+			  "HP_DET_H",
+			  "",
+			  "INT_CODEC",
+
+			  "I2S0_CLK",
+			  "I2C2_SDA",
+			  "I2C2_SCL",
+			  "MICDET",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  "SDMMC_D0",
+			  "SDMMC_D1",
+			  "SDMMC_D2",
+			  "SDMMC_D3",
+			  "SDMMC_CLK",
+			  "SDMMC_CMD";
+};
+
+&gpio7 {
+	gpio-line-names = "LCDC_BL",
+			  "PWM_LOG",
+			  "BL_EN",
+			  "TRACKPAD_INT",
+			  "TPM_INT_H",
+			  "SDMMC_DET_L",
+			  /*
+			   * AP_FLASH_WP_L is Chrome OS ABI.  Schematics call
+			   * it FW_WP_AP.
+			   */
+			  "AP_FLASH_WP_L",
+			  "EC_INT",
+
+			  "CPU_NMI",
+			  "DVSOK",
+			  "",
+			  "EDP_HPD",
+			  "DVS1",
+			  "nFAULT1",
+			  "LCD_EN",
+			  "DVS2",
+
+			  "VCC5V_GOOD_H",
+			  "I2C4_SDA_TP",
+			  "I2C4_SCL_TP",
+			  "I2C5_SDA_HDMI",
+			  "I2C5_SCL_HDMI",
+			  "5V_DRV",
+			  "UART2_RXD",
+			  "UART2_TXD";
+};
+
+&gpio8 {
+	gpio-line-names = "RAM_ID0",
+			  "RAM_ID1",
+			  "RAM_ID2",
+			  "RAM_ID3",
+			  "I2C1_SDA_TPM",
+			  "I2C1_SCL_TPM",
+			  "SPI2_CLK",
+			  "SPI2_CS0",
+
+			  "SPI2_RXD",
+			  "SPI2_TXD";
+};
+
 &pinctrl {
 	backlight {
 		bl_pwr_en: bl_pwr_en {
-- 
2.21.0.1020.gf2820cf01a-goog

