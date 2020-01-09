Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443C8C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1828420721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ieR+qxqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgAIVvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:51:18 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36417 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgAIVvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:51:17 -0500
Received: by mail-lf1-f67.google.com with SMTP id n12so6368917lfe.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 13:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pSJuCv0q0/z1FIFOdOKkUBldJYopo2x6Df2DsyN6P7E=;
        b=ieR+qxqTsANxu9KU5tWvLhl0Mvyhhs134onZh4oxgiuiYnDaI00xsh7R4b8zmrZO7C
         8ISLUpepGZmuHi71A542ASURhzsBRrjZWenRDQuFFx3ZcZfnuv2LQVb8KHEi4NZprJcp
         2iEAW2ufL+CvgdswRTShu6qWP3kYnkIIZh4PTCpIWvMqc7ga4peCC1RcAHSAc7di1Dh0
         MPIe4QLEIs29g9aSugBTsYe2rC3mc/koptJ6bZMKayeriQ6mROz2r5XbkBEJ0JcpZysp
         bdGhnwr9KjVEbLGvdNWPbh3uhrKOZOlRRVYXl3vevQ31CwpbpAZKEbyfVKL9iW9N4abT
         J8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pSJuCv0q0/z1FIFOdOKkUBldJYopo2x6Df2DsyN6P7E=;
        b=lTBapmpvSSLuHvVWliVdinmFLGkOQ4Evzxr7/wxI3+NUzhXJHdMimFEoVT+6wK3Zwj
         P83LTlwxYxEfsP2H7LJ+EVt2DkFKkcZm4BOxIKUSVWyZPkvmB5xgZ1AkfmE2cAW4bGaL
         JBklOk0wJtFZCkB6rUqgcP1ZHKmn8CC4Fni/UoNmcDV1RQtXMzXl5+rdMkOWC5OMnIZa
         54AE3eCGaPLWo3nMaKGpdYIAVS3V2IefLzBfBvLluR7UzJtFbqPnUsFCL7lHXH9zOpUL
         qvhrj8iRHNUlvkVV+062DxIrvd0JCkyYHBn5PbjFdLqZotVIRoE1TYRh6SezkhGSZLto
         iAnQ==
X-Gm-Message-State: APjAAAV5pffWKqy8RrkotRBADzOq8yUEOGAsg4L2dfRXG+tuA4BiFm8v
        DFeM8y5nzx9rTI5nqSAazY1021Oieb2kCbSUvmI67g==
X-Google-Smtp-Source: APXvYqww+xa/shqmj3ALY2JAcM4t2Oi9yfUMtjGqluc3+ah50x+EtFXlht3Em5G6Av0vEY0z2OhZ80T5Hgfzp+ShcR4=
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr7373029lfp.133.1578606675739;
 Thu, 09 Jan 2020 13:51:15 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Jan 2020 22:51:04 +0100
Message-ID: <CACRpkdbR2Ssr1WWfS2HZ-jd6XFgEvEsqrjVAcgPsR8RerE-xfQ@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v5.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Qianggui Song <qianggui.song@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

some two fixes for pin control, not much to say about
it, it's just regular driver fixes.

Please pull them in!

Yours,
Linus Walleij

The following changes since commit fd6988496e79a6a4bdb514a4655d2920209eb85d:

  Linux 5.5-rc4 (2019-12-29 15:29:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.5-4

for you to fetch changes up to 35c60be220572de7d6605c4318f640d133982040:

  pinctrl: meson: Fix wrong shift value when get drive-strength
(2020-01-07 11:21:07 +0100)

----------------------------------------------------------------
Pin control fixes for the v5.5 kernel cycle:

- Fix erroneous shift in the Meson driver

- Make Lochnagar select the GPIOLIB Kconfig symbol

----------------------------------------------------------------
Arnd Bergmann (1):
      pinctrl: lochnagar: select GPIOLIB

Qianggui Song (1):
      pinctrl: meson: Fix wrong shift value when get drive-strength

 drivers/pinctrl/cirrus/Kconfig        | 1 +
 drivers/pinctrl/meson/pinctrl-meson.c | 1 +
 2 files changed, 2 insertions(+)
