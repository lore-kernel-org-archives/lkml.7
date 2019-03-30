Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E69C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 15:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB75218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 15:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SC1vbPup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbfC3PE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 11:04:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38654 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730537AbfC3PE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 11:04:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id a6so3382303lfl.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=T0obJPIPoNaG783yquHbuq+2xdaotgm3WQPcjV0Jbp4=;
        b=SC1vbPup7FolDbTRxT76JWeTI1ISsZQz1tWI4iJ8SYeerO4fEPkbNhNCL+DjDcFUtM
         yQFFMEI6JFk3KIptV8egZHJA/Ao52Z/J4iZeKZoLKzUuIM4WvXTxAnC1Fn6HF6pTLgB6
         SVAw59nhbcUCTo+aDx0UzrDOLkt2zeEU/oTRF8h+55DTUhmSZ8aQH8dp5jsL8n1gC92B
         qaw5ltVuvs2WHAgCL1V+Urj7Ocw/92Kv3lzdFwGqNkoWwgQJ9yvxeJ0VxMFEJ2JbuzAZ
         ABgTXP01aezg6YKb6FwlwrmD/jb+PfCtQ703cBhQ9utJ8MA9rurIcRIgTf+C4oaYCReq
         k1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=T0obJPIPoNaG783yquHbuq+2xdaotgm3WQPcjV0Jbp4=;
        b=a8/dm5ySqScj8bI1lmftmT+OSlsLwiECGk/J/yPQeEKxpFsRw6l1nTq7UWNgiPcvXg
         aHr7GPwiTfBloNGLTsvXGmEsMsDcy34HzbuV33Nd2YpVMLIMrNP4x9/3uydTaSjP+uI6
         wBGbxzptclnhKCtQrv/NnKcmsZjGgHVz1klI1U/DoDn5UDdQptYgJzY06GBCqbITHQtq
         3jVZZUB2mPWXCbbUvKxtbs2TJxLBArFAO+rFjLjXdymtnoAGkmXhzWmGXn9uQ1gFsX8M
         nPyWlHwBkLVKNM5Ds462/qUSie7wsIq5XCDhQv7ofZkWh/bE1+B+9vqhzmQFgMqfDvnL
         d2hA==
X-Gm-Message-State: APjAAAWwsiv4P/LvRh4ti5b3Ph2mXEK7V5FGWNhxNPioMgH5K7XGlsgi
        WJNMbUWlPaF1++24KeLixFtCgscqvG2444rl7UCYXA==
X-Google-Smtp-Source: APXvYqzP9X109hmIMXsMjSbOJ56JpJt8v7BJBEX8lfc+MoBubQZRLuH/DvZmk+eCQNyoGCXHBazNFRlQ6V2fqlidcR0=
X-Received: by 2002:ac2:4304:: with SMTP id l4mr19433785lfh.168.1553958294183;
 Sat, 30 Mar 2019 08:04:54 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 30 Mar 2019 16:04:42 +0100
Message-ID: <CACRpkdY2yafXiqn8TDjTNQKUQn=d3xE5y9zUHuXp1ve25C0wcw@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for the v5.1 series
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is the first set of GPIO fixes for the v5.1 series,
as you can see I was away on leave and Bartosz kindly
stepped in and collected a slew of fixes, I pulled them into
my tree in two sets and merged some two more fixes (fixing
my own caused bugs) on top.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.1-2

for you to fetch changes up to 86d0756558b701b2c5502d90f705c2936008922d:

  Merge tag 'gpio-v5.1-rc3-fixes-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into fixes
(2019-03-29 03:04:47 +0100)

----------------------------------------------------------------
GPIO fixes for the v5.1 series:

- Revert the extended use of gpio_set_config() and think about
  how we can do this properly.

- Fix up the SPI CS GPIO handling so it now works properly on
  the SPI bus children, as intended.

- Error paths and driver fixes.

----------------------------------------------------------------
Andrew Jeffery (1):
      Revert "gpio: use new gpio_set_config() helper in more places"

Andrey Smirnov (2):
      gpio: of: Check propname before applying "cs-gpios" quirks
      gpio: of: Check for "spi-cs-high" in child instead of parent node

Axel Lin (1):
      gpio: adnp: Fix testing wrong value in adnp_gpio_direction_input

Bartosz Golaszewski (2):
      gpio: mockup: fix debugfs read
      gpio: mockup: use simple_read_from_buffer() in debugfs read callback

Geert Uytterhoeven (1):
      gpio: of: Fix of_gpiochip_add() error path

Kangjie Lu (2):
      gpio: exar: add a check for the return value of ida_simple_get fails
      gpio: aspeed: fix a potential NULL pointer dereference

Linus Walleij (2):
      Merge tag 'gpio-5.1-rc2-fixes-for-linus' of
git://git.kernel.org/.../brgl/linux into fixes
      Merge tag 'gpio-v5.1-rc3-fixes-for-linus' of
git://git.kernel.org/.../brgl/linux into fixes

Thomas Gleixner (1):
      gpio: amd-fch: Fix bogus SPDX identifier

 drivers/gpio/gpio-adnp.c                        |  6 ++++--
 drivers/gpio/gpio-aspeed.c                      |  2 ++
 drivers/gpio/gpio-exar.c                        |  2 ++
 drivers/gpio/gpio-mockup.c                      | 10 +++-------
 drivers/gpio/gpiolib-of.c                       | 17 ++++++++++++-----
 drivers/gpio/gpiolib.c                          |  4 ++--
 include/linux/platform_data/gpio/gpio-amd-fch.h |  2 +-
 7 files changed, 26 insertions(+), 17 deletions(-)
