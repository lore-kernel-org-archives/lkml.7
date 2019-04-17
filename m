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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19FFC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCF320872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoTnHoM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387690AbfDQUzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:44 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45103 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387646AbfDQUzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id t11so15426258lfl.12;
        Wed, 17 Apr 2019 13:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0b42a5FAmbnwfJQAnJRwbC3L/GSGJl/BJQZRv2jC7kY=;
        b=JoTnHoM3iofESlq5k7vPpDMk6jShwBhkN47vjpC3K+RackPRDqjgyf+ZLG8GTnyFUt
         b+qbEMnD3j+sADaWHjpBTePwUsz7rWUWj1NjI79V74ozCqioRVrJBCzILDTooilIcPL1
         4mwzgidYhWhmlPUvvI8t29jntoCDnN9SrEj+pCd2fnSwge9tZh07f0WKF7RETcjCNt38
         7dEjvMnBD9qcdbFPZrKKprS2/3xOHmOIoUMldispHnZNPImNdDeAFuT2Fft7BD3b/Vu0
         yQC3Yd6uyt/502SrxMmF4m5Chjpd0FXizu32+khv99JfbP+DDVKztaNDIVtOCGpa6J2n
         hU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0b42a5FAmbnwfJQAnJRwbC3L/GSGJl/BJQZRv2jC7kY=;
        b=CltNSn21gRqGySzwKW1HjflpPFRKHt2WvYFz7rUPXLILTweWHcFPLpzhrvyT5ArAD6
         D/H2mya/wYfKrSzFl0calEZedxBUPyLhTHZ8ZTxHlX2xeoMSw0UWELUTmFBdODoKDGhZ
         z4rD4LemQU+ADuuwWCLtxi9Yx9gAWmRqCU8cDb0Zs6KLrgyfCJlpRRp+DYKT52Ikchv0
         PJa3A0qhnroIr4m8OAQ/BBkOHtB0UqP31X3QU5poRGHiI5s8s2MGUSDN0dimZYBd7cy+
         37BiBHxRvA5tbVN0+H6Jker0NffxFtm+SgUAdjQeLVnwUZasHbkvyxGw9nE5MsEmfDz9
         i5eg==
X-Gm-Message-State: APjAAAX3KbmRb2BVsr/cfKtuPUqnvOqWHJi9vgPB6HRhUvuGuw0xLjzn
        HJdyNURjBHpX+rA7mZ6wrKfn84/gg5Y=
X-Google-Smtp-Source: APXvYqzl8MRBjHJRs5qesGoMaDNJF7RBbuXScdBtBYgG3jqA8awvCPs0RsqDPJQvKx2QwktoQZY88g==
X-Received: by 2002:a19:1dc7:: with SMTP id d190mr5475052lfd.48.1555534540174;
        Wed, 17 Apr 2019 13:55:40 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:39 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Simon Shields <simon@lineageos.org>
Subject: [PATCH v4 25/26] dt-bindings: an30259a: Add function and color properties
Date:   Wed, 17 Apr 2019 22:54:38 +0200
Message-Id: <20190417205439.17685-26-jacek.anaszewski@gmail.com>
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

