Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F88C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4460B2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PS86srXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389325AbfHAWEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:04:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34261 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbfHAWEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:04:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so32809622plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 15:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O7hLnC+GOiCgk4z8TAevBK2YUS9V2gISweOdp52qemw=;
        b=PS86srXDaP4fTTf+RUB3qrKPYKv5VVImbD5sr2kp3apOfNZ0eWIzFc0Mv0njZFxFih
         kIDPoa29TcWLjeGb1zylTG9tEJhsGTACwRaj6SaDNKYuk/UKYaAaiJJjHkiQvrgHK+lH
         RHGzZEyajD813os98uy8cLCgzhZFoWeYOIKZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O7hLnC+GOiCgk4z8TAevBK2YUS9V2gISweOdp52qemw=;
        b=Wc/aP47D25Eiy7B0rp9lN16WaFVp99eSk61lUU4f28WB3YqztB4gyPKpvYbPwjJvtZ
         jHhVZtSeYOfglZE2KBHjKcTsoObRC1R4tkHmhS1nTti9FdVE0jzIM9v5TNyI5Y9PReci
         FrfEYflaQXp/E4+W8EckAwUCjOC3YYEasclOG5a0euaIgDFzuyBOTjIjHq0hUrWslNGw
         iZyIFPctkmGhSHJNR7OPr6f6ugGYcpiGBu1damvuUzJ7x6BGXrrVFcDLw9YO1JzvDSZt
         iZ4mfwFBC8UJ/aC5oxaZKn79r/44gnpxJOb643qQdE3mY4XTAVNtLF/kgkldjoP4ZBSM
         uyOg==
X-Gm-Message-State: APjAAAU0amkzuGnwiplj4AFwGVoz1AmKV9rwxfDCZUhmWZMBZy2/ulRt
        1YLZGcxsFs84jIazSz2DUaGdGw==
X-Google-Smtp-Source: APXvYqxQ7cTZ2SN8igestlUX5ILuYgeNHRyShGDtkVrlsOwVJu4l7U3wDMFfsEDwuJT3bLOSz/Aj3Q==
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr44455167pll.133.1564697039800;
        Thu, 01 Aug 2019 15:03:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id g2sm89824740pfb.95.2019.08.01.15.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 15:03:59 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] ARM: dts: rockchip: Add pin names for rk3288-veyron fievel
Date:   Thu,  1 Aug 2019 15:03:54 -0700
Message-Id: <20190801220354.142933-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is like commit 0ca87bd5baa6 ("ARM: dts: rockchip: Add pin names
for rk3288-veyron-jerry") and other similar commits, but for the
veyron fievel board (and tiger, which includes the fievel .dtsi).

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm/boot/dts/rk3288-veyron-fievel.dts | 214 +++++++++++++++++++++
 1 file changed, 214 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-fievel.dts b/arch/arm/boot/dts/rk3288-veyron-fievel.dts
index 696566f72d30..5c14a8fa6574 100644
--- a/arch/arm/boot/dts/rk3288-veyron-fievel.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-fievel.dts
@@ -198,6 +198,220 @@
 	pinctrl-0 = <&drv_5v>;
 };
 
+&gpio0 {
+	gpio-line-names = "PMIC_SLEEP_AP",
+			  "DDRIO_PWROFF",
+			  "DDRIO_RETEN",
+			  "TS3A227E_INT_L",
+			  "PMIC_INT_L",
+			  "PWR_KEY_L",
+			  "HUB_USB1_nFALUT",
+			  "PHY_PMEB",
+
+			  "PHY_INT",
+			  "REC_MODE_L",
+			  "OTP_OUT",
+			  "",
+			  "USB_OTG_POWER_EN",
+			  "AP_WARM_RESET_H",
+			  "USB_OTG_nFALUT",
+			  "I2C0_SDA_PMIC",
+
+			  "I2C0_SCL_PMIC",
+			  "DEVMODE_L",
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
+			  "",
+			  "TOUCH_INT",
+			  "TOUCH_RST",
+
+			  "I2C3_SCL_TP",
+			  "I2C3_SDA_TP";
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
+			  "VCC5V_GOOD_H",
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
+			  "FLASH0_DQS/EMMC_CLKO",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  "PHY_TXD2",
+			  "PHY_TXD3",
+			  "MAC_RXD2",
+			  "MAC_RXD3",
+			  "PHY_TXD0",
+			  "PHY_TXD1",
+			  "MAC_RXD0",
+			  "MAC_RXD1";
+};
+
+&gpio4 {
+	gpio-line-names = "MAC_MDC",
+			  "MAC_RXDV",
+			  "MAC_RXER",
+			  "MAC_CLK",
+			  "PHY_TXEN",
+			  "MAC_MDIO",
+			  "MAC_RXCLK",
+			  "",
+
+			  "PHY_RST",
+			  "PHY_TXCLK",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  "UART0_RXD",
+			  "UART0_TXD",
+			  "UART0_CTS_L",
+			  "UART0_RTS_L",
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
+			  "USB_OTG_CTL1",
+			  "HUB_USB2_CTL1",
+			  "HUB_USB2_PWR_EN",
+			  "HUB_USB_ILIM_SEL",
+
+			  "USB_OTG_STATUS_L",
+			  "HUB_USB1_CTL1",
+			  "HUB_USB1_PWR_EN",
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
+			  "HUB_USB2_nFALUT",
+			  "USB_OTG_ILIM_SEL";
+};
+
+&gpio7 {
+	gpio-line-names = "LCD_BL_PWM",
+			  "PWM_LOG",
+			  "BL_EN",
+			  "PWR_LED1",
+			  "TPM_INT_H",
+			  "SPK_ON",
+			  "FW_WP_AP",
+			  "",
+
+			  "CPU_NMI",
+			  "DVSOK",
+			  "",
+			  "EDP_HPD",
+			  "DVS1",
+			  "",
+			  "LCD_EN",
+			  "DVS2",
+
+			  "HDMI_CEC",
+			  "I2C4_SDA",
+			  "I2C4_SCL",
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
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <
-- 
2.22.0.770.g0f2c4a37fd-goog

