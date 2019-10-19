Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE23CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 08:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC19206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 08:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="P1X7rjfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfJSIgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 04:36:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44679 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbfJSIgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 04:36:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id z9so8527593wrl.11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 01:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJb9zTJUFk5gt04WV606l1pH2Oso/m6U1KjJZ/jsQAQ=;
        b=P1X7rjfTUJ3nuQIt5WgPxo/bWVF1kNL7UC7z6D3mpB5+R/b/fRt812wGTpBYsf1l4X
         yLrW5jtqYTj9YCVhQyVaKhVahExaGBVsQ24kF8hxTisINKX9Ki9dkJoqd2OpUJpey5aw
         RJJfG8f4obCZrlt1J0H/Aed3CeK19+tFD1NoDtUEVAktPR+PGIL/dtASqLofSrkNqxKp
         OuTN9is8GL3bPXKg141be4zDoB0/wM51Cbdiu+mJ4FQidBEmd8QXf3ney/4vuQGHJQlL
         h+uHFSpFqfIzhmhbYrFM7LUnDmKWRncFKOUNY6CY2/IQnjXIx1JqTuDAaUOQDcS+FrRP
         UXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJb9zTJUFk5gt04WV606l1pH2Oso/m6U1KjJZ/jsQAQ=;
        b=Dgdfy2oftyFqbTK/5hN/G9qR7SY1X5KRCOhEuu3+DKzy5oeX9CH+FpBvcb7SYa/HUA
         ph47svJ9fGMg6k8olBLpZEvxnSdeh99F79DmaEZu1Cr1caTR2WCTqBB2bVIpSAAsQ+EI
         k1UKiEev4v57xY6xpDzHb1HVE8T0Yhyfkv9//4GWUpCV58Qu3g6aZ+8MYVwrmQCdchT7
         D2i3QuWJW+mSFinN5J9N3C3ZJ4d3fMViZSB0bfJu1LOnldQu3bl/zSmCiRJ34oAeT6sN
         5M30EIOGnjt+NMciH0nYCvXbVx6DZpu9tEvpVvlLC1jJyjPcIcRWMwIGWYknHWvSfWO9
         QzYQ==
X-Gm-Message-State: APjAAAWEdgU2ioWt1KnnAUHuaUWwrRAVGH3sSILA7e2M/kOQ9p8mCg6E
        hPiRRNl7YMX2S+ivqcUxhkIr0g==
X-Google-Smtp-Source: APXvYqyC7Ckh43yEeLj+N7+h+UruFS+0KKtHRNyoTyt/JpzLBEE5Q2IIWFp45JPp3FFZIDaUQ2sQwg==
X-Received: by 2002:a5d:6984:: with SMTP id g4mr1432291wru.43.1571474179094;
        Sat, 19 Oct 2019 01:36:19 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id u1sm7242627wmc.38.2019.10.19.01.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 01:36:18 -0700 (PDT)
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
Subject: [PATCH v6 7/9] backlight: gpio: remove unused fields from platform data
Date:   Sat, 19 Oct 2019 10:35:54 +0200
Message-Id: <20191019083556.19466-8-brgl@bgdev.pl>
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

Remove the platform data fields that nobody uses.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 include/linux/platform_data/gpio_backlight.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/platform_data/gpio_backlight.h b/include/linux/platform_data/gpio_backlight.h
index 34179d600360..1a8b5b1946fe 100644
--- a/include/linux/platform_data/gpio_backlight.h
+++ b/include/linux/platform_data/gpio_backlight.h
@@ -9,9 +9,6 @@ struct device;
 
 struct gpio_backlight_platform_data {
 	struct device *fbdev;
-	int gpio;
-	int def_value;
-	const char *name;
 };
 
 #endif
-- 
2.23.0

