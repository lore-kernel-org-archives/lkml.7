Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A534CA9EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 08:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FFF20872
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 08:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PJcwaQcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfJSIgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 04:36:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52586 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbfJSIgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 04:36:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id r19so8373803wmh.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 01:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5bBJYbCyuRW60GB1XX7z+M5+e/gSwELCNj1WMzvFBY=;
        b=PJcwaQcGOcOoFaLJc055qdw97PLYGQoFfRDf67LSJ8X9W1A1iGnc9ys8Qho6+Mvx3h
         q/BFei4zPDPOU7WWher6lqxzBZF921nW9bY9N/y3aYxEH5RCHkBFNNKK65i1iHilMwMx
         Bz5ZuyNmoSChqk8Alt/jNZxnZqQEOrxMTDWfzo3emNhzVjH46dK92qzd54hVyvJf31u0
         OBDyP/yUyKOOquD3ZA6N6xzMMLUi79NYGl2MFLOziQgEr0BvASZOtEAm9CbkzeI6nQmj
         TZKydUBlM9LXTKGo77rB8gA35rZvsGzwKchlILK1iLHpGXX9lg/299GPbb3BTZgyjnCj
         +SGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5bBJYbCyuRW60GB1XX7z+M5+e/gSwELCNj1WMzvFBY=;
        b=ZGkrpQI2Yx6WH3nRHmh7Wk75nM/sbB5H8sTKVEDfyIPye2TWNT6VvQcUhscif5XjrO
         NGnnnPm6V7bRvYGMRtVr/oI7WkdMBAyv4aG8R3QrvWRho+WukxIkn9QLyvlcNvoMGrAX
         Ld6xOnpy/dBHZMp97N0qPQEsW9Exe6xT1CsG2V9q3wkPVx+aSQDZaJtC93TXlGFsP8o8
         UfaIjNVeTXohqfKE3bfnbPwgYQ3dr+ni0LgX/CbZ4t0GJQH6zvzb9NG9MCV2xIpu3C3v
         0bQaZ7b6O5BJ4/LHAvoxw6Sk806c2VaeD9hrjeluzwGLYVjQlpqxrp77HD5OPsay3Zr3
         e0mQ==
X-Gm-Message-State: APjAAAV28bUjDJvRFW7ZOvzo+jK08/xtNwiWlIh1KsG7bW3Agzv0MYng
        ix0NzMP8UU2d2XFNIAw+NWmusg==
X-Google-Smtp-Source: APXvYqxeYmGu5PXx2s97sAMDcdiXX69oA5DXi1FfFsUYc8NVqOjz+0qhCX+j4MhOe+oQg8Ct+ADcyw==
X-Received: by 2002:a05:600c:2196:: with SMTP id e22mr7093447wme.1.1571474172029;
        Sat, 19 Oct 2019 01:36:12 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id u1sm7242627wmc.38.2019.10.19.01.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 01:36:11 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 2/9] backlight: gpio: remove stray newline
Date:   Sat, 19 Oct 2019 10:35:49 +0200
Message-Id: <20191019083556.19466-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191019083556.19466-1-brgl@bgdev.pl>
References: <20191019083556.19466-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Remove a double newline from the driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/video/backlight/gpio_backlight.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 7e1990199fae..3955b513f2f8 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -91,7 +91,6 @@ static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
 	return FB_BLANK_UNBLANK;
 }
 
-
 static int gpio_backlight_probe(struct platform_device *pdev)
 {
 	struct gpio_backlight_platform_data *pdata =
-- 
2.23.0

