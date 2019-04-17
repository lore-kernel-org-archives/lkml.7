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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DA1C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7793B21850
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cq+Q3nl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387514AbfDQUzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38621 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387474AbfDQUzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id v1so10606476lfg.5;
        Wed, 17 Apr 2019 13:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U2dPQ5PqeJUS3vRQT+iVuB+v/Ht4lgydviD9qFBU8yo=;
        b=cq+Q3nl/hDx07JGJx6k2cDUfj17n+uDAZE7JW9p3vmfv9u2p6WNSegEuqUrNxHrsN6
         LG8TSLhyUOoBRKFxeRIIEEpvAiFC3b7PAKYUKQhXnkdX/ybaUx88pRRLBtxxbLFTImDA
         X6634TMmRA1V/ZdtHJDlWJHmZINWRQKfTaGevUntiw2GiWlInKBUf9Z9wr8cdyX2FH44
         f3X4rVjtJPGkW4kKb/uPpYrY6HAO241H0+g3VqQcBUGn4MlFHZ2eEKaI/n6CIAnzMtav
         kQZYCc1z9gAPECgW/E+Z8VYENvrHeP7TFQsc8V0rGBIjZhN2OChDJExsaoKmUzY1ACAJ
         Kcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U2dPQ5PqeJUS3vRQT+iVuB+v/Ht4lgydviD9qFBU8yo=;
        b=e+aCn/VJWGGFRexWxHY8hap7Yog1PSEgbklDohbPoCG/3NUia0cIr9T7LifpCzmfhT
         4faeWuPsLLp1xgHl5ipYpwjIFPjjXpoRCmLg4Lu4cJbtSRk9tuuvhEBiEFVSM7+35p7U
         at1n/rTmfGjSOIRgxljjzqZZFb9OnCMjuZYoCa4v2xrMRCE6y1NNwXkY3+8ZplYrlPxG
         o8NWWKAwL2ECpoeTH89hZFg8MUyDVQURG2KjikBdrkdsfRR52PVsi+3A9Za5Nc1xQdMI
         UkfPvGzZZTe1t7iTlWYiMx8BOfsCsxsYAYePKwwGLgbPhOn5i95f6pKnOOgm7p7qo3Ce
         V7Yw==
X-Gm-Message-State: APjAAAXRtpmjUkgaHLkq57JKWYJl7LoJXAIqzvT3sGM1DOUWu3S4geKQ
        SwiIsaIBaDVPuJhtZm/FSFufJ1vQ5wo=
X-Google-Smtp-Source: APXvYqwqiNBYREqSkBlkSIWl8N5cDHBzb2/nuiu6SNGU8DO7yhl8sICF4zj/xvGkxVBH/DRPlB/AcQ==
X-Received: by 2002:ac2:4303:: with SMTP id l3mr29394756lfh.61.1555534514541;
        Wed, 17 Apr 2019 13:55:14 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:13 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v4 11/26] dt-bindings: lp8860: Add function and color properties
Date:   Wed, 17 Apr 2019 22:54:24 +0200
Message-Id: <20190417205439.17685-12-jacek.anaszewski@gmail.com>
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
Cc: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/leds/leds-lp8860.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lp8860.txt b/Documentation/devicetree/bindings/leds/leds-lp8860.txt
index 5f0e892ad759..9863220db4ba 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp8860.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lp8860.txt
@@ -20,12 +20,16 @@ Required child properties:
 	- reg : 0
 
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
 led-controller@2d {
 	compatible = "ti,lp8860";
 	#address-cells = <1>;
@@ -36,7 +40,8 @@ led-controller@2d {
 
 	led@0 {
 		reg = <0>;
-		label = "white:backlight";
+		function = LED_FUNCTION_BACKLIGHT;
+		color = <LED_COLOR_ID_WHITE>;
 		linux,default-trigger = "backlight";
 	};
 }
-- 
2.11.0

