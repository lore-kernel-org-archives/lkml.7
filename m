Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A51C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F9E2168B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="S02UO1ON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbfIBMfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:35:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36196 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731721AbfIBMe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:34:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id p13so14474932wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 05:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XOZ9G7G9MWu3PapBqwm76MzTbTk7qh7g47mE4DOAzps=;
        b=S02UO1ON99M1ouFNv8Fx0Xfkw7LOATunblr4HuZkddsYv/0NpCFEoEpOmOcnwsI8nY
         VElm2FAR+R/tHlyAC8hk1GoYi6+xQwuNbqFjtLSO0CpOk3Tzs3VdS93tFz15As0KPeBH
         UPJ7XsSxHjHFbfU3clWqLaBu5DJoT+go9nASHDJLsIIUvm4cscKqWHqdTjyrvLVQbPsW
         LiSHRSxqkQpNj6t15AFHNOTC8jy+ckjaVKdloIB83XMyl6hKi02d1Js3e6kCUlsZRK4a
         WvMbpKsMfc3vqm3H/Ee0G8Lkc3dJSCDM6c3tKCCq/WXG1oKwVrALh2/fv9nq4ZpO3nO5
         7Wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XOZ9G7G9MWu3PapBqwm76MzTbTk7qh7g47mE4DOAzps=;
        b=G2hjY2w5MtXllEkBOBzyeedIuEJ32JZuVbni8VkmxXX+VwEs/pWx9G06lDS3tTu4sU
         FTd0f5wYRL8lDv7F2ousrlVzBHRb52ndHSOYVD8swa4suQGlHrrx7wp8hhjZKosMxEPx
         7V6Ih1JushVakJfNIg/MsbpQX3wjefPhMx3nkDiYlOxoQw/yMFHBAXsCjvbDcRQwOz2c
         U+V7yVwAUSlQmA4Vod1P+NajccdW3VbpQdea2+E3Mj2xAY8Vs1p4Ix+yxuRW7KNjh2ni
         4KETBGski6G2nRLNvP2eVpWOi8YfzZ0W5S5HZ85XfSF5nEq1oGbB8c+2QqqJZLgKZ8Jq
         owiA==
X-Gm-Message-State: APjAAAVxRhQGvfJ03QaRD6DJDxqc/gqqAsCBW4T1BUcQYLNkjDDfziM2
        oHEoQBX16q0y2d3g/+Pdmw0Yiw==
X-Google-Smtp-Source: APXvYqyPyCZkVkGyJylO/Z4gFXwGq95akjDrBPerrKkIdPHewT4cqgI0NrgE4gHZcdxk3CuDm2BYqw==
X-Received: by 2002:a1c:eb13:: with SMTP id j19mr33248298wmh.18.1567427696092;
        Mon, 02 Sep 2019 05:34:56 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id k9sm22645759wrd.7.2019.09.02.05.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 05:34:55 -0700 (PDT)
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
Subject: [RESEND PATCH v3 3/7] sh: ecovec24: don't set unused fields in platform data
Date:   Mon,  2 Sep 2019 14:34:40 +0200
Message-Id: <20190902123444.19924-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190902123444.19924-1-brgl@bgdev.pl>
References: <20190902123444.19924-1-brgl@bgdev.pl>
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

