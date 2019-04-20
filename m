Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE73C282E4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F4B205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qaZ8lzoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfDTJYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 05:24:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43365 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTJYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 05:24:03 -0400
Received: by mail-ot1-f67.google.com with SMTP id u15so5996430otq.10;
        Sat, 20 Apr 2019 02:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Gb4/VMu7KH5rxCB7x/AZRSTQfoVJyp09bqTmrvK/YA=;
        b=qaZ8lzoUYYFnk+Usd9KrVY3GM7kajdk1D4RL26DCG+K+DrT7/PSfCyX/412VOM9Di9
         GONs056tAErtnwcw+/+CmU+cWHrCZkRcZIXZc96kQlXieE/muBnSCQJbTWAnF8Q7vcre
         CUiIIJUo7TL6kYOysdexDtTVK9SKCWDnVWs0/3uAmmDIkhcPcHeDS6pNzuOGTAHXTurS
         DkC1PpaPMaDIJYEmmNBmcVCUjEPa22qisXRkKXRRDOg+CaRJfU8+llNsTAbLPUzj9TUj
         iGgtTE+Ck6ALbGsm0AYzx4Bj1+IRMMKKmqz2fTau1KXAPhJ+c9nVxp2lZmJUhJeKgRN9
         Si7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Gb4/VMu7KH5rxCB7x/AZRSTQfoVJyp09bqTmrvK/YA=;
        b=VkGw9/gdIeg/COcSKmyyYLYzinrtVikb+flxCcUiqv6STY7VkWQuvmh/Ujr/V/l8d1
         /dcbUzO4sWzUJKYWxTT4EFFTs2prs9dws6WoDjUGhy52m5yfdsS2nQevD1a3dUYo0hWn
         u2Y1kSj9Zu0xkSEvIhlhNdroLDFFqEyB+EIi1CG4VXdec2gWPyXfOSF4YD/TbBrNI0UA
         dSXRWV4+KkirX+flWuIP4SPxsraC8pylNnIq2Q/g+l4NEjxGk0ae5YoKA7xJc3mXM1il
         lyNB9o8FUqVGriGkbNa3usdtnr8Gm5xW49xhBHoAdYKALSYh012zo0WhOr6+9iX/HRGv
         zPbw==
X-Gm-Message-State: APjAAAWRXq0jSnWCCt3y94sUaHjYmDm9Kx1xoPG2pfl9c3axr+d0RLD/
        Czw+Rbgd3EvG0h8/033xGf8BZmhQPqGFpGHthoc=
X-Google-Smtp-Source: APXvYqxhGTYdMX6k/b7uYzLmx+89ZwQCwYkcqnAJHrnbaTvpka4HeMXsiP8119gswQQ9Ucv5yu4kByN6OHPH+OI59y0=
X-Received: by 2002:a9d:3db4:: with SMTP id l49mr5073251otc.131.1555752242781;
 Sat, 20 Apr 2019 02:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190417204355.469-1-jbrunet@baylibre.com> <20190417204355.469-6-jbrunet@baylibre.com>
 <CAFBinCCAbMpWYY6-W+909Q=jLpweC2F6ED6CVf6zVGrRiA1hxg@mail.gmail.com>
 <8316d7875bf0479e91cc11ce5fbf3b2e21f92a2c.camel@baylibre.com>
 <CAFBinCBQPSsqwDSd6nQMLqOuApiESwHXn4wQbOp49WLpXfBk=Q@mail.gmail.com>
 <5b19d32be23fbe630339fd48f93b16e9301385d1.camel@baylibre.com> <5d65cc12e18f9a4b86c097fbade0cef91b3b5d9b.camel@baylibre.com>
In-Reply-To: <5d65cc12e18f9a4b86c097fbade0cef91b3b5d9b.camel@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 20 Apr 2019 11:23:51 +0200
Message-ID: <CAFBinCBtc=Yb3WDgLzgnyd=NauaZnkQRnc08_j-XbiDybh=7cg@mail.gmail.com>
Subject: Re: [PATCH 5/7] mmc: meson-gx: avoid clock glitch when switching to
 DDR modes
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Fri, Apr 19, 2019 at 10:53 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Thu, 2019-04-18 at 23:15 +0200, Jerome Brunet wrote:
> > On Thu, 2019-04-18 at 22:53 +0200, Martin Blumenstingl wrote:
> > > Hi Jerome,
> > >
> > > On Thu, Apr 18, 2019 at 10:46 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > > On Thu, 2019-04-18 at 22:16 +0200, Martin Blumenstingl wrote:
> > > > > Hi Jerome,
> > > > >
> > > > > On Wed, Apr 17, 2019 at 10:44 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > > > > Activating DDR in the Amlogic mmc controller, among other things, will
> > > > > > divide the output clock by 2. So by activating it with clock on, we are
> > > > > > creating a glitch on the output.
> > > > > >
> > > > > > Instead, let's deal with DDR when the clock output is off, when setting
> > > > > > the clock.
> > > > > >
> > > > > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > > > > it seems that this patch breaks SD card on my Khadas VIM and Khadas VIM2.
> > > >
> > > > The error I see in your logs is with eMMC and hs200, not SD card.
> > > sorry, I should have been more clear that there are two errors:
> > > eMMC, this is what I have been seeing for a while on my Khadas VIM2
> > > (it's probably not related to this patch):
> > >    mmc1: mmc_select_hs200 failed, error -84
> > >    mmc1: error -84 whilst initialising MMC card
> >
> > Following patches were also supposed to help the vim2.
> > ... something I tested numerous time on this particular board.
> >
> > > however, then there's this other error:
> > >    print_req_error: I/O error, dev mmcblk0, sector 0 flags 0
> > >    Buffer I/O error on dev mmcblk0, logical block 0, async page read
> > > as result of this the partition table cannot be read and my kernel
> > > cannot find the rootfs.
> >
> > I don't know what the problem is (probably some CRC error - you can check the log
> > in interrupt for this) but I'm pretty sure it is not related to this patch.
> >
> > I see in the log SD is indeed in HS mode, so not in any DDR mode.
> > I also see that the SDIO fails as well. There something really weird, which can't
> > be explained by this patch alone AFAICT.
>
> Ok, I think I got it. It is indeed not linked to DDR, but a more trivial mistake.
> It looks like a writel went AWOL during the final rebase (and after the test campaign).
>
> in meson_mmc_set_ios, after:
> val |= FIELD_PREP(CFG_BUS_WIDTH_MASK, bus_width);
>
> Could you try adding
> writel(val, host->regs + SD_EMMC_CFG);
good catch!

> Without this, the bus width is not changed, which explains why eMMC, SD and SDIO fail
> on init.
I have added that missing writel on top of the whole series and now:
- SD card is detected again (same as without this series)
- SDIO wifi is detected again (same as without this series)
- eMMC is detected (was not working before)

I will give my Tested-by on v2 of these patches


Martin
