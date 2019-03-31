Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F168BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C742321873
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHJz9RpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbfCaR4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:56:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45681 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731499AbfCaRzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so8883040wra.12;
        Sun, 31 Mar 2019 10:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cS1I+tAxnly/9j/g9qsRZheti1vjpbbj6KNsU8oMHJE=;
        b=IHJz9RpVvKBGSmLFm/ZtO9WtYXd4IKaKLFgKZPva1gHLppzbWm6BSQyjkYMZL0kPnt
         MRQ6xZ35JRpH8n7qyaYxjSP9jVIbpI1wUhWiREqNBcHvoAsKoUJc5auYv5kLVBSQaXyA
         yVk8ivW0gsZDXk1Kd5CSirwmjzAN8MCquj9rhA6X2C2OkHE+U0g6OW1js3MEEE7bIv8x
         xRABPhCV/VPFkj10CWXxbSXmnzaxwBKTrpSarrHMkA1DD1XIj35o1FHTabP1SSk2lgU6
         i5l9COVsaqidtxahMelavPxrH1ySQPRb+gUqWa0GM3i5ijXuFxZTA6uR5Jd4V62r+1TQ
         Clnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cS1I+tAxnly/9j/g9qsRZheti1vjpbbj6KNsU8oMHJE=;
        b=BJUTSGRBnFJelR2BOQdtod2U5dZpo17n2rWmvJnLBlyilk5UJQa8MQFjWRPHzd2zvk
         m2BRCUVdtP6+HzipzAu+dPdoBekHtw8jF9hM9eU8dHvnT4n+bC5NuJITusVkKqoHQb8X
         OxEOyaVTswZgzSHOHYP1fKdYE8TwlXhySZ0DLIz4iUiEjRc9kyzYT6rFT9ehM12K1SM0
         hNuFoyWs9dTqH5K8MN1guoy4YrjdjRVMUgVMH5xxKMaKoIFCOhiYeFlOHGKVpy+1iio7
         RlETbr/QajRY2Jo/jR/+ivJG04hr/DtU1EgOsHToFi7XX7l35MVYm0qXebqi6S/6xjAA
         qpTw==
X-Gm-Message-State: APjAAAWKTr1+Ze+1BJjNAfGJ4YxaNh8ecW91IZCsbR/SLNNsGL/8imw5
        2bESoV2pu+ygtr3HS1A9PBpBMHAbU8c=
X-Google-Smtp-Source: APXvYqxaJ7kE//V5BWanr2tf7ID+LWXfhO54F2NYH+AV7Nd/x6Mk0KkDwP3dHCvKhfMwgwCOK8/NRw==
X-Received: by 2002:adf:e683:: with SMTP id r3mr22327564wrm.286.1554054949228;
        Sun, 31 Mar 2019 10:55:49 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:48 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 22/25] dt-bindings: leds-gpio: Add function and color properties
Date:   Sun, 31 Mar 2019 19:54:58 +0200
Message-Id: <20190331175501.23471-23-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to new "function" and "color" properties and mark "label"
as deprecated.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/leds/leds-gpio.txt         | 23 +++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-gpio.txt b/Documentation/devicetree/bindings/leds/leds-gpio.txt
index a48dda268f81..d21281b63d38 100644
--- a/Documentation/devicetree/bindings/leds/leds-gpio.txt
+++ b/Documentation/devicetree/bindings/leds/leds-gpio.txt
@@ -10,8 +10,12 @@ LED sub-node properties:
 - gpios :  Should specify the LED's GPIO, see "gpios property" in
   Documentation/devicetree/bindings/gpio/gpio.txt.  Active low LEDs should be
   indicated using flags in the GPIO specifier.
-- label :  (optional)
+- function :  (optional)
+  see Documentation/devicetree/bindings/leds/common.txt
+- color :  (optional)
   see Documentation/devicetree/bindings/leds/common.txt
+- label :  (optional)
+  see Documentation/devicetree/bindings/leds/common.txt (deprecated)
 - linux,default-trigger :  (optional)
   see Documentation/devicetree/bindings/leds/common.txt
 - default-state:  (optional) The initial state of the LED.
@@ -27,30 +31,34 @@ LED sub-node properties:
 Examples:
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 leds {
 	compatible = "gpio-leds";
-	hdd {
-		label = "Disk Activity";
+	led0 {
 		gpios = <&mcu_pio 0 GPIO_ACTIVE_LOW>;
 		linux,default-trigger = "disk-activity";
+		function = LED_FUNCTION_DISK;
 	};
 
-	fault {
+	led1 {
 		gpios = <&mcu_pio 1 GPIO_ACTIVE_HIGH>;
 		/* Keep LED on if BIOS detected hardware fault */
 		default-state = "keep";
+		function = LED_FUNCTION_FAULT;
 	};
 };
 
 run-control {
 	compatible = "gpio-leds";
-	red {
+	led0 {
 		gpios = <&mpc8572 6 GPIO_ACTIVE_HIGH>;
+		color = <LED_COLOR_ID_RED>;
 		default-state = "off";
 	};
-	green {
+	led1 {
 		gpios = <&mpc8572 7 GPIO_ACTIVE_HIGH>;
+		color = <LED_COLOR_ID_GREEN>;
 		default-state = "on";
 	};
 };
@@ -58,9 +66,10 @@ run-control {
 leds {
 	compatible = "gpio-leds";
 
-	charger-led {
+	led0 {
 		gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
 		linux,default-trigger = "max8903-charger-charging";
 		retain-state-suspended;
+		function = LED_FUNCTION_CHARGE;
 	};
 };
-- 
2.11.0

