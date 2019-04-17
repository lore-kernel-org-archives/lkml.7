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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BC6C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E492183F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH6P1O1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbfDQUzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35467 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733281AbfDQUzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id t4so15250084ljc.2;
        Wed, 17 Apr 2019 13:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fhzQmAp5iOlIlBAu6HI0L2yh+fC0cdb1JmvV29SB8RI=;
        b=LH6P1O1QoDb5cgFYbWUbtdQga9StrjSwlACWL20LoodUPLiVXp7MVTI4B0nNbz9ezT
         AhCuHdYYZRzqNRrBASWtrOL2LNMdcCLPDW/f74a9Illh6lBUaOzh7WUZLlBxS1sHXNZg
         QEJoDqEW7M2f6r6ytXYFaqBz2AhHmsx7i/k70Dj1n2D50ogLELy6vc/fh8FLAjAKxwQn
         zuySYRzIhVmckDcEfSPnGVBKngmuNLPWeswtdDtH34rpSGLDdAGVjE+690BgEj8ecgMz
         8JwLBJLkCYw02lTKD2UkNEedCK5eduttoC4AcR4wAzR+eAXfuKoye//3CpBX2Xih4/5/
         0QRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fhzQmAp5iOlIlBAu6HI0L2yh+fC0cdb1JmvV29SB8RI=;
        b=b8upAFmDFTO6iMAlqODygBzLTWh8SDMwWDfTY1CRBf1MHC701ljFICUKDoBTbYlb+3
         ePu5X/48GZYCANwLndpQ0hjT+1QxmtIPyJqs4kuTNoM0C4dG1n8cKCXH6l+Pj+ZggcJN
         xzVj25WAetwQn6owZbj4XBa/QscRuk9qBJ8g90oUnjOTis4T4e8M8/vFE9bHcVZDvPSF
         wFBQL9q0MphKCusmkmpCqSQjQVNAiSGNCwvEiOB8RyR1tyj7P9g6SZKMlM4O1dACsPoK
         N3HRPPguwVB0O928f12fxIKFfroP8K22b/qx6Z2SVq319onI0Go3WjMkg8+XZOgIRcps
         /HsA==
X-Gm-Message-State: APjAAAVolVGNQ6nESGkCQuVjeIJgjuHboZvJjSWXWOfeWjfDJU8hK7qf
        l//48l059SbZcXPBznnSrTj6N5Jkgw4=
X-Google-Smtp-Source: APXvYqxLHXThqX7AWFpq0ltC6IGZmNgeSBK/yF6EOWW/GsIfWwlt0IeKDguoHLWeJGXp60qHStTvVg==
X-Received: by 2002:a2e:910b:: with SMTP id m11mr51769759ljg.14.1555534502164;
        Wed, 17 Apr 2019 13:55:02 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:01 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Baolin Wang <baolin.wang@linaro.org>,
        Dan Murphy <dmurphy@ti.com>, Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: [PATCH v4 05/26] dt-bindings: leds: Add properties for LED name construction
Date:   Wed, 17 Apr 2019 22:54:18 +0200
Message-Id: <20190417205439.17685-6-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce dedicated properties for conveying information about
LED function and color. Mark old "label" property as deprecated.

Additionally function-enumerator property is being provided
for the cases when neither function nor color can be used
for LED differentiation.

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
 Documentation/devicetree/bindings/leds/common.txt | 62 ++++++++++++++++++++---
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
index 70876ac11367..9fa6f9795d50 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -10,14 +10,30 @@ can influence the way of the LED device initialization, the LED components
 have to be tightly coupled with the LED device binding. They are represented
 by child nodes of the parent LED device binding.
 
+
 Optional properties for child nodes:
 - led-sources : List of device current outputs the LED is connected to. The
 		outputs are identified by the numbers that must be defined
 		in the LED device binding documentation.
+
+- function: LED functon. Use one of the LED_FUNCTION_* prefixed definitions
+	    from the header include/dt-bindings/leds/common.h.
+	    If there is no matching LED_FUNCTION available, add a new one.
+
+- color : Color of the LED. Use one of the LED_COLOR_ID_* prefixed definitions
+	  from the header include/dt-bindings/leds/common.h.
+	  If there is no matching LED_COLOR_ID available, add a new one.
+
+- function-enumerator: Integer to be used when more than one instance
+                       of the same function is needed, differing only with
+		       an ordinal number.
+
 - label : The label for this LED. If omitted, the label is taken from the node
 	  name (excluding the unit address). It has to uniquely identify
 	  a device, i.e. no other LED class device can be assigned the same
-	  label.
+	  label. This property is deprecated - use 'function' and 'color'
+	  properties instead. function-enumerator has no effect when this
+	  property is present.
 
 - default-state : The initial state of the LED. Valid values are "on", "off",
   and "keep". If the LED is already on or off and the default-state property is
@@ -99,29 +115,59 @@ Required properties for trigger source:
 
 * Examples
 
-gpio-leds {
+#include <dt-bindings/leds/common.h>
+
+led-controller@0 {
 	compatible = "gpio-leds";
 
-	system-status {
-		label = "Status";
+	led0 {
+		function = LED_FUNCTION_STATUS;
 		linux,default-trigger = "heartbeat";
 		gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
 	};
 
-	usb {
+	led1 {
+		function = LED_FUNCTION_USB;
 		gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
 		trigger-sources = <&ohci_port1>, <&ehci_port1>;
 	};
 };
 
-max77693-led {
+led-controller@0 {
 	compatible = "maxim,max77693-led";
 
-	camera-flash {
-		label = "Flash";
+	led {
+		function = LED_FUNCTION_FLASH;
+		color = <LED_COLOR_ID_WHITE>;
 		led-sources = <0>, <1>;
 		led-max-microamp = <50000>;
 		flash-max-microamp = <320000>;
 		flash-max-timeout-us = <500000>;
 	};
 };
+
+led-controller@30 {
+        compatible = "panasonic,an30259a";
+        reg = <0x30>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led@1 {
+		reg = <1>;
+		linux,default-trigger = "heartbeat";
+		function = LED_FUNCTION_INDICATOR;
+		function-enumerator = <1>;
+        };
+
+        led@2 {
+		reg = <2>;
+		function = LED_FUNCTION_INDICATOR;
+		function-enumerator = <2>;
+        };
+
+        led@3 {
+		reg = <3>;
+		function = LED_FUNCTION_INDICATOR;
+		function-enumerator = <3>;
+        };
+};
-- 
2.11.0

