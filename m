Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82C4C73C5C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F97B20656
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuGNttqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfGIVsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 17:48:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43533 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbfGIVsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 17:48:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id w17so208101qto.10;
        Tue, 09 Jul 2019 14:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pObonpCVhBSmmiSRgLF61Ki0eXVsuxi+cPBVrWAPOgE=;
        b=WuGNttqWLWY2ZilDDq/cmXWwieqNlqYaoKgGTV0hs6MhLCzsar9IieghREaCh12pYO
         mcSt3MXg/FQYOVdTIgRq0nWk69auT0nVFM8ENzugPJBpWwUvOlEc4qdUXsFnytl52WPD
         fnyQQ34giXP4UTEt3hul2/BNMfkG9JnY9IOuYkleXLWm2gzUkV+4fti5PAkbjdTpmLHg
         LSfhIRit46IAjUz16kYPCPSxwvr6J3u3V3sskmTndoVu+bktVyIuaQjEuURE5ivelgmw
         wQsqDZ+0b+cILcmlUzAdcrWl+Chr4ij+F9O7xc33ez5NfLN4VxHvSftK6Pxlrk4JyX+z
         GjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pObonpCVhBSmmiSRgLF61Ki0eXVsuxi+cPBVrWAPOgE=;
        b=Nu91DPkhqEsZBDKkzejFC4Xq8AY0oahXriuSMBrjmO4FdUccD6hKTiueM1hgXTMAlD
         3gtXAB1rhLD1FYv7V3dlkLIWohDF55BZZVwZQ8DcnwdcXh19ghMQrHH7jReHRjwI+MAq
         wxyE/oqtLWqBoQwSpDorLBPK/rBuC1gei3xm6+X0TsgX63mtVAjdA98ahvwuSVRE1ExJ
         Mt1oXjkCFayQ7YyKGaVf19l8F48HIMYyw+vEei3f+pBK/Bx+bYAMIU52TWIM3IzpfgF7
         wNafY4TkZKKrUmDMirJRd9QRzTen+FmTxKR3UAkh3le3dTnVuxY/nTi4dUzVcUPNg2VF
         bg1A==
X-Gm-Message-State: APjAAAV9sJaG+hvBncMzONFQkHc5ovGomrDUdyikt6MdnEWFGi4PnHlC
        Atqbd8vHqArr+yELMiZ7Z7rKM9GAW1MfP/4I2XNSM+jQOXI=
X-Google-Smtp-Source: APXvYqyywjCWmRSpegmDraZaGC6H19pvew0Xiws8Ie8gSnqctiNwYxTuBCPdVFk8g5+yZmE855EOfG09T0cwXg0mVKw=
X-Received: by 2002:ac8:1c2d:: with SMTP id a42mr20603885qtk.311.1562708910876;
 Tue, 09 Jul 2019 14:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190708195613.205729-1-dianders@chromium.org>
 <CAJKOXPf9OTPaheUdiZtaDGU0sE2vsdRiLx5nptMt_EVKU7GObA@mail.gmail.com> <CAD=FV=WquwqKjUKh5=M6tbTrD3svVTGWLU3iSTzD-uXBX73YWA@mail.gmail.com>
In-Reply-To: <CAD=FV=WquwqKjUKh5=M6tbTrD3svVTGWLU3iSTzD-uXBX73YWA@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 9 Jul 2019 23:48:19 +0200
Message-ID: <CAFqH_52Vhonb0ui5eXVHtyt+3td=_9pLZBWTBsHBgt34bX=H+Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix occasional hang after tuning on eMMC
To:     Doug Anderson <dianders@chromium.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alim Akhtar <alim.akhtar@gmail.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Missatge de Doug Anderson <dianders@chromium.org> del dia dt., 9 de
jul. 2019 a les 18:38:
>
> Hi,
>
> On Tue, Jul 9, 2019 at 2:07 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Tue, 9 Jul 2019 at 00:48, Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > In commit 46d179525a1f ("mmc: dw_mmc: Wait for data transfer after
> > > response errors.") we fixed a tuning-induced hang that I saw when
> > > stress testing tuning on certain SD cards.  I won't re-hash that whole
> > > commit, but the summary is that as a normal part of tuning you need to
> > > deal with transfer errors and there were cases where these transfer
> > > errors was putting my system into a bad state causing all future
> > > transfers to fail.  That commit fixed handling of the transfer errors
> > > for me.
> > >
> > > In downstream Chrome OS my fix landed and had the same behavior for
> > > all SD/MMC commands.  However, it looks like when the commit landed
> > > upstream we limited it to only SD tuning commands.  Presumably this
> > > was to try to get around problems that Alim Akhtar reported on exynos
> > > [1].
> > >
> > > Unfortunately while stress testing reboots (and suspend/resume) on
> > > some rk3288-based Chromebooks I found the same problem on the eMMC on
> > > some of my Chromebooks (the ones with Hynix eMMC).  Since the eMMC
> > > tuning command is different (MMC_SEND_TUNING_BLOCK_HS200
> > > vs. MMC_SEND_TUNING_BLOCK) we were basically getting back into the
> > > same situation.
> > >
> > > I'm hoping that whatever problems exynos was having in the past are
> > > somehow magically fixed now and we can make the behavior the same for
> > > all commands.
> > >
> > > [1] https://lkml.kernel.org/r/CAGOxZ53WfNbaMe0_AM0qBqU47kAfgmPBVZC8K8Y-_J3mDMqW4A@mail.gmail.com
> > >
> > > Fixes: 46d179525a1f ("mmc: dw_mmc: Wait for data transfer after response errors.")
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Cc: Alim Akhtar <alim.akhtar@gmail.com>
> > > Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > ---
> > > Marek (or anyone else using exynos): is it easy for you to test this
> > > and check if things are still broken when we land this patch?  If so,
> > > I guess we could have a quirk to have different behavior for just
> > > Rockchip SoCs but I'd rather avoid that if possible.
> > >
> > > NOTE: I'm not hoping totally in vain here.  It is possible that some
> > > of the CTO/DTO timers that landed could be the magic that would get
> > > exynos unstuck.
> >
> > I have eMMC module attached to Odroid U3 (Exynos4412,
> > samsung,exynos4412-dw-mshc). What is the testing procedure? With your
> > patch it boots fine:
> > [    3.698637] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
> > req 52000000Hz, actual 50000000HZ div = 0)
> > [    3.703900] mmc1: new DDR MMC card at address 0001
> > [    3.728458] mmcblk1: mmc1:0001 008G92 7.28 GiB
>
> To really test it, it'd be nice to see some HS200 eMMC cards enumerate
> OK.  Specifically the patch adjusts the error handling and the place
> where that happens mostly is during tuning.
>
> I'll also try to find some time today to check a peach_pit or a
> peach_pi.  I think I saw one in the pile near my desk so if it isn't
> in too bad of a shape I can give mainline a shot on it.
>

I did a normal boot on peach_pi [1] and odroidxu3 [2] with that patch
applied, and the eMMC attached on both was detected as

 [    2.294798] mmc0: new HS400 MMC card at address 0001

I can do some stress tests tomorrow on those boards if that helps.

Cheers,
~ Enric

[1] https://storage.kernelci.org/chrome-platform/for-kernelci/ib-mfd-cros-v5.3-87-g0fe7e9d7d5a3/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-exynos5800-peach-pi.html
[2] https://storage.kernelci.org/chrome-platform/for-kernelci/ib-mfd-cros-v5.3-87-g0fe7e9d7d5a3/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-exynos5422-odroidxu3.html

> -Doug
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
