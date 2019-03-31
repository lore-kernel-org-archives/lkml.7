Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6142CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3694920870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm276C0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbfCaRzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:55:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36761 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731524AbfCaRzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so8656580wml.1;
        Sun, 31 Mar 2019 10:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/1d5STtYeSfvYq/JvOmhvEZUVTsQSGLaSpbZY+1iQas=;
        b=Mm276C0TzW4bMdQZkdopzZI5p3lut6pPbrLlEhmxGtrPmDLGQUUGzkziXNUWYmnpai
         PHdwxPoSppeTJmkxssCnCx1UhX7Bqn1DqHUqrC6KNttTRLoFbDIpXTUrlXXN7qyAzYu6
         uOaJbsgrhclxBYgVLYG0JcC8qBqmGGdLnncb0nqy0gwX8m52eFCpgEYjTgh7opBS/Sb1
         bAlI8fYCfllqGsrEoH7jlfIoX5vLLdNeB9WRNOnnweU1ismlg7YSOmuaV9ZQWduWvGNS
         tZ0UfBew2D3758tgVE/pCyRBK9mlybl1mI3soD7Wbgsey0T+QSiy9N+HjpQZl27n1ERk
         twag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/1d5STtYeSfvYq/JvOmhvEZUVTsQSGLaSpbZY+1iQas=;
        b=kcANxN/6srpzlIq9YO07MGCv6ud1/uxi0o7/cC03wibR/6JknkwJBCyEU47VWF9ZDO
         4hKNo/cCUyHXJTtAZ3SUn6dryQcVxsWvSwQd1Z4wRLZFm3++L3Ja+/9GOmz2I1Bfj+ME
         3wosxA908/MFdxVYf3OX0/+dJuvHlwD2c1TDvXin/ZCMrQ+J1dEdckuUPM8WOEPt9gaN
         MyFALB6rue4Ou80UZDMpg58OhDSSFDD3qwD7/Z8sH50V/tIPUX12MP7gY8ZPm81HLoKr
         BfW9HIDngE2kh0fI6bpYqwF9tzTMQ/DyQ5RqxvMv2HYW9OcOWyq3ojFm3Rm+J068jo8m
         mWMw==
X-Gm-Message-State: APjAAAWucSFavxyV4FkExqIv89DGIOhqs/G7EuO9VhonYFp9EdAzmLtf
        ATmzPzxxJ5EifuWqEHgVmxV5vudcnqY=
X-Google-Smtp-Source: APXvYqyzflXu2jSQq4HM7kgUidgOMUHHhmT//cqYs2YClnL/QeAfzzuEFNHo+lTeMAPoLCjuevtqhQ==
X-Received: by 2002:a7b:c94c:: with SMTP id i12mr10198707wml.115.1554054932912;
        Sun, 31 Mar 2019 10:55:32 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:32 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 12/25] dt-bindings: lm3692x: Add function and color properties
Date:   Sun, 31 Mar 2019 19:54:48 +0200
Message-Id: <20190331175501.23471-13-jacek.anaszewski@gmail.com>
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
Cc: Dan Murphy <dmurphy@ti.com>
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

