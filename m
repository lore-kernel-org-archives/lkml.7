Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A90C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9389206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="W6EpkC4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbfCZRdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:33:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42498 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732034AbfCZRc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:32:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so11883572wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKNCVQXWN6oEf8giX8idUUq1TytMK5c/qkMs8Fw701U=;
        b=W6EpkC4YFr9SFFojs2AUYtmVFt/uujyibwlOBPnNx0XcNaKRyNlrsqi+T7Qs67hr/o
         zzI4NT+LWa4xhA13jzAskfNtzOmRnX26zK5/8ryzUegSBqFsYjoJs50eAqyIvqczehs2
         u4eLkx1pForftbyDG7WKmXpzCYLDmkGKu+12MfsOnoSJDoVpuOWUwGRsXxeIdBk/raPU
         awGbvgH6oXuGn03qHPd1IfcfPBl9iMQHolzulZ+DQTuIdPQa5iPKm8lI/x31KI3SOG4o
         M9X5Xsn3MwCDWpNSmK6Kq9YHZZ5cDTsBP4s/tzfjeOAFAr89sI05grAG67oKLjDnINN7
         UiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKNCVQXWN6oEf8giX8idUUq1TytMK5c/qkMs8Fw701U=;
        b=HOlOAx5YHD8g8fP82Ev0s6CJ8QDvZwlF4k3NolhIHg9NXjr+154/zgvXreyipvhGjH
         FVcLDXBlx77OPryovVf93986MaAKvgEBw1WS0WKWmlNbofHl3g+jOe+r1/PF8wjr2Wky
         jTphklj7DIp75ZeMOS+rm2WY8EQYK1h1ReEyxK9+adEWNkXl4T7wLrpJpsMaEVgHIFbd
         0GwEt/lfmQqjSep1RoYak+PViKtXSINp3uNbvQARQlOOv7A7cKfZwpfGRPJb/fIT5k4b
         e6LRt3BLtJMq5ya1EQeQZp8JlpB0xT8nT1IunWWOTrniEsopVf87bytq48PxryYOxftL
         s77g==
X-Gm-Message-State: APjAAAVUFAS9hZ9t9bYstfU5vzsTG6DY9/iplDKZh59MBbRV9VBBde2k
        Nq5jHjQWEYbvEs5iXTAoCO6rxQ==
X-Google-Smtp-Source: APXvYqxQBCpEM7DnHKEWXgBblNh0JQfx1rRBj369z+9hcNxQOm4PvIXkx7FX3es5jmatLPTHewIYEQ==
X-Received: by 2002:a5d:63c5:: with SMTP id c5mr19336534wrw.82.1553621545172;
        Tue, 26 Mar 2019 10:32:25 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 4sm2534541wmg.12.2019.03.26.10.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:32:24 -0700 (PDT)
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
Subject: [PATCH v7 03/11] dt-bindings: leds: add DT bindings for max77650
Date:   Tue, 26 Mar 2019 18:32:00 +0100
Message-Id: <20190326173208.30614-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190326173208.30614-1-brgl@bgdev.pl>
References: <20190326173208.30614-1-brgl@bgdev.pl>
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

