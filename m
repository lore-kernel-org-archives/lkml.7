Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF7DC49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D07D20650
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/JOEZTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbfILI3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:29:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40006 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730125AbfILI3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:29:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so22715597ljw.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 01:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AWT+r6/NgVobzeH1u98/3A5yGwSecklVJ9rqaQzylB0=;
        b=m/JOEZTjFPzWHbSmnr5nr/Tdgu6cFmzrYLIQjyCa8sXFWKn83drTTd91g4MK0HMczx
         EvdRww1VzMqHz/p7Edx5K68PlE+PVc0zjg+Zv3xjzcgIcnvB6dse9FWjUe65gHNQ5ijr
         EyaMfYC9QxuPnjjawE+EJrQMn+3n6H6qiyvli3aL7caP+QsYDBGaj+0nAUYA00YwsPNC
         Vuho4SzqP7gYxBshamH3wbEZ9iVSQSf85AOi68fbcH+xtZvuf6SvjqjFJCJ1OufRVlNR
         rFDT0EYKdP3Em06q/O1d+bF2DE4doCj94737U4FTZnNhBhBIer+FKhx02qkLDLl51qcQ
         RZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AWT+r6/NgVobzeH1u98/3A5yGwSecklVJ9rqaQzylB0=;
        b=PZp/j5be6ATKsjSImlszGTGV+jmWV4dks7FMV2W/FfM+1GiIyb43GtGyAVRnBQm4fO
         Nf90kZotwb7fKXfwf99XVp0HAoB6P+sZIQ0EFKCLDPjrs+Ali/4lAkPobY/5zlfgE5aC
         2ixwMApqbRlWiy314lp0X8nwoa5OC4AGbEmphHD48ZWWXyPfLR25UDk0b8Cf2XKSJdqW
         3sFabrgJVbJTIDIAY8lGucA6UacWmaldAPvqJboUig4o7yxDoRqJs3Lm1SnmI+D0C8sK
         kRM5PE5FXPi5lQ2WOb4FQOdnhkP2Jr8pw9YKEBVqZZTuAo22CyW2mF9Z5CPzufCMMp46
         Ow3w==
X-Gm-Message-State: APjAAAUKZt7I6XQAqDwzQO2Q9n6xwa0lG9llWy/Gqsb7NtcMVCsHlR+M
        MnARimoCl/I7dH0Heduu1dWiwfXkYKYLig/2OCu7ZA==
X-Google-Smtp-Source: APXvYqwAI869nyytO0eJsd4fc6BSdITrx5GuQ64geJL29p/gUUY6gSER0UCDyqE6Bdh0ZZgyOvEhIFWATYfZ660KXQI=
X-Received: by 2002:a2e:8056:: with SMTP id p22mr20686035ljg.69.1568276948342;
 Thu, 12 Sep 2019 01:29:08 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 09:28:57 +0100
Message-ID: <CACRpkdaF8PNXBR2+d7OBWmR7wqRy=iP3OOCJDAFV0rf_e5PaZQ@mail.gmail.com>
Subject: [GIT PULL] last pin control fix for v5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is a hopefully last pin control fix for the Aspeed.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit d45331b00ddb179e291766617259261c112db872:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.3-3

for you to fetch changes up to c1432423a16825ef94e019808ed7330ee33ffc69:

  pinctrl: aspeed: Fix spurious mux failures on the AST2500
(2019-09-12 00:08:27 +0100)

----------------------------------------------------------------
Pin control fixes for v5.3:
- A single patch for some Aspeed problems. The BMCs are much
  happier now.

----------------------------------------------------------------
Andrew Jeffery (1):
      pinctrl: aspeed: Fix spurious mux failures on the AST2500

 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 30 +++++++++++++++++++++++++++++-
 drivers/pinctrl/aspeed/pinmux-aspeed.c     |  7 +++++--
 drivers/pinctrl/aspeed/pinmux-aspeed.h     |  7 ++++---
 3 files changed, 38 insertions(+), 6 deletions(-)
