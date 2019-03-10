Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04525C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6B420657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbNDE6O5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfCJS3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:29:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46736 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfCJS32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id i16so2650744wrs.13;
        Sun, 10 Mar 2019 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gsglFRHEUxkPK0tIo95amr6BFFuEAxh1ztYoILwzUrE=;
        b=CbNDE6O593cQUFweEODvAY3o1nKd4POB6tO9C1BnMSEqcyV0Gq9/k9zYiOjXWXe2ra
         pVsv0W1KXP1KpN+DvvQ7RgcLVkcX3+diQlMF4bk/lEEGvJLSm+ouPHBCFJimMfQ6+eeD
         EVaP27g5whexHkGG2E/iRjUtd3Mzq0wJRcWD0RgGo12lwo31IB7N8KbPOuvzAMLPPZmg
         cUXOdZeajGOJ+ITjemSG1Yq8Pv7sgZ3dADUY+OqysgVRyVU1N12LywjeZfG4ezc2xMRH
         sYEc1RGXMnTSS7ZVSdeKLl1tUie6mbOiLvt9vMUmfwvGSjDcaNJsTLpQvgKSjxJbnXbM
         LMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gsglFRHEUxkPK0tIo95amr6BFFuEAxh1ztYoILwzUrE=;
        b=JiP0coc1j7cNSYiB+P+FFl0+aIPtF0FsiW0c75Oe7C11LHBSyxVixrsSNYGMDxLbxs
         BTJt7tzC4GKFVPWw4SuqZPJf4C4RzOfd7aXWLeS5viW3OY2jYunxHf+mydlHPTCK6oeh
         UIVLHrbmzu8fS1yQWHaj0tRnwQ3Ow2quQLSXnasJ+AABP01z8yAHuP2M/6S5byKg1mIb
         qvg44VB414Huh1EFE4dHxAZVuH07agXMTm+gdtupa0LpoPHurlU1am8cQFfJ804PFzGw
         95qNXDT7zdss9oyrPtRcPgoEv702XVXTsiNQ9HUMwYvZyXzuJW/sKPsNriQcg/z4KzkK
         VBcg==
X-Gm-Message-State: APjAAAU1dMqVAQu1JHZBcjvaKy9cbJ83EJeu5Z1asmnX1QYn0F6CBGm+
        pwxFPV0InUkEdJzvjC1IgDK77YDRubM=
X-Google-Smtp-Source: APXvYqzeCVCHOPrCWDDv6D0mx9ge6/EGJgfPugL+4tpiMs1Yf0XaPJzBqnE2OFr8/MI13nFuPtJ0Ag==
X-Received: by 2002:adf:f4d0:: with SMTP id h16mr18473353wrp.103.1552242566221;
        Sun, 10 Mar 2019 11:29:26 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:25 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 22/25] dt-bindings: leds-gpio: Add function and color properties
Date:   Sun, 10 Mar 2019 19:28:33 +0100
Message-Id: <20190310182836.20841-23-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
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
index a48dda268f81..90fb24cb2864 100644
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
+		function = LED_FUNCTION_HDD;
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
+		color = LED_COLOR_NAME_RED;
 		default-state = "off";
 	};
-	green {
+	led1 {
 		gpios = <&mpc8572 7 GPIO_ACTIVE_HIGH>;
+		color = LED_COLOR_NAME_GREEN;
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
+		function = LED_FUNCTION_CHRG;
 	};
 };
-- 
2.11.0

