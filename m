Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E10C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826FA20872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxsFg0B6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbfDQUzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46489 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387646AbfDQUzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id h21so23721386ljk.13;
        Wed, 17 Apr 2019 13:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cS1I+tAxnly/9j/g9qsRZheti1vjpbbj6KNsU8oMHJE=;
        b=CxsFg0B6T9j/JoeGAmq6kfyoPuMw5A+bx+A+EvUn+KdQK+2C/eMh23pp+OimiemKv4
         l2FS2ptjjQZemFd3+0HnvgR1x+pbib0/HwEajmMvwRwis13WfihsJyo3N5hrAY4JhNJi
         iFziYXGw+Mr1USEpt1GIRL+RCNGaexu/yz98K8EX2Qvza84G9KSZCTL8hdD9KuSmXoAp
         G+cgleXAZ92aSotTfdHeT+gdEFltwrjq629DCMk/9AitIE6poG1Wwv34akHq5i9hlsWM
         8dXPYOCqElC/RJTC1WjP3qB+/rNSSoPUcqRjwoDyXz2q1thDB29HkhmIhUpJQ2MEgoSt
         yW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cS1I+tAxnly/9j/g9qsRZheti1vjpbbj6KNsU8oMHJE=;
        b=Gmyi3QnU25/T/wm11c55eBwR1FrHnNaUCRPR17UGjCcRYSCFZ9YAe2kE2jmx0YVij3
         5KwHk3tdpT34JVKQIkMT3vvIwA9Q+qEiMHx//x4T49ITi2vDiNzd/f3/AxSKUtcoPL2K
         FmdrmHr2jWHvu1i3EQsYVfdzH1iB4hFpboI9YBWbrBkAmcGYxOCjc2+p0PVODMGP3NyH
         /ykINU59lthqKTXU+4UqtWVjBT/9P9HyHSwh+pCeHmRgGcJsLaA9RWg98o/GMdFIDU99
         Rw7kpgQoRT7py/u//1D8/Z7R5NglMrEGSHKFwKzCtBqMnicd/vaguqlyKwFZZsLOu+C8
         qgZg==
X-Gm-Message-State: APjAAAUyO7UFHet0Wszlsyh3/PMzC3lGW/iDAp/weGNCzA//n0+EQLNh
        pr63Zn8geRIP/fHNbfMY2jmXsEs3UfM=
X-Google-Smtp-Source: APXvYqxU7uLnUMsEGRR7iwD3iJ88Elwwv66TZC+5Q/sgzI4ZcgJi98QELM34gP10PZF+W8zgrsUx/w==
X-Received: by 2002:a2e:5518:: with SMTP id j24mr47701716ljb.167.1555534536497;
        Wed, 17 Apr 2019 13:55:36 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:35 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 23/26] dt-bindings: leds-gpio: Add function and color properties
Date:   Wed, 17 Apr 2019 22:54:36 +0200
Message-Id: <20190417205439.17685-24-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
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

