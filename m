Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A39DC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 09:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DA72166E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 09:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4fnE0Lc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfHJJBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 05:01:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38618 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfHJJBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 05:01:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id r9so94175092ljg.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 02:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oD/Q6G/6W7nTlypRrPNMZQgnb5/E1uytnbBR5dQIk4Q=;
        b=J4fnE0Lcep5KmTR/bSIzJSIUS/cLyiUz2x4KsdUfRK5dB/gjcfCfslOEfBcLw52rgs
         EMviEh1o+yJISGq8uMDk7CV/aA94Xc8NFKmZvsT04xbm7Sv1egPq8EkG8Y+2LLnk1WIp
         IrB/TgtySjNylZf3B+oeGGmCRQ5VJUeeCWEvcwQRkDF/M4UYAzaIyntpdKQgV9cmmOJa
         naPD8MS/fUk0c1RBADmraZ/2TGk45RNDcWb63BjppByRH/TKd1nI3hWIfmdgI9rvv+03
         g+pQxjpAki6ZqDOXULCRgqNYJCi7TMJX7BWhbfllYt1/OR5QjmgVM4VfingW/CpkN85a
         fK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oD/Q6G/6W7nTlypRrPNMZQgnb5/E1uytnbBR5dQIk4Q=;
        b=BAJf+SsQcapMtMq5+zaUKHimFpbu6nXz5HYVykCQsQ1NC35aYTgCuk8GQph5hXLtE6
         iVregFqidXvU3tHaaA8PHns5Ndq45OLnpAtfLXclydQmfi6sfIG7D/nV71MJetlQa+xX
         rOGmgCJlZVOkRbQRHM7KjTTl+8Mp/MB78zSPty9XE4HlaXip7L2HyMQk92oD1qZ/ybin
         ntAufcBdHOKmPCbCH8tLcPl/Ydw+TGs0enTyMonzsGB4wBPFWPNXcXZoVzWbZHqqHtoO
         JzzdxbFqhkyhZCZjWqXtd8hefU9/XYNrvNqMy5I/eMWtszO5M4Ayqj4r65UP5KYUWTeL
         QZmQ==
X-Gm-Message-State: APjAAAWbevvdaBxj7APQlVFmTAmkK8P1EgUKeuavfAkSNymBMVx+5ujN
        +WpjAT959I4kC+6GiuErzmU/N3N4eanX4vSq7NhOWg==
X-Google-Smtp-Source: APXvYqzAONLPdh4o+NouNG/QFJxb4T9bH5J8zHJQGa7JZySBNXe2HJoRmhj4JGiLvN+pM/qj2zTkv397Dbnvlxzplg4=
X-Received: by 2002:a2e:9048:: with SMTP id n8mr13725271ljg.37.1565427672367;
 Sat, 10 Aug 2019 02:01:12 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 10 Aug 2019 11:01:00 +0200
Message-ID: <CACRpkdaMp16=-NGxOhe_Gz-vvoZrN7S+CE6zVmD+erVU051kmQ@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some pin control fixes for the v5.3 development.

I should have sent earlier, vacation interfered. Thus there
is a syntax fix I would normally not put in as fix at this point in
this set, but I think it is no big deal.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.3-2

for you to fetch changes up to 8c4407de3be44c2a0ec3e316cd3e4a711bc2aaba:

  pinctrl: aspeed: Make aspeed_pinmux_ips static (2019-07-29 23:35:31 +0200)

----------------------------------------------------------------
Some pin control fixes for the v5.4 series:

- Delay acquisition of regmaps in the Aspeed G5 driver.

- Make a symbol static to reduce compiler noise.

----------------------------------------------------------------
Andrew Jeffery (1):
      pinctrl: aspeed-g5: Delay acquisition of regmaps

YueHaibing (1):
      pinctrl: aspeed: Make aspeed_pinmux_ips static

 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c |  2 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 92 +++++++++++++++++++++---------
 drivers/pinctrl/aspeed/pinctrl-aspeed.c    | 12 ++--
 drivers/pinctrl/aspeed/pinmux-aspeed.c     |  2 +-
 drivers/pinctrl/aspeed/pinmux-aspeed.h     |  5 +-
 5 files changed, 75 insertions(+), 38 deletions(-)
