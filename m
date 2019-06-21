Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FD6C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3D9206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1wcagAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfFUNn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:43:26 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46124 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUNn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:43:26 -0400
Received: by mail-ua1-f67.google.com with SMTP id o19so2954141uap.13;
        Fri, 21 Jun 2019 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q33VMB3ypbHwOwppVVrLlgmUH5mxcaA4HJxW2dFca6o=;
        b=D1wcagAnBTWmdUQeUme6lToz8OTYS/7I2UnlVWewxnV5IqtffAh5E3+h2dqHjnR0pX
         WhKJUFrSCXwFy2tMqIixRX3uFxe17AFa8GMsCi9p/GAwRy8jw2YhomZRCUp9Gdk/7Ge7
         seXrXjnwfOy9oKGmvvuBykq+fr0sqASSfggBSiChlAGQUZ6MVC2c4Mudl+0rIMkIXAgc
         kEL/I2wWsxe1Icti5ydiwnMWVX3N9fnxodmPs+3zkPbmZtnU6HiNB4EUhfAdDiiKudw9
         1tzp94IXaVMSlmBhtqAwR3y/Uj/7WMA26KO/847FNv6RE7HKIBb9H99BM3HpHsmuHb41
         WxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q33VMB3ypbHwOwppVVrLlgmUH5mxcaA4HJxW2dFca6o=;
        b=BGTYz+Ar5U+LLkYYHTlYDa55SEK2b3yEjMu6PjMItRS5LNJzPXlZAB5Ji7CistGa71
         GE1mzXjjItnsmGC38vQqDqL8E/ikvitOXfxf9PzjNNONUR0mE0/dRRvbyJhJ0h+07nsI
         3h80JzlSzLXgEPcLrLfcoN5C3Ogcj5eU6SfeQqTAuWqaIt2Rpb5JWsS8yk71qBYPqzl2
         RRDEVVR3WLNexKXT4JUXmUjBwfvafYKqETsImy7J0tqYZaGo07Ma3EKWcvJkM7sIJlsi
         twLin8kdKUvfR0+y5JpYqCfXeYLUfJjztdxos8tvXLG95Mx99U+p0pAkBFG76I0vUPeU
         8GEA==
X-Gm-Message-State: APjAAAVp0LZvLKSg6G6b9gqobnIe+aXL12NqtzSNOJRAWGKv6lzEQTnt
        poa1s+9wxFZID1e2lY5bEmbmIu2rLns1GfycGtE=
X-Google-Smtp-Source: APXvYqwrAtxG9WFdU7+zxFJH2xHp33ZglUqgqJOd0aECdFmqX9cAcxHDIo1ICcA1xNjdrxSU02d6Gmef1/iDikl2EL8=
X-Received: by 2002:ab0:2810:: with SMTP id w16mr15346167uap.118.1561124605074;
 Fri, 21 Jun 2019 06:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <1561064991-16874-1-git-send-email-alcooperx@gmail.com>
 <1561064991-16874-3-git-send-email-alcooperx@gmail.com> <1561094780.19385.2.camel@mhfsdcap03>
In-Reply-To: <1561094780.19385.2.camel@mhfsdcap03>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Fri, 21 Jun 2019 09:44:11 -0400
Message-ID: <CAOGqxeV=7kwt9oyso_0yuBOT-a9bhzXJcvav-+jRY_j_=-W8QA@mail.gmail.com>
Subject: Re: [PATCH 2/6] usb: bdc: Cleanup clock support
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
> > index ccbd1d34eb2a..11a43de6c1c6 100644
> > --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
> > +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
> > @@ -490,8 +490,14 @@ static int bdc_probe(struct platform_device *pdev)
> >
> >       dev_dbg(dev, "%s()\n", __func__);
> >
> > +     bdc = devm_kzalloc(dev, sizeof(*bdc), GFP_KERNEL);
> > +     if (!bdc)
> > +             return -ENOMEM;
> > +
> >       clk = devm_clk_get(dev, "sw_usbd");
> >       if (IS_ERR(clk)) {
> > +             if (PTR_ERR(clk) == -EPROBE_DEFER)
> > +                     return -EPROBE_DEFER;
> what about using devm_clk_get_optional()?

Good suggestion.
Thanks
Al


On Fri, Jun 21, 2019 at 1:26 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> On Thu, 2019-06-20 at 17:09 -0400, Al Cooper wrote:
> > - Fix driver to defer on clk_get defer
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > ---
> >  drivers/usb/gadget/udc/bdc/bdc_core.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
> > index ccbd1d34eb2a..11a43de6c1c6 100644
> > --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
> > +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
> > @@ -490,8 +490,14 @@ static int bdc_probe(struct platform_device *pdev)
> >
> >       dev_dbg(dev, "%s()\n", __func__);
> >
> > +     bdc = devm_kzalloc(dev, sizeof(*bdc), GFP_KERNEL);
> > +     if (!bdc)
> > +             return -ENOMEM;
> > +
> >       clk = devm_clk_get(dev, "sw_usbd");
> >       if (IS_ERR(clk)) {
> > +             if (PTR_ERR(clk) == -EPROBE_DEFER)
> > +                     return -EPROBE_DEFER;
> what about using devm_clk_get_optional()?
>
> >               dev_info(dev, "Clock not found in Device Tree\n");
> >               clk = NULL;
> >       }
> > @@ -501,11 +507,6 @@ static int bdc_probe(struct platform_device *pdev)
> >               dev_err(dev, "could not enable clock\n");
> >               return ret;
> >       }
> > -
> > -     bdc = devm_kzalloc(dev, sizeof(*bdc), GFP_KERNEL);
> > -     if (!bdc)
> > -             return -ENOMEM;
> > -
> >       bdc->clk = clk;
> >
> >       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > @@ -551,7 +552,7 @@ static int bdc_probe(struct platform_device *pdev)
> >       ret = bdc_phy_init(bdc);
> >       if (ret) {
> >               dev_err(bdc->dev, "BDC phy init failure:%d\n", ret);
> > -             return ret;
> > +             goto clk_cleanup;
> >       }
> >
> >       temp = bdc_readl(bdc->regs, BDC_BDCCAP1);
> > @@ -583,6 +584,8 @@ static int bdc_probe(struct platform_device *pdev)
> >       bdc_hw_exit(bdc);
> >  phycleanup:
> >       bdc_phy_exit(bdc);
> > +clk_cleanup:
> > +     clk_disable_unprepare(bdc->clk);
> >       return ret;
> >  }
> >
>
>
