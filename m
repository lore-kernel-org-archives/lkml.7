Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB629CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CC0204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="svMRcQ9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfKAI6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 04:58:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36943 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfKAI6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 04:58:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id t1so3033564wrv.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 01:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=S5fQT2eVO9V38Zm9JZGmC3M3bk7YmWSMdjQ7Ok2mRcE=;
        b=svMRcQ9vBjrXT2qn/6kethfQvV0UlAW5sEgQDR41qIHly1Y8PT1R9cce8OhGLd23tx
         8OoR73wILPiH79hKzZCAP4sQknRdUDbuhN75ObUIOZBq09vMSCRi22PnDvfGt/T0EhnD
         U5/eHFT8izrZnKoCnfjiweDd96fr0mvLCl5r8+vViQtyq+6hcMM8SPjXuYD3mZMmj6T9
         wacRNcNQzaoyxuCBaFRrC4aQEkNk5mG1x3+V5UrYyc5eZoMYWBGjYGTLOu01I/64e0c3
         INlnHrvci6GbXLmUf64Lhq54JPwhwZOI90GH32o9yIvWsKOhBmPKzkWv1ln45tHgT0p1
         VWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=S5fQT2eVO9V38Zm9JZGmC3M3bk7YmWSMdjQ7Ok2mRcE=;
        b=UGCb56Yn5l2ZbqSjSg6xuvdHePemAw0YxkGXhCGULO6RxnAVP+5a6dmgUuYWEJQ6dZ
         1bq/yYaR2JjZcvWzRZ8uEdPjkmFs2pmJHMEam2yqt4Z9GETfKIaCZd8Od1b9r0SPcu4C
         u033J1I+aIALP5/+OhkIFx9PW3CthyHQTfbxjfjxxFmMpLID8L1MYHlHdSkZ5jjeE/5p
         z2TJldMgXz7WPjHpdUCpQQAGUNRTvwhe8MPr+Y5dpE84zpWDNjJJD63W0dB4hHRqosNr
         C/aJ9/5/PGE3th2FyhQOTo9HFhHYesrBfcvG6wMQEZXvgi49QRLFKQvKBYjOx9Cum/7Q
         aLmQ==
X-Gm-Message-State: APjAAAWmoT/PJ01d5LMtCqVFX/5II1AGM56QqBkyRTh31BV0A/UTOnKO
        HS2TxJIv5VYXNmo0ryCI3HbRMg==
X-Google-Smtp-Source: APXvYqx/0D/E3fqHGg3SO471Ql1SFjgo2/8jy1O0UmD3LhH76T/0FxaRwKHUwv0G597dXLhvqq/DfA==
X-Received: by 2002:adf:f048:: with SMTP id t8mr5980197wro.237.1572598685466;
        Fri, 01 Nov 2019 01:58:05 -0700 (PDT)
Received: from dell ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id s21sm9001511wrb.31.2019.11.01.01.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Nov 2019 01:58:04 -0700 (PDT)
Date:   Fri, 1 Nov 2019 08:58:03 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v7 0/9] backlight: gpio: simplify the driver
Message-ID: <20191101085803.GD5700@dell>
References: <20191022083630.28175-1-brgl@bgdev.pl>
 <CAMRc=MeyrDZgmHJ+2SMipP7y9NggxiVfkAh4kCLePFWvUku9aQ@mail.gmail.com>
 <20191023155941.q563d3cfizre4zvt@holly.lan>
 <20191024064726.GB15843@dell>
 <20191024071703.6keoebzlfnn2qmyd@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191024071703.6keoebzlfnn2qmyd@uno.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019, Jacopo Mondi wrote:

> Hello,
> 
> On Thu, Oct 24, 2019 at 07:47:26AM +0100, Lee Jones wrote:
> > On Wed, 23 Oct 2019, Daniel Thompson wrote:
> >
> > > On Tue, Oct 22, 2019 at 11:29:54AM +0200, Bartosz Golaszewski wrote:
> > > > wt., 22 paź 2019 o 10:36 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
> > > > >
> > > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > >
> > > > > While working on my other series related to gpio-backlight[1] I noticed
> > > > > that we could simplify the driver if we made the only user of platform
> > > > > data use GPIO lookups and device properties. This series tries to do
> > > > > that.
> > > > >
> > > > > First two patches contain minor fixes. Third patch makes the driver
> > > > > explicitly drive the GPIO line. Fourth patch adds all necessary data
> > > > > structures to ecovec24. Patch 5/9 unifies much of the code for both
> > > > > pdata and non-pdata cases. Patches 6-7/9 remove unused platform data
> > > > > fields. Last two patches contain additional improvements for the GPIO
> > > > > backlight driver while we're already modifying it.
> > > > >
> > > > > I don't have access to this HW but hopefully this works. Only compile
> > > > > tested.
> > > > >
> > > > > [1] https://lkml.org/lkml/2019/6/25/900
> > > > >
> > > > > v1 -> v2:
> > > > > - rebased on top of v5.3-rc1 and adjusted to the recent changes from Andy
> > > > > - added additional two patches with minor improvements
> > > > >
> > > > > v2 -> v3:
> > > > > - in patch 7/7: used initializers to set values for pdata and dev local vars
> > > > >
> > > > > v3 -> v4:
> > > > > - rebased on top of v5.4-rc1
> > > > > - removed changes that are no longer relevant after commit ec665b756e6f
> > > > >   ("backlight: gpio-backlight: Correct initial power state handling")
> > > > > - added patch 7/7
> > > > >
> > > > > v4 -> v5:
> > > > > - in patch 7/7: added a comment replacing the name of the function being
> > > > >   pulled into probe()
> > > > >
> > > > > v5 -> v6:
> > > > > - added a patch making the driver explicitly set the direction of the GPIO
> > > > >   to output
> > > > > - added a patch removing a redundant newline
> > > > >
> > > > > v6 -> v7:
> > > > > - renamed the function calculating the new GPIO value for status update
> > > > > - collected more tags
> > > > >
> > > > > Bartosz Golaszewski (9):
> > > > >   backlight: gpio: remove unneeded include
> > > > >   backlight: gpio: remove stray newline
> > > > >   backlight: gpio: explicitly set the direction of the GPIO
> > > > >   sh: ecovec24: add additional properties to the backlight device
> > > > >   backlight: gpio: simplify the platform data handling
> > > > >   sh: ecovec24: don't set unused fields in platform data
> > > > >   backlight: gpio: remove unused fields from platform data
> > > > >   backlight: gpio: use a helper variable for &pdev->dev
> > > > >   backlight: gpio: pull gpio_backlight_initial_power_state() into probe
> > > > >
> > > > >  arch/sh/boards/mach-ecovec24/setup.c         |  33 +++--
> > > > >  drivers/video/backlight/gpio_backlight.c     | 128 +++++++------------
> > > > >  include/linux/platform_data/gpio_backlight.h |   3 -
> > > > >  3 files changed, 69 insertions(+), 95 deletions(-)
> > > > >
> > > > >
> > > >
> > > > Lee, Daniel, Jingoo,
> > > >
> > > > Jacopo is travelling until November 1st and won't be able to test this
> > > > again before this date. Do you think you can pick it up and in case
> > > > anything's broken on SH, we can fix it after v5.5-rc1, so that it
> > > > doesn't miss another merge window?
> >
> > November 1st (-rc6) will be fine.
> >
> > I'd rather apply it late-tested than early-non-tested.
> >
> > Hopefully Jacopo can prioritise testing this on Thursday or Friday,
> > since Monday will be -rc7 which is really cutting it fine.
> 
> I'll do my best, I'll get home Friday late afternoon :)

Welcome home!

Just a little reminder in your inbox. TIA. :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
