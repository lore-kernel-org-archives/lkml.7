Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD94C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B982190F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TsqapSCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfGVPDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:03:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43415 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfGVPDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:03:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so39751333wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdufiTePFKOcw3PXCBBvJkARSPrI+OCusBaTYJELEjQ=;
        b=TsqapSCFfaQBoVbpHKI/m+obmflr41GlOM1rPFV007j2Zv7OerhmRuJG21pozO+P1A
         jTOHiU/zOVdxrV2v/bG8njldvSpnDW/pU1d6WXmgBNL+ZAnPJupgIR2OUZFCHmVY5JRO
         NC6gJyFpSSdFodmwdDchaBFsttM8pha0dZkeDgf/TnHgkD16mDRERvJpAH/bTYE0OjoE
         VlXyqbWGtjvdZfwHscynD/iZnEqcFwQZhNU5rNIDzLMje3EkV/XxY8ZMvwv/X28jazwS
         NBASzJ6jmaUrYhaiWMIHR1bEPDSX8z4JsW9XGg0EN2DqxVK3oKAYiXwjq+EHr1zxllVK
         pNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdufiTePFKOcw3PXCBBvJkARSPrI+OCusBaTYJELEjQ=;
        b=sUu/qpu57aadW/ai1xpCG5oUnd5DjRc34+2/YLbaZXvqd5LPwbW4Z1R9medGW3LE3B
         BBLhNwoQLXKwomsoRQI5HJrAt9OaDeVvcaVDWvT2dSKtECjUCECmA/h2rkUvwAcbD/1y
         ODCK2WB270zGLswoaz6p+0LPd/4rWP0DXzwSSzIewZ2/kNUuEWaRPUezCf/cvGzRK5x1
         jb4isu9eyOughLlc364pn+q64b5bE14HzXIS1aXcw+o3Ig3McrzW6CuiaorWjsDn3FHP
         LHoYDeATC0J4PydnPxUvpf24lE/VK33Tx7pOEphRmOb27jvPqvPmVZhq6w8404wmjYoK
         6Yrw==
X-Gm-Message-State: APjAAAUNeG/UJVLlPrOAOFcvjxEbi6aFm5pBAKeJlz69GUOAcEYui3Xx
        /m2DWpKvty1glFlk6k2DQlU=
X-Google-Smtp-Source: APXvYqwoKpD/MpcmzIu1lOX2+THt1HzZrurirW2Y9G174HfbVtdYjcEwBdY78NR/Z3UWvwPmL5JvNA==
X-Received: by 2002:a5d:5303:: with SMTP id e3mr60089734wrv.239.1563807795684;
        Mon, 22 Jul 2019 08:03:15 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id v23sm36310460wmj.32.2019.07.22.08.03.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 08:03:15 -0700 (PDT)
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
Subject: [PATCH v2 0/7] backlight: gpio: simplify the driver
Date:   Mon, 22 Jul 2019 17:02:55 +0200
Message-Id: <20190722150302.29526-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
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

Bartosz Golaszewski (7):
  sh: ecovec24: add additional properties to the backlight device
  backlight: gpio: simplify the platform data handling
  sh: ecovec24: don't set unused fields in platform data
  backlight: gpio: remove unused fields from platform data
  backlight: gpio: remove dev from struct gpio_backlight
  backlight: gpio: remove def_value from struct gpio_backlight
  backlight: gpio: use a helper variable for &pdev->dev

 arch/sh/boards/mach-ecovec24/setup.c         | 33 ++++++--
 drivers/video/backlight/gpio_backlight.c     | 87 ++++++--------------
 include/linux/platform_data/gpio_backlight.h |  3 -
 3 files changed, 48 insertions(+), 75 deletions(-)

-- 
2.21.0

