Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AC3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8171421473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AKjTpCpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDCJCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:02:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36893 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDCJBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:01:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so7164534wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 02:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aeN889BbLX2VoZH82bVkpm7x6WciirBMN3MYn1uX0yI=;
        b=AKjTpCpSkJ1oyvQNgwb5Nvi6R6QGtG5oaqpLCLc8+hGa3G62LWDZGhSYBHwixxh0TO
         Cmz/1dPpTCbl2+o6Fn31Dh8AmvgelI1Dqb634vZ699vnGJpQh1gOTODsPBYSrku/h3XT
         zUOgLt3BCI9BOZ1TzL5eAm8udpmgi3uL7nQ7P2g1/Fk2VsntZ7Zk3zVlfR9pxNa7QxT7
         AP8HMGR5rLyGzcAVvUYMcxhb2TE4RXThatXtF2QrmDMGpPCx6eLW9EsQX1gBU2M/B4x7
         pUDh82m+sxNdkktoR13Uhdg0MjpNZwNxpjsNLpTQTsydf7TM13UV5VXbHWDzQMwbJLsA
         9MlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aeN889BbLX2VoZH82bVkpm7x6WciirBMN3MYn1uX0yI=;
        b=Neq3IzoBak7JCKyOFnncH9n8daBZ8gaIPlNHN1m48px86JcltCi7Mb5T3AQ6q+ygzp
         JwpyB2tEWhmpgNiUyYAgEV4Fqqz3DoAfxtavXPVf5mRyWYkHkuOtKU/AvrfzmO+Yu0Jg
         mgfxLSyrx10I8fIoI2DhsmxcU+emh4Lmr1MKfn+WzBPUPT7/CcBPf6X6KklxIrGmoeCJ
         RDYy9n1hW8dZkGJyPMVmddZ72hG+qCAJvRzIxbYFzvaZ0dzlgRJdw5A1q+iWEElJJa/k
         oObGWLmDCoKa/k6rN/jT6YNgePSDusMIfHuex7X1BkYp82MGcyN6CzKMonPBr5u9UgiV
         gs+g==
X-Gm-Message-State: APjAAAWMDgN+tIxYHwvrB8KOkxEIOzTVngLpLgJIeIStuxdPJfRMA1qo
        /M6eolaSS2jTQ7tyetUf4ITWXQ==
X-Google-Smtp-Source: APXvYqxY11rOOzqHV3Kr6xDZ/FL9P5Dc2PhfrEfZEHpCCDJYsRtBnupEvWev7q/6mq+4z5vdhnYprQ==
X-Received: by 2002:a1c:20c1:: with SMTP id g184mr1252997wmg.137.1554282081192;
        Wed, 03 Apr 2019 02:01:21 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id v16sm23981998wru.76.2019.04.03.02.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 02:01:20 -0700 (PDT)
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
Subject: [PATCH v8 01/11] dt-bindings: mfd: add DT bindings for max77650
Date:   Wed,  3 Apr 2019 11:00:58 +0200
Message-Id: <20190403090108.24788-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190403090108.24788-1-brgl@bgdev.pl>
References: <20190403090108.24788-1-brgl@bgdev.pl>
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

