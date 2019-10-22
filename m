Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC1ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07712089E
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KOwac6lX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbfJVIgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:36:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52720 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388431AbfJVIgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:36:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id r19so16178896wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YdPiqrMx4DGxjMQly7Bs8yH/i3WsBA2bl/JSPtLQAlU=;
        b=KOwac6lXMvPzKQbGfVwOeuk/E80ZqaFmm5zXdBDTyds3/Js1pcVarjfBKCxKxF4H4u
         apUS5rMwuujrjZOQ6a7IQDxC0iyQLPSGSGwrYdpQjpsq7nau7MJt9PMGqZK1CZKlzxoe
         wXTFpQYR0kUsTC3gLtwmTju8gYiqmU3FUT5hm+NQIg5jPw8aJqxilt2wa7hEuyhgiTfs
         KG+V8Zdlm+SKT/bF1hR7zWuVljXx8qWrPmanQNX4oy78eIqIv5k9BZpOwQd+5v9+Azif
         Lc7blMT/nujxMIz8oqLpcJ//JXiXSXA18vogHoVObQ0yZZY1QWE3XLU1BfuskLL3xezj
         YR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YdPiqrMx4DGxjMQly7Bs8yH/i3WsBA2bl/JSPtLQAlU=;
        b=i2REjYKw0IpHfu9FQjvgldlHdkuoj1GKw5uoUW1Bap3qJamyQWqraFwc79cJvmYuij
         XuSVV3x8QZCgo44HL2sIeTZ5ZTO5hOtv6xiBP0HTIEFy5Xt+LjV2wOIDi4Gv977OUA+2
         jlTCVbhd8DtVB+HAZH10Zj3/j9hMq3kLmvf8WUJ4aO/3L8TzluGa65pGiVAFQrhhdfYL
         zTI8q5GsODIvmh/moarzd0TUFyroaHf2IWbcvDOYEfSDYND9jfqkjKDW0dUpZatjWQYI
         n/mwXxKeRUsMCEIcwg6aBi0/I5GFuYUS2fLRU79xaNz9IBUof55cX4iz0uUa3zRHe26K
         XUfA==
X-Gm-Message-State: APjAAAVx986hOGcN70WjA1zR2fB4IgsCa5nZw20EdsuLIzwkkwrISvLJ
        B+kCVR7KfTnedYJoRLu7iyxHgg==
X-Google-Smtp-Source: APXvYqzrOTy8tDKT2zZ6P5R14GHkgBj65AvHBPBErhOvZSksyq4orZqQnZgOBg6C1rMPoItuIr/Dgg==
X-Received: by 2002:a1c:2986:: with SMTP id p128mr280566wmp.173.1571733403089;
        Tue, 22 Oct 2019 01:36:43 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id g17sm17115253wrq.58.2019.10.22.01.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 01:36:42 -0700 (PDT)
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
Subject: [PATCH v7 6/9] sh: ecovec24: don't set unused fields in platform data
Date:   Tue, 22 Oct 2019 10:36:27 +0200
Message-Id: <20191022083630.28175-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022083630.28175-1-brgl@bgdev.pl>
References: <20191022083630.28175-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Platform data fields other than fbdev are no longer used by the
backlight driver. Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/sh/boards/mach-ecovec24/setup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index aaa8ea62636f..dd427bac5cde 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -386,9 +386,6 @@ static struct property_entry gpio_backlight_props[] = {
 
 static struct gpio_backlight_platform_data gpio_backlight_data = {
 	.fbdev = &lcdc_device.dev,
-	.gpio = GPIO_PTR1,
-	.def_value = 1,
-	.name = "backlight",
 };
 
 static const struct platform_device_info gpio_backlight_device_info = {
-- 
2.23.0

