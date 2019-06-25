Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09B5C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE05208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="B8LuQu66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfFYQey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:34:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34349 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfFYQex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:34:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so18662600wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RNjXZTa0eehs8U6TXIJ1xtY97Iu/6Eek+y81QQNtjK4=;
        b=B8LuQu66bgMmpBHn0CbN+gVJmLWy3c3N7z8bxuh0JXGKTw6PWfsSrpdrk5mrFYRvmt
         CeUcFrYqeCPgbiCJ+jIiEUE2NbmgnQFalb/wUcSM8ab3BddXyQ02/10RO9om9ObUS8VI
         sGVmk+ffQ8YrqfA7m/lbU2K1B/9/tczAwT7KMOOrh4Sd13TAzAhT66t4CKX4s9yQH1PU
         l8BYKVJU3d61u7wZ4h/eYquVn0tk1mbumj6t91PAzxrKbo2uiCe1uu/MMQkGxLylJ/5D
         zHz02i20yGrgLom/qdpFn5k25qlFJq2s36M/p6mmBeIaxkvGXx1yijivOajz10lQ2ZDo
         hrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RNjXZTa0eehs8U6TXIJ1xtY97Iu/6Eek+y81QQNtjK4=;
        b=gns1/l7ByAbJcia1DdtzWK7AgrtfLvC01QLXowppSGzBcNXyAbm0CsMnjk6L7MN7kl
         Okm2kmcdTjJiUXg9MrZlJtGJfpnDojFIiJps5Se/o0PRmyTBEa8L8EM8Jz5VdGsyuid0
         sB3JiD67JNggYFI53WnbssTyxdoQdX6oHCe7VCpUiS+x8H1RCYKEC2Jbdi3drl2hnkD4
         /j3eu9p23SoAyZxuxI8nHlJ/B5+kZg7RJaGKue6GGmmbvNXedIfn5lXhPeGchJ01V/hC
         1s2otehIwdasGd+D3b0+GhIxzqzWEblN3GEqjBwVem73JUwNzGpiz5fmAbB7AoE08hIg
         5Aww==
X-Gm-Message-State: APjAAAWP4rjgpGP7PGWv4rOuQtx6WOTYyPhNbdMvU+419xtrKYyBXFD+
        /X6Cgw4temSA8jThbCUSY5v0ew==
X-Google-Smtp-Source: APXvYqwGZ61fCCBpD9shDosEmPm3n3rtBVEJAron1RaBsQFJZuBhiFZxaTmMz81yYUZI1bSgnfdGEg==
X-Received: by 2002:a5d:5446:: with SMTP id w6mr106263069wrv.164.1561480491732;
        Tue, 25 Jun 2019 09:34:51 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id g8sm2683795wme.20.2019.06.25.09.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:34:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 00/12] ARM: davinci: da850-evm: remove more legacy GPIO calls
Date:   Tue, 25 Jun 2019 18:34:22 +0200
Message-Id: <20190625163434.13620-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is another small step on the path to liberating davinci from legacy
GPIO API calls and shrinking the davinci GPIO driver by not having to
support the base GPIO number anymore.

This time we're removing the legacy calls used indirectly by the LCDC
fbdev driver.

The first three patches modify the GPIO backlight driver. The first
of them adds the necessary functionality, the other two are just
tweaks and cleanups.

Next two patches enable the GPIO backlight driver in
davinci_all_defconfig.

Patch 6/12 models the backlight GPIO as an actual GPIO backlight device.

Patches 7-9 extend the fbdev driver with regulator support and convert
the da850-evm board file to using it.

Last three patches are improvements to the da8xx fbdev driver since
we're already touching it in this series.

Bartosz Golaszewski (12):
  backlight: gpio: allow to probe non-pdata devices from board files
  backlight: gpio: use a helper variable for &pdev->dev
  backlight: gpio: pull the non-pdata device probing code into probe()
  ARM: davinci: refresh davinci_all_defconfig
  ARM: davinci_all_defconfig: enable GPIO backlight
  ARM: davinci: da850-evm: model the backlight GPIO as an actual device
  fbdev: da8xx: add support for a regulator
  ARM: davinci: da850-evm: switch to using a fixed regulator for lcdc
  fbdev: da8xx: remove panel_power_ctrl() callback from platform data
  fbdev: da8xx-fb: use devm_platform_ioremap_resource()
  fbdev: da8xx-fb: drop a redundant if
  fbdev: da8xx: use resource management for dma

 arch/arm/configs/davinci_all_defconfig   |  28 +++---
 arch/arm/mach-davinci/board-da850-evm.c  |  90 ++++++++++++-----
 drivers/video/backlight/gpio_backlight.c |  67 +++++--------
 drivers/video/fbdev/da8xx-fb.c           | 118 +++++++++++++----------
 include/video/da8xx-fb.h                 |   1 -
 5 files changed, 165 insertions(+), 139 deletions(-)

-- 
2.21.0

