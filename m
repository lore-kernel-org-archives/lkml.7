Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C04C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E8B2182B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WaqzP2Oa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfGQPYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:24:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39551 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfGQPYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:24:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so24019976ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=RiBxeDla5S+W1dOK7Khr8uPhoGXyMITDyRV+d4Gpttw=;
        b=WaqzP2Oaflu33Wr9zVrugsUqwIcrHOC6d1INoBgDeGzkUUzC6C1UQ5XLpyMA7c1uu0
         Yj8PHMAR69KBRiYNMncEc5F+Y4WjalukgGpDzO8ps/VqVRnZy8+3icmjMzKiRCcbOI/i
         otXJNpfRwoAbHZ6kFyUoXSJidXDiKagyn4x7tQ/xB4e381VNUXbRfH3KUuGJsxDuxGFj
         K/1ce/gafL5dUYRoqzbvgDMouuwkwlvBu+lrTRuoOc449W86vJtgD4KkyeKTE61FmF6Q
         MHjji/RO3xgkV2ehxOPnf7sDpFyHWyIqWa7+ZgehWk8pfhsFvgfH/Ai7u5sNs1J1HehU
         vpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RiBxeDla5S+W1dOK7Khr8uPhoGXyMITDyRV+d4Gpttw=;
        b=e2SbDcv6GXinhPUVcFJfN+MRRQPz/YrPdq9aD7dbeIbNL6UjgnlUaAXfALmE/4OdvJ
         uggAwc+AU6WX8Cx4x8UhmxywDj7S1LsVK5b1xveqnnmIVO0OPIVr/Yk+heiJ+L3mK+i3
         QAJv0Cj2Gxnj/GVeZrysGkBjfBenAFaUKpdVkTBATUJTwkfaycDFYFYkEuyTu65cScpb
         1cY3tH/iTQeQN6zQTkgDj8vOI5/V6+4YweX8AQN7Nf+kQFvz4+KXQ+Qnw7Nu66iSiGUb
         SGkIL/1OjdMWg6HRKT8qRhf3B9/Uy+eX+H20PLms+IrPLX/Y+tNhHkt2i+sPidnqfj40
         WlBw==
X-Gm-Message-State: APjAAAWvB7OYVdQlIzzlapU/ohqkxVQBNyyTgVWHTKheB75zsV1fmxVN
        5niQxQD06UEnuEJzZJ+pi27uXKXWtda7lt9SKd75ZoBiwKU=
X-Google-Smtp-Source: APXvYqwtOm+KRiLvQOXdvGCwtGiYezXbs0zHjP2TQOlPCu8ncjrv1uFE3puMuifvkG/6TI4TgDJaXgpjY8GJ8Mqin2g=
X-Received: by 2002:a2e:8756:: with SMTP id q22mr21546133ljj.108.1563377090216;
 Wed, 17 Jul 2019 08:24:50 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 17 Jul 2019 17:24:38 +0200
Message-ID: <CACRpkdYOahn84UxZ_-YAQsP+4W+HQCAL7xEJieEDd53xLgaWfw@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for v5.3 take one
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

some fixes arrived early so let's merge them early so we
have as little problems as possible in -rc1.

This is based on the most recent HEAD commit that day.

Please pull it in, details in the signed tag.

Yours,
Linus Walleij

The following changes since commit 9637d517347e80ee2fe1c5d8ce45ba1b88d8b5cd:

  Merge tag 'for-linus-20190715' of git://git.kernel.dk/linux-block
(2019-07-15 21:20:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.3-2

for you to fetch changes up to 88785b7fa74ae2dc52f879140b976984b5374c79:

  Merge tag 'gpio-v5.3-rc1-fixes-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into fixes
(2019-07-16 11:12:14 +0200)

----------------------------------------------------------------
GPIO fixes for the v5.3 merge window:
- Revert a SPIO GPIO fix that didn't fix anything instead created new
  problems.
- Remove the EM GPIO irqdomain in a safe manner.
- Fix a memory leak in the gpio quirks.
- Make the DaVinci error path silent on probe deferral.

----------------------------------------------------------------
Bartosz Golaszewski (1):
      gpio: em: remove the gpiochip before removing the irq domain

Keerthy (1):
      gpio: davinci: silence error prints in case of EPROBE_DEFER

Linus Walleij (2):
      Revert "gpio/spi: Fix spi-gpio regression on active high CS"
      Merge tag 'gpio-v5.3-rc1-fixes-for-linus' of
git://git.kernel.org/.../brgl/linux into fixes

Nishka Dasgupta (1):
      gpiolib: of: fix a memory leak in of_gpio_flags_quirks()

 drivers/gpio/gpio-davinci.c |  5 +++--
 drivers/gpio/gpio-em.c      | 33 +++++++++++++++------------------
 drivers/gpio/gpiolib-of.c   | 10 ++--------
 3 files changed, 20 insertions(+), 28 deletions(-)
