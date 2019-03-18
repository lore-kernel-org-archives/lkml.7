Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36034C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CA720989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ba/8r8av"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfCRRmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:42:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54705 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfCRRmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:42:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id f3so14070213wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ed0hAf8WZbtq4MmRoK//lOwdefFE9pMkHjk9cFK24Ko=;
        b=ba/8r8avWH1xZwlYaDrQth34v57v8VoTzfww9gs5OSP5gvzh1asZ9R8mYv+EhDUpyW
         k1/29103FsjJ+fGu7cdh4xwpvMUyB0IAucf7igwiLTs0yi2pFI30JFcjNFqVCM3dXM3N
         iagzGtoyAhR68DdicShpynAJHwCFcPgfm7LmP3RkuIVEDvCsuFM6cW9UDJh8UZ8nE63g
         0eUCy8EiZnietNSZggeIXoGQ/MBUDpjAB+vYMYOXw/zqsMtFNqUM/3c7mu6zIoktxMBF
         XMUfvHV9tu8dI3tlaBZjhnA6GpifvY6l0tfGU4QdwKmxrLVe7xtubv1AsQnnL/ri6BEx
         wsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ed0hAf8WZbtq4MmRoK//lOwdefFE9pMkHjk9cFK24Ko=;
        b=Jcvyo3TY1IrxRVw13tNq2VCTAmE9aovWjBrJl27SCACM14sGURhdQ0Iqd33wtzIK0M
         w8XDUnutQ5k2GKONekycVReaLTT33z4ZT1HIvxn3G1Rhnx6A/+f3p5gPPfzG3+5SnICl
         iGCDyWfpt4NnFDBIThc5cTEXmWaucJqFs3wa8MqzHsWqA+KxeiPsnpacbnASmfjr1GFh
         1b9o24CjTPKPi4QC8Sw6FM7X6Zr4mFtRlLHZ8mtl55fgFVAwONHRB70y8ZfC0RsDa/Qi
         elCqfpi2Hen/jJxeNyQIm7nEuaZjB6UEcS8cOtkPtAU5n/r+jeDXUeB9ZDQN0LNYQ9zY
         3ziQ==
X-Gm-Message-State: APjAAAWTZrgUWm5lOYl7UZQH6ERy8BRTASY75sSDXa//IsQHtbcYKrWk
        UxNEqYnb+gNUv0N03e8/tIQBfw==
X-Google-Smtp-Source: APXvYqxfzgFsSBrWgerYGF581NeieWUjJxuKKydhzNmkZMF4SXet45ztrTev2jNhSdSVCwvVE18udQ==
X-Received: by 2002:a1c:e2c2:: with SMTP id z185mr56857wmg.84.1552930953850;
        Mon, 18 Mar 2019 10:42:33 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id g24sm14873909wmh.45.2019.03.18.10.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 10:42:33 -0700 (PDT)
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
Subject: [RESEND PATCH v6 01/11] dt-bindings: mfd: add DT bindings for max77650
Date:   Mon, 18 Mar 2019 18:42:18 +0100
Message-Id: <20190318174228.18194-2-brgl@bgdev.pl>
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

Add a DT binding document for max77650 ultra-low power PMIC. This
describes the core mfd device and the GPIO module.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

