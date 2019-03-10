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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BAEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36C120657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdJtGDIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfCJSaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:30:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34090 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfCJS3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id f14so2682629wrg.1;
        Sun, 10 Mar 2019 11:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yuBb3NfQYhODXKKaYg/6vTGzYilmvoaMj8YJO6znSoQ=;
        b=kdJtGDIsU8HWR/HxcCZE8uuszKMwlTPj9acqE2YX35Cu8EMcrSy1iZshuBmFJVa09P
         jCQTqMmhDkg/tO4TG5SYJNZkLmTYBtKHdE5DJ4vJCiRCuCrYnqcPuZH06iCCYjTWHTPv
         YHpaAQljsEDJZNohmFGdr2MoNrfB48iTu/e/c3nb5QEGlggpQtgNH+NX1RtssFDDUVfP
         o2HICxbnbyAGj3N1MvVJcDRqcpThxFOuzM16FV9Dhy6OpZwTGqnRN0XyKaU9zT8b9skr
         8+VDDk16c59QQKcJDwQ1E+lmpOylc3yNXrgIvxFlBRp598uR79q/RE8m9fsm0DItwzn+
         XCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yuBb3NfQYhODXKKaYg/6vTGzYilmvoaMj8YJO6znSoQ=;
        b=J5nb7BKzo940fYbg2EFouYc0XDKWmofYDH8zB3PYtKWuwye/0p+WKdRKW2HtNcenu/
         H+r18RkqLPuVWa3eS5aPTMtx7Yjyk+yujAcoyXlY/gAz3Iqk/Ucm6SnwpRjYAh1J4CVs
         ppfmjvmgiBj+zQ7JtzqWjrKjSx/Zi7LiE5u3TacvsQw8hU07bieitSW26i2kBgEghtCn
         LhxiMz75dnb3H0n6M0hzMi3+Ub0fYOLuRpOI5yiJFHd9vEsUFSA4hgPOoPRptVfSeRzi
         1G5V3jwjUqMWH8/ONCBO40it5+mPVP86uO6IOkbZLWpaeJ0Ud/xK0YHA0udeIhQ7vKi8
         S8pw==
X-Gm-Message-State: APjAAAXAwrsMRev+bOtbSfzYJ7ys5i/ZFtD/CwoVnHp1qsoVAZPFEjl6
        0QE6rleBIWWo6TuSKJayUQlYlsDU/kM=
X-Google-Smtp-Source: APXvYqwIhXaBJYEwJnMmV9+CEzr0VduFCSv5gwDzUEnjTL3ufFYPlTyWHSj+teTMDCyyWO3h5+KQBw==
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr5115763wro.133.1552242563285;
        Sun, 10 Mar 2019 11:29:23 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:22 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 20/25] dt-bindings: as3645a: Add function and color properties
Date:   Sun, 10 Mar 2019 19:28:31 +0100
Message-Id: <20190310182836.20841-21-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
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

