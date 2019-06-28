Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2E2C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BC120665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Me3TL758"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfF1Jf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:35:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37078 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfF1Jf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:35:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id 131so5311470ljf.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gm81eQXirqjQ8ir5W1mh/MO4CE2jStCNfLLn6pKP+mE=;
        b=Me3TL758RRm+ZooMTytttUvmF+hc1jb8D/jfkVz9b19dkkWHYgqnW/mBLcgiA7cYZS
         zuuhJ0sMQCj72GTTK24NETz6bIwj26Rc8pCfxLv2x2AohpOZPbmyP6mOlpZ6YWBEmily
         DkS6bSFQQRVKcNGEC6fRJrTSKvftsC1zCyWjQ9ftXCLA8c2EDkLitxNMHKZ1fHgab2lE
         HE72Zcqo9zWv6tU1LFarRIsNHQ8rumMUh61EDaioegjaLOuc9HKiU04ZWkD1G73vO8lf
         n+0ITHbfacSkxycFTRUgAZY0h78QHmguLFgMvurVVFSlCWhqA6+Ghrf2fqFTbojmrVw0
         2PZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gm81eQXirqjQ8ir5W1mh/MO4CE2jStCNfLLn6pKP+mE=;
        b=Q8qF91mY06CpcY1EAC05zDgILKkXFreYs3GN8OEIc1Kl9ukn2JwYnR5S1Mn1RoPMgi
         4fcoaV4KKKlAeb44RwpDkBde0EFZRTXchpu8SqOZnFraWk3QttQyDa8vtOeg6YvLvDLp
         zQrgqLeFuXyS5rT4xGpQ1dP2/KfBboeXZW4Cl2mOvTWT0WLNXX0zou2FwlAUMvnICxt2
         KWqEMPG/TyhMURN+UTxM4W87x5kjriSTwCtFc/XMWCS5Zme4GzxEDGI95EuZcghXPRyE
         HO/NjJ+8w0ytEDRQv4BvEXED69dW7HPjPJN7lcnKyvQoMfLynv9j0uQl6AGSQyJUONp8
         h+XA==
X-Gm-Message-State: APjAAAWBZoQ5rBxYnmAEryDobInw0YCXzqG4Uh5wsONMJk3KGNoDQ9Uj
        uqvUCp/YpYzRgGR0mOxUfurEUGtD5A2iqB0f62lHrp9dKI4=
X-Google-Smtp-Source: APXvYqyCRplnbdfueknv2w+rIqQfd/hR36KbMNU3YvRG5O2rZ8mWhRYuIhtOKpoEiLQn/QiwaIWlheLq5Fd/Jb/KPHQ=
X-Received: by 2002:a2e:8756:: with SMTP id q22mr5727021ljj.108.1561714556904;
 Fri, 28 Jun 2019 02:35:56 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Jun 2019 10:35:45 +0100
Message-ID: <CACRpkdaiMrQyaxrLhy=Az5SCoz_C3NWRSYiQFqr=_BsD+qugMQ@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v5.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Reid <preid@electromag.com.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

sorry to bomb in fixes this late. Maybe I can comfort you
by saying it is only driver fixes, and mostly IRQ handling
which is something GPIO and pin control drivers never get
right. You think it works and then it doesn't.

It also took some time because we smoked out commit
message syntax issues in linux-next.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.2-3

for you to fetch changes up to 9d957a959bc8c3dfe37572ac8e99affb5a885965:

  pinctrl: mediatek: Update cur_mask in mask/mask ops (2019-06-27
12:22:11 +0100)

----------------------------------------------------------------
Pin control fixes for the v5.2 cycle:
- Fix IRQ setup in the MCP23s08.
- Fix pin setup on pins > 31 in the Ocelot driver.
- Fix IRQs in the Mediatek driver.

----------------------------------------------------------------
Alexandre Belloni (2):
      pinctrl: ocelot: fix gpio direction for pins after 31
      pinctrl: ocelot: fix pinmuxing for pins after 31

Nicolas Boichat (2):
      pinctrl: mediatek: Ignore interrupts that are wake only during resume
      pinctrl: mediatek: Update cur_mask in mask/mask ops

Phil Reid (1):
      pinctrl: mcp23s08: Fix add_data and irqchip_add_nested call order

 drivers/pinctrl/mediatek/mtk-eint.c | 34 +++++++++++++++++++---------------
 drivers/pinctrl/pinctrl-mcp23s08.c  |  8 ++++----
 drivers/pinctrl/pinctrl-ocelot.c    | 18 ++++++++++--------
 3 files changed, 33 insertions(+), 27 deletions(-)
