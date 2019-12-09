Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE414C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9462068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea0xRToy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfLIOCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:02:47 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38786 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfLIOCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:02:45 -0500
Received: by mail-qt1-f194.google.com with SMTP id z15so3712198qts.5;
        Mon, 09 Dec 2019 06:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ldqJ1SZTM86i1NDUWb8AoCSQlQUTKFP3Yzg0EhQCsM=;
        b=ea0xRToyTQAOSYaMQIUh7dMSvI/bYuX5NsGjwiP/tqHkEtEDAPmSkvqWOdiyAFHg6B
         vDHB3pjTFIiPw0cUfdqbfcjVyw9Uxb+xzwXYjTjFA+lTSlE9pt/S8hXz7LnJFxzgb2MD
         9Eolg70Jp3L5GJjMtq1ZRPfK4T0bkXtcC1se+gSI5YWlsfyRAxNysXN/8yBbxz5S2X3b
         H78YA8nG8WUX/3Mm6v8Ya5uUM7FlbxN/ZtGAlOIkk9y+IfWFjghDAuvTkjhyVbKk/74v
         F21z4Y0qHvu/3kZ59Lb+jY09NtMNBcjsqvRElL5AGwCjcVmGnaa7pOEGZ3+u+2AYSqzm
         KUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9ldqJ1SZTM86i1NDUWb8AoCSQlQUTKFP3Yzg0EhQCsM=;
        b=D9SSkkgYRdb2+2t3RFRfSZWd4iRP0agwWjB2B6/n7hYDbuvdB0cByARq/xiOpNQF0l
         rKPLtNXImwlDRcZ6oM+YF8/ERbJyQz0fqAFuc42TFwhJxtKKCPUmxxdXmxwhowGUXnBm
         3BinlqbfrZDN1Xv8sF1OSXT/9cSpp9Zs2dpgMUwMzSEk3hSTPNVUoGJY5HE80vBeyDYA
         s/mHbqV3GTbsmkbBYv3kYgG3xVqOrsKXWZWeIusVW2Y75PiTqvSSRoWuy+3TIBz/8EYp
         EUPcMPuPC9FsEySHlBLlvIWAYhIVnmFmSyluAdRJ+tOHc+76cT+F95qkeH/tJ5ntf0T9
         g+iA==
X-Gm-Message-State: APjAAAWNmarjo69Npfjq4tprBsTFT/OOr1/HoKx0tGLG7V6TwubMODMd
        4x+Yz4d0zTrsGkma3nz85/M=
X-Google-Smtp-Source: APXvYqztzrVLLGA7w+ahwGSQFwLTP6K8GAsDsLwxpdjc/fVJqXOcLNgNj4z6oBzvhbewNFKx0I1IGA==
X-Received: by 2002:aed:2047:: with SMTP id 65mr25382186qta.78.1575900160420;
        Mon, 09 Dec 2019 06:02:40 -0800 (PST)
Received: from localhost.localdomain ([72.53.229.209])
        by smtp.gmail.com with ESMTPSA id h28sm10128023qte.54.2019.12.09.06.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:02:39 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Pavel Machek <pavel@ucw.cz>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Grigoryev Denis <grigoryev@fastwel.ru>,
        Axel Lin <axel.lin@ingics.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [PATCH v5 2/2] dt-bindings: mfd: update TI tps6105x chip bindings
Date:   Mon,  9 Dec 2019 09:02:34 -0500
Message-Id: <20191209140234.6558-3-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209140234.6558-1-TheSven73@gmail.com>
References: <20191209140234.6558-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver has been extended to optionally get its operational
mode, regulator init data and LED naming from the devicetree.

Tree: next-20191118
Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 .../devicetree/bindings/mfd/tps6105x.txt      | 47 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/tps6105x.txt b/Documentation/devicetree/bindings/mfd/tps6105x.txt
index 93602c7a19c8..d15763740a3f 100644
--- a/Documentation/devicetree/bindings/mfd/tps6105x.txt
+++ b/Documentation/devicetree/bindings/mfd/tps6105x.txt
@@ -7,11 +7,56 @@ Required properties:
 - compatible:		"ti,tps61050" or "ti,tps61052"
 - reg:			Specifies the I2C slave address
 
-Example:
+Optional sub-node:
+
+This subnode selects the chip's operational mode.
+There can be at most one single available subnode.
+
+- regulator: presence of this sub-node puts the chip in regulator mode.
+	see Documentation/devicetree/bindings/regulator/regulator.txt
+
+- led: presence of this sub-node puts the chip in led mode.
+	Optional properties:
+	- function : see ../leds/common.txt
+	- color    : see ../leds/common.txt
+	- label    : see ../leds/common.txt
+			(deprecated)
+
+Example (GPIO operation only):
+
+i2c0 {
+	tps61052@33 {
+		compatible = "ti,tps61052";
+		reg = <0x33>;
+	};
+};
+
+Example (GPIO + regulator operation):
 
 i2c0 {
 	tps61052@33 {
 		compatible = "ti,tps61052";
 		reg = <0x33>;
+
+		regulator {
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
+	};
+};
+
+Example (GPIO + led operation):
+
+#include <dt-bindings/leds/common.h>
+
+i2c0 {
+	tps61052@33 {
+		compatible = "ti,tps61052";
+		reg = <0x33>;
+
+		led {
+			color = <LED_COLOR_ID_WHITE>;
+		};
 	};
 };
-- 
2.17.1

