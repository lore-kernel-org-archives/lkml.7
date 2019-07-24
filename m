Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A90C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C40122ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="eMMmroR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfGXIZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:25:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36866 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfGXIZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:25:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so40740352wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bZYb/2BvCTI7DdfJeewjmu59+q6QA8Ct5o62NPSlXLQ=;
        b=eMMmroR7V1M+etXX4tYfPBtj+QEIIIUXtNJYKhwTIwvxfRUNRc3IZfzvWJXAvrNYWU
         advngdJeEYxOqTd3iZl5xGYkFNxm0CngMKJr18xOtSwvzlW1dOyGy1oMF0bxwqwpA37w
         977smMjcPWCsg44JwBkhdWtYAWEcH+IT+EP22quG88BckRt4EAY+nM9q2ekhzOHyZB5+
         wGgvDvDbX2/qq7WwZtSuhRJcSqByopwj1f7ukQWn41YQi/HWvI0u/IC1pTwK5CTvgKhC
         etBqD7P2AQBsWj+uSkD+VetwheS4bWknvZ6JCCK9BfFIxj4I6ij4mc8vc1cACyjhgPCn
         imvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bZYb/2BvCTI7DdfJeewjmu59+q6QA8Ct5o62NPSlXLQ=;
        b=pR96Sl/VfwKOneAMiFUZG9+yfX4lXgROwUi+DBLoVgVyuWUaEtbjRJqh4KmsDavF/k
         PpbScro7abpZ8dmRwM6LxkKZGgT1E8kSyH1BYJwjjciLKZT8XOuRvCh3hd4V1bx44Yej
         g/DiVRvWu+wmldrpjNDt+imaguTeMqdUal2FJKi6X/StoXIJ2yMkDUc7NrYhn4bMb/VG
         2ZDssF1qVg+2HLzUbEIBTdGqYUBj224XzVb6xDbzTGpj0cSOm+4gnynA+i8s8tN7+WEw
         8o7ldzMAMYO+C0kNu9G+3g3xwJmelDBemhd1GlZCt/ZxqfMAIHhYs0W8ZUeysqeAQatV
         FoTQ==
X-Gm-Message-State: APjAAAXs9xLdES3C+O81DD57uLQNQ6X59p768Qiup++IVV1yfV9h5kZs
        SpVblwZQoVfZbFmFuBQA3W8=
X-Google-Smtp-Source: APXvYqxOORrgcEepfDSEgrObXsBtxM+8pGNSKgl7s1yaroVXpQpRAWrFwTKiJdvbP27wuH9VC4s4Vg==
X-Received: by 2002:a1c:f116:: with SMTP id p22mr71783247wmh.70.1563956715936;
        Wed, 24 Jul 2019 01:25:15 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id z7sm42393880wrh.67.2019.07.24.01.25.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 01:25:15 -0700 (PDT)
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
Subject: [PATCH v3 3/7] sh: ecovec24: don't set unused fields in platform data
Date:   Wed, 24 Jul 2019 10:25:04 +0200
Message-Id: <20190724082508.27617-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190724082508.27617-1-brgl@bgdev.pl>
References: <20190724082508.27617-1-brgl@bgdev.pl>
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
---
 arch/sh/boards/mach-ecovec24/setup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 6926bb3865b9..64a5a1662b6d 100644
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
2.21.0

