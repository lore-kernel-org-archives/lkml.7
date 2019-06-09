Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF7BC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 19:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00822206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 19:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDmnZ16A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfFITIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 15:08:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37307 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730277AbfFITIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 15:08:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id 22so6177336wmg.2;
        Sun, 09 Jun 2019 12:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6lQi1mllsYB+wfDhYNDS6WRLJG67uHkKkm9jX2RbAEM=;
        b=nDmnZ16AdqVrf1Kj0XFxb6pXcQRw4pAK5GFi4cYu5JkWQghWctgEb/yDYJUj9ziJVV
         UEYBiDUZPC9mjqHXDN/rHUiUhTCh4xxd2D9+6G14Hso8ulWIzjtzLLWxp3sU/x2EBxkv
         HNMGFlzy7kelbgSfz4NwB8Q9uHaMdXjI7C7L1APgWkRYRjjhbrgN4D9BDDOY/oUpBx2O
         Cgn6IYVPiUVx6ykV75fReSkBm4aAiNlMsbWM27ot9rKlGehFhD+JinHOdcO782XBw+wn
         3i78qNKdAHAq8wmLLC1bEzww+QZuUE3L3C+xZIEUo0BQ84X5oC3CGfeIXRVbC96Ko5zp
         Vz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6lQi1mllsYB+wfDhYNDS6WRLJG67uHkKkm9jX2RbAEM=;
        b=Az9GWwk3kYKEhtmdUeysJXIEJlEQKGN3wrnRjlEZVYlsAt9Ts5oU6iQGkxVa5OkTh1
         XmNxU3usnMXEJo6JCa7xRLdUB9Fj069ibUOH1VPN8cLtQNsMDAIDSLrtF8W61rsPLGak
         GuYhH2phCWdchDy+6cM0cheaBRBCPxai5EnbjTR/6OBeZ0GJi6RmiGQQ/h3u++9+W9xA
         PoS+QXh2hluc6E+w2gqqD60ifh8i2NcarX8dXy0/E+7dHaO14Q3puKfGPtyX9U6+D09O
         6lkB6pzTb5aPbD5DWe+yHrtl66QzNoECt4s4i8OSW+L17r0QWVnaYCLWdv3fLrsCoPbK
         /rrA==
X-Gm-Message-State: APjAAAXmwKjOyzvPnNmA+YwxqxoD2zJWAWY1aCP1MWA+L8iVPEVylEo0
        PPlbHXL7VQ3mRjvdoggP0trFXCob
X-Google-Smtp-Source: APXvYqzrQhDNJYkzz8hQndy7ixiNj0ON+Dv+19lV/D3MLfewJG9vKb0tRCx+Kct2YSl/R8PW0Jpv/Q==
X-Received: by 2002:a1c:5412:: with SMTP id i18mr10609429wmb.11.1560107328163;
        Sun, 09 Jun 2019 12:08:48 -0700 (PDT)
Received: from myhost.home (ckm12.neoplus.adsl.tpnet.pl. [83.31.88.12])
        by smtp.gmail.com with ESMTPSA id y38sm14725041wrd.41.2019.06.09.12.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 12:08:47 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        dmurphy@ti.com, jacek.anaszewski@gmail.com
Subject: [PATCH v5 12/26] dt-bindings: lm3692x: Add function and color properties
Date:   Sun,  9 Jun 2019 21:07:49 +0200
Message-Id: <20190609190803.14815-13-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190609190803.14815-1-jacek.anaszewski@gmail.com>
References: <20190609190803.14815-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to new "function" and "color" properties and mark "label"
as deprecated.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Reviewed-by: Dan Murphy <dmurphy@ti.com>A
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/leds/leds-lm3692x.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3692x.txt b/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
index 08b352840bd7..4c2d923f8758 100644
--- a/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
@@ -26,12 +26,16 @@ Required child properties:
 		3 - Will enable the LED3 sync (LM36923 only)
 
 Optional child properties:
-	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- function : see Documentation/devicetree/bindings/leds/common.txt
+	- color : see Documentation/devicetree/bindings/leds/common.txt
+	- label : see Documentation/devicetree/bindings/leds/common.txt (deprecated)
 	- linux,default-trigger :
 	   see Documentation/devicetree/bindings/leds/common.txt
 
 Example:
 
+#include <dt-bindings/leds/common.h>
+
 led-controller@36 {
 	compatible = "ti,lm3692x";
 	reg = <0x36>;
@@ -43,7 +47,8 @@ led-controller@36 {
 
 	led@0 {
 		reg = <0>;
-		label = "white:backlight_cluster";
+		function = LED_FUNCTION_BACKLIGHT;
+		color = <LED_COLOR_ID_WHITE>;
 		linux,default-trigger = "backlight";
 	};
 }
-- 
2.11.0

