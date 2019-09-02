Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9400C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C213A2168B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pVkk4EQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbfIBMez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:34:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37216 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730165AbfIBMex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:34:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id d16so14427201wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 05:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtfVe2y0PV6JCnkWUgt29BFtDKrtsJ9asmKj1fX6iHM=;
        b=pVkk4EQb8Rw026QE2F67s/FRBhwcF2RyAloU19aASKmT4dLQntoYwfHzxQIV3lDTlX
         J2UPXFD2FdccyDHwI9GOSoMmWyKK6AWhN6uJu6eBjE9aq51c03XadnQfVpnCbnNsk4Pq
         Re8CdR5aYt1pqNEFBLX7O4Moo6VmqLxp/bu0REWCEuoPLedggkakQpNbB+m2zXBae4hd
         flGcAQIcc9FgyB3wsG4o+RhkuyJHlpVoaM+swKs0Zjxs27c/6T6SnaQ5wHSIn9/9E9h8
         WdgXWvWlzbDhxolhuq+K5d4TvZYiuFKKCjxnIXK3nv/yQrvryc5SByyykXN9SPHDVF65
         mUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtfVe2y0PV6JCnkWUgt29BFtDKrtsJ9asmKj1fX6iHM=;
        b=UaFDnlgUS+AxgsLdVZ/r7M7jD0VKUjyCDNq29d/7443nJu9GRKfcP/YvGbODl6TR3Z
         eTf7UfQUV1RhtmrbI91srxEsKfGUizZeqTSR5DbVJQUZKZ5rOaSPSfMPT5BxtMFWq72F
         m7yhheZj8lBAcAnUqPmPmASC1iieQv8f5M8SloOdurDvCYvVPgU3cfh+UxAmEzgOqr4L
         8/DSecw2qJ2lIfvj9+hojfdHC93PboXEo6usqjp/Kois0jiC92yF5TwXB4HVtPCkJpw7
         lA8iS4ixNISmp7sZTsSIGVpN1QSdJU5fxpXLCznAFLdJM/sKUEeTeF4pa88maYElwn9l
         whsQ==
X-Gm-Message-State: APjAAAWjiss3NpRddX74NF98sNtSOqKE9d8Z7Ff/YQ65wN/4EOE23+7+
        H8il/mynmOCsWthKZsiQnCEqVg==
X-Google-Smtp-Source: APXvYqyrnPWYmmZIE808s52Grv7xJXO5wACPj/78PCA7WIfz+B6gplbNIrHaV5BnZvS7GkbDFMpz5A==
X-Received: by 2002:a1c:7513:: with SMTP id o19mr34854254wmc.126.1567427691708;
        Mon, 02 Sep 2019 05:34:51 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id k9sm22645759wrd.7.2019.09.02.05.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 05:34:50 -0700 (PDT)
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
Subject: [RESEND PATCH v3 0/7] backlight: gpio: simplify the driver
Date:   Mon,  2 Sep 2019 14:34:37 +0200
Message-Id: <20190902123444.19924-1-brgl@bgdev.pl>
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

