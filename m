Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FFAC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10988217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="j23QN8Gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfDKMni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:43:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37398 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfDKMmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:42:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so7166294wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 05:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aeN889BbLX2VoZH82bVkpm7x6WciirBMN3MYn1uX0yI=;
        b=j23QN8GxdGViL+EdSxspl2Gtwq6MO6vIwcV7YvdMTfEtiFCdZA48G5et2IvWOAcffX
         540jqvsccX+xawXbDlHhVDw5raS45q82yAPVifNcFRTgjOMFJMpAc8mrKpyK0RZz1G5B
         dV3JnCKDOccprMS0x/VxPP2AS1kpzKbDSKC1QwjqpGHZAp0hSJqn2BvNUnHfgSjlmZfz
         oQE7H+TJEncF/VhcI0jGW5VKwl8msE6CulZ1BO87OoEqzZZSU9nbMGs42p5I5GgMWwft
         ONwJntbgBOGoKKkzVAJ5WkxzGW3f6DFVqTLYF6Oom1SYVVNZzyjHpTFuhZbGRT27U0Lz
         oJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aeN889BbLX2VoZH82bVkpm7x6WciirBMN3MYn1uX0yI=;
        b=oTbIWF7JemFHKmTd/y5eG21qY5Rbb0o/pTz6uVTH6oYS56hBk1z4vEinX54PWckJQX
         LwRKVeZ+bz0e0jgf7pA8+l0FH/KsHRhGZkDjKGTIr9m3tJPghlEQcGFg/k70BsExC55+
         JETvjX/c8EB0Wkr7KuuFtdpwn7ZXRutNckNsCmXmtd+ThkMpI6ViaQrncKboENLxCROq
         IqdUISmWdJSPleHnUND3KN5RG2OqbcUeMU9hnSxQOH1lwVxXuR2EsS+Emm+7TpNzFZAJ
         XkUm0sd2s+cXW5zxk9mzsZBhIJqOWOKLnntQXdV4smCZ4xW0Of1CeKtK1RqL+2OMUZbh
         1Hxg==
X-Gm-Message-State: APjAAAVkocIKFPPNp+Q6a8C4nf+9/Wi6YZaWdR/PxtDe1+Iol41hZm28
        9z3IgDZRG56kTAkxLOe9Fz6ExQ6BpYg=
X-Google-Smtp-Source: APXvYqzwNazKQgQJMU4Cy3eAoMvHsVUKejLXwm1jDx2nNUWtmQo0k600i/dINyYKoInPpuEmGsWXwQ==
X-Received: by 2002:adf:d848:: with SMTP id k8mr31959662wrl.185.1554986540943;
        Thu, 11 Apr 2019 05:42:20 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id d4sm32894510wrv.42.2019.04.11.05.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 05:42:20 -0700 (PDT)
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
Subject: [PATCH v9 01/11] dt-bindings: mfd: add DT bindings for max77650
Date:   Thu, 11 Apr 2019 14:42:02 +0200
Message-Id: <20190411124212.7612-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411124212.7612-1-brgl@bgdev.pl>
References: <20190411124212.7612-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a DT binding document for max77650 ultra-low power PMIC. This
describes the core mfd device and the GPIO module.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/mfd/max77650.txt      | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt

diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b/Documentation/devicetree/bindings/mfd/max77650.txt
new file mode 100644
index 000000000000..b529d8d19335
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max77650.txt
@@ -0,0 +1,46 @@
+MAX77650 ultra low-power PMIC from Maxim Integrated.
+
+Required properties:
+-------------------
+- compatible:		Must be "maxim,max77650"
+- reg:			I2C device address.
+- interrupts:		The interrupt on the parent the controller is
+			connected to.
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells:	Must be <2>.
+
+- gpio-controller:	Marks the device node as a gpio controller.
+- #gpio-cells:		Must be <2>. The first cell is the pin number and
+			the second cell is used to specify the gpio active
+			state.
+
+Optional properties:
+--------------------
+gpio-line-names:	Single string containing the name of the GPIO line.
+
+The GPIO-controller module is represented as part of the top-level PMIC
+node. The device exposes a single GPIO line.
+
+For device-tree bindings of other sub-modules (regulator, power supply,
+LEDs and onkey) refer to the binding documents under the respective
+sub-system directories.
+
+For more details on GPIO bindings, please refer to the generic GPIO DT
+binding document <devicetree/bindings/gpio/gpio.txt>.
+
+Example:
+--------
+
+	pmic@48 {
+		compatible = "maxim,max77650";
+		reg = <0x48>;
+
+		interrupt-controller;
+		interrupt-parent = <&gpio2>;
+		#interrupt-cells = <2>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "max77650-charger";
+	};
-- 
2.21.0

