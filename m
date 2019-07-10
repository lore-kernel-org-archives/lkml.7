Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E79DC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37ABA20693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ugp7S7GF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfGJUWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:22:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43680 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfGJUWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:22:12 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so7533313ios.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 13:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlFRlvlH9bN0SYpSDNk4APXnCg4d/CNCqu9ZPK+njpg=;
        b=Ugp7S7GFWdWPqCLlfCk+lMD6r2Vg7SKm/PaJOARJkx7lubIx1VUsoQQeklzDVBe/5O
         dOlmTOahKL1oFh+CKCrVBRY+ZaLF7YKnqm+F2oVkHTvC7JiAcNI6xgGAeo/miO9eMT2T
         4VgFxIdDMYWHgNraVouGl6QVmCdZ4+fCMklhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlFRlvlH9bN0SYpSDNk4APXnCg4d/CNCqu9ZPK+njpg=;
        b=i1YMPrIBcdEOnDSUCk74IEzm0SwSdUMWpOaJMzk2XlnUXVzRESXE3GxV6Fq735ukBO
         by5bWGv04WvkeT7isIhqjQdcKa+4iQQ2ssGiUQjS7vk0LWa+fNORNvCg444xI67Eudi/
         ZC4uq5qOWAli+a9p7xPoTEGJcMEWdOnlRkzXPGwY95NL2hX9BVz+6w7JjPu2261toDtR
         l9nsyTBbyhN6ZQ3jVs41+j8c0GZrsPJOciAy+rwCns9O39KmRUqv/jna0X7hU8ZIboeC
         6+Qg/gvwNlZ5Up3p76n023wI4ZsRidMzXTmGXbz0VUu+FA59/YUvCeKJje1tdIHhSytF
         1tjg==
X-Gm-Message-State: APjAAAUvzwslMJX1hxXJbPz+y8TuKjyOO8eV9QsbmPBjDCQ4vTWPL3Kh
        wGfMLcdjkK5r2RgdZ6Yrm5irwpLBnmU=
X-Google-Smtp-Source: APXvYqxjEzb7gpgvKmHURF8uHFO96GhooNvNvr4rOd2OswagxLQxnHRiaZ4ZNZK043tiluA1Mqtwpw==
X-Received: by 2002:a6b:e60b:: with SMTP id g11mr4300703ioh.9.1562790131061;
        Wed, 10 Jul 2019 13:22:11 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id e84sm3288897iof.39.2019.07.10.13.22.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 13:22:09 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id u19so7533305ior.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 13:22:09 -0700 (PDT)
X-Received: by 2002:a5d:885a:: with SMTP id t26mr11784877ios.218.1562790128781;
 Wed, 10 Jul 2019 13:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190708195613.205729-1-dianders@chromium.org>
 <CAJKOXPf9OTPaheUdiZtaDGU0sE2vsdRiLx5nptMt_EVKU7GObA@mail.gmail.com>
 <CAD=FV=WquwqKjUKh5=M6tbTrD3svVTGWLU3iSTzD-uXBX73YWA@mail.gmail.com> <CAD=FV=X=RALazfX+vjQ7E-JmVu6xqDWCad5hPF+gNtHCuvZMTA@mail.gmail.com>
In-Reply-To: <CAD=FV=X=RALazfX+vjQ7E-JmVu6xqDWCad5hPF+gNtHCuvZMTA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 10 Jul 2019 13:21:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WL_Hy78REn+0CMOjYgPcuDcN1w-+94QD9HHJraQBNj4g@mail.gmail.com>
Message-ID: <CAD=FV=WL_Hy78REn+0CMOjYgPcuDcN1w-+94QD9HHJraQBNj4g@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix occasional hang after tuning on eMMC
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 9, 2019 at 3:02 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Jul 9, 2019 at 9:38 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Jul 9, 2019 at 2:07 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Tue, 9 Jul 2019 at 00:48, Douglas Anderson <dianders@chromium.org> wrote:
> > > >
> > > > In commit 46d179525a1f ("mmc: dw_mmc: Wait for data transfer after
> > > > response errors.") we fixed a tuning-induced hang that I saw when
> > > > stress testing tuning on certain SD cards.  I won't re-hash that whole
> > > > commit, but the summary is that as a normal part of tuning you need to
> > > > deal with transfer errors and there were cases where these transfer
> > > > errors was putting my system into a bad state causing all future
> > > > transfers to fail.  That commit fixed handling of the transfer errors
> > > > for me.
> > > >
> > > > In downstream Chrome OS my fix landed and had the same behavior for
> > > > all SD/MMC commands.  However, it looks like when the commit landed
> > > > upstream we limited it to only SD tuning commands.  Presumably this
> > > > was to try to get around problems that Alim Akhtar reported on exynos
> > > > [1].
> > > >
> > > > Unfortunately while stress testing reboots (and suspend/resume) on
> > > > some rk3288-based Chromebooks I found the same problem on the eMMC on
> > > > some of my Chromebooks (the ones with Hynix eMMC).  Since the eMMC
> > > > tuning command is different (MMC_SEND_TUNING_BLOCK_HS200
> > > > vs. MMC_SEND_TUNING_BLOCK) we were basically getting back into the
> > > > same situation.
> > > >
> > > > I'm hoping that whatever problems exynos was having in the past are
> > > > somehow magically fixed now and we can make the behavior the same for
> > > > all commands.
> > > >
> > > > [1] https://lkml.kernel.org/r/CAGOxZ53WfNbaMe0_AM0qBqU47kAfgmPBVZC8K8Y-_J3mDMqW4A@mail.gmail.com
> > > >
> > > > Fixes: 46d179525a1f ("mmc: dw_mmc: Wait for data transfer after response errors.")
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > Cc: Alim Akhtar <alim.akhtar@gmail.com>
> > > > Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > > ---
> > > > Marek (or anyone else using exynos): is it easy for you to test this
> > > > and check if things are still broken when we land this patch?  If so,
> > > > I guess we could have a quirk to have different behavior for just
> > > > Rockchip SoCs but I'd rather avoid that if possible.
> > > >
> > > > NOTE: I'm not hoping totally in vain here.  It is possible that some
> > > > of the CTO/DTO timers that landed could be the magic that would get
> > > > exynos unstuck.
> > >
> > > I have eMMC module attached to Odroid U3 (Exynos4412,
> > > samsung,exynos4412-dw-mshc). What is the testing procedure? With your
> > > patch it boots fine:
> > > [    3.698637] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
> > > req 52000000Hz, actual 50000000HZ div = 0)
> > > [    3.703900] mmc1: new DDR MMC card at address 0001
> > > [    3.728458] mmcblk1: mmc1:0001 008G92 7.28 GiB
> >
> > To really test it, it'd be nice to see some HS200 eMMC cards enumerate
> > OK.  Specifically the patch adjusts the error handling and the place
> > where that happens mostly is during tuning.
> >
> > I'll also try to find some time today to check a peach_pit or a
> > peach_pi.  I think I saw one in the pile near my desk so if it isn't
> > in too bad of a shape I can give mainline a shot on it.
>
> OK, I managed to get an exynos5800-peach-pi up and running.  I put my
> patch in place and am currently at 45 reboots and counting w/ no
> problems.

In case it helps, I made it through 2379 more reboots on my peach_pi
w/ no hangs.  I'm putting the device back in mothball now.  :-P  I
didn't go back and try to reproduce the original problems so I guess I
can't assert with 100% authority that the original issue is gone, but
my testing combined with Enric's seems like things are working fine.

-Doug
