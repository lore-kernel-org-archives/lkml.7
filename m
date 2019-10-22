Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B1DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB0021929
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OVaxqkiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388362AbfJVIgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:36:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40539 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731244AbfJVIgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:36:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so15249691wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lPnRL6NpoSqZohNp9zgeBMxysYnhgrlrtuMJ1IcmiO4=;
        b=OVaxqkiV3r66rCJJ/etx7RcDaFZpH+qujz5COsDg5e2kyosZzs1ammXKSMfEvWjVqo
         5LUTARizfYH78ZKf1AjSkhJ0vaerruSVrLdmnWd1/zJHjTY+TRrXeiUYXKp+Mh0NSrpJ
         ieQMAoZO59R40dcP9klGlFS/jeZ5AHtdTzMf7i1wsVdXIYsmQEad9sLN2lqxuSfVkAHT
         jtFE85+X8jX1kAEtQ7n4IB0VXYKse0OXHrwGcPpbLaoY7Ofm1rbcAqCXB0uErCYA/D0a
         HZJjTK9CEXfvyAbhVNTtWRYxSdiyGshcerExV5YXr8ylFkySuMNC1oQV/N5DrJWJZmHD
         ycUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lPnRL6NpoSqZohNp9zgeBMxysYnhgrlrtuMJ1IcmiO4=;
        b=DAeNwwfbdeNsI7Bhki131GlQL3xcW+4CG7UNAHFSCWnPfEgtP436guc8kfAf0398JW
         ALSl5bOMrbVTS/5m6VvGmiBag8p6I7hV4iQIkoBbru2n4jkqZj0BbRrev8SnYGM0iM4t
         eyYhX3OX/m2EqBEh3JLQQmtSOhaf7/fLIDXaFjjSbfULOT41i7ZKB9/iNgjLmO4IeRMa
         c1s3FnYIlNbUYzyRtoZ+iIprhxGWVS0/876f/uUIt0qMpIWlBTOgFC1Ao21scBjlMT4Z
         F+C0AZA57INnHzZQJRIegzpwfuXv+eCrjQbLdWcwLQ46sMK/uFK556TJc2v2nU96dupC
         23GQ==
X-Gm-Message-State: APjAAAUD1YRWXR/orH1e7r6BRCkfKFtbUlhTvwk458fy4wVe4J2FWaaf
        DTiFHPYL2Hp3pOnYRWVQyK+7Xw==
X-Google-Smtp-Source: APXvYqwin7FI5BQUaoLOJ1m7zw/wr3yxBZOmxIPUtoJU2kMR7WARJaTrWbmN83nJqNw4l2Y2RU1QXA==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr1901269wms.166.1571733396580;
        Tue, 22 Oct 2019 01:36:36 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id g17sm17115253wrq.58.2019.10.22.01.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 01:36:36 -0700 (PDT)
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
Subject: [PATCH v7 0/9] backlight: gpio: simplify the driver
Date:   Tue, 22 Oct 2019 10:36:21 +0200
Message-Id: <20191022083630.28175-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

While working on my other series related to gpio-backlight[1] I noticed
that we could simplify the driver if we made the only user of platform
data use GPIO lookups and device properties. This series tries to do
that.

First two patches contain minor fixes. Third patch makes the driver
explicitly drive the GPIO line. Fourth patch adds all necessary data
structures to ecovec24. Patch 5/9 unifies much of the code for both
pdata and non-pdata cases. Patches 6-7/9 remove unused platform data
fields. Last two patches contain additional improvements for the GPIO
backlight driver while we're already modifying it.

I don't have access to this HW but hopefully this works. Only compile
tested.

[1] https://lkml.org/lkml/2019/6/25/900

v1 -> v2:
- rebased on top of v5.3-rc1 and adjusted to the recent changes from Andy
- added additional two patches with minor improvements

v2 -> v3:
- in patch 7/7: used initializers to set values for pdata and dev local vars

v3 -> v4:
- rebased on top of v5.4-rc1
- removed changes that are no longer relevant after commit ec665b756e6f
  ("backlight: gpio-backlight: Correct initial power state handling")
- added patch 7/7

v4 -> v5:
- in patch 7/7: added a comment replacing the name of the function being
  pulled into probe()

v5 -> v6:
- added a patch making the driver explicitly set the direction of the GPIO
  to output
- added a patch removing a redundant newline

v6 -> v7:
- renamed the function calculating the new GPIO value for status update
- collected more tags

Bartosz Golaszewski (9):
  backlight: gpio: remove unneeded include
  backlight: gpio: remove stray newline
  backlight: gpio: explicitly set the direction of the GPIO
  sh: ecovec24: add additional properties to the backlight device
  backlight: gpio: simplify the platform data handling
  sh: ecovec24: don't set unused fields in platform data
  backlight: gpio: remove unused fields from platform data
  backlight: gpio: use a helper variable for &pdev->dev
  backlight: gpio: pull gpio_backlight_initial_power_state() into probe

 arch/sh/boards/mach-ecovec24/setup.c         |  33 +++--
 drivers/video/backlight/gpio_backlight.c     | 128 +++++++------------
 include/linux/platform_data/gpio_backlight.h |   3 -
 3 files changed, 69 insertions(+), 95 deletions(-)

-- 
2.23.0

