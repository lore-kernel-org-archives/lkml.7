Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A124AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7584020870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWFC31uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbfCaR4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:56:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42660 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731557AbfCaRzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so8888852wrx.9;
        Sun, 31 Mar 2019 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZIq6j+6IS1KOZkUIM5hYoUOu/DqX2iyXvykiBiDhRTM=;
        b=JWFC31ukqhaAlmd9SwC5iwI+Vp7HpX/tFoKi0Y/n9tVTKIcOU2CEDv6+eZUfL5YMSA
         iMwfdpd6S7T6YfSgZ9OKei4GSRzFP/ka34Lffi7/gY2IwETW9No303DM+NzsbaRqZLe3
         z6lVQie9sJ23RqlV8xSeXw3VL0c9bTIY1lWhivOsXuBZEhm+jWCLF8/sB2IsJa/K8coe
         8C8/uCRR4zOsMdb/kEePnBGjhUbPvD5XEIFDRz31k2Yr/MIcazRnAF178XvPLEl17OZ3
         6Cjnck/tNP2OgTugCYkvBflRGLK1i0r8wJu/hbfKQqJRKYGbinfgN6yzy1zennj9Q+08
         shbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZIq6j+6IS1KOZkUIM5hYoUOu/DqX2iyXvykiBiDhRTM=;
        b=bPMNkUdF+idyJHQzohRWwAxL8bA++GBSlUl51oxmdbS7eNHfveW5ZZNwofeNWj4G2y
         gfqw4h+NBI2PR614kujIXWS4NajStPQ+Kj4IE/snnOhnHoewYdEWqz26CEDGHeH9SXNG
         BHz6Prl1wy1oaJ1dD7u3HZOSq4WASGrDrdRmXmZ73OamlzLyuPUGb7O7OyFBa+z/iv3Y
         /8lWYYS4V75BYzE2UXXpQtPRrOUV5E01r105A0oclptFMJ+W0lGVw2eaa6M9bwr4y9zj
         FlWyuQtEiGKemJhr92pNCjNKL867Uk2XuMqUHl5UtPBNLsN4uq7en6fCcdsKHE1eGiwG
         XzRw==
X-Gm-Message-State: APjAAAVLTPkYVHB14q9HEEIbJp1sThd+FaS3Aclc1G03s84S9q/ffCe9
        jWrlwKKQYmyvnUJbFAOJtexJtVVWmOE=
X-Google-Smtp-Source: APXvYqyC88M3qV+zfIvjjp4QeFxdv046c6f0akm4+rPFVq1IOjZPHuIFIu2LEVVZDIOtgz4VOEBd6w==
X-Received: by 2002:adf:f70e:: with SMTP id r14mr36575354wrp.37.1554054936268;
        Sun, 31 Mar 2019 10:55:36 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:35 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 14/25] dt-bindings: lm36010: Add function and color properties
Date:   Sun, 31 Mar 2019 19:54:50 +0200
Message-Id: <20190331175501.23471-15-jacek.anaszewski@gmail.com>
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
 Documentation/devicetree/bindings/leds/leds-lm3601x.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
index a88b2c41e75b..095dafb6ec7f 100644
--- a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
@@ -22,9 +22,14 @@ Required properties for flash LED child nodes:
 	- led-max-microamp : Range from 2.4mA - 376mA
 
 Optional child properties:
-	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- function : see Documentation/devicetree/bindings/leds/common.txt
+	- color : see Documentation/devicetree/bindings/leds/common.txt
+	- label : see Documentation/devicetree/bindings/leds/common.txt (deprecated)
 
 Example:
+
+#include <dt-bindings/leds/common.h>
+
 led-controller@64 {
 	compatible = "ti,lm36010";
 	#address-cells = <1>;
@@ -33,7 +38,8 @@ led-controller@64 {
 
 	led@0 {
 		reg = <1>;
-		label = "white:torch";
+		function = LED_FUNCTION_TORCH;
+		color = <LED_COLOR_ID_WHITE>;
 		led-max-microamp = <376000>;
 		flash-max-microamp = <1500000>;
 		flash-max-timeout-us = <1600000>;
-- 
2.11.0

