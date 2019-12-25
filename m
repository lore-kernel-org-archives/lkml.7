Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD26BC2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 23:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838312075B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 23:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqqZ7APU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfLYXHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 18:07:53 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43962 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfLYXHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 18:07:53 -0500
Received: by mail-lf1-f68.google.com with SMTP id 9so17394247lfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 15:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=+tSSA6VWqaa29D/81Kxz1W67EXFx2P3VO41Ty+etGfw=;
        b=KqqZ7APU5SNZMRD+NMez/fMGThMzF+/JpzAxfiPKLv23K/MQDwa5l5qBUO/ljmAQDf
         IAPa6pOYDk55ZZ4HT9YSU4SmjHCQkmxAvOH1GKeRJRLTN0Lk39DioUNvgQyGOZJWOnel
         7tcgqd9ivDONDIcVpCRRF+r91XUTzLbf/yaV0vZKiylAXDhp0C3VK0IRWW1Zbs9IUJ5/
         aSUcOLLDm0JF2dQkyrayhDHrAGVaJntFW9MjZ835NmOmJ97Ifq1jWsg+7wf5/9jrPq1w
         QfmAxD4BYHpccCJbqHGFVeC7907UxKWJkEG7PC6Nk0mL96asYanby5MFY8YLMfyMqvn8
         G8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=+tSSA6VWqaa29D/81Kxz1W67EXFx2P3VO41Ty+etGfw=;
        b=U2N8eKV7PBGmxcMmgL6B/gqfDhjItQN/SiYaj9MQhnDStYblnV/gZnGNGvn0061YGS
         K6T9ufLa2ZJf3b/XIAk0Z3BKA1ADTvyB3ChG03BUHGzAZoPajVCt5hc1TLoHDD9ZvjWJ
         Glx4FUf5DYvD+U7R06bXuVCvIJM/oNEwuTZW/AAnHXEswnfDHalIWn+aThW/GcuugAPW
         HWNbTUe0YkTIoiT4hO5QEZDiDsUIGbkONulMJLaaTDNfL3R5miR6rRiTEJIVYOoB3S5M
         YFwyP6Q22rKVyDXpGEfkqHcmgTch5sfvhM0K4QzzJb6mt528a23cVgE+jjdKOZRJgLCu
         fKtg==
X-Gm-Message-State: APjAAAWQqBhJAck2UXgSQXLd9tbuXnJTDEtS+t5muHJg2W7e+rEnrRSX
        BfYlG/8D+9+WivWUAEAXHo+PxC4oNr6RZA5NdSh/SQ==
X-Google-Smtp-Source: APXvYqz404A72Js0dpvRqj99Gvt3aoSkNTXfa2TY2YLXQtMxzTK6SrbXy2CgiuwEfmDKtGU0GZJdoAmqKFjnjBg7aHg=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr23696873lfi.93.1577315270809;
 Wed, 25 Dec 2019 15:07:50 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Dec 2019 00:07:39 +0100
Message-ID: <CACRpkdZucwZNrUo3=WPM-utorFaqOn4AyhxMnX4xM_wvhP8SXg@mail.gmail.com>
Subject: [GIT PULL] gpio fixes for the v5.5 series
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some slightly overly ripe first GPIO fixes for the v5.5
series. A bit late and too many because christmas stress.
Not too many lines though.

Please pull them in!

Yours,
Linus Walleij

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a=
:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.5-2

for you to fetch changes up to 286e7beaa4cc7734894ee214569de4669ed9891e:

  gpio: tegra186: Allow building on Tegra194-only configurations
(2019-12-16 11:16:57 +0100)

----------------------------------------------------------------
A set of fixes for the v5.5 series:

- Fix the build for the Xtensa driver.

- Make sure to set up the parent device for mpc8xxx.

- Clarify the look-up error message.

- Fix the usage of the line direction in the mockup device.

- Fix a type warning on the Aspeed driver.

- Remove the pointless __exit annotation on the xgs-iproc which
  is causing a compilation problem.

- Fix up emultation of open drain outputs .get_direction()

- Fix the IRQ callbacks on the PCA953xx to use bitops and
  work properly.

- Fix the Kconfig on the Tegra driver.

----------------------------------------------------------------
Andy Shevchenko (2):
      MAINTAINERS: Append missed file to the database
      gpio: pca953x: Switch to bitops in IRQ callbacks

Arnd Bergmann (2):
      gpio: aspeed: avoid return type warning
      gpio: xgs-iproc: remove __exit annotation for iproc_gpio_remove

Geert Uytterhoeven (1):
      gpio: Fix error message on out-of-range GPIO in lookup table

Johnson CH Chen (=E9=99=B3=E6=98=AD=E5=8B=B3) (1):
      gpio: mpc8xxx: Add platform device to gpiochip->parent

Kent Gibson (1):
      gpio: mockup: Fix usage of new GPIO_LINE_DIRECTION

Linus Walleij (1):
      Merge tag 'gpio-v5.5-rc2-fixes-for-linus' of
git://git.kernel.org/.../brgl/linux into fixes

Max Filippov (1):
      gpio: xtensa: fix driver build

Russell King (1):
      gpiolib: fix up emulated open drain outputs

Thierry Reding (1):
      gpio: tegra186: Allow building on Tegra194-only configurations

 MAINTAINERS                      |  1 +
 drivers/gpio/Kconfig             |  4 ++--
 drivers/gpio/gpio-aspeed-sgpio.c |  2 +-
 drivers/gpio/gpio-mockup.c       |  7 +++++--
 drivers/gpio/gpio-mpc8xxx.c      |  1 +
 drivers/gpio/gpio-pca953x.c      | 26 ++++++++++----------------
 drivers/gpio/gpio-xgs-iproc.c    |  2 +-
 drivers/gpio/gpio-xtensa.c       |  7 +++----
 drivers/gpio/gpiolib.c           | 13 +++++++++++--
 9 files changed, 35 insertions(+), 28 deletions(-)
