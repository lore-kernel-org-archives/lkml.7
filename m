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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5BBC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B8A20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLgRi3Uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbfCaRzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:55:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33294 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731229AbfCaRzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so13741001wmi.0;
        Sun, 31 Mar 2019 10:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ktvBiJvWAjmIYqfFAf7fHcArYe4lqW5fuidbgFVYf0=;
        b=lLgRi3UkZr0suNviwEehHnerfHX7mkbH0U6uiFWPYb8XpHh++Hu/0Da0xLYGm/Ykvg
         ZJ9Lk4JzHwDoZCXt2iqYsJovc36PyZnJT3G8ivcOE2C2Pt8JWYi1E17Z55+b3tsYtyfr
         GZKwud9imnyCAx5wiaOl4d6tCyRuq+kSFY2CstyREwj/pHmVP5THTUCt4GS4t4qOg7Qn
         cEeTn7GoyGi08eOc6oLJU5BxsjvRSTVadzcaquO6Law6gDJ2KTJfyF/qks9X9raqd6hw
         m/xWaNGVlcasMjK3fePp5TPbrVkKhBva4cWvDT33L/AqhzKrg/FsCBWkc0jjMWESQ91Z
         lbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6ktvBiJvWAjmIYqfFAf7fHcArYe4lqW5fuidbgFVYf0=;
        b=fpIw73gD0aiHXeSbkbrEogus+Fl4v7szEr9AsOiMa+QbijFIYL8THbmJxRQduA7SqY
         /U4wPQE9cvFAWVRrfvwo9YK4mcd2lyMZrVot6lcFmHhSPoqzjUz94vUTmuoL5nrPYf9H
         vb6EiONYGhh4GHMg6Gu66RsvFnkwPCnH+pXmJSpe1ZysGRk4AOW0fi0vnHbu8b/nijIj
         0cxciZMOozEY0VmtvIgk3PZCnDugAjdUGJAr9ShA5ZC/7jINmz6DC9g085q+FHMFCdcE
         wK0F+c+ka5TzjJZNya2Cyifmi0fj8d87f0F4MtcvDTQXnjpgsqM2CpzWnBI0Pvs88bH0
         ZDnQ==
X-Gm-Message-State: APjAAAWNQ0t4Az78NdNdYH7xKXcyWfWAvqIYqoOSNbgJXcQkmz3HdMwd
        VquIwTtS7wz//05V5IVJScb+sJYt
X-Google-Smtp-Source: APXvYqz9LUHDhbofEDInoUSBGKEoTuR7ELHNwgBPWPKH846hqm7nuvPBKZyK2eAswgkE7Ph/3malfw==
X-Received: by 2002:a1c:1d81:: with SMTP id d123mr9471754wmd.59.1554054918961;
        Sun, 31 Mar 2019 10:55:18 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:18 -0700 (PDT)
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
Subject: [PATCH v3 04/25] dt-bindings: leds: Add function, color and led-enumerator properties
Date:   Sun, 31 Mar 2019 19:54:40 +0200
Message-Id: <20190331175501.23471-5-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce dedicated properties for conveying information about
LED function and color. Mark old "label" property as deprecated.

Additionally led-enumerator property is being provided for the
cases when neither function nor color can be used for LED
differentiation.

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
 Documentation/devicetree/bindings/leds/common.txt | 61 ++++++++++++++++++++---
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
index 70876ac11367..a63b4c6ac1ff 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -10,14 +10,29 @@ can influence the way of the LED device initialization, the LED components
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
+- led-enumerator: Integer to be used for LED differentiation when neither
+		  function nor color can be used for that purpose.
+
 - label : The label for this LED. If omitted, the label is taken from the node
 	  name (excluding the unit address). It has to uniquely identify
 	  a device, i.e. no other LED class device can be assigned the same
-	  label.
+	  label. This property is deprecated - use 'function' and 'color'
+	  properties instead. led-enumerator has no effect when this property
+	  is present.
 
 - default-state : The initial state of the LED. Valid values are "on", "off",
   and "keep". If the LED is already on or off and the default-state property is
@@ -99,29 +114,59 @@ Required properties for trigger source:
 
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
+		led-enumerator = <1>;
+        };
+
+        led@2 {
+		reg = <2>;
+		function = LED_FUNCTION_INDICATOR;
+		led-enumerator = <2>;
+        };
+
+        led@3 {
+		reg = <3>;
+		function = LED_FUNCTION_INDICATOR;
+		led-enumerator = <3>;
+        };
+};
-- 
2.11.0

