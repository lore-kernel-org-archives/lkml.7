Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343B1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052FB21473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="T8gpEi7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfDCJCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:02:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41438 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfDCJBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:01:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so20223248wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HApJK7a6SBb5lOZD3+DMDZ0tOFvNqkBPKDw8GEzYb6w=;
        b=T8gpEi7O6uybru83C1aNyodNZR4ZJDtmJThrmF+0J3+bnYsBRKTtvLomX+LCi4K9PB
         bLdSy/5kYffjdJsatmTKW7L9O+80JvfvAQye6f5d3k3Wwc1iunk0S/iGjnK+ojMBgXRm
         urqB7qILcCbjALENyHWpr0lF5oCKzZNP7ivVaTRJ6wmwM52NmUI2xaAIGk9NwOkOFUG7
         Q7bNlGv+rBXtHcF/x5mxOzv1M7pAnbfAfGOUw3sdxtlJ/Z5X3srujWZd/IizyZz29Fzj
         tTAq9UOIKFnPHcuqlCGytzxNgXPk7WV3cuLoMa3nFvj3Z1ySn1Vuo/grJOdpoqhK7lwV
         KMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HApJK7a6SBb5lOZD3+DMDZ0tOFvNqkBPKDw8GEzYb6w=;
        b=L+UqWjxURrmkbq4BeVZ52M/diuuZgzLMFnXR0rRwosL7uOAxNB/htf58+oG0OFHhei
         LdBZ0UFf//PShFhBMrYnSi7DhLa5j5sO/jNIsCAUvA3Eek3l0alaaGNVtcv8P6oeZnIr
         05kEv0r8tQvOm9+NmbwTtW2vwL0oq3vH2yk9GiZKECw7W1yh+C9rxixy+8lyRkZ+LfVL
         tbk2srLqdaeCeokS4HVRBOR9cGO7SJgBiOkzgrnDdgTrvzH0tU9onrIQoNTzONz+64aB
         2E8ToFpOzBUidoX8SD7UO9HdB1eAn563ibE0dC53p81j1h0PUVh4IRtCodkDrXV37iPF
         RJJA==
X-Gm-Message-State: APjAAAUb0OLYyFli+qr8kV9EUm/Ar5YNyFj3mO09qcrR3rDQSTx+A7oW
        S4o/cSrJQXldgktpYfWrn98ixw==
X-Google-Smtp-Source: APXvYqx9R5uGBv4ItqtCdzdMB3frYw9GuPJFwjXcmP+hQAZt8Bu3keTmhNNoW4liaqZHxzI90Hp5Gg==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr28972088wrp.61.1554282082464;
        Wed, 03 Apr 2019 02:01:22 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id v16sm23981998wru.76.2019.04.03.02.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 02:01:21 -0700 (PDT)
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
Subject: [PATCH v8 02/11] dt-bindings: power: supply: add DT bindings for max77650
Date:   Wed,  3 Apr 2019 11:00:59 +0200
Message-Id: <20190403090108.24788-3-brgl@bgdev.pl>
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
2.21.0

