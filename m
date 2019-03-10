Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F58EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAD820657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dShOMu15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfCJSaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:30:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52135 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbfCJS3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id n19so2240376wmi.1;
        Sun, 10 Mar 2019 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YzjpFaeJj+kFZvyrF2opKUMWFvF+7xeJgSa11B1bXkk=;
        b=dShOMu15kO7bPusC4N7YmpjZSiKJy6itxIbLmQmdaSkqyZiATnQaHj2YQxOTprjOfy
         StRqgIqnrcc/cuQtmC7wbGXPukcZiNo+YvkXfmdWCwPA0DhHjPGeVDQ86fBG2CqpsulU
         lv4r5sr3n4d0p9uLitj9tigManb0uIqngNzUDsaCkU6UVYKqHiIOT1YZoIWIlCDFtCVM
         0ClNidKdfGeOS7Cz3AuWe28oCGGWeOvkpYLagEFs1qxypIb5iLXYc/RfKaMWhlbnE/q3
         J8hH+3DB9rFO9kmuMJox7Ge0e0TFPx9ixN0/bQmrL885o+XFqqRuPgQXtE9wJouDYn3O
         8Hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YzjpFaeJj+kFZvyrF2opKUMWFvF+7xeJgSa11B1bXkk=;
        b=gmRfcWwbDO91hrFRpD2VVHaL62QvvGPBeRMzx8QuJUWHwCeRE7UlDRBqD+KaRNz1be
         ePv0ZW2btnRm6P+mo7lcJHGxHu7f3gHZclxz5lbLaBjcXrvYTDwXDcPZ+RL/h9A9yM5M
         ndbxof1Ne44I/nBTvWJoSfWFxUCp5sy517E8hbsBWDqDD0J983BRLwMZ9NqmmaYUOfMo
         gvaji4isbG0mmSopqx8scMtJmJ5ou0ubqGzYWULs/fEH8TapA3kFd49urTvTGMSDPAYo
         icC3jOO4FWqFIAFQjqM3Fezt8L+qGIeiRFCc5E3YL6Y7SjeAiVjnix4IWkubZDc9EXrW
         IVDg==
X-Gm-Message-State: APjAAAUaHxSFTL6+WbpjijcsSIFLUxNgg2EJonlbtbKFTP8Nm/TC5jS/
        qKZOB5hlM/RiYSzNjMp0ahd6tHun
X-Google-Smtp-Source: APXvYqzqQL/Wd1TbOs0Ir5tg86qersauozJZFHxCeXAGFCCNDX4m+8VzbPdCFXEqK/uORpOwrN/0uw==
X-Received: by 2002:a1c:6042:: with SMTP id u63mr14905248wmb.92.1552242547660;
        Sun, 10 Mar 2019 11:29:07 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:07 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Daniel Mack <daniel@zonque.org>
Subject: [PATCH 08/25] dt-bindings: lt3593: Add function and color properties
Date:   Sun, 10 Mar 2019 19:28:19 +0100
Message-Id: <20190310182836.20841-9-jacek.anaszewski@gmail.com>
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
Cc: Daniel Mack <daniel@zonque.org>
---
 Documentation/devicetree/bindings/leds/leds-lt3593.txt | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lt3593.txt b/Documentation/devicetree/bindings/leds/leds-lt3593.txt
index 6b2cabc36c0c..63af05827447 100644
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
+		color = LED_COLOR_NAME_WHITE;
 		default-state = "on";
 	};
 };
-- 
2.11.0

