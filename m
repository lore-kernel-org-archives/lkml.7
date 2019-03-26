Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C5BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F86206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ElefbW/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbfCZRds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:33:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34022 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732004AbfCZRcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:32:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id o10so2907219wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W6m6QUwPm95HDuN9+yw7fF14rWdHdRE1dw7z5w3mpl8=;
        b=ElefbW/ArTJWxjb/ix+I51tTnryYGOefPEiSyeObwOnkED5d1dSIgi2CXxn56X2Gw+
         5NfCl2nEKl9Gvt4k9ttcSa3RTGi6Xi/EaNXEB4sp5uo5yS7YdX5J3aiBbhzNjnag2jZs
         Of5m3UJNhj3UHAtbQfLN/h/IvjD7Zz10tTGEhSNFKtDSd3sxRidUyEXtPCPt8OlMCWej
         QhfpxJc439aSW00kaSUCyZch8Y2MDAbrSJ0u6rHsbAOOkL3636GhjtHPukgwgeTyVt28
         7tV994xx4ZVPCmk3sVjMOyeFDQ0Sb1hSSSdbeo++rRfxYV973OZQ8Jx5cEctKPKo1G3Z
         9+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W6m6QUwPm95HDuN9+yw7fF14rWdHdRE1dw7z5w3mpl8=;
        b=PKW9jxNcOPeeUHIDJstx9MViOdXe4+y40TLZfmiD1XylAs712r3gjJMhbjI/TlP5En
         N9Y7WRWDis/pPES35w9VB4pjaxe+hTC2qFPLg9MlW1zMbZUCyNtDLpuih7mz1llYoKiY
         4+/hfm/2W4wVZc6st4uvYt/Jdt8bg3jRt3DOprYPeJ6tPc6L234wMmSYX+owAcux0Uws
         eBTHnsz67R8y/L0qAEZs8bWLN+xlL40WDSG9d6/PEJzV2c7TONLBVKBMMTD7demmnj4s
         wSWPKT7Tm5Oc5at/SIsITQJMOHdIE+cJoIgBM4R4fkbJBEEHv2zDuTLotFOeNBL5Ej2H
         5RZQ==
X-Gm-Message-State: APjAAAWFBS38ZvY9QiocJozqHSckfkUybuITh8CGoWE19ToL5K2sT0Lo
        oj7r21TyEygEs1ld8HrUzkn2/g==
X-Google-Smtp-Source: APXvYqxk5XkIUE4KtdY1xdlnW976IqAEcWOy5gCTeaLs6LmyTpUQoAnq5VtUrxSYOmicCtvZoOX2Zw==
X-Received: by 2002:a1c:9c14:: with SMTP id f20mr9809480wme.16.1553621543712;
        Tue, 26 Mar 2019 10:32:23 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 4sm2534541wmg.12.2019.03.26.10.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:32:23 -0700 (PDT)
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
Subject: [PATCH v7 02/11] dt-bindings: power: supply: add DT bindings for max77650
Date:   Tue, 26 Mar 2019 18:31:59 +0100
Message-Id: <20190326173208.30614-3-brgl@bgdev.pl>
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

Add the DT binding document for the battery charger module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../power/supply/max77650-charger.txt         | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
new file mode 100644
index 000000000000..fef188144386
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
@@ -0,0 +1,27 @@
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
+- min-microvolt:	Minimum CHGIN regulation voltage (in microvolts). Must be
+			one of: 4000000, 4100000, 4200000, 4300000, 4400000,
+			4500000, 4600000, 4700000.
+- current-limit-microamp:	CHGIN input current limit (in microamps). Must
+				be one of: 95000, 190000, 285000, 380000, 475000.
+
+Example:
+--------
+
+	charger {
+		compatible = "maxim,max77650-charger";
+		min-microvolt = <4200000>;
+		curr-lim-microamp = <285000>;
+	};
-- 
2.20.1

