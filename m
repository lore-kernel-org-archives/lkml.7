Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A102C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496E921738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PfmmyxUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfDWJFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:05:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37426 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfDWJFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:05:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so17803869wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BVv9VwERw/8GMdcR/JI8zl7ecUyce8bFKk2N+Z24cdM=;
        b=PfmmyxUAzdA244oOC7Wb5572XM20J9l/MeW3KPlCJPFSuqF4qF60vm6RF9REIuNGZo
         ixmhPm4gFCHQ7zOvDpBzQKRBG+KlW7/+QNZvhTzsvPzkSNX+AgoaO7b1svU/uPxWhVGJ
         kvV0T07IhzEKqef1HRX0Sy8xKxl5B8Q7xT0i9FwWjMUdY7GSMaKHPV6C+rUiA1OgVJ56
         LpvAgUMtcuWyaf7wcKrvgEFCYafNf1IYEhaUWPc4PtOzulbGCGYFsg8yOZtdprRxClGm
         cjflkXbLvg1SMVAkqwP0H5wNwwTT3xQsIzuRiK+e/EPMTIsm+X4Sxg7ZlupcLMYcjFPE
         4MKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BVv9VwERw/8GMdcR/JI8zl7ecUyce8bFKk2N+Z24cdM=;
        b=VHw8+XATvfwg2O0N1WHbXlBOCXQd5EfBMUozNzl5nH55WNVfhkCvhQTgDlGYjZwWNe
         wofDwFUaG4z6EUOq6BnoFAvHOjYJ3ONoq9DHPBK/Yo470c9wG2RdlazKhfoLAzT2AgmM
         1RD0V3jsHio8kjRnPCDmf02wCTlA+mF0ZEkZ4wqcvUnstSZC28bW/wOMMBB+pRRfDNal
         dOKboJjhyNTPXIWqyjT50uxtOC7nggLI2Y94kdCSvFMltUGQWnQR73+afbY17lOxmf8I
         lSbuARglu9DO5a/9JnqdrF0oFZxXNlT102YJN4ekz5dtdqmW84QBDMdkdys+D4VhfxQ8
         T1GQ==
X-Gm-Message-State: APjAAAVS31LjfBwxzzS0ZnkOUCi+nRdEqbPLvMF8AWe9zUK1qUHTIsjX
        egfUD0GxnqwRiBfF6S+U/do0vg==
X-Google-Smtp-Source: APXvYqzRX5MaRsm7L714EA1dFxtOEycJyxRGKGyn9+84v/WxRg7PIBfhLWuHV+67AytadO/vAes+5Q==
X-Received: by 2002:a05:600c:2294:: with SMTP id 20mr1379060wmf.56.1556010314643;
        Tue, 23 Apr 2019 02:05:14 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-25-101.w90-86.abo.wanadoo.fr. [90.86.250.101])
        by smtp.gmail.com with ESMTPSA id v190sm15360434wme.18.2019.04.23.02.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 02:05:14 -0700 (PDT)
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
Subject: [PATCH v10 11/11] MAINTAINERS: add an entry for max77650 mfd driver
Date:   Tue, 23 Apr 2019 11:04:51 +0200
Message-Id: <20190423090451.23711-12-brgl@bgdev.pl>
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

I plan on extending this set of drivers so add myself as maintainer.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09f43f1bdd15..aed6698cc4eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9406,6 +9406,20 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/max9860.txt
 F:	sound/soc/codecs/max9860.*
 
+MAXIM MAX77650 PMIC MFD DRIVER
+M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/*max77650.txt
+F:	Documentation/devicetree/bindings/*/max77650*.txt
+F:	include/linux/mfd/max77650.h
+F:	drivers/mfd/max77650.c
+F:	drivers/regulator/max77650-regulator.c
+F:	drivers/power/supply/max77650-charger.c
+F:	drivers/input/misc/max77650-onkey.c
+F:	drivers/leds/leds-max77650.c
+F:	drivers/gpio/gpio-max77650.c
+
 MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
 M:	Javier Martinez Canillas <javier@dowhile0.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.21.0

