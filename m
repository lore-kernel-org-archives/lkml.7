Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB491C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9978E2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVu+qpIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfCJS3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:29:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46720 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfCJS3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id i16so2650199wrs.13;
        Sun, 10 Mar 2019 11:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gIXPiGOH4LW1MoGaybgap4r7othESitSAvXiWK6FST8=;
        b=GVu+qpIceZh67TBD5N3iJ1gqYfCgNfjRjp+uQ1znX48lHEpIK9D7HhbpVJKvWWo5Ax
         qNiakDtXNtw3UJwjayGGcqbmefcd3FFS2kSYIK6E7dMrSJ+yevptAZVkrpLUS3Vcq/iL
         9HRC66IEBX/GODscuKCHCpngwJvpsxaODn+1Xy3tumh4wcSjI7EAMsPi2kiqfX3sctG2
         BVILDu9GjDawqkmgPvEe/HNUvEscfacPqb4B7fjNk0YFEXq/dG4GVRhMGDBMdvrjcTGg
         AJ6LkGA6zwUexPDXMb0jA3QB5YvLr+SRmh+OZgbT4iwSFcO1p6+8BtxlFwLSsyhq0or5
         SpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gIXPiGOH4LW1MoGaybgap4r7othESitSAvXiWK6FST8=;
        b=bkoDnyzqE0BhkuLdYLkDVEbEQFszqItH7r6p4Q63NIGDkFy9fhWIGwPP4wNdH4D5Si
         51RisNZ0Sn4tAcBzQJncP050yitX2cv7UTXmxTwYUrbrIPaa5IzkEpNNPr6olicRu4mH
         t66SgIhNyfIoMZbSEzYi6p592txwlbCzwFy+XpJIjFiE3IIjD2FzemTPd/KcZ2OF760l
         RwhsHGjyWv98Ib8SbItVqnlMoHsbGchkWBUNDgS6f+SnKUoFA2BCiZXWcD/fmQu86uPf
         esQcsmg6D60CHY5b+BlzEueBnl/OwALIELZ4SL6b/YMCNene6sRcmOsN3Nm87LZ0vNLq
         cr8w==
X-Gm-Message-State: APjAAAXS6hPN0nfKCTJU56c8kFEf3sAyyutpwnmlcgKStP7CGeWDAVcg
        CJLbFn3uFWnoW1GCUmBGO2J4o3Z5
X-Google-Smtp-Source: APXvYqzS4WrvaE+blcePE/ahvRi3pVnEd+rHz/lBHtlrvP5IWn/Ot8i+LKW/xXZFhFEKvrkCB/yQqw==
X-Received: by 2002:adf:dc10:: with SMTP id t16mr18276616wri.40.1552242543854;
        Sun, 10 Mar 2019 11:29:03 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:03 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: [PATCH 05/25] dt-bindings: leds: Add function and color properties
Date:   Sun, 10 Mar 2019 19:28:16 +0100
Message-Id: <20190310182836.20841-6-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce dedicated properties for conveying information about
LED function and color. Mark old "label" property as deprecated.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Simon Shields <simon@lineageos.org>
---
 Documentation/devicetree/bindings/leds/common.txt | 55 +++++++++++++++++++----
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
index aa1399814a2a..3402b0e1cec9 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -10,14 +10,23 @@ can influence the way of the LED device initialization, the LED components
 have to be tightly coupled with the LED device binding. They are represented
 by child nodes of the parent LED device binding.
 
+
 Optional properties for child nodes:
 - led-sources : List of device current outputs the LED is connected to. The
 		outputs are identified by the numbers that must be defined
 		in the LED device binding documentation.
+- function: LED functon. Use one of the LED_FUNCTION_* prefixed definitions
+	    from the header include/dt-bindings/leds/common.h.
+	    If there is no matching LED_FUNCTION available, add a new one.
+- color : Color of the LED. Use one of the LED_COLOR_NAME_* prefixed definitions
+	    from the header include/dt-bindings/leds/common.h.
+	    If there is no matching LED_COLOR_NAME available, add a new one.
+
 - label : The label for this LED. If omitted, the label is taken from the node
 	  name (excluding the unit address). It has to uniquely identify
 	  a device, i.e. no other LED class device can be assigned the same
-	  label.
+	  label. This property is deprecated - use 'function' and 'color'
+	  properties instead.
 
 - default-state : The initial state of the LED. Valid values are "on", "off",
   and "keep". If the LED is already on or off and the default-state property is
@@ -87,29 +96,59 @@ Required properties for trigger source:
 
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
+		color = LED_COLOR_NAME_WHITE;
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
+                reg = <1>;
+                linux,default-trigger = "heartbeat";
+                function = LED_FUNCTION_INDICATOR;
+                color = LED_COLOR_NAME_RED;
+        };
+
+        led@2 {
+                reg = <2>;
+                function = LED_FUNCTION_INDICATOR;
+                color = LED_COLOR_NAME_GREEN;
+        };
+
+        led@3 {
+                reg = <3>;
+                function = LED_FUNCTION_INDICATOR;
+                color = LED_COLOR_NAME_BLUE;
+        };
+};
-- 
2.11.0

