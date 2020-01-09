Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A05C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED0F2075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lupy590s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgAIWBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 17:01:02 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40481 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgAIWBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:01:02 -0500
Received: by mail-lf1-f66.google.com with SMTP id i23so6385330lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 14:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Mi3sk3TlD65TjPJS6t+i6kqtarlRrjgY8N4j6OEE+Sc=;
        b=lupy590s587XYo30Rgt0h/B5lxayn4BmVjvmVFaElEgBVOnGNKHxDhSxNzxyih7w1Q
         hSdB9U+AQGOGSbf4nqVd7mLLCMfJe2wHbg9dKTBMOLgszAFwm3btFQVD1iv2V3GWEa2r
         VG4IGpPBPPye2ee0Iquh/MEw1ixTrza6K0RnXjwIDWqSXa/2SA5JiZhg+pr4Sf+Nq6O3
         C7eRlIVj6/A3vMl5FtW6lrKzq2MD7AEN568JwhZCF0vcel0UmkAxB/AzyGSEBZsAKBme
         oQeUGUsFTy2piLpuutukxu7dTq5LUDqidGPSekE2suuICUFGfqHm6+L+Pd3IE92pKUd3
         t1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Mi3sk3TlD65TjPJS6t+i6kqtarlRrjgY8N4j6OEE+Sc=;
        b=Egus9Hj9h0ZRgko+Q5LTGm/11y7frY92QOdF4W14k22q2D8z3QAK5spQuwmOYJI42L
         fiFy9Rv7XlYf8T4Ny4I3mVvcFc6wflVQG6blB+mBSyC2uPhlpy40csvnW9/wB2Phdi7Y
         RYJyYl7Pbl8TaP08c5dNtkcI1hax/hQzP+f9TbRf23yTomVtR8LZ5+QwApEj8nNGodjs
         NfqUKYzmNBpOgA/HKz1SgZYx7/pdJkE9Fu/D8rUMqIkVmi2et2N74et2l9WeqYwkRnhO
         BrzdK0QAdNPlulyUo//RCHU1XxAy0sD2tHUYu5q4176xkfKI9njKH3RFAdeM74hX7Oog
         XWzg==
X-Gm-Message-State: APjAAAXJVrLBR8UBnhx+diMU5keii1rcRJPBwD9KstCKT6HbSbECOeKc
        Hlj4NsiMPZnd42PWN7ywh7AVBVjufpN4FnXVDFzwmQ==
X-Google-Smtp-Source: APXvYqzRI6RTJONfr++1e8TbnhwKAJWFgwOFxp3yxWshXsnym/ktIJLACYbuwcrWWHDSdmj91kgsFwt6HJtQ+1bo0m8=
X-Received: by 2002:ac2:5e78:: with SMTP id a24mr7472412lfr.5.1578607260191;
 Thu, 09 Jan 2020 14:01:00 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Jan 2020 23:00:49 +0100
Message-ID: <CACRpkdaUEAxP8Q9iLR+DBuDAkq0U9mAhSwJsrqT7dCF3zAC8vA@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for v5.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is a host of GPIO fixes for the v5.5 series. The
ACPI fix is especially important, see the signed tag
and commit for details.

There is also a coding whitespace style fix on the
mockup device maybe I shouldn't have merged that here
for fixes, it was more of a -rc1 thing, it just slipped
in through the winter vacation returning to duties window.
So sorry about that, if you insist I can rebase the lot and
take it out.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit fd6988496e79a6a4bdb514a4655d2920209eb85d:

  Linux 5.5-rc4 (2019-12-29 15:29:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.5-3

for you to fetch changes up to aa23ca3d98f756d5b1e503fb140665fb24a41a38:

  gpiolib: acpi: Add honor_wakeup module-option + quirk mechanism
(2020-01-07 12:58:15 +0100)

----------------------------------------------------------------
GPIO fixes for the v5.5 kernel cycle:

- Select GPIOLIB_IRQCHIP on the max77620 GPIO expander
- Fix context restore in the Zynq driver
- Create a new ACPI quirk handler for disabling wakeups on
  problematic hardware.
- Fix a coding style issue on the mockup device.

----------------------------------------------------------------
Bartosz Golaszewski (1):
      gpio: mockup: fix coding style

Dmitry Osipenko (1):
      gpio: max77620: Add missing dependency on GPIOLIB_IRQCHIP

Hans de Goede (2):
      gpiolib: acpi: Turn dmi_system_id table into a generic quirk table
      gpiolib: acpi: Add honor_wakeup module-option + quirk mechanism

Linus Walleij (1):
      Merge tag 'gpio-fixes-for-v5.5-rc5' of
git://git.kernel.org/.../brgl/linux into fixes

Swapna Manupati (1):
      gpio: zynq: Fix for bug in zynq_gpio_restore_context API

 drivers/gpio/Kconfig        |  1 +
 drivers/gpio/gpio-mockup.c  |  4 ++--
 drivers/gpio/gpio-zynq.c    |  8 ++++---
 drivers/gpio/gpiolib-acpi.c | 51 ++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 54 insertions(+), 10 deletions(-)
