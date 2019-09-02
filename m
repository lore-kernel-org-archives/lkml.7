Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297E3C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0146721881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="RiF6eugg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbfIBMfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:35:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53673 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731738AbfIBMe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:34:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id q19so5600921wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 05:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bHnB1L+P4+1aGMlVqMp08Ixue8e2E9v91GNi38QqZ9c=;
        b=RiF6eugg6V5iUB4obVg0sR7cypt5WU9YOMFriMux45aF+xW0zjazRTUXDi8WQsm1NS
         cprxfuxAqEy1Vi9GNJuDxtyOJDs3NxNE7C9s+QOaAzCiVDn2YZrr63DziJcnmI8NAv6z
         CuhKqFsWHUkId5jp1hhvWrNPeh89aSuhuLHbvxngPoxOuZPuhkBFz3kpHI3Jg0qgWfoc
         u8WqJ+8E8Y7kDB7zjnn4AFUOKg32D33j+AOOEfYjKVQeir7zocUMw1Wf9W8dQZVBlkyG
         zfDL4DzrWaWUq8JzI6ZajlZ06ZiDjw88IY5cycMsHkilxMazzMWK6wmmV/gSarzR6D2b
         kETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHnB1L+P4+1aGMlVqMp08Ixue8e2E9v91GNi38QqZ9c=;
        b=Racm0698MWhO8KRAWSIo5kGb+BwNEPos+37HFJFh1Ku17SZxX2jkUoCRx0zOUhxdsZ
         dWZYQMnexAG/ZPNLz/txPxLf821dHTeCdjzYQ8Ti9sAYJ8yRIgdDMzrqiOFro9s2I51G
         TLMJyULAmV+4CWnlMb5InPpE9fDdwoBREwo5DYi2spogcK6vRRQ66jPTpoaZeIVQL4EY
         hYwVFPciIPwcDQpSu2ZetBv9qZtzl7c9x0qN80x3CJTXIejHmq9Ydi43cTlh70Lw/NTK
         9MSv4bVtdMwruSz3dQNOOk9V4KQJ+ACp4pmvuChBQrM/dkZS2IGBmdRuLO/LW/9Gx3sB
         JdtA==
X-Gm-Message-State: APjAAAV0V9BuxNtY6TBXJoptLnAHIG7+Cqsg15VvfhrfkfhuLvl80z1U
        9JRt5tOXs/NCc+7vIvb062EK0Q==
X-Google-Smtp-Source: APXvYqwFfCqx6lY10v5xazk7iXImJ1ceSZ7J4x9MKHeaOck5dr4/AvcHY1Tlp222xnKOcnKqL+InVA==
X-Received: by 2002:a1c:7513:: with SMTP id o19mr34854600wmc.126.1567427697250;
        Mon, 02 Sep 2019 05:34:57 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id k9sm22645759wrd.7.2019.09.02.05.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 05:34:56 -0700 (PDT)
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
Subject: [RESEND PATCH v3 4/7] backlight: gpio: remove unused fields from platform data
Date:   Mon,  2 Sep 2019 14:34:41 +0200
Message-Id: <20190902123444.19924-5-brgl@bgdev.pl>
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
2.21.0

