Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474F4C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1430820449
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DmVPsbqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbfHAIyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 04:54:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35505 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbfHAIyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:54:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id x25so68634182ljh.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 01:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fj6W4jsDxt5GsOE7AoLkpZsyiRf9t5PKjkLMJ6plbFU=;
        b=DmVPsbqw/kSlVSFadze89/Sc0JzpcdtHUnqSdiL5TyQ1QeMKBopbggLJpuRSmJRnAE
         pG0xR14TgLrgySXKBytkziQtyjTwBcisTJY06pzdHHvHbSkMF8wwnEW+98MMyUf6KrOH
         f/cUObCtFQNZBK1UISVrZYk7c6skL6t0wIEVApagXM58STpeHWYpC2w4nSsV/pRRMGdT
         +QhweXMNUXgheZrTpnzHKZYQgiA8mcw15xz/vThes6vsPnUnzeSmwpc6OIgTSsjnFhMb
         JJGrkiW6nzxvObOXI3YSORdUKkYrskTgTIDf3/Eidgj1PKQIVCc0SaoJo7HwkLvMc4Y+
         uB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fj6W4jsDxt5GsOE7AoLkpZsyiRf9t5PKjkLMJ6plbFU=;
        b=hHMqh7MwjDG9PAMPVE6IqLIIjJE1h6iDkCzyaHoHGS26m/Ms8K0w/a1f85QjJJCtMB
         fjL1vB3642mgSTYC8EzQAZHsCMQYK0I5jS24WILDMB++8y6bRWh5sgXjT1whn0VvMbfA
         u+7UKFLLNW74/RHMDjHYKCuiQE5eVAfJVI3KlSe48Uw6x24dNsSmJLref422GBWPW8Q5
         8xVb7mMF+EWKLiovClrWzeb7ixTtvdf8O0pfoXFDzoAyXEY34ksykJymetSIeaWHEPgt
         2vbDmObA5yiBjkHQ2AOlxA6ZMNPO6qbhbR8ekDDuvM9igpR1zPNEYfU41rriDz3ck6e7
         S54g==
X-Gm-Message-State: APjAAAWD2ElfK3+K5n56BNkXtmRtizeuk9O2JZZG1OtoT+Sv8TXlF1pM
        rgy+eQxd0ODXL+s1x5O9DOtciiQetlN30VzADxZbiw==
X-Google-Smtp-Source: APXvYqyYaZPASZtOn0ZX+gJmT9dDUAOlR4zhzJeW212QGArfen4IG1eVzvHqoyWaaoH0MWG02b4AQ7AproTe9HBLplc=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr3822821ljm.180.1564649639696;
 Thu, 01 Aug 2019 01:53:59 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Aug 2019 10:53:48 +0200
Message-ID: <CACRpkdYN=GzAa6E+krY3+kMq2NgM=U26FQe1SJzGbbsnOO6V9g@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for the v5.3 series
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some three GPIO fixes for v5.3, all touching
the core, so quite important fixes.

Please pull them in!

Yours,
Linus Walleij


The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.3-3

for you to fetch changes up to d95da993383c78f7efd25957ba3af23af4b1c613:

  gpiolib: Preserve desc->flags when setting state (2019-07-29 00:57:39 +0200)

----------------------------------------------------------------
GPIO fixes for the v5.3 series:

- Fix the request of active low GPIO line events.

- Don't issue WARN() stuff on NULL descriptors if
  the GPIOLIB is disabled.

- Preserve the descriptor flags when setting the
  initial direction on lines.

----------------------------------------------------------------
Bartosz Golaszewski (1):
      gpio: don't WARN() on NULL descs if gpiolib is disabled

Chris Packham (1):
      gpiolib: Preserve desc->flags when setting state

Linus Walleij (1):
      Merge tag 'gpio-v5.3-rc3-fixes-for-linus' of
git://git.kernel.org/.../brgl/linux into fixes

Michael Wu (1):
      gpiolib: fix incorrect IRQ requesting of an active-low lineevent

 drivers/gpio/gpiolib.c        | 23 ++++++++++------
 include/linux/gpio/consumer.h | 64 +++++++++++++++++++++----------------------
 2 files changed, 47 insertions(+), 40 deletions(-)
