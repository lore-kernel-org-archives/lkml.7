Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17D9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A943C20674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cqy4uiJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfDWJGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:06:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43708 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfDWJFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:05:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so19136642wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MedpQw8DFsDt3V/ORD2drjMi3LvgLvtlXtjB66si/QY=;
        b=cqy4uiJoGch/a9yBruv3xx6f57TeqskU5aF0iQBzIBHcEOCuC71DDV1W4uJarfunmC
         gXKEkDFJF2R4YSI8IrH7l3I/uzHfPdEc+hXWKL89nvGfnVzahINSlqLNLUiMNY48DT9P
         jY/oKgKcO6Mqtwrkkg6TIegemNWSa9KkknYIPv50odQFhqX9U7i9TQFE0d1y8F4bhMQZ
         8n+vZpKfL8cgKc3rUc/Snt5K0zTiRzPA35YDoYVZ6JPJV2/9yhJ4UfGsZFbJnI4UtHcM
         FoOOQUj0l3EM+FrdTdFL6iLYbvZaplVr0TMmxAFuSewNJX3KkKXMX66J1OTwDV3U3ZB/
         NMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MedpQw8DFsDt3V/ORD2drjMi3LvgLvtlXtjB66si/QY=;
        b=Xz2yZZiMJmmdzrKfJBBiaHktkbyW1dgf0X8Ot7j5PToi8L6p+T8MAgw4cJPTx18fAS
         PaaYtMPvH2dqS3j/2W3dNXrfDoBF3sjfkjn3L1gHSJGRzgGKVt3BqP83HH2zTDx9ik89
         r4w6ok03F+Oip64LcC5kRdQAgEFR0qxNH45NLHLKgvcza8p3pNjQeQMwEkLIs9HJlZNt
         zgwPwXhCM4/K5r35e3CfY8XE2VLvyM4iu9Ytwg//wj3rj+G7ByHzT7YK5HVwzAxr5TM6
         I2cIKnQsBtGguYfFDUPSkDVWmmY+WwEUf238KSPryMcGh54EKOPR6ohZ+ud+4JIorZKZ
         CW2g==
X-Gm-Message-State: APjAAAUOms7dyhxFZD8DgvEYs6Y7RtTZfoHRWZtbgo7G4i6oV3+NDqeb
        /alVUnE/qm6oKlad9gI8dxKnjQ==
X-Google-Smtp-Source: APXvYqzg7hz8sx+qK/JUcn5kAB6BZih/qY9QgDprH/MpI5/1qsS/2vb/Ouszgak4Fst3yVrog3Dpkw==
X-Received: by 2002:adf:f390:: with SMTP id m16mr2420365wro.25.1556010301888;
        Tue, 23 Apr 2019 02:05:01 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-25-101.w90-86.abo.wanadoo.fr. [90.86.250.101])
        by smtp.gmail.com with ESMTPSA id v190sm15360434wme.18.2019.04.23.02.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 02:05:01 -0700 (PDT)
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
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v10 02/11] dt-bindings: power: supply: add DT bindings for max77650
Date:   Tue, 23 Apr 2019 11:04:42 +0200
Message-Id: <20190423090451.23711-3-brgl@bgdev.pl>
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

Add the DT binding document for the battery charger module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../power/supply/max77650-charger.txt         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
new file mode 100644
index 000000000000..e6d0fb6ff94e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
@@ -0,0 +1,28 @@
+Battery charger driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The charger is represented as a sub-node of the PMIC node on the device tree.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-charger"
+
+Optional properties:
+--------------------
+- input-voltage-min-microvolt:	Minimum CHGIN regulation voltage. Must be one
+				of: 4000000, 4100000, 4200000, 4300000,
+				4400000, 4500000, 4600000, 4700000.
+- input-current-limit-microamp:	CHGIN input current limit (in microamps). Must
+				be one of: 95000, 190000, 285000, 380000,
+				475000.
+
+Example:
+--------
+
+	charger {
+		compatible = "maxim,max77650-charger";
+		input-voltage-min-microvolt = <4200000>;
+		input-current-limit-microamp = <285000>;
+	};
-- 
2.21.0

