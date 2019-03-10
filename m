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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0801CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2E220657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSQRfQ7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfCJS3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:29:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43762 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfCJS3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so2658309wre.10;
        Sun, 10 Mar 2019 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P3Eq/z9XqnlDZWCHRvBje1On9BdD/KWeXqb9HES1aUU=;
        b=oSQRfQ7jak75Xitm00/NVx/exgml8xfLReYDZBo3DxQGFBH5YNwSCvQXqUae2t/6q8
         eW7pl55PBXQSkHU7Dhv9u415rLM42p5Ln8BeGJeBIhpYycyMwtrXya2Avd2x23MzYFO/
         v+cA6WpPKLSogQgcA5F/41O08pEkidg5Lu7Tsi+gQL8jBGNrP9Ljzz6mI7p/miNZXShP
         0JkFDAwwK2Z+cavRT7mHP2L7QW/DTiEPd4Q8H/9KdQ/+Dzv8Jc3bQNiXBMak+J721Ga+
         JIBukG8ICrd9Jde9VoooCjBAnHq75Tx3N78vE4BJWZ58RCrsh7w4izhKCTCXkOrX/6Zv
         nKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P3Eq/z9XqnlDZWCHRvBje1On9BdD/KWeXqb9HES1aUU=;
        b=ubzryWuFIuNUj+K/SQxXBVJ95p+6BNDhQr3/Ij96/Jfqh/yaPLHA2wbmjnq7HdC4GE
         mKtXmjfd46+SZxP9VGFrEI8WzTtdjU8mATJh0Tpu6Gl0VrqOmyEL7Ad7rafoqgVMDtPD
         YI4f3HkB/019ZKpfwZA2KDvkc1mFwksNBF5OmtfFWurK7NgognYhgdy16aazEJX/cHHG
         hbjChJwmw203J/e5Ky4kHjXqYWvTB4PHOce7FShlivbdZwUaP+/1iYYMhhTmurqmoOb3
         tO6phDpgt/wUFh/QSDJwFhqgy7nLIjXLUapIsrU27HxK98lzv7J8l/l+KTe/oPi2Hm2i
         Z4uA==
X-Gm-Message-State: APjAAAUvyxbm6BiEg+M7ooE05XPf1UFF7iLWw95Z1+Oo6Ei8qZUirX8W
        5JNfYOvU2+rM2jEWM7xtJr7yFeRt2VQ=
X-Google-Smtp-Source: APXvYqwxjnl4aWv5UpAEq5+N6fj5eXm37ZB4innNXD1j8k3raev86rbioP8egwqrmOoHCeiVPU5t1A==
X-Received: by 2002:a5d:6749:: with SMTP id l9mr13576611wrw.315.1552242568802;
        Sun, 10 Mar 2019 11:29:28 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:28 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Simon Shields <simon@lineageos.org>
Subject: [PATCH 24/25] dt-bindings: an30259a: Add function and color properties
Date:   Sun, 10 Mar 2019 19:28:35 +0100
Message-Id: <20190310182836.20841-25-jacek.anaszewski@gmail.com>
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
Cc: Simon Shields <simon@lineageos.org>
---
 .../devicetree/bindings/leds/leds-an30259a.txt     | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-an30259a.txt b/Documentation/devicetree/bindings/leds/leds-an30259a.txt
index 6ffb861083c0..0e894c9b80ad 100644
--- a/Documentation/devicetree/bindings/leds/leds-an30259a.txt
+++ b/Documentation/devicetree/bindings/leds/leds-an30259a.txt
@@ -15,10 +15,19 @@ Required sub-node properties:
 	- reg: Pin that the LED is connected to. Must be 1, 2, or 3.
 
 Optional sub-node properties:
-	- label: see Documentation/devicetree/bindings/leds/common.txt
-	- linux,default-trigger: see Documentation/devicetree/bindings/leds/common.txt
+	- function :
+		see Documentation/devicetree/bindings/leds/common.txt
+	- color :
+		see Documentation/devicetree/bindings/leds/common.txt
+	- label :
+		see Documentation/devicetree/bindings/leds/common.txt (deprecated)
+	- linux,default-trigger :
+		see Documentation/devicetree/bindings/leds/common.txt
 
 Example:
+
+#include <dt-bindings/leds/common.h>
+
 led-controller@30 {
 	compatible = "panasonic,an30259a";
 	reg = <0x30>;
@@ -28,16 +37,19 @@ led-controller@30 {
 	led@1 {
 		reg = <1>;
 		linux,default-trigger = "heartbeat";
-		label = "red:indicator";
+		function = LED_FUNCTION_INDICATOR;
+		color = LED_COLOR_NAME_RED;
 	};
 
 	led@2 {
 		reg = <2>;
-		label = "green:indicator";
+		function = LED_FUNCTION_INDICATOR;
+		color = LED_COLOR_NAME_GREEN;
 	};
 
 	led@3 {
 		reg = <3>;
-		label = "blue:indicator";
+		function = LED_FUNCTION_INDICATOR;
+		color = LED_COLOR_NAME_BLUE;
 	};
 };
-- 
2.11.0

