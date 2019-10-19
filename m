Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2EDCA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 08:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8092920872
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 08:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KTrWMJfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfJSIgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 04:36:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43675 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbfJSIgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 04:36:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so3298398wrr.10
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 01:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YdPiqrMx4DGxjMQly7Bs8yH/i3WsBA2bl/JSPtLQAlU=;
        b=KTrWMJfcSsNsU/hInH+8etvSbXWxmCunj3myy9w3kenbKYKLPvPV2HXvi/9ONkNlby
         JlacPZ3LR4yVNif1PlgZpYgm6GvDWNCsxclVp+7fpsz9MlOznlaVrG9I85dnSyZcPjuK
         zZTZrKKoHTU/wnkEaBL9oEttLxsLvew/TtYzrVTXdL4dWZQ4NtjZyZq6UYkDskdNSgWP
         Aw7QdUQ0Pi9iYxj9wqB9guvcDwKlzlHqSbrPiqZ9iUULr1G+gvARZZTFhGNhXxAxkcXm
         EBhC3iFA9YN46vY/ako/Gp2L4ASzbDaTlcUsXZxo3XR04DIEVlIbKINwG1cLyh8dPg2u
         /HUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YdPiqrMx4DGxjMQly7Bs8yH/i3WsBA2bl/JSPtLQAlU=;
        b=GlssOG2oDsfnTgUygdjKWJFU9o8GCo1MSI3tf4QE8ffhPhpUlBq11Y/TFdv9YF6tVR
         0uJtT9XTdIFoBQx9OqvA0U+xGo1Nlo5ZbAnflKAjvGEFnSqNJwHAEVX4GBOrXRffLWrU
         KjX5tmBPioiXzomuGY5gNDrtk+LcWnd8M0JrhGPpEKwixekKeaLFkzIwyG11vNlPqDtI
         ONj1382jACWtL0gyyGUpLzzsWpnLb1JPbxtHoTM1EZKo9FzxK6mm2Zr5N4tAA4bmfYMD
         BhrQbjltVC9Fe2j2HZ8h7Va+omzrQDY2AQA5drWB8VUkUjiZ/yLGKSxv/TEFMegVTZpc
         kdUg==
X-Gm-Message-State: APjAAAVL7l/vh3kfQovZMFVR3QpMsHebspbhWZFaMuiSZ4KuHOQOmF1W
        8QAMhOfWkU1VlCH7SB3Kw31pWg==
X-Google-Smtp-Source: APXvYqyMb3UE4kvzJU/RtmQDyFjei6QR5gPK148b8ly3ekSY2I6LEvUTkS+/jEFISaVozTN+hXpUFA==
X-Received: by 2002:adf:c105:: with SMTP id r5mr4342828wre.125.1571474177563;
        Sat, 19 Oct 2019 01:36:17 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id u1sm7242627wmc.38.2019.10.19.01.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 01:36:17 -0700 (PDT)
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
Subject: [PATCH v6 6/9] sh: ecovec24: don't set unused fields in platform data
Date:   Sat, 19 Oct 2019 10:35:53 +0200
Message-Id: <20191019083556.19466-7-brgl@bgdev.pl>
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

