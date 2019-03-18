Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B92C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3F721873
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="COQ2KIi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfCRRk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:40:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34082 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbfCRRky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:40:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id k1so17593049wre.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KouBHCieDSV7idkFJwAAq2H7EglJYSpQY5o99NkrtdQ=;
        b=COQ2KIi4u0q4ui0h/1NMXSVjw3UAXP4l0sMFG9Nhfvrdm0UkDRten8x44r8YzO0ks0
         tvr7+s2/20GnViY3vPM/mteuATMF+rDu+yFh+lfNVWrFwhnRvDYiTXFJsqLrRX9uAJzl
         9JspawxrsHuFdWWDg2V2XwbIp3lamGdQWeKd8yswphQWQ+aqXm2Z96AsiQlOkRBFej2w
         tx/rbZa/deAEsGFOaGbEOYKRF1u/t7qr/4X8Hryv3sdzRdqbmpoVGESaqC/d+ALzcCRM
         O8UKLzy6Dkru3ytFiJyVfB6UWPL0gnOfb/in/SwueYsn876O42bdPdoeCp+9Ykq9s1mi
         tumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KouBHCieDSV7idkFJwAAq2H7EglJYSpQY5o99NkrtdQ=;
        b=a4wc2puoHt+NeZ+r7UqZVBCq6qWy/RewQbyQWVagegwzdLChh3GXr1YyPQ0542c2Wd
         Lzxc8UYCfrLn57goqxu5Fyp98OQBkqqahMtNJUvrGBXcjils835apq1zxXwb1Whn61Yh
         GRsL9bu7pZiO2FAe8IbO5pgPyBx7m1wzeqxRs0o1a9Cl1ygGKn87J+mdadJFwGPhZJxU
         pQ2yAC3Ko366+Whn1mXBHk0kkQSctspZnT0wGg0kA6ziTxtRfH9tzFU/o9A7OqMVNoff
         2RPnGfyhyCaCSx4usSldPXzS+J74m1qMx1s2/laPMvPcDe9WyQaBg1qNwAR21PTdtU6x
         UwEg==
X-Gm-Message-State: APjAAAXFFVeY+pRcZhoJJyBF+0+uEZzSf7JyI0asOTGURR7qMYi6ufsZ
        NprNc1nsXwgxPstU0hlZCs+duA==
X-Google-Smtp-Source: APXvYqzr3uvH4eJ5lFJKY9Scbm5ob1Q2hDg/2COw838wa05pvk8WpJ6+Y9aLX+i7PLMB/K8KmGal8w==
X-Received: by 2002:adf:ba52:: with SMTP id t18mr12434931wrg.73.1552930853097;
        Mon, 18 Mar 2019 10:40:53 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y140sm41436988wmd.18.2019.03.18.10.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 10:40:52 -0700 (PDT)
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
Subject: [RESEND PATCH v6 02/11] dt-bindings: power: supply: add DT bindings for max77650
Date:   Mon, 18 Mar 2019 18:40:31 +0100
Message-Id: <20190318174040.17899-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318174040.17899-1-brgl@bgdev.pl>
References: <20190318174040.17899-1-brgl@bgdev.pl>
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
index 000000000000..d25c95369616
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
+- curr-lim-microamp:	CHGIN input current limit (in microamps). Must be one of:
+			95000, 190000, 285000, 380000, 475000.
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

