Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10152C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55692184C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sq6afwcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfC1Uro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:47:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53375 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfC1Urm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:47:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so247512wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZgQjHt1Nd6z+d3OPKfLJBIy/36DrcKsgVb4QbnZCvQ=;
        b=sq6afwcBJzuTTmJiiNyrHdhH0t7TWV9D182aXP/u6STRo5Zpq8lGYyfwWN72FArZZO
         s2IqDjgUK3IuRpA5iOXBHqNKVyiUukQa+nVTk4AmXUTysx4NA6bauHxRM3hU27bJd2/A
         LwbPI5g2of007gxUQC6bL3uDKfqYsbG2ASif3K6B7gw5opM6yL2iOqjyA7Zla23vsZoO
         kik3pgdFAekp8IxaLqejI480wjJLlEjecYu8nOSwGBDqGllKuoktmAIDiNsyXruPw3US
         FGVboJsuAKouYBYiNvvxOKXbYP5E1CLv5HPcSh95BFUU58hlsVXm/Te51iKI0JgeklBo
         WbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZgQjHt1Nd6z+d3OPKfLJBIy/36DrcKsgVb4QbnZCvQ=;
        b=Z0xKKeYOJ0+XYA7e73EVjd2Cw/68hHC/pOUcb+a0KrgmdLfAAuEeh4RZz1lGUupnEw
         jFYkkF7crRkDhB803P2juk2GdT9p/hLCh39lY9OtTOVd97EtgjJEDVvooWkgnv4Jl89s
         372K95njdrHwUcEGHDglKNTH4npm/PvbH5xf/Eb4jq3tr8yxFR/z9+oWRnnmaj/FMFbN
         JfXYvbLkw1fwwrdvZhYRlBq/Tmqh0OUp0akyBqot78dwK1kYCOSTai882EZG/+5uhAsG
         DCbXeZFDan0Te9SLSAHKlP9OUNepS4tJQt1ncTSCod/eXTIadzI+Ve2DRaiNZlXhRm0s
         SN0Q==
X-Gm-Message-State: APjAAAVLjTCR3urudtHveEzZOoWJAejE99H7G04xpEuxh5e9jFKeusTL
        GqEwx6z/DPC8uCjIs2RMLKQ=
X-Google-Smtp-Source: APXvYqye+k7ZxkONJ8PuOu2sCbS0dWz3UEoe9ZEiIjWyeYJpx33ACjsQ7bOl5noXG3IbU8jRcWuxlQ==
X-Received: by 2002:a1c:20c1:: with SMTP id g184mr1268390wmg.137.1553806060599;
        Thu, 28 Mar 2019 13:47:40 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD73999007CF185662A5FF671.dip0.t-ipconnect.de. [2003:dc:d739:9900:7cf1:8566:2a5f:f671])
        by smtp.googlemail.com with ESMTPSA id y9sm257173wrn.18.2019.03.28.13.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 13:47:39 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/1] ARM: dts: meson8b: odroidc1: add the GPIO line names
Date:   Thu, 28 Mar 2019 21:47:21 +0100
Message-Id: <20190328204721.25970-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190328204721.25970-1-martin.blumenstingl@googlemail.com>
References: <20190328204721.25970-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the GPIO line names from the schematics to get them displayed
in the debugfs output of each GPIO controller.

The schematics from Odroid-C1+ PCB revision 0.4 20150615 are used as
referenced.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 52 ++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 3b0e0f8fbc23..0157646e3a89 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -234,7 +234,59 @@
 	};
 };
 
+&gpio {
+	gpio-line-names = /* Bank GPIOX */
+			  "J2 Header Pin 35", "J2 Header Pin 36",
+			  "J2 Header Pin 32", "J2 Header Pin 31",
+			  "J2 Header Pin 29", "J2 Header Pin 18",
+			  "J2 Header Pin 22", "J2 Header Pin 16",
+			  "J2 Header Pin 23", "J2 Header Pin 21",
+			  "J2 Header Pin 19", "J2 Header Pin 33",
+			  "J2 Header Pin 8", "J2 Header Pin 10",
+			  "J2 Header Pin 15", "J2 Header Pin 13",
+			  "J2 Header Pin 24", "J2 Header Pin 26",
+			  /* Bank GPIOY */
+			  "Revision (upper)", "Revision (lower)",
+			  "J2 Header Pin 7", "", "J2 Header Pin 12",
+			  "J2 Header Pin 11", "", "", "",
+			  "TFLASH_VDD_EN", "", "",
+			  /* Bank GPIODV */
+			  "VCCK_PWM (PWM_C)", "I2CA_SDA", "I2CA_SCL",
+			  "I2CB_SDA", "I2CB_SCL", "VDDEE_PWM (PWM_D)",
+			  "",
+			  /* Bank GPIOH */
+			  "HDMI_HPD", "HDMI_I2C_SDA", "HDMI_I2C_SCL",
+			  "ETH_PHY_INTR", "ETH_PHY_NRST", "ETH_TXD1",
+			  "ETH_TXD0", "ETH_TXD3", "ETH_TXD2",
+			  "ETH_RGMII_TX_CLK",
+			  /* Bank CARD */
+			  "SD_DATA1 (SDB_D1)", "SD_DATA0 (SDB_D0)",
+			  "SD_CLK",  "SD_CMD", "SD_DATA3 (SDB_D3)",
+			  "SD_DATA2 (SDB_D2)", "SD_CDN (SD_DET_N)",
+			  /* Bank BOOT */
+			  "SDC_D0 (EMMC)", "SDC_D1 (EMMC)",
+			  "SDC_D2 (EMMC)", "SDC_D3 (EMMC)",
+			  "SDC_D4 (EMMC)", "SDC_D5 (EMMC)",
+			  "SDC_D6 (EMMC)", "SDC_D7 (EMMC)",
+			  "SDC_CLK (EMMC)", "SDC_RSTn (EMMC)",
+			  "SDC_CMD (EMMC)", "BOOT_SEL", "", "", "",
+			  "", "", "", "",
+			  /* Bank DIF */
+			  "ETH_RXD1", "ETH_RXD0", "ETH_RX_DV",
+			  "RGMII_RX_CLK", "ETH_RXD3", "ETH_RXD2",
+			  "ETH_TXEN", "ETH_PHY_REF_CLK_25MOUT",
+			  "ETH_MDC", "ETH_MDIO";
+};
+
 &gpio_ao {
+	gpio-line-names = "UART TX", "UART RX", "",
+			  "TF_3V3N_1V8_EN", "USB_HUB_RST_N",
+			  "USB_OTG_PWREN", "J7 Header Pin 2",
+			  "IR_IN", "J7 Header Pin 4",
+			  "J7 Header Pin 6", "J7 Header Pin 5",
+			  "J7 Header Pin 7", "HDMI_CEC",
+			  "SYS_LED", "", "";
+
 	/*
 	 * WARNING: The USB Hub on the Odroid-C1/C1+ needs a reset signal
 	 * to be turned high in order to be detected by the USB Controller.
-- 
2.21.0

