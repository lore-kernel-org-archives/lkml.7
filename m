Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D285C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E2020674
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BE85dBJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfHXVSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 17:18:10 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42922 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfHXVSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 17:18:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id s19so9553495lfb.9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=buG8rS1mJF0qAnzC4CPBok3txDbgd1yDUZD/dbaM0ZI=;
        b=BE85dBJbTx/kCV/K61eeXdfzfnJ2mys1pqTCzNLN+29ZHQOyNl4I0MC0JtYtksN+3/
         ThtcLUKmJQRpyc+FwTr/Xs7fOvgEwJrDE/O9EvdkhQoVPENqR2+P6dBQAyzfvnhdiQ5h
         aY1OBBncu7vycqpujXGWqpvbtcr4L5vCSuvcNu+X+a/KDIDDkoz/iyWyUnl64/ulJ7/i
         Sh1ZO7XNNbGhgltOWHB5Mhaw5U5fHU1foQY12xa2gvnlySrqB6YITMnNQgEMHndh+jH6
         gY/ZaCu3wvWUE0/wwCAs3IBaMO4l1eWkftuXLIDGNZCaHTBSetOwtlhu0vLIA4ljEvth
         JpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=buG8rS1mJF0qAnzC4CPBok3txDbgd1yDUZD/dbaM0ZI=;
        b=pUXWSeGq6tub5a+lWPzCy8d1+qiGuaCoRWqeOTISFHHhFBYbM4GTYYjShPxPRdTISR
         +70f995DHlQGETsQ4oCwCqfgEt6LdlByT4woQvsY6vQFlBvwvWYDJxT1ers9BLNnK4jW
         /2gy2wFOhvsoNQipvsRZT1baRDNBXk0DUf41hwtlHT7qD794BBX9VFWSY/Z1n/6Uh6L+
         l/b+bmeHJacFDsjwpjYqYQrQVSKSXAfzzOF7ElwOXOFblah4uOEhc8+ZSbJEcVfL6566
         8OUGOFl4MVy9bsIpCvTrsLQbvwVk7Pr4kWYseCJACubore99FLUQ1GoxmHMhV8jXCKrx
         qgtw==
X-Gm-Message-State: APjAAAWdoxb1M6jsqCb0IgS0pPcMtQUvDVw30xlRED4VoVTgyfIvufuU
        un/VH0Wve+gpPjtS5ByGlyJ4IFERSGWEZdlOsSFN8A==
X-Google-Smtp-Source: APXvYqytYBob1ysBJFACFwD27yhpXuh79le74ImOIBK9fnFXYOfsrqZBUWF/nbQVDk6NXB+PhLckDQnRms6L+zoHv0A=
X-Received: by 2002:ac2:5939:: with SMTP id v25mr6513387lfi.115.1566681486625;
 Sat, 24 Aug 2019 14:18:06 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 24 Aug 2019 23:17:54 +0200
Message-ID: <CACRpkdaWR9GZ0Hem4h-jdGcYc_Uwx29XvsHuEgvXiebRG6DCwA@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for v5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is a (hopefully last) set of GPIO fixes for the v5.3 kernel
cycle. Two are pretty core.

Please pull them in! Details in the signed tag.

Yours,
Linus Walleij

The following changes since commit d45331b00ddb179e291766617259261c112db872:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.3-4

for you to fetch changes up to 48057ed1840fde9239b1e000bea1a0a1f07c5e99:

  gpio: Fix irqchip initialization order (2019-08-23 11:00:43 +0200)

----------------------------------------------------------------
GPIO fixes for the v5.3 kernel:

- Fix not reporting open drain/source lines to userspace as "input"
- Fix a minor build error found in randconfigs
- Fix a chip select quirk on the Freescale SPI
- Fix the irqchip initialization semantic order to reflect what
  it was using the old API

----------------------------------------------------------------
Andreas Kemnade (1):
      gpio: of: fix Freescale SPI CS quirk handling

Bartosz Golaszewski (1):
      gpiolib: never report open-drain/source lines as 'input' to user-space

Linus Walleij (1):
      gpio: Fix irqchip initialization order

YueHaibing (1):
      gpio: Fix build error of function redefinition

 drivers/gpio/gpiolib-of.c |  2 +-
 drivers/gpio/gpiolib.c    | 36 +++++++++++++++++++-----------------
 include/linux/gpio.h      | 24 ------------------------
 3 files changed, 20 insertions(+), 42 deletions(-)
