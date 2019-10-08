Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C685C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E18206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vm/asU4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfJHJAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:00:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44756 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbfJHJAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:00:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id m13so16623810ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 02:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=teTMW0xTyzGadnBpOLviUKelFXzH4FksSl8RfVfYuKY=;
        b=vm/asU4UhgzlA6XukbK82YQmiDr8qpfhHjhcnzyBapIdRLd9rciZKGg5MriVpzRyAh
         mIu4O3/xhoB65peMKtP12+lkvrHtuV/4wGepNNAoLnrDojQPxIXyYgiWXWEW4cO241aS
         qp/j5NDvGOl3E9/1kM4hFF1/6IZ/HtrrSyhcBI3RdPa/RLd0X4e1loMf4SErlTe5VBYV
         12UsQtsCEsOk9le9OTRBPNsu1kuVPB1CSlclimaTd9xeth6fv+eng9FtnoUQ2MqRpzMI
         P4hjCwN23uOlKeXSKM8+ggN6A/Dl4brIETBj9jDh4Ezl0jW4PTsftStyAO1NLM2stkLo
         6y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=teTMW0xTyzGadnBpOLviUKelFXzH4FksSl8RfVfYuKY=;
        b=dP1eCm3wz7GBJkKB/zgAzam8bVtwC37RjLa8AmLcTK+2A+cFjBESXymGDY1zZX+woi
         pjp3vnj6Qo8ymoFjRgzCiTJr12Um9aY237Ya7Ze+kivJMQSM2RDZfKAg3y58sy49vcGE
         SKEeo8g74K2Wtd1VisikGeOPX+ATh+OgGKwTG4rbqOu54MdPfDYArvSdxjxMWS5pVoQ/
         +a214qaf6BpPXn0m4RC80JePxoaac3YrxCRZwAcjp68pOnxev08rk6P/5XpFvsOAAGHB
         MsnM5iJkWn7Ih5XS0joVTNc3ghKtXnt2xA8wtTPpbAHCsPWZbIpUITUo1UrYFSnUE8u2
         cQ9Q==
X-Gm-Message-State: APjAAAX1mUxR66ewIQoWebsVpczEk2kDQq+hc8TFqKRzjFUZ2a5plK49
        599KJZTRJ1hW1wlki1RXCyJVbw1Cr/4NanMLretL9g==
X-Google-Smtp-Source: APXvYqw9fWGADAgVJEmFIATdDVbXmdaqmYVxjYl4JLUOWELQrCpjiffIUikAvMGhadt+AKiLWWY/NgqaUfqnTPWEw3I=
X-Received: by 2002:a2e:5dc3:: with SMTP id v64mr21693733lje.118.1570525209710;
 Tue, 08 Oct 2019 02:00:09 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Oct 2019 10:59:58 +0200
Message-ID: <CACRpkdYnnZnOko4q+NmLwdKeObT--f8Xgv+e+fBLLXUAWqh7bg@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for the v5.4 series
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

some GPIO fixes collected since the merge window,
3 for stable, 2 driver fixes.

Details in the signed tag.

Please pull them in!

Yours,
Linus Walleij

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.4-2

for you to fetch changes up to fffa6af94894126994a7600c6f6f09b892e89fa9:

  gpio: max77620: Use correct unit for debounce times (2019-10-04
23:58:10 +0200)

----------------------------------------------------------------
GPIO fixes for the v5.4 series:

- Don't clear FLAG_IS_OUT when emulating open drain/source in
  gpiolib.
- Fix up the usage of nonexclusive GPIO descriptors from device
  trees.
- Fix the incorrect IEC offset when toggling trigger edge in
  the Spreadtrum driver.
- Use the correct unit for debounce settings in the MAX77620
  driver.

----------------------------------------------------------------
Bartosz Golaszewski (1):
      gpiolib: don't clear FLAG_IS_OUT when emulating open-drain/open-source

Bruce Chen (1):
      gpio: eic: sprd: Fix the incorrect EIC offset when toggling

Linus Walleij (1):
      Merge tag 'gpio-v5.4-rc2-fixes-for-linus' of
git://git.kernel.org/.../brgl/linux into fixes

Marco Felsch (1):
      gpio: fix getting nonexclusive gpiods from DT

Thierry Reding (1):
      gpio: max77620: Use correct unit for debounce times

 drivers/gpio/gpio-eic-sprd.c |  7 ++++---
 drivers/gpio/gpio-max77620.c |  6 +++---
 drivers/gpio/gpiolib-of.c    |  2 +-
 drivers/gpio/gpiolib.c       | 27 +++++++++++++++++++--------
 4 files changed, 27 insertions(+), 15 deletions(-)
