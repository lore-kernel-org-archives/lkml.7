Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B71C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B88220811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kP7Kdk/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfDWJhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:37:18 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38637 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDWJhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:37:17 -0400
Received: by mail-it1-f193.google.com with SMTP id q19so4563693itk.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3QSVMOUFtCNP5UaU6eeQexmFEB3Ff4Zqfri3mdLtbuI=;
        b=kP7Kdk/75fXHgp+nQUb5ZTlnOt1bEryDuS9gd1gywVqc4dWpjxUD0/BbzWDa00DaE5
         O3waQ3j+6vILfSZhVM+/LK3nWRQ4bwmzP8jJa4WKS1J3EqZswcE3E7oHdlKsSw1wHYkA
         YPIZeoWlKWUjB5RejuUY7kUHKeP+81+Uynd87ssYvm6SyNcjX1L5N1TQ1RC30cfiIqM0
         9MbanUh3xI4tspNgWnV9476AzXes52/++Fgplia7Jve5CVDcXIAirJGEVu2xkX2NuI2D
         W/GvhAwv2aqmtch5d5exUf9ngjX33IoANzbWEOafSq4uOJjRr6RDECMPmZtrfJSNvpZG
         013A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3QSVMOUFtCNP5UaU6eeQexmFEB3Ff4Zqfri3mdLtbuI=;
        b=QvKqHD0ApLq/pZrAHn/x4BhOWc0MMzWW9TCjB8RTsljssmgsSndRgebWTVrhSfR9iH
         Pg6pZK3RSJp48zzgjid03DqL4dad8Lbwj5KfRifs22WE+T0AkfQeMDqh9+i3rqnccg8j
         FI41wuLC905+nCm2CiqoEqI01mODK8cdOnAbt8NeooNWWuJf/IqbUV+vl23qS8RCDne6
         kjlK3sxcC/KYhJUFKPI59NwSAQ0iSeYptIbXIgrU+gytVL8CJSQHp+1Ev7oVWyefxshl
         gv9ECdW7Myf1CgRkY7tUjK3iGiXbai3s8Cta9Y3zvxJkitj8jWf6jQZ5qNBwotys6n7P
         DD8A==
X-Gm-Message-State: APjAAAWBYxHcW8bru7lNlLTtLOgRQfkkzlgahw93BdajbnYxcliPkntT
        nyDMLkHwtrQg5A/KqagFLNY/fObh+xQuNEtF7YFpAg==
X-Google-Smtp-Source: APXvYqzT5/Fev1FmWXQbDuvyvTZFvzVmlwY3ICLeXnN8NI3cAiA+kec8HEh3w7FhmH1K0N+Evc4nkxoh17wg+S2tnOM=
X-Received: by 2002:a02:2a42:: with SMTP id w63mr14665743jaw.57.1556012236731;
 Tue, 23 Apr 2019 02:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190401081635.18673-1-brgl@bgdev.pl> <29cb0f74-672a-56f3-6e85-82f7e2a99ddf@codeaurora.org>
 <CAMRc=MdK-d-A=-eJWNktTX41PMx1AC=9GvGHOg3vytdaxmf9YA@mail.gmail.com>
In-Reply-To: <CAMRc=MdK-d-A=-eJWNktTX41PMx1AC=9GvGHOg3vytdaxmf9YA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 23 Apr 2019 11:37:05 +0200
Message-ID: <CAMRc=MeTWD6L3kzAi-g5L+rvFQiEzUAEYj6StiHG21qwGQBRWg@mail.gmail.com>
Subject: Re: [PATCH] drivers: fix a typo in the kernel doc for devm_platform_ioremap_resource()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mukesh Ojha <mojha@codeaurora.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 10 kwi 2019 o 09:50 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=
=82(a):
>
> pon., 1 kwi 2019 o 12:23 Mukesh Ojha <mojha@codeaurora.org> napisa=C5=82(=
a):
> >
> >
> > On 4/1/2019 1:46 PM, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > It should have been 'management' not 'managemend'.
> > >
> > > Fixes: 7945f929f1a7 ("drivers: provide devm_platform_ioremap_resource=
()")
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > ---
> > >   drivers/base/platform.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > > index dab0a5abc391..09c00d91094c 100644
> > > --- a/drivers/base/platform.c
> > > +++ b/drivers/base/platform.c
> > > @@ -84,7 +84,7 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
> > >    *                              device
> > >    *
> > >    * @pdev: platform device to use both for memory resource lookup as=
 well as
> > > - *        resource managemend
> > > + *        resource management
> >
> >
> > :-)
> >
> > Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> >
> > Cheers,
> > -Mukesh
> >
> > >    * @index: resource index
> > >    */
> > >   #ifdef CONFIG_HAS_IOMEM
>
> Hi Greg,
>
> can you pick this one up into your tree?
>
> Thanks in advance,
> Bartosz

Ping.

Bart
