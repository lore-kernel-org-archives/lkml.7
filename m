Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B53ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CAB21872
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rZwtI0mZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388191AbfJAM7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:59:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55115 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732272AbfJAM72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:59:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so3274063wmp.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 05:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OU2bh+kVbPH2QOESllwlntXEadkasZXlFhA24tJCYMc=;
        b=rZwtI0mZre9T+U1FCWCcvcEBN85L3YXBKHzWkcFPGHcFAeM3WYEdwywJEKfA7rfFk/
         7Hfu9B48gxfbPWbmoY1voarlphxyl2u5YfnAxoOM1ZLF+VcqOqh6AcxM/2O3RSvEHSLF
         4rC2yzROzddoadVAXP+KAIYdyCxB4OBCVnMmH7F/bBFh/QWaqcQGY3iHqq0YpN/yEM4X
         SB2DlNqTIjDqR8g1WMR9vhTqPSeY5n2nbSV7tuUxYhJTJZ31nr7dHQmLnLtjQtMSm/Fg
         Cu9tJYKtjLO4SSHmxYjO2YxLREkDXzQe5+wkRkggXqXmvm9CVar6d7cDED/jfgvNPNTq
         nbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OU2bh+kVbPH2QOESllwlntXEadkasZXlFhA24tJCYMc=;
        b=RgZ3Kt+wLS/+YlK/F69N3hANTKIum6HYJVwicZQhlVVpRU9ALUL4ahzVBooR2p7r9X
         99gYSHT9yxe/zk0FxjZ4v4tWGJFIjM67t3NckOc9CULLA6ExUqidPlAXPg7mdj3fVG5Z
         Vl/jepK8XcmKPJQ3Kc7EVEA8Ik/QS5Qe7t4YvFHedWo5kJoziGsb25nm3kSBzTXg7vQl
         CjPuZ2tZHrPvGsupXarDwUwK5KmuBhYnoTkw8BPezsKJQlb86YI/SadhTSRSSA4H77yb
         kSf1Q8eCyHpCnNxZ5FIVS9SFoXGrt0HO32j9zeARszA2aaZdjdxVNMGNJhQv2gRPiSD8
         J1aA==
X-Gm-Message-State: APjAAAW3O91txSSStW0R2y4lyRWBX3QaeXlpju2HHOi75fgGaZMNKHEW
        aafL3dhQWkd53J7mBDCe51D+/g==
X-Google-Smtp-Source: APXvYqx1Kr64Tj6Qz4cblkoPu+gaNwnWELKZxN/qXd6/fHiNvyOllFG948GDKWDssvQCyIjl5kMnvw==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr3594002wmc.141.1569934766193;
        Tue, 01 Oct 2019 05:59:26 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id 3sm3561400wmo.22.2019.10.01.05.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 05:59:25 -0700 (PDT)
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
Subject: [PATCH v4 1/7] backlight: gpio: remove unneeded include
Date:   Tue,  1 Oct 2019 14:58:31 +0200
Message-Id: <20191001125837.4472-2-brgl@bgdev.pl>
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

We no longer use any symbols from of_gpio.h. Remove this include.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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

