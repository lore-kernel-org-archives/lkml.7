Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27228C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5EF20989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="I3J/bBM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfCRRoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:44:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34993 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfCRRmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:42:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so12121449wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKNCVQXWN6oEf8giX8idUUq1TytMK5c/qkMs8Fw701U=;
        b=I3J/bBM4FuDwKixkWau6qcQ7BFVgwIKx8NX6hXoZjgHPBV3G4LHOhbNtYuquWm6bZV
         3pSHO+RJmZlB2bVfjOziAZb5MHhOvkPCVRNxKpXIzp68aapu7ty/2XYoaY6iHwLdH9Lu
         +MqVqAzQqdEgdLTT/x5ip1V2D93YenxVuem7uEinvz0E4DK4uSPAZPRz7k9DDw2g+DOW
         W/TcwknJewwSFK4k/tmB8SBFX8hYtIiw4ju+nnMUv5E7t+20R8CZALUDF713oZ9VQzK1
         xa8ReXr2yCpeUGrpeKYzIaR5MT79K71MpBWsofjBIoOCNRJpD7eosZmZyh+J1dsHxLr5
         9vDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKNCVQXWN6oEf8giX8idUUq1TytMK5c/qkMs8Fw701U=;
        b=q+08WsmeIgi9LGe4br8JFfdQo7jAJNRIcNOdJ2XfpXdNmNwsu9qqRvmypJT7cErBkD
         1tCTKuzMPl8pxLN9TDfknTcaOiFEv3c1E27/n6TUGLgVP9br5FBYC1xXbSl8kgVBFKa3
         d5fywLoQzI6H6d3342GJeyYXUTFz6ozpe3Pe2wwEPp1cnLeTY1hl85+HM1ArRjCcb7fS
         vZtfvsL/f/73J2kUO36xDyZyGRO48sEfrHCd2R6CQt9oCfgjidwfx556xRaOvz3lDmcf
         FDngNOLseKNC3qI9ObV5k/8dXvfg2rsJWJ9GQDo/TZf7cn/h7l+i0LbpWhbA/RPYczq9
         8/zw==
X-Gm-Message-State: APjAAAX3/PiLJmRWhFd46Yo6hHPII+eh6NOo7PP01TIhOhIwWQO2XzdF
        Rq7Nboxf6B711OHJKDSdtxXo8Q==
X-Google-Smtp-Source: APXvYqw1rbFycuGlhGIxk6qAn+u6PgoMLDZ8Mk2T86tuLP7HbHVuqLSnCitUj2+RbX4G16r5Rym0Kw==
X-Received: by 2002:adf:d081:: with SMTP id y1mr13111050wrh.283.1552930956788;
        Mon, 18 Mar 2019 10:42:36 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id g24sm14873909wmh.45.2019.03.18.10.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 10:42:36 -0700 (PDT)
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
Date:   Mon, 18 Mar 2019 18:42:20 +0100
Message-Id: <20190318174228.18194-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318174228.18194-1-brgl@bgdev.pl>
References: <20190318174228.18194-1-brgl@bgdev.pl>
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

