Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AA7C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7CF206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLNmAwml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKKHoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:44:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34433 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfKKHoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 02:44:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id e6so13510677wrw.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 23:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hBbBXxtB4JGrAZVYwMzrM6N5+DTJrDtT85S5KcS/BSo=;
        b=bLNmAwmlYqMOXoRD7nIagqUBAznwl4rTE7PVm7hKKWihFmJN69jpPWmeMnxrRIpKJ7
         WriR09Zo4VYj5FBB0WhZzZvDP5IzS2hi0oCUphMP4CAY9fawe6Q/0A0XtBPdUVXdmDC2
         +v4p+fD+YLPYL6jkkNERCvIGgqVu26f+gEdQEn2bUS3S4uTPpOIGwlU2mf79ZaLg/Clj
         CYPBm+ThN/pHZ2PmrMtOyuDW7RqgEexOftCPM9I9o61SafRgyKUBHylqeBqzAmtTS87P
         eXNKZHSFcyRn+PmyGts7VRsCL+TSlFbZQK0XPWUlRVA1oLkP7J/hJ+B4AJ/bE0PEPDOr
         BueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hBbBXxtB4JGrAZVYwMzrM6N5+DTJrDtT85S5KcS/BSo=;
        b=t5zkA3XhbWDy9GRS9aLzjOykj8XRoEFYptv3/fRnf2yonNjsAm/nPhz40zS9wthm5P
         a7Dr3J6/kmBeMybeC8GqfvKHr9j7OrXTCei5Xr7rOQddD2BiBrBpsrKQ43qKBU+SLat4
         z/BOBPPNsGRxAMg9mN2WgvxN0Wr9Ux5b6rXcrm2OFJf871Q8MTKDxvYOWLfB8juD2CmN
         uHRaYTksdFFp21VLzGl0gBU6CEIQEaYH2pbmW46mvqdc5R3yC8G9T5MP1/6eGy/MNisp
         X3SBJLXxvcc+thqwewNdItQ+4MKNgoCzlVZDu5DelU/BAnyXEe40f89yOlFLMmL+DIm5
         qPRA==
X-Gm-Message-State: APjAAAWqwcfclBRsvXB1OKiz7EMQ7vhOtCiU5jgu9BgvTy1zYVaLcrYk
        1HI8qIpTPJt/YFDv5YxP9OyMaA==
X-Google-Smtp-Source: APXvYqxSsd7eDpxdDNpxnC/L7qzZ+aHe+8v5YGClauimnF6TLrUu+Mb9R+pXcwC92caBEU1o4oxL7A==
X-Received: by 2002:adf:b686:: with SMTP id j6mr19230608wre.186.1573458258403;
        Sun, 10 Nov 2019 23:44:18 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id 189sm3187351wme.28.2019.11.10.23.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 23:44:17 -0800 (PST)
Date:   Mon, 11 Nov 2019 07:44:10 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 0/9] backlight: gpio: simplify the driver
Message-ID: <20191111074410.GD18902@dell>
References: <20191022083630.28175-1-brgl@bgdev.pl>
 <CAMRc=MeyrDZgmHJ+2SMipP7y9NggxiVfkAh4kCLePFWvUku9aQ@mail.gmail.com>
 <20191023155941.q563d3cfizre4zvt@holly.lan>
 <20191024064726.GB15843@dell>
 <20191024071703.6keoebzlfnn2qmyd@uno.localdomain>
 <20191101085803.GD5700@dell>
 <20191101154133.qqjj3uriwrl2j5r5@uno.localdomain>
 <CAMRc=MejNQAPUXQkJsVFBxcQUJ83xRF0ntKM2ssnAxc1C+7Jjg@mail.gmail.com>
 <CAMRc=Meh1jdc562bTHEfodyud7B0dBM+Lti3ZaCBUaqOjDhaCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Meh1jdc562bTHEfodyud7B0dBM+Lti3ZaCBUaqOjDhaCQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Nov 2019, Bartosz Golaszewski wrote:

> pon., 4 lis 2019 o 10:22 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
> >
> > pt., 1 lis 2019 o 16:39 Jacopo Mondi <jacopo@jmondi.org> napisał(a):
> > >
> > > Hello,
> > >   as promised...
> > >
> > > On Fri, Nov 01, 2019 at 08:58:03AM +0000, Lee Jones wrote:
> > > > On Thu, 24 Oct 2019, Jacopo Mondi wrote:
> > > >
> > > > > Hello,
> > > > >
> > > > > On Thu, Oct 24, 2019 at 07:47:26AM +0100, Lee Jones wrote:
> > > > > > On Wed, 23 Oct 2019, Daniel Thompson wrote:
> > > > > >
> > > > > > > On Tue, Oct 22, 2019 at 11:29:54AM +0200, Bartosz Golaszewski wrote:
> > > > > > > > wt., 22 paź 2019 o 10:36 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
> > > > > > > > >
> > > > > > > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > > > > > >
> > > > > > > > > While working on my other series related to gpio-backlight[1] I noticed
> > > > > > > > > that we could simplify the driver if we made the only user of platform
> > > > > > > > > data use GPIO lookups and device properties. This series tries to do
> > > > > > > > > that.
> > > > > > > > >
> > > > > > > > > First two patches contain minor fixes. Third patch makes the driver
> > > > > > > > > explicitly drive the GPIO line. Fourth patch adds all necessary data
> > > > > > > > > structures to ecovec24. Patch 5/9 unifies much of the code for both
> > > > > > > > > pdata and non-pdata cases. Patches 6-7/9 remove unused platform data
> > > > > > > > > fields. Last two patches contain additional improvements for the GPIO
> > > > > > > > > backlight driver while we're already modifying it.
> > > > > > > > >
> > > > > > > > > I don't have access to this HW but hopefully this works. Only compile
> > > > > > > > > tested.
> > > > > > > > >
> > > > > > > > > [1] https://lkml.org/lkml/2019/6/25/900
> > > > > > > > >
> > > > > > > > > v1 -> v2:
> > > > > > > > > - rebased on top of v5.3-rc1 and adjusted to the recent changes from Andy
> > > > > > > > > - added additional two patches with minor improvements
> > > > > > > > >
> > > > > > > > > v2 -> v3:
> > > > > > > > > - in patch 7/7: used initializers to set values for pdata and dev local vars
> > > > > > > > >
> > > > > > > > > v3 -> v4:
> > > > > > > > > - rebased on top of v5.4-rc1
> > > > > > > > > - removed changes that are no longer relevant after commit ec665b756e6f
> > > > > > > > >   ("backlight: gpio-backlight: Correct initial power state handling")
> > > > > > > > > - added patch 7/7
> > > > > > > > >
> > > > > > > > > v4 -> v5:
> > > > > > > > > - in patch 7/7: added a comment replacing the name of the function being
> > > > > > > > >   pulled into probe()
> > > > > > > > >
> > > > > > > > > v5 -> v6:
> > > > > > > > > - added a patch making the driver explicitly set the direction of the GPIO
> > > > > > > > >   to output
> > > > > > > > > - added a patch removing a redundant newline
> > > > > > > > >
> > > > > > > > > v6 -> v7:
> > > > > > > > > - renamed the function calculating the new GPIO value for status update
> > > > > > > > > - collected more tags
> > > > > > > > >
> > > > > > > > > Bartosz Golaszewski (9):
> > > > > > > > >   backlight: gpio: remove unneeded include
> > > > > > > > >   backlight: gpio: remove stray newline
> > > > > > > > >   backlight: gpio: explicitly set the direction of the GPIO
> > > > > > > > >   sh: ecovec24: add additional properties to the backlight device
> > > > > > > > >   backlight: gpio: simplify the platform data handling
> > > > > > > > >   sh: ecovec24: don't set unused fields in platform data
> > > > > > > > >   backlight: gpio: remove unused fields from platform data
> > > > > > > > >   backlight: gpio: use a helper variable for &pdev->dev
> > > > > > > > >   backlight: gpio: pull gpio_backlight_initial_power_state() into probe
> > > > > > > > >
> > > > > > > > >  arch/sh/boards/mach-ecovec24/setup.c         |  33 +++--
> > > > > > > > >  drivers/video/backlight/gpio_backlight.c     | 128 +++++++------------
> > > > > > > > >  include/linux/platform_data/gpio_backlight.h |   3 -
> > > > > > > > >  3 files changed, 69 insertions(+), 95 deletions(-)
> > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > > > Lee, Daniel, Jingoo,
> > > > > > > >
> > > > > > > > Jacopo is travelling until November 1st and won't be able to test this
> > > > > > > > again before this date. Do you think you can pick it up and in case
> > > > > > > > anything's broken on SH, we can fix it after v5.5-rc1, so that it
> > > > > > > > doesn't miss another merge window?
> > > > > >
> > > > > > November 1st (-rc6) will be fine.
> > > > > >
> > > > > > I'd rather apply it late-tested than early-non-tested.
> > > > > >
> > > > > > Hopefully Jacopo can prioritise testing this on Thursday or Friday,
> > > > > > since Monday will be -rc7 which is really cutting it fine.
> > > > >
> > > > > I'll do my best, I'll get home Friday late afternoon :)
> > > >
> > > > Welcome home!
> > > >
> > > > Just a little reminder in your inbox. TIA. :)
> > >
> > > For the ecovec part:
> > > Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > >
> >
> > Thanks Jacopo!
> >
> > Lee: I hope it's not too late to get it picked up for v5.5?
> >
> 
> Hi, just a gentle ping for this series, because I'm afraid it will
> miss yet another merge window.

I have it marked to handle it, along with 10's of others.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
