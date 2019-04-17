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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC35C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B4E20872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOVS+zut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbfDQU4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:56:17 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44307 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfDQUzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:35 -0400
Received: by mail-lf1-f68.google.com with SMTP id h18so19893039lfj.11;
        Wed, 17 Apr 2019 13:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yuBb3NfQYhODXKKaYg/6vTGzYilmvoaMj8YJO6znSoQ=;
        b=WOVS+zut5BeSh/LdYy4w15+lAeizbKIjnWeLju5YFdZHEGkYd6upfMsJQdsMvZkGvL
         TvE211+bJf9m/ai4lHbhOayKQyNj8qGGXsfLvRmHpyQv2Z/7U0p96D50PqeLrCN12I4V
         D3a8AooNOanSOyiCZ6k1Y52wZQc5+nAd8tu4bFPDOqB4XYs4kQLqDsiJku3QR41o3p0W
         IepokBlPDKDTEGRp7ojYFOl+KmCfyiL0O25Q01TVitvW8fY2KH1PC2ZpNqUCjCw1dSYH
         CP0ZQYyl2t1iFdStgOY1fsERw+7Wxc3kxErXqRe5e60YoML849ru1JRxbuIPk7BB2FPU
         MqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yuBb3NfQYhODXKKaYg/6vTGzYilmvoaMj8YJO6znSoQ=;
        b=WAJYCLvL/SN4vZT5452GRbq/Nr+CYYSzca4CTtBQNrLpfZwEcp1CE3l2bQltSMpODw
         /RX29IzmOgRpQ9IUf47v9S3DBJqml4AsXFG5tGqwPVHFP7mV4dSPsA5dqbMFeQ7LUsQV
         Gn+TZqPd6FBObHoljehJpxObwCAEC0TGHxshOhegEzcaNKcxuTdmtb3NdPvGoPXMvDIW
         Hu/YCJUuCwg/M3j54M+3PipBTOIRbI8CLUptRJMJCghUjS7MLZtzs/mibN2K6/bwlUVF
         8wzlzMPOvAi9m5RzY60cnXxLBzxhCVUPS0NV4PKGqZdoJJNxPE0J0suWAIws6HUR36zt
         iWWw==
X-Gm-Message-State: APjAAAXHRw9F0Ifwm3Jd3BOtHqF4U8NhGMjdOt0EM418+1b0eDnCjnW5
        9jmi4cFUCk9mD2yW/K9Yxg0t/5EMyBA=
X-Google-Smtp-Source: APXvYqwUkV9Z4Vj5nXhwW83j8iI4IIdrHh16Kbezg863EeT81Bdar+POnCRnVB10rDJb6bUmYQazEw==
X-Received: by 2002:a05:6512:c8:: with SMTP id c8mr30981925lfp.138.1555534532754;
        Wed, 17 Apr 2019 13:55:32 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:32 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v4 21/26] dt-bindings: as3645a: Add function and color properties
Date:   Wed, 17 Apr 2019 22:54:34 +0200
Message-Id: <20190417205439.17685-22-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to new "function" and "color" properties and mark "label"
as deprecated.

Also, fix malformed syntax of address-cells and size-cells
in the example.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 .../devicetree/bindings/leds/ams,as3645a.txt       | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/ams,as3645a.txt b/Documentation/devicetree/bindings/leds/ams,as3645a.txt
index fdc40e354a64..4af2987b25e9 100644
--- a/Documentation/devicetree/bindings/leds/ams,as3645a.txt
+++ b/Documentation/devicetree/bindings/leds/ams,as3645a.txt
@@ -39,7 +39,9 @@ ams,input-max-microamp: Maximum flash controller input current. The
 Optional properties of the flash child node
 ===========================================
 
-label		: The label of the flash LED.
+function	:  See Documentation/devicetree/bindings/leds/common.txt.
+color		:  See Documentation/devicetree/bindings/leds/common.txt.
+label		:  See Documentation/devicetree/bindings/leds/common.txt (deprecated).
 
 
 Required properties of the indicator child node (1)
@@ -52,28 +54,32 @@ led-max-microamp: Maximum indicator current. The allowed values are
 Optional properties of the indicator child node
 ===============================================
 
-label		: The label of the indicator LED.
+function	:  See Documentation/devicetree/bindings/leds/common.txt.
+color		:  See Documentation/devicetree/bindings/leds/common.txt.
+label		:  See Documentation/devicetree/bindings/leds/common.txt (deprecated).
 
 
 Example
 =======
 
+#include <dt-bindings/leds/common.h>
+
 	as3645a@30 {
-		#address-cells: 1
-		#size-cells: 0
+		#address-cells = <1>;
+		#size-cells = <0>;
 		reg = <0x30>;
 		compatible = "ams,as3645a";
-		flash@0 {
+		led@0 {
 			reg = <0x0>;
 			flash-timeout-us = <150000>;
 			flash-max-microamp = <320000>;
 			led-max-microamp = <60000>;
 			ams,input-max-microamp = <1750000>;
-			label = "as3645a:flash";
+			function = LED_FUNCTION_FLASH;
 		};
-		indicator@1 {
+		led@1 {
 			reg = <0x1>;
 			led-max-microamp = <10000>;
-			label = "as3645a:indicator";
+			function = LED_FUNCTION_INDICATOR;
 		};
 	};
-- 
2.11.0

