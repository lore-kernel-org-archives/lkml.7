Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845F5C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592FF2465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBz77i1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfLSVdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:33:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44877 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLSVdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:33:51 -0500
Received: by mail-lj1-f194.google.com with SMTP id u71so7807812lje.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 13:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PqR4x8+f9h2Qn/e8Pu7yo3KcXeRHhFv38n6yorLO0Ug=;
        b=CBz77i1+cO1ZzfRyHCuPs2lWQc8MNXKOd8UnR8KIwv2ButzuSX5Q0Uzg6RhYpOT7bO
         SmlbQw3On2pYwbmZ8S4scNa7Z4sJNUvFJXLAqmdCn+jWmeM30PoQ4Ux3+ulVxH8OI/6K
         +3ljNBvOX1mcnfDdt3Al4YIeK5xhztrwh6y9efzjtZNYO8AqnmSIqUc0Vo1jXQ+3+3aE
         2cu9W9RWEAA6hfhjxUXH6Rn6KunkxwQRKujnDSJWLiny69Am3KNmIvrS/Ef3kXm2gEZ3
         c5i/kiGuY9EUmmP4+84E1+I7tmWZxeXPdIN3SlhWquC9YPHiu96rOwG5cc30LzmKuIot
         L9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PqR4x8+f9h2Qn/e8Pu7yo3KcXeRHhFv38n6yorLO0Ug=;
        b=UqwGlup3hpooyzPgB0iB1dwjEwYWeOkphUxgExP13yjRYjrJT2uaAa9Ceuu5efPNal
         0NmQ0HKKW+N0a0OKgipkJWktFzoevgwg/Wo46yyzDFY3+GEAnfwUbRCkpwDGe4YM2TUL
         SdDsD7nlxzl8H/mmWmk2uHCGJ6GhpPzFA4iZKtmqo71h5/QS0EhBD63Fht9psMb/bEer
         FnM9qu5Z0c6kVf1hXhmWF6crWBwkrotlCUCLRbfPacIKuw3JTA68wKU+Zrrk50gfaIA6
         RZq54e6kYIVsonsAozWDo78Tkl+c0p1sG/PKOFyjAdE2Bl1r5Go5LJjHiQZGXC9dvsnk
         QLkQ==
X-Gm-Message-State: APjAAAUG9wq8NTKMCOosi1GM6Pwib4E4E/Qkkkkk6vGj8GgtuZx+Rxg6
        1KZlP+ILdQ8+EnDYWqowrhRUqkHpfS53ZK/EFuoHHKyTQc/PvQ==
X-Google-Smtp-Source: APXvYqz19W2owPoKz+mA6kiWEUSTR8sk4af5EkB2e/vEhQHVrVOyBFIZCzLq8fe6Xg5K9N/ABY3tBHpcKTz1BD2FN4I=
X-Received: by 2002:a2e:a490:: with SMTP id h16mr5702791lji.251.1576791228697;
 Thu, 19 Dec 2019 13:33:48 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Dec 2019 22:33:37 +0100
Message-ID: <CACRpkdbY1XBspR0rrXVvCW2LwnRfA_DnA0YzwFy-dHCVhQSr0A@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for the v5.5 series
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

sorry that this fixes pull request took a while. Too much christmas
business going on.

This contains a few really important Intel fixes and some odd fixes.

Details in the signed tag as usual.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.5-3

for you to fetch changes up to 9e65527ac3bab5480529d1ad07d4d228cc0295cd:

  pinctrl: ingenic: Fixup PIN_CONFIG_OUTPUT config (2019-12-16 11:38:20 +0100)

----------------------------------------------------------------
Pin control fixes for the v5.5 kernel cycle:

- A host of fixes for the Intel baytrail and cherryview:
  properly serialize all register accesses and add the irqchip
  with the gpiochip as we need to, fix some pin lists and
  initialize the hardware in the right order.
- Fix the Aspeed G6 LPC configuration.
- Handle a possible NULL pointer exception in the core.
- Fix the Kconfig dependencies for the Equilibrium driver.

----------------------------------------------------------------
Alexandre Torgue (1):
      pinctrl: pinmux: fix a possible null pointer in
pinmux_can_be_used_for_gpio

Andrew Jeffery (1):
      pinctrl: aspeed-g6: Fix LPC/eSPI mux configuration

Andy Shevchenko (3):
      pinctrl: baytrail: Update North Community pin list
      pinctrl: baytrail: Add GPIO <-> pin mapping ranges via callback
      pinctrl: baytrail: Pass irqchip when adding gpiochip

Hans de Goede (4):
      pinctrl: baytrail: Really serialize all register accesses
      pinctrl: cherryview: Split out irq hw-init into a separate helper function
      pinctrl: cherryview: Add GPIO <-> pin mapping ranges via callback
      pinctrl: cherryview: Pass irqchip when adding gpiochip

Linus Walleij (1):
      Merge tag 'intel-pinctrl-v5.5-2' of
git://git.kernel.org/.../pinctrl/intel into fixes

Paul Cercueil (1):
      pinctrl: ingenic: Fixup PIN_CONFIG_OUTPUT config

Rahul Tanwar (1):
      pinctrl: Modify Kconfig to fix linker error

 drivers/pinctrl/Kconfig                    |   1 +
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c |  24 ++--
 drivers/pinctrl/intel/pinctrl-baytrail.c   | 200 ++++++++++++++++-------------
 drivers/pinctrl/intel/pinctrl-cherryview.c | 107 ++++++++-------
 drivers/pinctrl/pinctrl-ingenic.c          |   2 +-
 drivers/pinctrl/pinmux.c                   |   2 +-
 6 files changed, 184 insertions(+), 152 deletions(-)
