Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1B4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FA920657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0CUehkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfCJSaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:30:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37291 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfCJS3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id x10so2193610wmg.2;
        Sun, 10 Mar 2019 11:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XphnFDe5ytr3tb6S4HWMrVg/VoiopBTbnsCsIvT9pDY=;
        b=n0CUehkzcorzvuGYf15Ft7aXQF5r/8pVoPy+m02WyZrow/KHp5sohlaLRegdObHcru
         jjkv0jG9yzzHK+YwsQndev6VpB3nY1wb4sXvVTCGZTazyAq5y17F9GIsjGx8Xz8J10D3
         FfumlIGY/oQk1D/3O8KHSrBpVSTAoouq+jgst0SDI8RPSgk0IjpBhOD261chsPCzxxrA
         oFE/y9W8JtglDYNgG8FgPs4vt/sZuSI7Z2At6PJn78xLzBE9/NHwGURi9dBTaAcjqa/J
         6oy3i+XtgjFUhQZyEwRT5pqHU3IphMYv2hltCcC0v2PtbhVyc+jZAsP8I7NpuwxaYJdk
         y20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XphnFDe5ytr3tb6S4HWMrVg/VoiopBTbnsCsIvT9pDY=;
        b=Qj7NECTdWKItbZgnmwyVdC+6mAz7jKW+gk7w1iWAFN3vic6eYfb0jGJNt0JPPB7bA4
         sSx2ZecurBYj+REtm3Ew7vhKB+KrULcWCGrqQiH42E8K19BUpXcHsDfPDUAPGeIIq3Wk
         aOpIlLeHVqWCKj7YNSFHZdJUr1Dkjk+WAg/jJSVfWsVwEKEIIHk2JVad5+gRHIq9eGSF
         3x8M/ZwEJtXa6cnFJvd9UXNSEZ8KEKzadxrvodiWIvIAP4hDYxcE8qh8rq1sdWabf3US
         0a0csPyA+klL1D2ABe8HAzedZ1n2oju7jF9Q+4/DUJSh7/EQRsC4QAVtf9gR99OLNwa/
         0lsw==
X-Gm-Message-State: APjAAAWpHQWQj737l3JL6jiYOwh1O8sGa8Wq1GXP4zfpqlnPfyDREtjg
        yUkjnDRRcGXRjxFNN+x/EjXnHfk2MA8=
X-Google-Smtp-Source: APXvYqyPxZaFmd6KiA19e0TBqybD9gnzcFiQr+qb8jgHFcOi43xD/UCZPWklkMMo6/gASPnf2IKyKQ==
X-Received: by 2002:a1c:1b4e:: with SMTP id b75mr15713747wmb.88.1552242560635;
        Sun, 10 Mar 2019 11:29:20 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:20 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com
Subject: [PATCH 18/25] dt-bindings: aat1290: Add function and color properties
Date:   Sun, 10 Mar 2019 19:28:29 +0100
Message-Id: <20190310182836.20841-19-jacek.anaszewski@gmail.com>
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
---
 Documentation/devicetree/bindings/leds/leds-aat1290.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-aat1290.txt b/Documentation/devicetree/bindings/leds/leds-aat1290.txt
index 85c0c58617f6..9192ff42c886 100644
--- a/Documentation/devicetree/bindings/leds/leds-aat1290.txt
+++ b/Documentation/devicetree/bindings/leds/leds-aat1290.txt
@@ -32,15 +32,18 @@ Required properties of the LED child node:
                          formula: T = 8.82 * 10^9 * Ct.
 
 Optional properties of the LED child node:
-- label : see Documentation/devicetree/bindings/leds/common.txt
+- function : see Documentation/devicetree/bindings/leds/common.txt
+- color : see Documentation/devicetree/bindings/leds/common.txt
+- label : see Documentation/devicetree/bindings/leds/common.txt (deprecated)
 
 Example (by Ct = 220nF, Rset = 160kohm and exynos4412-trats2 board with
 a switch that allows for routing strobe signal either from the host or from
 the camera sensor):
 
 #include "exynos4412.dtsi"
+#include <dt-bindings/leds/common.h>
 
-aat1290 {
+led-controller {
 	compatible = "skyworks,aat1290";
 	flen-gpios = <&gpj1 1 GPIO_ACTIVE_HIGH>;
 	enset-gpios = <&gpj1 2 GPIO_ACTIVE_HIGH>;
@@ -50,8 +53,9 @@ aat1290 {
 	pinctrl-1 = <&camera_flash_host>;
 	pinctrl-2 = <&camera_flash_isp>;
 
-	camera_flash: flash-led {
-		label = "aat1290-flash";
+	camera_flash: led {
+		function = LED_FUNCTION_FLASH;
+		color = LED_COLOR_NAME_WHITE;
 		led-max-microamp = <520833>;
 		flash-max-microamp = <1012500>;
 		flash-max-timeout-us = <1940000>;
-- 
2.11.0

