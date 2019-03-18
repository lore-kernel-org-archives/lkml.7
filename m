Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87DEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DFD2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="i4uHt6Ct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfCRRlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:41:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37321 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfCRRk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:40:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so5231977wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKNCVQXWN6oEf8giX8idUUq1TytMK5c/qkMs8Fw701U=;
        b=i4uHt6CtexflJwvEVHlktzw5ym29/cAovC6xWOaqOZNG5kkaX/d1oKDNP77R/k1K38
         KO39o93U3Gk8/lNlYvZSzewvK26FtloXqwgDbIxvi+28QlW5D56rFm8OrzFAz6iqV9Gu
         iN1hQHpS6v2weivc0upGEgMCt6wc+/VmGiB1v9D7xyjkg1vK5lki3SToMGk1lzY4cfT0
         dw0hj8NBuNYRjz3KYFqxYbsbXeD4BiV9APIWmF+nZaWP08wImXz0vYquG+Bn02Ro67mq
         wo7gLLMIfcc825W7y46kqzgFrQWSOBAVUofgiGiuMmCFRPNL8IAEPOzaHKtko5+2dWl3
         0ndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKNCVQXWN6oEf8giX8idUUq1TytMK5c/qkMs8Fw701U=;
        b=WeWZpzyoP6XghBUd0AijAKh06uBkp7weEfd55TrKZNxW60g4W65+hot0v/48jqoZud
         r6uOuIz2ycpBVu6viRtFmtpm/VsgpJ9S5MyGwLkC87L14dmRBLv3AhILPvKTtYE6Wd2k
         zJQ576YO1TNn7DJAes+98hXyeg2/ON6vROp9+Hy+xlqDC38IxcDPCBGrxa3pMZ0qyX8i
         bFwF9SoJXnnpU+pACLpD4IPxcWDmEa5wshD5CDG4jr5t/riOR6JgRdY1W2vh2KvAeiXa
         lnGRRNaBU5Lz0JQqMyFOTnOMlT2tl2MV8hhAA4AA/vZvoB+0+8M8FpbLNUtuPMHIiGDd
         EcPg==
X-Gm-Message-State: APjAAAV8LdsXClzR4TPwBzNItpOEZ9ax8wGL+C+ADRWG5y8peFPuip3D
        j+TAgB8osReaqaDoN4qzSeKijw==
X-Google-Smtp-Source: APXvYqwi4r2wD+0c/hTXbA9dq9pW8ZSDE1+b/L8TVbVaD6iVFv7WK1lI9Rhgqh6fMbwWejfD7BijCA==
X-Received: by 2002:a1c:9684:: with SMTP id y126mr41571wmd.124.1552930854549;
        Mon, 18 Mar 2019 10:40:54 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y140sm41436988wmd.18.2019.03.18.10.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 10:40:53 -0700 (PDT)
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
Subject: [RESEND PATCH v6 03/11] dt-bindings: leds: add DT bindings for max77650
Date:   Mon, 18 Mar 2019 18:40:32 +0100
Message-Id: <20190318174040.17899-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318174040.17899-1-brgl@bgdev.pl>
References: <20190318174040.17899-1-brgl@bgdev.pl>
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
2.20.1

