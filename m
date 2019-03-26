Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D17AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCBD20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AZtQt7UG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbfCZRc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:32:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45513 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731987AbfCZRcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:32:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so15353298wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=845yew9YCqJr9EBUhWoMlXsRsK/rS13QIA65vNiDan8=;
        b=AZtQt7UGjE6+5ar4HOdqgG1AzbNT8XCFUOMyw+LRDWvt2JawpoF3fq82t5hFozT5uU
         /JWm2ddsygTHlDX53Ne5JFeBTQ3J/dwjbt9leOTCxvQOz0/AuTQx8WtUf9txOJf45XDC
         tlsZdQ9qLctFy3MlWvfv2ay6siS5dVNyl4Fnh3HTBsXB2zhSHtKKjQZ0C93qF2mELi+N
         HW5ZLgOJJnUTEabHqir+sJGVl4/JTDAUayW7GS6pcU3CbZmUImrHIcUCpFkp61wRjXew
         eMAGR93ZQJCVCCbhJeNHP7MeCGOUHiA0o9wlscDq104mBWrc3YNCUVTEMQe9rtI+jw64
         lWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=845yew9YCqJr9EBUhWoMlXsRsK/rS13QIA65vNiDan8=;
        b=iABc5Poe9VxPTUMWLbWVpWe5onEkl2Hphh7KHnlx+FMnctgAve27TCIAYAufGRn1iM
         oo7Qpgnu8j0vsS1pOrjx74WYL42MaDP8bsJ3iy0A4TLuJymCfcRSS88x9x9RvZO1C7om
         NEkAN9u6Y6vq5KsTz7fTFiyDUZ2Tu2VsyBmOZmkJ90rd7KY3Byj2CC1k4G0uM6N9bPm0
         /ODiBD94C++IyL9T3ip9Nv1uw5QfLedQrpdZG782KvwYTdwp2kBvI6z7zM59buOuPxKj
         ejbcep8LOaqO+WD5eUzlcp+NoccdkW+zQ6o+wrVsYSj5EGtr7RfeF/9RpPl/3i7llZRa
         K1Vg==
X-Gm-Message-State: APjAAAVKCW1HJxkBpOR9ZNREHtlAvlFpx6g6zCLdJqOmD0zNC8z6MsdR
        wI77cfMd94e+7NoY+vYfijt5Pg==
X-Google-Smtp-Source: APXvYqwzn5vKpNTZ4yvtxp4GdzQOi6+HJd8bNcJQ6zKqsvbXoIKl4/bozYNbfalvT4wlAw/mQRwLxw==
X-Received: by 2002:adf:fd0c:: with SMTP id e12mr19596165wrr.230.1553621542344;
        Tue, 26 Mar 2019 10:32:22 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 4sm2534541wmg.12.2019.03.26.10.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:32:21 -0700 (PDT)
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
Subject: [PATCH v7 01/11] dt-bindings: mfd: add DT bindings for max77650
Date:   Tue, 26 Mar 2019 18:31:58 +0100
Message-Id: <20190326173208.30614-2-brgl@bgdev.pl>
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

Add a DT binding document for max77650 ultra-low power PMIC. This
describes the core mfd device and the GPIO module.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
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
2.20.1

