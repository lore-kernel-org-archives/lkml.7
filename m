Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86477C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B8E20657
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="E4/h8Faq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfH2OiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:38:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35503 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfH2OiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:38:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id g7so3721292wrx.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lE7XX75yR5MTUDt0RcCW0PjxA1AwFACxE3fSvtSieZk=;
        b=E4/h8FaqQxHIPE+lyWVoIiYaohjVmxyJxNjhr4mVE7ydU3eFRBaO9bDcFmwHHHMLGe
         UhpMU1eioTe76W/DMfVRPPx+cb/2aWPv9oYfhfbJwczs1UWdoreCBFRDfCNCmip7kvR2
         TN3pvj/DhTphU4WkfTRgTNz11/2jlBnOct2Nx++ItR4D+woDSwGkZkFMwHzJHWW/OLVo
         JFJfQ+3Efv/Hat8DK7BZEeFNtQdxE2h2kpmjqbmpJvI/GqfWOaepSxqBPHU4ekzDZvn1
         u7YIbw+QuGgZksaApBzGRgYxAHtwqeO4hfoIOK/is0s+ZUVkR2f/9n1ShZzWkWOel1Ic
         gfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lE7XX75yR5MTUDt0RcCW0PjxA1AwFACxE3fSvtSieZk=;
        b=LsQV1S0ysnML2a4yeaUJXXD+Jl9OfZxOJ2cFamHFhCE8MFXxRRRGqRWuBJzkTg7sGo
         76xF1jPNzPi7VrhrbG1rz1zZ/YkRzzWIhQ3B//7KDGL2ol2BnddJeb8abulN6oXMqVQF
         em3BrBe+fetFia+ZJRPyLQSmq2jrPNAbUtrEF8AQfnpFEtmcVtiscKRAmtL6Dv4jBnyT
         xjC1ZiqpiZTaSq3rNkm0ONbRIISly5fhvpFKFMIBOuxPj/hwpmaidESUcsCKdgRnI9BG
         t8AanzKGkJJwYGNb4njUH7ZvWoO49Nz+tazY7WrcGi43pxbFH8geUGwXpPiHiyRu7w9Y
         QtdA==
X-Gm-Message-State: APjAAAWH2zgeJ9a6WfHJ++y1/eXj6iazj6qUdCIXCr1fbmHNYUy0rVSc
        WLZZVJD9H/iyX7viZlTLZxcLTg==
X-Google-Smtp-Source: APXvYqxDQrS8AALyEx0kI8uwCK17C4j0Sj65Wf212UqhAKwMPXuCpKUGz6RWY5RQSygoujaEeX7r/Q==
X-Received: by 2002:a5d:6446:: with SMTP id d6mr11636659wrw.159.1567089483908;
        Thu, 29 Aug 2019 07:38:03 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id g15sm3241925wrp.29.2019.08.29.07.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 07:38:03 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Alban Bedel <albeu@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/9] drivers: add new variants of devm_platform_ioremap_resource()
Date:   Thu, 29 Aug 2019 16:37:33 +0200
Message-Id: <20190829143742.24726-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The new devm_platform_ioremap_resource() helper has now been widely
adopted and used in many drivers. Users of nocache and write-combined
ioremap() variants could profit from the same code shrinkage. This
series provides two new versions of devm_platform_ioremap_resource()
and uses it in a few example drivers with the assumption that - just
like was the case previously - a coccinelle script will be developed
to ease the transition for others.

Bartosz Golaszewski (9):
  Documentation: devres: add missing entry for
    devm_platform_ioremap_resource()
  lib: devres: prepare devm_ioremap_resource() for more variants
  lib: devres: provide new variants for devm_ioremap_resource()
  drivers: provide new variants of devm_platform_ioremap_resource()
  gpio: em: use devm_platform_ioremap_resource_nocache()
  gpio: ath79: use devm_platform_ioremap_resource_nocache()
  gpio: htc-egpio: use devm_platform_ioremap_resource_nocache()
  gpio: xgene: use devm_platform_ioremap_resource_nocache()
  misc: sram: use devm_platform_ioremap_resource_wc()

 .../driver-api/driver-model/devres.rst        |  5 ++
 drivers/base/platform.c                       | 70 +++++++++++++++--
 drivers/gpio/gpio-ath79.c                     | 10 +--
 drivers/gpio/gpio-em.c                        | 22 +++---
 drivers/gpio/gpio-htc-egpio.c                 | 13 ++--
 drivers/gpio/gpio-xgene.c                     | 14 +---
 drivers/misc/sram.c                           | 28 ++-----
 include/linux/device.h                        |  4 +
 include/linux/platform_device.h               |  6 ++
 lib/devres.c                                  | 76 ++++++++++++++-----
 10 files changed, 165 insertions(+), 83 deletions(-)

-- 
2.21.0

