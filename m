Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232C7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FB920882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TJdF1/rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDCJB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:01:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54319 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfDCJB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:01:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so6495824wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Xr1jsD375oor0bo92jhZRFG0f8hjG44jwYFFHmorH8=;
        b=TJdF1/rx7chEHOH012wvi3DUsGRTcw2U/1cQLP0lGRKaknYt+6ys58b57ahpzwHGKy
         un7i8xjJG0zlofY4Wgy/3fZMYpT9QPo+wnYZS/7GMDkrON/xnkmhY+lru77dCkbhJ0og
         X/OA9NNX6YtVaXmOfTLUasJXBfLxBhT9S/INP9fBkdAPTBovUy2Q6F9zC26eEc8NyGmd
         YmC7ZIq38GZDPDKOZsTS+t9dbOXmLm2hQb82h/076jepLxLUdtNtymnLVx25C9otQDN7
         aUHWmNuwIuxW/MCTCr+wyaMcDGp0aEekZEe6ooroGuLTdieWVBItr55honRB0TfR3olt
         zhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Xr1jsD375oor0bo92jhZRFG0f8hjG44jwYFFHmorH8=;
        b=mgIpUjF6r4yghC5izzwlyIFmiNufnvs8bGbMuOUBD9q3PWUmhirAOelzlccc3xo2Gz
         Q5WxgW6s7WRwwM276ArVQ14x78y4nxQ/eMaMiGih++ISkyPWxh9o3bH3E4uXl7/+EnXi
         dph2hQnsCLDRJVAUzAMjxsTGgtH5Opaa+ipCccO/E4se4WG+lqYvV53Zh7MHQWbQmwvg
         4EhQAhILkrjRHQ0bNtjkExMX0hQoyTO2xCaXmLJaZvUS9USkQ8/L6D0XvDHQ6Wu8Mf4u
         eDfiqhwC8bWPy+tU4gNrgqfQqWjrTyfQBmLm575iNIYDTkjmVjkTpEzJqLNfGDowHnRf
         4Icw==
X-Gm-Message-State: APjAAAVgfUq7qjkNb9A8vNW6heXLozhmDdesvG3LN5QU09MTZFLqnSdg
        9/4i8mkkeJr1POj92rsJOi6QDQ==
X-Google-Smtp-Source: APXvYqz3el+vcl9u93QWcaZ5q4209p+aSL4E5aTzeh93mmndGlxsFAUwm4ePJ+iPk7obG77F25zlkw==
X-Received: by 2002:a1c:80c1:: with SMTP id b184mr1249146wmd.109.1554282085150;
        Wed, 03 Apr 2019 02:01:25 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id v16sm23981998wru.76.2019.04.03.02.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 02:01:24 -0700 (PDT)
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
Subject: [PATCH v8 04/11] dt-bindings: input: add DT bindings for max77650
Date:   Wed,  3 Apr 2019 11:01:01 +0200
Message-Id: <20190403090108.24788-5-brgl@bgdev.pl>
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

Add the DT binding document for the onkey module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/input/max77650-onkey.txt         | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt

diff --git a/Documentation/devicetree/bindings/input/max77650-onkey.txt b/Documentation/devicetree/bindings/input/max77650-onkey.txt
new file mode 100644
index 000000000000..477dc74f452a
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/max77650-onkey.txt
@@ -0,0 +1,26 @@
+Onkey driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The onkey controller is represented as a sub-node of the PMIC node on
+the device tree.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-onkey".
+
+Optional properties:
+- linux,code:		The key-code to be reported when the key is pressed.
+			Defaults to KEY_POWER.
+- maxim,onkey-slide:	The system's button is a slide switch, not the default
+			push button.
+
+Example:
+--------
+
+	onkey {
+		compatible = "maxim,max77650-onkey";
+		linux,code = <KEY_END>;
+		maxim,onkey-slide;
+	};
-- 
2.21.0

