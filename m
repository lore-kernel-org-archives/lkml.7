Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEA2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E50620872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv1fsjPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbfCaR5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:57:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43520 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfCaRzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so8882495wrx.10;
        Sun, 31 Mar 2019 10:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0WHI/j314P0fYo6XeNgCy+ifzI1rtMM5AZ50TEjjVc8=;
        b=jv1fsjPdspZjXaZAOwcbZq41Hx6E5WTtriaUh6wRBUzo+ARjBRV0sD3LO1852/U1xo
         Zp7nSLQZlhivqWk9AJMiM2tohH0jxiRSAoKUdTCztZ6Z52tWO/B1EmWIT0OUTbRxUom4
         nTHbjiYKxJy79DM10RS0V7RfvZtArrq/EHiNhddQVlrOXjgfA9yQFjSMRI8HLJDNOXH0
         yk5g2iyNdztgezoEPnuqj1TIA6zR1Tke0YSMTxjpvX/e4WmvfvXz22JxfSrbC56ECMO4
         1jfSVFsTLmeOEz+gOgnsmLrQIGUdevZ22vzYASt0LcxNIkmWiNmk0eU0FUy0qjxgGyv5
         q1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0WHI/j314P0fYo6XeNgCy+ifzI1rtMM5AZ50TEjjVc8=;
        b=R3U4IyU4Q/4q+xywX8DqH+DyOZedThLyXVZvlSG1GIcR3ZC70tS1LF73L88GWn+prC
         o7NAnQZ36M8d37RULqaCBv39CqGx8JtKS0fmfG1acrGxxSC3oVlx51tjzfnWPO11Ks8U
         nQjBEynygmmpDvfDq2MnHKIslJ/QZWsoMeXZEguqLY7dtrdlQZBL8Sk5JaAYtpZPKdyd
         GLTeqAOByikjxhGJeiuypglCXRS8pnEqoqJsRg1YfI2Cltz+GHu2XaMw5CsFrXANEbFb
         t0oOgTqx42wF5lbmBgEQIosgXTRILf8L631MU5XPx3/zLrela2HIdJmZWbAimtSUdV/N
         loiw==
X-Gm-Message-State: APjAAAX5WAI1+YKcMjsYefVqouCc0Ju/U9l/MrPdRWcaJilPzk9XV4M6
        29xKwCPl88tt/dqP7irihJKb99vR
X-Google-Smtp-Source: APXvYqx6wrrPm/prgiarenpJsA8cDLcfwuWyd2f7insmvFT6xqetTO7XtC+dleJg0QvXI7nVc4UiBg==
X-Received: by 2002:adf:f147:: with SMTP id y7mr36300989wro.102.1554054914914;
        Sun, 31 Mar 2019 10:55:14 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:14 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Baolin Wang <baolin.wang@linaro.org>,
        Dan Murphy <dmurphy@ti.com>, Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: [PATCH v3 02/25] dt-bindings: leds: Add LED_FUNCTION definitions
Date:   Sun, 31 Mar 2019 19:54:38 +0200
Message-Id: <20190331175501.23471-3-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial set of common LED function definitions for use in Device Tree.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Simon Shields <simon@lineageos.org>
---
 include/dt-bindings/leds/common.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index e171d0a6beb2..0325db5b4208 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -19,4 +19,40 @@
 #define LEDS_BOOST_ADAPTIVE	1
 #define LEDS_BOOST_FIXED	2
 
+/* Standard LED functions */
+#define LED_FUNCTION_ACTIVITY "activity"
+#define LED_FUNCTION_ALARM "alarm"
+#define LED_FUNCTION_BACKLIGHT "backlight"
+#define LED_FUNCTION_BLUETOOTH "bluetooth"
+#define LED_FUNCTION_BOOT "boot"
+#define LED_FUNCTION_CHARGE "charge"
+#define LED_FUNCTION_DEBUG "debug"
+#define LED_FUNCTION_DISK "disk"
+#define LED_FUNCTION_DISK_ERR "disk-err"
+#define LED_FUNCTION_DISK_READ "disk-read"
+#define LED_FUNCTION_DISK_WRITE "disk-write"
+#define LED_FUNCTION_FAULT "fault"
+#define LED_FUNCTION_FLASH "flash"
+#define LED_FUNCTION_HEARTBEAT "heartbeat"
+#define LED_FUNCTION_INDICATOR "indicator"
+#define LED_FUNCTION_KEYBOARD "keyboard"
+#define LED_FUNCTION_KEYPAD "keypad"
+#define LED_FUNCTION_LAN "lan"
+#define LED_FUNCTION_MMC "mmc"
+#define LED_FUNCTION_NAND "nand"
+#define LED_FUNCTION_ON "on"
+#define LED_FUNCTION_PROGRAMMING "programming"
+#define LED_FUNCTION_POWER "power"
+#define LED_FUNCTION_RX "rx"
+#define LED_FUNCTION_SD "sd"
+#define LED_FUNCTION_STANDBY "standby"
+#define LED_FUNCTION_STATUS "status"
+#define LED_FUNCTION_TORCH "torch"
+#define LED_FUNCTION_TV "tv"
+#define LED_FUNCTION_TX "tx"
+#define LED_FUNCTION_USB "usb"
+#define LED_FUNCTION_WAN "wan"
+#define LED_FUNCTION_WLAN "wlan"
+#define LED_FUNCTION_WPS "wps"
+
 #endif /* __DT_BINDINGS_LEDS_H */
-- 
2.11.0

