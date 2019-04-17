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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE5AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19B121852
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9FMKPNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387542AbfDQUzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33673 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387506AbfDQUzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id j11so19949368lfm.0;
        Wed, 17 Apr 2019 13:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/1d5STtYeSfvYq/JvOmhvEZUVTsQSGLaSpbZY+1iQas=;
        b=V9FMKPNA4LVURReEmOZW3YFC5gXHXhcV2KKwqaqqDvv+LxcfCI6XSaVeNuLnjEKptq
         NiCLeA4LdRWq239GfPafdTjViPbfbuJbtHL589L9MCF+++tNFazulYSuTdAcfOTVY9Ym
         WK/2e9Mst3anKhBiLB9iYLyLtiriQgBNhf1REyM5HnpjTNIe8aUk/idghE2LoqS6gzMp
         bNN7gYdFqOsYBIiaV8FGFMOq5O+sFy6f9yxE2AQgHkK6ra5qF7XVEEj0PgHoqWaOg97x
         C+AZmY3Lnap2gC319+Lg0R2iQ/auVQFekuQ3CZTx8OmBkCTYnwaB33v77X8+ncD12XCH
         0UBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/1d5STtYeSfvYq/JvOmhvEZUVTsQSGLaSpbZY+1iQas=;
        b=ik2qH3rlRGFVE3YzpZ8VZW4AiaDOf95wcmq78m3rF+gttZUykK8rYckxWLl04ErY42
         1SaKDaiJPWs6oDiB8NhRDV4K7AKV4ImuCMXaMH8zt/GpDyYFzOOFmJyQ3vXkJQo6lTpV
         c5i+AuiSJhJMEhjjyDQVbCpZdo3zXcVYXbhsS/wbpWttgQm6uBoHKCjXIocOMD/RNCN8
         ZF80EIJ0fCTq/AV3HK0ZpUxcu+oBDVc5iLW3aFAbIUHjBjsurmV2H+OwW98gb14gnC4S
         xAC/YpBY+k2Th4nXfuq9lJD9oQC/8VqbMMGz0Ooi3YzvXthom9DC3/h56Nc0GVDZCGPh
         yNIw==
X-Gm-Message-State: APjAAAXi/WwU/CSO492/ya7RHx9S+hXHW7KIReXlumYfiJ9R/AwXbQDq
        OZM7kNHGk7Pgl9+dcYeLLeLl1XzX0jA=
X-Google-Smtp-Source: APXvYqyAKdyAhYN9ySmZxAHk00h3EMi9+Tw/4slJl4LgMWv8iayGLomPgoxZj9R0ODXB2J22sMeSpg==
X-Received: by 2002:a19:f705:: with SMTP id z5mr31868092lfe.93.1555534518199;
        Wed, 17 Apr 2019 13:55:18 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:17 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v4 13/26] dt-bindings: lm3692x: Add function and color properties
Date:   Wed, 17 Apr 2019 22:54:26 +0200
Message-Id: <20190417205439.17685-14-jacek.anaszewski@gmail.com>
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

