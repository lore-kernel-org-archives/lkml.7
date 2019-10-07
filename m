Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3299CC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 03:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A8E2133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 03:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="edi7NYtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfJGDcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 23:32:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36079 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfJGDcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 23:32:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so7752410pfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 20:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XXUGs3TD/mQ9EDaZ43OuKw31dOCYSa+NG57KsS4H5LI=;
        b=edi7NYtYkiqE1uOWeL+U87Ck5mZpITswFODSgMcBAtpM60H+NcmQ1P13TeUemB2tXb
         nYWc7NXa2Rygyfr0y+T+T6F/VX/YcYhwJX+hIjXFAxA8pv3CNNRtzGAYoje6QugPsHgW
         7f8J7IIc8ejfyyLdcO4inN5wtPcu/z7VdbEHq9yvGW3on1vSaNYWpqxFWSVJhJUpvlVu
         jNDWGewuuI45w5ms+ZPxtc5MHS2i/2ehOYqGySiFBXVOb3KMy9aSruKofSgiOehdlH1F
         PR3LajUBOwTC7I5nYpXz+9X6zPjE5V7Qrh6z9DBAFH+HjVolLxiJbfAn1FVYsHHgLIz/
         9JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XXUGs3TD/mQ9EDaZ43OuKw31dOCYSa+NG57KsS4H5LI=;
        b=ox8JO82Clu7ljXI40k+tTJZjFy2cXVj2qgshRjBplTQA8yMIKxyIxp96MmYfMys3lS
         TTTDJ5BPpeaMBWozx3fafL5fS3Sdnuq6cqd0ra3t9PlEKFHmPyd62hcRHeseudhGFJ4k
         E/KoJAsAxu1NS3E/Gu/DMAfhGnx3UwiLmJMdAoj9GmgXzP511SNytXoj9Mp5grs3ROrp
         thSBxrfVbu9Yf+D/Ue8tvynkPeUpoE/2k59oYllB8UIPE2NxEIdxZ2/1m/NNUEFMY1Th
         UC2SjvYm/i3MnMpIl/pXMHkdLRY+RaQBeIKp143lJqpBklOdXX7pVym6UqkvqEyoBhKx
         RCqQ==
X-Gm-Message-State: APjAAAVkOerLlFVLefyg8ft3zc2MDmoZSkz7T0dHzMhegnpa2Y7ep4Gu
        R7TKp1EV2QhbuKubTzCCYEm4QA==
X-Google-Smtp-Source: APXvYqwD1Ahm73jrBPcdOwtpwjSteXXDBGfgtBkjwZk7/DaYkZiI+mMtwaDZj10mJprtCxD4b2Gkfw==
X-Received: by 2002:a63:1915:: with SMTP id z21mr5731158pgl.343.1570419124423;
        Sun, 06 Oct 2019 20:32:04 -0700 (PDT)
Received: from debian-brgl.local (96-95-220-76-static.hfc.comcastbusiness.net. [96.95.220.76])
        by smtp.gmail.com with ESMTPSA id x10sm16377720pfr.44.2019.10.06.20.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 20:32:04 -0700 (PDT)
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
Subject: [PATCH v5 1/7] backlight: gpio: remove unneeded include
Date:   Mon,  7 Oct 2019 05:31:54 +0200
Message-Id: <20191007033200.13443-2-brgl@bgdev.pl>
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

We no longer use any symbols from of_gpio.h. Remove this include.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/gpio_backlight.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 18e053e4716c..7e1990199fae 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -12,7 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_data/gpio_backlight.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
-- 
2.23.0

