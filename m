Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650F4C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0002173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QBq9fahc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfEUUcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:32:41 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:32789 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfEUUck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:32:40 -0400
Received: by mail-it1-f194.google.com with SMTP id j17so3676856itk.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 13:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TL0Rco+HJb/XdiRCUNcHvK2NcbT9epjRSGpGsvVbQoI=;
        b=QBq9fahcLU2tgJhshCN0dwVdL0HE77OlAbTaVT8QDvwmSf17Ll5gBABBcZbQPKSgI8
         wPLldHhQueXNBElEdaeVQGucuCyfo4uJDJwgYvxXvlJB+Ro8K+sPZp03zZ6h3jcX+Zwn
         8KN7ULMXhj+3tDAZroKu43AHQM5IoJZShiDBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TL0Rco+HJb/XdiRCUNcHvK2NcbT9epjRSGpGsvVbQoI=;
        b=PnU+YneRxxUctkMuRQVMxc30i5tke8+P05k/AJSc7b9kuAB255B4XM22tdtFMcBLsD
         Q6pvDUe2WUG8dfKboGZCpkOk5/FBkvAhgps8DlnUfJ7FN+RNcsybXvYbv3Uyd8I+1GtB
         v38OqZKx5md8dJJfy3G4aqICc1J4gVNQ2BacWeqzd9bDleINxFYXgeJA78INt3xp26Qk
         yo7qhu8jWw9ucucwxc9ebqEuereI+FWGbXEkAaRK3uVhCnkViUuKAQBTmQdp5AbvnwNW
         leAaK3YQWZ32Kh5nzvquUhedDtF1+jdFm9/BqJ5/3fEUva+sUQFDg1xmS0ADHvAtbsPw
         k+9A==
X-Gm-Message-State: APjAAAUkgx0oATt5eJ+2TelYodTt/Ai2ZxODcyIniR0v9j3jE1sH5B+9
        7XQYheEq1JL/xZ193EVkRSiHcw==
X-Google-Smtp-Source: APXvYqzMgS+2Y+L54Bugxjb3Y7W5RtvSETPi7Pcr1ybp84tqKgN8/mOHXp8N4/4GVoMpgsDaegyHyg==
X-Received: by 2002:a24:278c:: with SMTP id g134mr4385454ita.49.1558470759345;
        Tue, 21 May 2019 13:32:39 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id e22sm7205710ioe.45.2019.05.21.13.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 13:32:38 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     briannorris@chromium.org, ryandcase@chromium.org, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] ARM: dts: rockchip: Add pin names for rk3288-veyron-minnie
Date:   Tue, 21 May 2019 13:32:14 -0700
Message-Id: <20190521203215.234898-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can now use the "gpio-line-names" property to provide the names for
all the pins on a board.  Let's use this to provide the names for all
the pins on rk3288-veyron-minnie.

In general the names here come straight from the schematic.  That
means even if the schematic name is weird / doesn't have consistent
naming conventions / has typos I still haven't made any changes.

The exception here is for two pins: the recovery switch and the write
protect detection pin.  These two pins need to have standardized names
since crossystem (a Chrome OS tool) uses these names to query the
pins.  In downstream kernels crossystem used an out-of-tree driver to
do this but it has now been moved to the gpiod API and needs the
standardized names.

It's expected that other rk3288-veyron boards will get similar patches
shortly.

NOTE: I have sorted the "gpio" section to be next to the "pinctrl"
section since it seems to logically make the most sense there.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288-veyron-minnie.dts | 212 +++++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index ce57881625ec..a65099b4aef1 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -184,6 +184,218 @@
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
+			  "nFALUT2",
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
+			  "PROCHOT#",
+			  "EMMC_RST_L",
+			  "",
+			  "",
+			  "BL_PWR_EN",
+			  "AVDD_1V8_DISP_EN",
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
+			  "dev_wake",
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
+			  "Volum_Up#",
+			  "Volum_Down#",
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
+			  "DVS_OK",
+			  "SDMMC_WP",
+			  "EDP_HPD",
+			  "DVS1",
+			  "nFALUT1",
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

