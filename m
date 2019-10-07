Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D80C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 03:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C61E21479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 03:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bZlGFSZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfJGDcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 23:32:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42158 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfJGDcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 23:32:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so6189731pls.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 20:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJb9zTJUFk5gt04WV606l1pH2Oso/m6U1KjJZ/jsQAQ=;
        b=bZlGFSZZDV/Cfp22DU/NgsaVo8wYUYI8yHknx+coDeipjtN9VtPDfxSY8zd2elzjXa
         Y/QzPRSOScAuDQp/IMJFwpSwC40pb1zcW8kXEe7fYxJCWYGS9yKxYaGuj93pRoiquK5Q
         aADQ/bgClY7XcmZdf5e8az+S9cDB4r8TO0kDoB5x1T5HoLfh2+Sp9sMZ6rZiMBMBvqf9
         +nQxtRD6ehrn7bTu8VeoWMlJApH8e/ve5A7RBTl78Qz/InuJYkrl5xvMoQmYAZK+CskA
         64Ogkzl4ist0WFjZ+VGhAYTYFLqSOTkH0t/NncBzxiZu/4gNEZkC7jbsaBgdp7uNk0PA
         0VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJb9zTJUFk5gt04WV606l1pH2Oso/m6U1KjJZ/jsQAQ=;
        b=T3M7OHEMZd8RcInbZ18iZiZ8Bn3DXZM/e/h7zv7GkvBlI1xUCiB9blSKTakvD9jG7k
         87Rv0/zTADZuIuqjJW94JZ8S6RrDzEpLZqcHqzljexzTnWjrNWbH7LfzLyrtsTWPkqba
         4/aK55biJb5+Sx4GCt6dTFYm0dPrZ2jR0+4ZeBD4ScDOKx1Jmy/jas2RAZL7C0Qx3fAp
         VyVtDSYJAv1lrKx62mj5x3SabUvL/4tuz2ysJLWuDt+Mj/5kLshUZMuaoQU9Y0s3oybP
         xM8PvYyjCYtPKcPowju5vqNE9Pr6ZWrRTuq93XDTNYQkfMZ5vlVwqM6AWKtPbJbrVzWJ
         V/PQ==
X-Gm-Message-State: APjAAAUSqi2oXBN+csQdSwjSY8+YIFmLgJaFYXL/8Vu9v3qB8/OVn3H0
        ax8KMxNc6pOqBY7vlvtZIrJYRg==
X-Google-Smtp-Source: APXvYqyMJpRgbsk8LYwFFeym3A3ODf7oVSr8gKY6I9NTk6wL5VBDQB09tM4CGa5DcdvslC6UztiJAA==
X-Received: by 2002:a17:902:36a:: with SMTP id 97mr27459476pld.61.1570419129714;
        Sun, 06 Oct 2019 20:32:09 -0700 (PDT)
Received: from debian-brgl.local (96-95-220-76-static.hfc.comcastbusiness.net. [96.95.220.76])
        by smtp.gmail.com with ESMTPSA id x10sm16377720pfr.44.2019.10.06.20.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 20:32:09 -0700 (PDT)
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
Subject: [PATCH v5 5/7] backlight: gpio: remove unused fields from platform data
Date:   Mon,  7 Oct 2019 05:31:58 +0200
Message-Id: <20191007033200.13443-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007033200.13443-1-brgl@bgdev.pl>
References: <20191007033200.13443-1-brgl@bgdev.pl>
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

