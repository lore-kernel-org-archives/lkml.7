Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978CCC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1C220872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAah8uBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbfCaRz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:55:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43565 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731672AbfCaRzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so8883671wrx.10;
        Sun, 31 Mar 2019 10:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0b42a5FAmbnwfJQAnJRwbC3L/GSGJl/BJQZRv2jC7kY=;
        b=gAah8uBevMa+InJSjBHUhzrS6dtuJcsetUKxGkuuYoCa0dz0fzE3JQZR/khy83JNlF
         dxJez2cwq7wmo8vM61wZR9H48BmzVGdH4KwRYJxTjtvjz/Uu73nFRJB0OWukpfQtt2Es
         XGMwEmp55qxeryvzCuhOjiYi7YSH2HTkpZ86fDDPtLTjUG/45aJGbgsaPoDGEieRnA2r
         RaDfgTj7YvE94s+XbbCLsFCWdjqFX3xkqgn3FJYpLRskRHsbjlZgiA3MHM5SsMQO27Op
         2sutpu9ZOL/Dz/itXXjhJqzhpIiM4IVAk6u7oIE2BRHTgK8n7DBWfvNu6RjxeLTP3GJ8
         QcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0b42a5FAmbnwfJQAnJRwbC3L/GSGJl/BJQZRv2jC7kY=;
        b=Zamfsx4sbshn4USfiXUGPB7ZjKN24K739CBe7kvwd4n9dgyHUbOk+6oUzsh4hGHvBH
         t/3icDq864k8utlfmHLSivb3g1DOGc5qnK78pEjnxLHMML+ErTdsQx2aKe8eCc3cjqJo
         4fghDf5GbEkXT6ybQzde+cszMwI4qIJ40pfTUjvduGIcM2FLYWJda1Gh+ChmSLR8DLbL
         iQU18HqxUV/xFZfH5XrxMCYDEgqZTewk11sY8ZHP5BN1ytwPQmYuSik+XJXC6epe9HmY
         TAf1lodAJzY04rf+juuJ4t5ClTa1WOMt+5vcB0AOgBE51kMCa5SmgsIqUFsdAH8PlK1Y
         BnMw==
X-Gm-Message-State: APjAAAUalpj+RgHGTCGPnrkPAPNQ5/9iQvDvr9TJO67dEJf5eLh/oxVt
        7L2swWI133jMLKUTQDaGMcfUdB0guBQ=
X-Google-Smtp-Source: APXvYqzQx3C+fHHebFL/pzOKpvDQBryOMjzxaXPVxmQT/WDrLQ/e7drUbtEercqLEyy1Ge/wQztHvg==
X-Received: by 2002:a5d:684e:: with SMTP id o14mr40121045wrw.138.1554054952384;
        Sun, 31 Mar 2019 10:55:52 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:51 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Simon Shields <simon@lineageos.org>
Subject: [PATCH v3 24/25] dt-bindings: an30259a: Add function and color properties
Date:   Sun, 31 Mar 2019 19:55:00 +0200
Message-Id: <20190331175501.23471-25-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
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
index 6ffb861083c0..cbd833906b2b 100644
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
+		color = <LED_COLOR_ID_RED>;
 	};
 
 	led@2 {
 		reg = <2>;
-		label = "green:indicator";
+		function = LED_FUNCTION_INDICATOR;
+		color = <LED_COLOR_ID_GREEN>;
 	};
 
 	led@3 {
 		reg = <3>;
-		label = "blue:indicator";
+		function = LED_FUNCTION_INDICATOR;
+		color = <LED_COLOR_ID_BLUE>;
 	};
 };
-- 
2.11.0

