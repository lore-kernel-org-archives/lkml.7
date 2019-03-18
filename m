Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CEBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42DD2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZPPPvL3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfCRRoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:44:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39114 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfCRRmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:42:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so3891345wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KouBHCieDSV7idkFJwAAq2H7EglJYSpQY5o99NkrtdQ=;
        b=ZPPPvL3sR/4zgjsZNfE25S5k4HFsc8d0UyqcHXUi9IPBJUg8EtyFwqavCwBiZ1jYyj
         VSPC7d+OFxUcZkEEHs7sG9lXnXKaKNzRjdg1g/zNRrZKQ3o8D/VR7KHKxQiXCIn1TSdG
         0YRveVd1Ng88RPNaqpUr/IqY7NhyCvuKsj7Bb9EzyeL0Q9HBEMn7jk5TgdfqdjqnNv43
         fjgU6WTHaKuOyfNaqq2ynG8O6o8Fj6wz7ot2IT8vyBjLchSxmxDTmDu0/kI7PW71r7De
         rcSjpm/Ke1yCzZAnuf0F09OqAh89eAbOeTvms+Y+bX5yrBTDCgoeta9x2cL2CBW77SYc
         BuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KouBHCieDSV7idkFJwAAq2H7EglJYSpQY5o99NkrtdQ=;
        b=QmPPNQpUwLxS4dC0TlVAsH4kIw7goildkiGf5c3veT6xUI9Z7P544NIVwu5ABS14UG
         3PeU/NFK2mUhhZc9bGwxMCVDkwU03knGyHNNRx3Z/Mt2ZhoFi/jmN+GwD24mfsSr48Zz
         oAbrs1ET96zAtbkZROSGAbJdPX4+8LV0YgLwzxcfZmt6D99nvet61TgKv8DidfxmdPJ2
         yC0nQUrJddno7/nt8Mnxn1MR8/vzfHY0mIQ+UtO5tOKKP7DEWN4PptUwcnTOYkeEqurF
         4ZLuGECFXCkBgxazRUikCrbwar+mZy/v+ygkrnUGaqZiFDfopL5rrRKom94i8NfKmWKc
         LGIg==
X-Gm-Message-State: APjAAAVjdGAevv/NiusnXthNOfkRavPBnDGa5ROLEBSwMJ9JPr2ebOLf
        HirR05X4qTSkdmEXqwJtkiv9bQ==
X-Google-Smtp-Source: APXvYqxY7VJT4IATEvCgkJ3hr4R5vjIOfQ5r2GtjjltpSGItLoNblyMUYH2oN/16xqZargkaGMXt8w==
X-Received: by 2002:adf:dc4d:: with SMTP id m13mr13749090wrj.330.1552930955353;
        Mon, 18 Mar 2019 10:42:35 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id g24sm14873909wmh.45.2019.03.18.10.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 10:42:34 -0700 (PDT)
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
Date:   Mon, 18 Mar 2019 18:42:19 +0100
Message-Id: <20190318174228.18194-3-brgl@bgdev.pl>
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

