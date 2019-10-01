Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28179ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F393621872
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="e9zGUWIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388255AbfJAM7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:59:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52806 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388177AbfJAM7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:59:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id r19so3283880wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJb9zTJUFk5gt04WV606l1pH2Oso/m6U1KjJZ/jsQAQ=;
        b=e9zGUWIrAnJPy7zH0daodOP5A42zAKpfk3GklS6/uyW//JHY97R6fivbB05Og7UESK
         R/GXudS+cvP2/5BCo4x9qcTL28BstxtkktdGb/3tZ2mdkkbGnvqCsDwQOOIelgQhu9Ih
         d5d2HJAlG/EumY3UKQfSq+sRYWnkagCW/7aXxVpKXqK8LSsB0JZzFK8LVAfT71uCZDcq
         z/3J9sVzHso1zUyb3BkDZWMm3tG68KtHujqJDJ3d3KP3SBnKewioZIDESV1KDXNMvAsA
         fTB+yIY5M6/HUyWQ2VSsNCESU/S1G6xrp/pYkpI9bT5cKloypooIngT/0BxatlIhcsDY
         w+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJb9zTJUFk5gt04WV606l1pH2Oso/m6U1KjJZ/jsQAQ=;
        b=LXZ2SZEllGY+YPUazIpFwJporQUKKiGURicdBPjsHDzf7ve6QP+9Y99A15CA2dkJ6X
         cVzHoI91onph4lF4lJkhqEjI5U871UdDdp7OTt8KyPvf2cXYdrw5FdnedBQnR298NKt+
         ZWeJuYG39OoeFr1h7GvzpiQAGmm08gxRiGI4QZQbjs4rw1GphVynvERkntSm+YWxSpfX
         96fSWO9Y6z7S8DVdrR4qQGU+xLLnDDLLEgGU2imxq2H1K3DLdNfzwHWxhWJ++D8iN6fN
         jElSRBAzjfMf4NLVtNGALVxZy4E3GY/lYfTCnEWQ74cj+2zf5WfdSBmh/aSFuyWAkdbv
         sTMg==
X-Gm-Message-State: APjAAAXzCv9xB1g3YQamCP/QuYmHpMe9VpLRnonYNZwvixAuBQ0zT5AN
        LjyYVW/l5kxRDADONHwcLtOAlA==
X-Google-Smtp-Source: APXvYqy3/DmZXqN3YFKLxvkfXEQz4vfrJsXzpQUD3G3jaeUG/Y4mWtb+jhRmWonqX1buJ2udxNd/xQ==
X-Received: by 2002:a1c:9d52:: with SMTP id g79mr3474322wme.91.1569934770925;
        Tue, 01 Oct 2019 05:59:30 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id 3sm3561400wmo.22.2019.10.01.05.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 05:59:30 -0700 (PDT)
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
Subject: [PATCH v4 5/7] backlight: gpio: remove unused fields from platform data
Date:   Tue,  1 Oct 2019 14:58:35 +0200
Message-Id: <20191001125837.4472-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001125837.4472-1-brgl@bgdev.pl>
References: <20191001125837.4472-1-brgl@bgdev.pl>
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

