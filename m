Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C668C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED38620674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="2FBghxgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfDWJFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:05:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45069 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfDWJFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:05:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so19106163wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5g4/Swk4uHJKHMZmRZrqdiq0P5Jmw7elqSkjk3sVLtc=;
        b=2FBghxgKJ9e2gFedgDh3FwTHSyxIoAUou+9liQqL5Z6myq83FZws3K6BjcpUvAXKtH
         9T33N3Grgac2H/KJEDrgJ077Us9RUZWWgq6Eh6JEOT4jTzUYHUhbP5BY8XWREQE60LI/
         pfFZINifthxeNQGcOyyiVFN8uyUyQ124xGn6Ox9K38e9v/jb61/xvNnEKb3Mg5u23rAA
         g2lHntrMdYg55zQVsNZfp57agGwAQMBuwljHn3YtheKA4JXYPxCEaWW0M0prWeUc4iui
         j7OkHD0gc/Elhn1DIPfAJsUDqkXKReYF7TIUi1JqXYxeOfJJfuqB662/7poIfmCryess
         D9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5g4/Swk4uHJKHMZmRZrqdiq0P5Jmw7elqSkjk3sVLtc=;
        b=J7hKt3LMToDpatWmuhMTbsrxXKL8XFH0FZgkzKIoeeuDwhzy4ptTyTbBMIjuEw6zMI
         LIjfzDisAcdgWiQO3gMMh5icVPA2RQdrhbLGqOWbfeZMBbeLz0h75XBUlShw+SQne0XU
         3zKfFPqx1dGufQxwNpLFXpct8/vGyvPuL1uvAN4K3AozD2c5vSNT+gzMapg87Y7szisr
         WukcY3Xx3sdPhQBRFHjrRVL7kr0Nr/+dPaGc5mcPDmYpNiO030BqIUK7wHT3Bn+i+bde
         aygM+4MNOlhOzG1vctZST2F4f1T9ErXJgM0V0UAE1OFps3pr0WGufde2Y+P/WR//yLR3
         2Vdw==
X-Gm-Message-State: APjAAAV6Qa2TamLkeUXnVRBYV76C5I29v0XvXWnTx1SfQGq5r0xI4bOb
        hebW0LzYnNKSxhq++r/Ue5RpPA==
X-Google-Smtp-Source: APXvYqxVfLzB+jJW1IoDVeHx8AyYnOPA7F5TVwvhN1ru9SAwA+E3zve6RNsRKus/f5ZtT7USwFPSiQ==
X-Received: by 2002:a5d:5346:: with SMTP id t6mr17440716wrv.59.1556010303199;
        Tue, 23 Apr 2019 02:05:03 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-25-101.w90-86.abo.wanadoo.fr. [90.86.250.101])
        by smtp.gmail.com with ESMTPSA id v190sm15360434wme.18.2019.04.23.02.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 02:05:02 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v10 03/11] dt-bindings: leds: add DT bindings for max77650
Date:   Tue, 23 Apr 2019 11:04:43 +0200
Message-Id: <20190423090451.23711-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423090451.23711-1-brgl@bgdev.pl>
References: <20190423090451.23711-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the DT binding document for the LEDs module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 .../bindings/leds/leds-max77650.txt           | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-max77650.txt b/Documentation/devicetree/bindings/leds/leds-max77650.txt
new file mode 100644
index 000000000000..3a67115cc1da
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-max77650.txt
@@ -0,0 +1,57 @@
+LED driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The LED controller is represented as a sub-node of the PMIC node on
+the device tree.
+
+This device has three current sinks.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-led"
+- #address-cells:	Must be <1>.
+- #size-cells:		Must be <0>.
+
+Each LED is represented as a sub-node of the LED-controller node. Up to
+three sub-nodes can be defined.
+
+Required properties of the sub-node:
+------------------------------------
+
+- reg:			Must be <0>, <1> or <2>.
+
+Optional properties of the sub-node:
+------------------------------------
+
+- label:		See Documentation/devicetree/bindings/leds/common.txt
+- linux,default-trigger: See Documentation/devicetree/bindings/leds/common.txt
+
+For more details, please refer to the generic GPIO DT binding document
+<devicetree/bindings/gpio/gpio.txt>.
+
+Example:
+--------
+
+	leds {
+		compatible = "maxim,max77650-led";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			label = "blue:usr0";
+		};
+
+		led@1 {
+			reg = <1>;
+			label = "red:usr1";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led@2 {
+			reg = <2>;
+			label = "green:usr2";
+		};
+	};
-- 
2.21.0

