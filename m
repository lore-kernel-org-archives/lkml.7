Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AF4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6716D2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QbxMuYop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDCJBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:01:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37736 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfDCJBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:01:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so20223773wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 02:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=unJxoU0PCbkDM1pinnosEnZGsulOI/CNsi3pQOOlS9o=;
        b=QbxMuYoplFiStRzKd7iI+/UdT4nY4LY0GJ5YXLUeLeJ/JD5HRF9dkOYRlF2k8zz+LL
         L0C1HLjuVf/y6P/1i1BOrPPdhsTArThrpwm9v3LB3thsHs+V0oOmOOdqiUl+klfG3XJg
         l5Wy7ps1gn7y1Uv95t/dohg6FGZJCS+Dfxkt+V2Hj88Ll9gYQygG3y19OvTdRNJKiXLT
         STElpmPUPHDYczX1Tl6FoVN4DUsPCBQ981Kn2BVxJ6RhEc1JzYKf4NmbK5zveFf0vzTZ
         u8ZIG9yNTROTH9SzMhe3AxSPwhDIRbApQezcN+aGNgaMmvn6tFPLWc9bGsUZFJi420AI
         rD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=unJxoU0PCbkDM1pinnosEnZGsulOI/CNsi3pQOOlS9o=;
        b=o+bpPzXqmduFAKxorle3Qjgc01eOgURZMcsNBkUkohhYEKbABexJ6NtC9QWd7sIYvV
         aDYKF8ZhZhGehwjdF9i+WuEElupQ/O2jVFqJfOnX0uzbKyZCqSLPz71tEj4XUzmTYoRR
         TF0BrYCsKEqv4Aw7147deWim8iNmCluom28ov9mhPLlqw0SJ45S4LZHqO0Yf+gOhZ22X
         qzd2yR6g/02b9xoURdLQz7sl7tEgl2FD8fUjSnHUUNpOZpOAW+ad8pZnNHTWgnHz/itq
         j0C86/VytGkdx1TxUI7MFoWjElYyla1ITwzxu7Ezsn8r8VMVDWXig7rmcAJAJiUk7SVV
         z66g==
X-Gm-Message-State: APjAAAU3ArggWkT5R0qed41ShnUaJf8Aedy5yzzpTYb9JWm50QpqI4cW
        dwJXuUNZlHCvlf+blrYawc08IQ==
X-Google-Smtp-Source: APXvYqxHaqdrc+Hl8EA2lLv8AgWqfFW6w3il/CRNWHejzaj3CgUDw61cncXJetJ2Roo2rjn5YdGcAA==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr46969112wru.150.1554282095939;
        Wed, 03 Apr 2019 02:01:35 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id v16sm23981998wru.76.2019.04.03.02.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 02:01:35 -0700 (PDT)
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
Subject: [PATCH v8 11/11] MAINTAINERS: add an entry for max77650 mfd driver
Date:   Wed,  3 Apr 2019 11:01:08 +0200
Message-Id: <20190403090108.24788-12-brgl@bgdev.pl>
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

I plan on extending this set of drivers so add myself as maintainer.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43b36dbed48e..d8bdaeb72b95 100644
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

