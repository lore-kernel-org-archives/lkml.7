Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3F7C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29F022324
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HaBuYw8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfGVPDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:03:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41172 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfGVPDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:03:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so36589662wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LLvAXEq2SM+mYzd8MvDi1noi/4oB+ae8rtxDIe/pNO4=;
        b=HaBuYw8aP/LTLQkjoBo3QxFQrr5CvKqNDDJOUoZjamO6fWlt7hKvBHcwVDhTxa2bVk
         PGmrPqgdMzHYC40+rjS1RCR1E5fh3s4d66tpKXUu2PJoyoXOFhpbeXpgJ6AEM9p2yZ4o
         93mf4+8xW9ChHouV4+22xxtu7EsKTKnml1ymwSywVL8CPeX0NZdPM7gPIb2OmzV20UUI
         Y13RNHjxzT16PLh80llP2bp1kam0WIwrFGsbeQrfnFr6IGkG5/NtHUsUTBQGlXBAJ9Ur
         dU1qJZ6RRrzhjtNst8i/aUfgatG9XA3jevR78rlR86grA+KQBLViQ+NLtwPAgQF0Lk+L
         BGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LLvAXEq2SM+mYzd8MvDi1noi/4oB+ae8rtxDIe/pNO4=;
        b=i3taAwUiw1Qs3R4rp3QPJYV0jP5Ufg2BXgk9w0fMF/h5HG9ZOhZgv1bS0H25Ak2MVR
         h7HBNOxWhx3a1WKVgXrwW/GruL/TCFoFZA7Wun2WScH1xAB3aIJRM5CxgztAbuqGJXVM
         WXOIS+1m3IRlvg5lpUcUZfKSXSZxZv3mll+XVXnuRsZKhnl5BX7GBqKhc0HRzg2yv67J
         hW0k/M2uJo51PxMAGBVsDbvlQ07ayYjORtYJydbENqm3PfbZPC4equO8oIgyaqwxxFDh
         VrWByrGPcORJXAoUUSrJwHjcLStQqaItP6VYqADT/XBPcL+dIVQt3TZsSsdv5K52DwJJ
         QoNA==
X-Gm-Message-State: APjAAAXY7fwYWCaZx+xNQP7p8mtvKjkADUO5fOmUm7UJRg0FwXNnTwqj
        U4jssmMQ9axddD2snWpe7Cw=
X-Google-Smtp-Source: APXvYqxvVgKJopHmtr3HmxSqR0pet7pHj/B1wjfvhB2W3jmIJhEdw2gzxQuq1hz3S75KUVbiMQ7OLg==
X-Received: by 2002:adf:f84a:: with SMTP id d10mr69194280wrq.319.1563807801489;
        Mon, 22 Jul 2019 08:03:21 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id v23sm36310460wmj.32.2019.07.22.08.03.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 08:03:20 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 5/7] backlight: gpio: remove dev from struct gpio_backlight
Date:   Mon, 22 Jul 2019 17:03:00 +0200
Message-Id: <20190722150302.29526-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722150302.29526-1-brgl@bgdev.pl>
References: <20190722150302.29526-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This field is unused. Remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/video/backlight/gpio_backlight.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 01262186fa1e..70882556f047 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -19,9 +19,7 @@
 #include <linux/slab.h>
 
 struct gpio_backlight {
-	struct device *dev;
 	struct device *fbdev;
-
 	struct gpio_desc *gpiod;
 	int def_value;
 };
@@ -69,8 +67,6 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	if (gbl == NULL)
 		return -ENOMEM;
 
-	gbl->dev = &pdev->dev;
-
 	if (pdata)
 		gbl->fbdev = pdata->fbdev;
 
-- 
2.21.0

