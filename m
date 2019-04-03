Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F90C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3546721473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FgR5TMOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfDCJB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:01:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40956 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfDCJB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:01:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so20209380wre.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 02:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3c2Py0QhAwV6yG/8pNQYFpMbQckkgSj5d6HvOL7EdA4=;
        b=FgR5TMOpfwjLKuUFPyVy9c+ifR10ctS4vqEJ6aTpFXQF8XfzWhH2rZcNPj0teMrF1k
         p+LQa8V1g+s9IE67Dh4BaaECNXeTrE3MvxIyiZi3Xnbj15sMtnAptSetF9LABbOlbtyQ
         Q+kcc7CY73GN9e830+ssjyjiHY6M8dxLjjj0SHqBz2zaZGWJYcaIEVMTjXRajmFnUWdQ
         7sPydASetiPtgjRplomdrVk1SlFVPGdivARK/sZeReHYT79Mf8U8q/iE6AoIR3EGGVpn
         7GnyLiAESh/xrs3IaTN9WzA/RORtFSIO+aJGU/ciMzZ93QUyKrZT53NCyzoZ9dU5MOSp
         bPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3c2Py0QhAwV6yG/8pNQYFpMbQckkgSj5d6HvOL7EdA4=;
        b=shmsuopHW7QKGo6GCLEzaSetgUrJRIOcTNhOIpApbsR3DIE2YYbeS3LXPE5JcEYVZj
         kn8fTpKk3U9qMpNdpsV3u6vkOFlZIgPRvEv6p+jAvu78jlfrD/AAmT7xCdMA2wULAei7
         2SafpwB8fzJ9koIWsrYBulGmLsZl675kg1aYhXdqYFXMic2H+xrQpEw5P8Ee3MlLv025
         Xa9JI8Stm6Um3/ze4zAeX9vNRDDiLqmCvMftV17K67G/UxJ6D+yQSXGrsjg6yGf7+q74
         8Jw96ug8Ki+ACHXEGxQfTQ3/1E22K80mys7uDlDiEFkuGgeCw59QGDvvmmMWegk8aOZG
         d+vg==
X-Gm-Message-State: APjAAAVb+OTFOXB8HM5Re2J3vtJueOpRqa1UhW+C0i5s0w4gvB7Olc6/
        txvkzv1sKp2cxeNEbVeTlCBI5g==
X-Google-Smtp-Source: APXvYqwiqCshQp2ovvvjEMWh+8OZMQZSlOpKcHKKocgFAVf0dWEHcrRfT9jcqrL+4OcJz5wKY/MkNQ==
X-Received: by 2002:a5d:69c7:: with SMTP id s7mr10091334wrw.71.1554282083826;
        Wed, 03 Apr 2019 02:01:23 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id v16sm23981998wru.76.2019.04.03.02.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 02:01:23 -0700 (PDT)
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
Subject: [PATCH v8 03/11] dt-bindings: leds: add DT bindings for max77650
Date:   Wed,  3 Apr 2019 11:01:00 +0200
Message-Id: <20190403090108.24788-4-brgl@bgdev.pl>
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
2.21.0

