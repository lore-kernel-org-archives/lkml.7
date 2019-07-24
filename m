Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB38C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0925229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yS/fpv0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfGXIZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:25:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44566 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfGXIZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:25:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so45902223wrf.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtfVe2y0PV6JCnkWUgt29BFtDKrtsJ9asmKj1fX6iHM=;
        b=yS/fpv0lDg7cmmGiJlJuxWZDC7FTLbDacrHOf0iRdHeUNwswrCSddeVLBE4fTzDSh7
         Crlc8kCfIK9TKMmhBMLM1skpv9wTY7ZUenyFTibdYFbmNnH8OgZrxnSyIr+LnOLjf5GK
         iXdZ3gpPL2+YgwVWFQdaV3jQ7WP+5WionDivvwBsxj0D6JBVtrl8nolAO6STna0u8qXS
         XWm2eCsu8ikm2EnIFJSbRkXkIiWr1WSUG+j8I839mzmKDW9ZrJZYzrKh9efeK2HUtUSR
         6e5GIkzyc17iGtczLzfFbKCqD8HeRDPzb6a8BUuQOYcjOq/wKTn9VuuyZnWMBhrnvetc
         +hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtfVe2y0PV6JCnkWUgt29BFtDKrtsJ9asmKj1fX6iHM=;
        b=mR51cg8pQ6NXWssJFKWk0dmsG9VYdnzQCt6o/izjgAQuSZQaWJdIQWk9U2T5MLhx4Q
         chLJgdHQ/RVp9gMirC2u53QDnn1xhzze9snzW3awpzdB69Ninztjp0razXxKncF/PFcK
         wOeZ7LahWCU5kUeChnujV3BP5g5UEVjVg7Ql4SW2OzFGZZnfdT4zllXBg+esTpQRhwYB
         +IcjzBJWgAgyOykRtLzCtDdS2o4Oz1Mlp7L618HoiqFraD7bdpr6Wd/LHMWUGIDFisYx
         DPRP6GW7tTUDPqa/VF2pWHppr7hq3laxEOSneddpPlHqHYVVkSfFT3GE+p0P3zGUg62B
         TD/g==
X-Gm-Message-State: APjAAAVVdT0kKXxhLMI9dQ88cg49xHmekyjpgM1kyTUUulcgi/I0w0xr
        +vbS+IM2ewlaXLweMGqrpNw=
X-Google-Smtp-Source: APXvYqwpDOFg0SMrkMrSkLYjQMLQnQYz0BaTUXKeEAnLvEP5ghElBAxYipQ0U+HL2Q/1CRGgVkParw==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr47444184wrr.5.1563956712658;
        Wed, 24 Jul 2019 01:25:12 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id z7sm42393880wrh.67.2019.07.24.01.25.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 01:25:12 -0700 (PDT)
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
Subject: [PATCH v3 0/7] backlight: gpio: simplify the driver
Date:   Wed, 24 Jul 2019 10:25:01 +0200
Message-Id: <20190724082508.27617-1-brgl@bgdev.pl>
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

v2 -> v3:
- in patch 7/7: used initializers to set values for pdata and dev local vars

Bartosz Golaszewski (7):
  sh: ecovec24: add additional properties to the backlight device
  backlight: gpio: simplify the platform data handling
  sh: ecovec24: don't set unused fields in platform data
  backlight: gpio: remove unused fields from platform data
  backlight: gpio: remove dev from struct gpio_backlight
  backlight: gpio: remove def_value from struct gpio_backlight
  backlight: gpio: use a helper variable for &pdev->dev

 arch/sh/boards/mach-ecovec24/setup.c         | 33 ++++++--
 drivers/video/backlight/gpio_backlight.c     | 82 +++++---------------
 include/linux/platform_data/gpio_backlight.h |  3 -
 3 files changed, 44 insertions(+), 74 deletions(-)

-- 
2.21.0

