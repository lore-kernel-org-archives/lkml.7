Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7322EC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D16221850
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrQs7ksp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbfDQUzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41626 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387417AbfDQUzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so23770565lja.8;
        Wed, 17 Apr 2019 13:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nRhyaqL2A8FcxSwVQxioSKMHZ1Dx0VcVyHzkz2mjWKY=;
        b=MrQs7ksp+8YvAH2u8LGuD2jleXcfW4O5rXry6QLlX7RkCXP5mmZrSQSCq6Z7SV+jO6
         mLTpq0y/3apkPhHJ847+H9k2iuRczQXNgHwou9Wx6Eta3q0dY1GZ55h8/T/podZOhCZ7
         bIIWoeIMt85OL8ZnM+gjtk0NZEurPfLjZqqsRNoDWQWe58SmSnOUqZyOa85COEdrokrr
         lxwEwWZeb19UjU9HIT+EMTyxYN5Y/QLicMdeya7+zxoOGwOCwPMSIHl3DXHGuWwXF2ZS
         J5uFPk1ajet6DI1/pO1AIV0Cte8ne8CIK6cA73/frOQMXSPEt+gXutjBYhGSWDaK1UAz
         cP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nRhyaqL2A8FcxSwVQxioSKMHZ1Dx0VcVyHzkz2mjWKY=;
        b=aGrLIe1g+lqTVyrgYWdseTK8jgOuAHHxGq2fU+V2PjJ8b9zvCVaY76HazpufJ3GZke
         zmsb3RJ+eeI9RiCnWqr9B6N/Ix++DV4hus/GQeNJSsg1iKOQY3KGBlAX0MBLZx4NOsVV
         PY6+o/9jJWbvCYCgff+pd7V/sajKLq1EOMWlVc/RlXF7UC4YGsS71k4aGDqBr9Oe/4Yd
         D4nLCK/XPNKqxTvIaVQLqMj0EQwqKcvzZ9rAh2TkXF+uBU7JK8suWscjpmtGKqS54Z5G
         P8P212PksGC1eMwU2aDVHBMOuiYPgXA3S716dL+xChIvHJ8moQw+3d9sXb+wQKyZlWiO
         S0rg==
X-Gm-Message-State: APjAAAWK11fxoYzaSX7bD5HGgmKI/7w/ixTek7NndDcxP5OPoATr3iP7
        wARPsJ9hytTWxImGIPoAyAf11Z5sWaI=
X-Google-Smtp-Source: APXvYqybduURqxlcxH0epU88Cddz+wh7vbgCZAPZmj0oJQrEirmNkm88mAx3I20lDOagG8YXGmiy8A==
X-Received: by 2002:a2e:9645:: with SMTP id z5mr1124937ljh.187.1555534510863;
        Wed, 17 Apr 2019 13:55:10 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:10 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v4 09/26] dt-bindings: lt3593: Add function and color properties
Date:   Wed, 17 Apr 2019 22:54:22 +0200
Message-Id: <20190417205439.17685-10-jacek.anaszewski@gmail.com>
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
Cc: Daniel Mack <daniel@zonque.org>
---
 Documentation/devicetree/bindings/leds/leds-lt3593.txt | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lt3593.txt b/Documentation/devicetree/bindings/leds/leds-lt3593.txt
index 6b2cabc36c0c..24eccdaa6322 100644
--- a/Documentation/devicetree/bindings/leds/leds-lt3593.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lt3593.txt
@@ -9,8 +9,10 @@ The hardware supports only one LED. The properties of this LED are
 configured in a sub-node in the device node.
 
 Optional sub-node properties:
-- label:	A label for the LED. If none is given, the LED will be
-		named "lt3595::".
+- function:		See Documentation/devicetree/bindings/leds/common.txt
+- color:		See Documentation/devicetree/bindings/leds/common.txt
+- label:		A label for the LED. If none is given, the LED will be
+			named "lt3595::" (deprecated)
 - linux,default-trigger: The default trigger for the LED.
 			See Documentation/devicetree/bindings/leds/common.txt
 - default-state:	The initial state of the LED.
@@ -21,12 +23,15 @@ be handled by its own device node.
 
 Example:
 
+#include <dt-bindings/leds/common.h>
+
 led-controller {
 	compatible = "lltc,lt3593";
 	lltc,ctrl-gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
 
 	led {
-		label = "white:backlight";
+		function = LED_FUNCTION_BACKLIGHT;
+		color = <LED_COLOR_ID_WHITE>;
 		default-state = "on";
 	};
 };
-- 
2.11.0

