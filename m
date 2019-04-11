Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C76BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05683217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OOMZdmny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfDKMnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:43:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38580 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfDKMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:42:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id w15so6493410wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 05:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5g4/Swk4uHJKHMZmRZrqdiq0P5Jmw7elqSkjk3sVLtc=;
        b=OOMZdmnypoZOLmXGa1ZDnUFRPUAlE0IPYZDa6Q6ujHSUAknUEtOYsbgPrYHgIsja4c
         5G/F5SUe0HqAgrX/SN/vD09N2eXU0pfbGSr5UN6KfpUTxwr2oGx78f1ui0KCbPuvC1BB
         NRxzn2ZAPjrXld4Om+YLps5rkwdZ/W6q/z/vwe7FFZB+OM/X1wx3emGlEtW52IXRYntl
         6ZtK5QvIxehlKXA/FSRnM/SPlk+gS4lecOpNgD4kN6OYNvMtU35APSksP2Ky/bMxmTrv
         JFfnS0oWujmR2o/bezX3lm+5cwKnS14mixKGvL7t43lc7p4bimTZVYDZQXxuRffsrYcf
         cBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5g4/Swk4uHJKHMZmRZrqdiq0P5Jmw7elqSkjk3sVLtc=;
        b=bjCy37EtVOx02nD3ZQaXa/62wSZG3SHMPHGhZh6jrpgkEbT1fcJoQfW/2RO863wtIK
         hyv0VXKiQNuJiSy4LtKU4nvvOyYS7fnEQwvZW8IGqqXLPGLaub38DAWR6E/VJuGkeamf
         3YUIDnI7Qgk4TKx6RHYeatwAkGcJgCYv7jFbQ1qFQ8It/kITT3sZ7EnYIzJakbb8exXb
         LgDwHSn8MxZQuFMzg3/T8VO4OfYk97tiLltwIVYtJocPCpjOth0tdIedIaGAfyDbW08m
         SaxUWAGLcLEvBJXWpcQooKGuviDZCt/PpFDhxSjGbUnTCCIr5g2Nrt3tTb1oe+F2ZAJg
         p0+w==
X-Gm-Message-State: APjAAAU7dxiHXPXhldnJWl8EKZMPURK0taskxbDLAETE2AqkLbMYs47q
        dixFC1d3wHi6x2FE7ZYwEeOgHQ95MIU=
X-Google-Smtp-Source: APXvYqz8OSN6W/p/iYNRVwEzMy1VKX9TUlZIsLCw4vG0Y3WueoL4qH17VNpTYkHwgZcbXiVDV0tNvQ==
X-Received: by 2002:a1c:f50a:: with SMTP id t10mr6601257wmh.86.1554986544168;
        Thu, 11 Apr 2019 05:42:24 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id d4sm32894510wrv.42.2019.04.11.05.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 05:42:23 -0700 (PDT)
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
Subject: [PATCH v9 03/11] dt-bindings: leds: add DT bindings for max77650
Date:   Thu, 11 Apr 2019 14:42:04 +0200
Message-Id: <20190411124212.7612-4-brgl@bgdev.pl>
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

