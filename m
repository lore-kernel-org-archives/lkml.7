Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C13BC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 03:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C44920862
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 03:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KpBM+zmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfJGDcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 23:32:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40640 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfJGDcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 23:32:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id d26so7327277pgl.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 20:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m6ZVj+HV49loAv95ReQOh5GSunOnE35wX2Bc+0q93oo=;
        b=KpBM+zmvrOzbdWsfbpdXfUOh/HlwxVlM6JtPhdxdQrGG/iNat1s44Xk1dIe5G0yytN
         g4uFYUJgcL/7ZzJwYBoBSxbzLFp1yUnec+Kny7Hh9U0uLRzHbCgQ1JisnLiswN2gc5KV
         uWItlqydSYWsSq6Bfpsfzu9YC5jWFxlOelQ4GueEHJkh+czXgYhKgiYvDM0mMVsRgkXu
         9rm2kFk2xxohwng1/1LGytYCrVv7SpCWybwGabJEkzbE2+w5xiJQCpuU5Qy5ywjhif9l
         aAYdY0MmHol877lte5vNPlPFhXptGVMnqp1pXpQ37tF8TGcxxvOs7VAB08YCFBw63bvU
         jpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m6ZVj+HV49loAv95ReQOh5GSunOnE35wX2Bc+0q93oo=;
        b=eoVnXRuxPZP89hGdddsCzyXgCqoXyZubQTV6Rfn+a2NGtERJ8kSgclzx96FFBtFhls
         lOOFo/qDZH4pFvs2+rK7P6b43awToieCjEnu1Rrj0kT8uWEwf5vg1pOff5Nk+xhCqnzg
         fA9h1y/36jQzSKY5wcHHWGDQ2EjblffUfcX7MXhToGVvO+8WSKbLrxgsxhFof6S8lsph
         5EB9QmmWCKH+D6Wsn82dnnkK8oB2MPyiC+b9m/YzBRC3iIPWTIkXiUZ00LiSbkz/IA9N
         Y97KH/rrjwWxlyD1KBbm/mwfavrUmLPvMmCVMK9n+Iui+6LF0k6IuUYlwGj9x2yrh8gi
         LMww==
X-Gm-Message-State: APjAAAWRnKWTNbv8zfhcfDxVVSTgKEUbXQAofzJ47R/ukpTK7OXFkPEs
        DwMuyPr/OzVu3rIokSFu+c9mnQ==
X-Google-Smtp-Source: APXvYqzOOwyanRyMiJGsVbmq0P686Fa+QDrzb4QYm1IDHlrNgzTjC4nRJtm6F85fOzT8iD4OWtQP0g==
X-Received: by 2002:a17:90a:3387:: with SMTP id n7mr29905561pjb.26.1570419123161;
        Sun, 06 Oct 2019 20:32:03 -0700 (PDT)
Received: from debian-brgl.local (96-95-220-76-static.hfc.comcastbusiness.net. [96.95.220.76])
        by smtp.gmail.com with ESMTPSA id x10sm16377720pfr.44.2019.10.06.20.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 20:32:02 -0700 (PDT)
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
Subject: [PATCH v5 0/7] backlight: gpio: simplify the driver
Date:   Mon,  7 Oct 2019 05:31:53 +0200
Message-Id: <20191007033200.13443-1-brgl@bgdev.pl>
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

The first patch adds all necessary data structures to ecovec24. Patch
2/7 unifies much of the code for both pdata and non-pdata cases. Patches
3-4/7 remove unused platform data fields. Last three patches contain
additional improvements for the GPIO backlight driver while we're already
modifying it.

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

v4 ->V5:
- in patch 7/7: added a comment replacing the name of the function being
  pulled into probe()

Bartosz Golaszewski (7):
  backlight: gpio: remove unneeded include
  sh: ecovec24: add additional properties to the backlight device
  backlight: gpio: simplify the platform data handling
  sh: ecovec24: don't set unused fields in platform data
  backlight: gpio: remove unused fields from platform data
  backlight: gpio: use a helper variable for &pdev->dev
  backlight: gpio: pull gpio_backlight_initial_power_state() into probe

 arch/sh/boards/mach-ecovec24/setup.c         |  33 ++++--
 drivers/video/backlight/gpio_backlight.c     | 108 +++++--------------
 include/linux/platform_data/gpio_backlight.h |   3 -
 3 files changed, 53 insertions(+), 91 deletions(-)

-- 
2.23.0

