Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F73C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976FC21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="IV1QR0NX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfJBJJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:09:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45730 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfJBJJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:09:36 -0400
Received: by mail-io1-f68.google.com with SMTP id c25so55119267iot.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 02:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hlThU/0+3HTSxVJIpbAfEl3+62sbcU01NeSU7eG4LqY=;
        b=IV1QR0NXPUhoMOjxwHh18ibizuWPQ+4/OYrnffr2ZXKuvvWAf9gmljv0v7HkbZEiVt
         zARhx2Xi6V3Nma7orMBFSNGs/EK8tnXF2zJKtrGR34m4X9Sia9oZtwTdZ9YW68LPKN7a
         sxBQJcC+4R6XsKKVlRNkM/0/FBQ7Y/7hFIrNmvYAlvyHYVprDoSwhQ4lMamuwfcnCAU6
         Fx1R6ch3q3XUxYYCKd5KWw5MceInpGHhV7byF+XrHXmBPIDopaGbx75hbB8VUd8ACpkp
         lgy4b+MOUeirAgVbku/LVB97akEMZURhy8bCooqQyQNd8UKbUVBLCisXuU4kzgw7Z/r0
         nIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hlThU/0+3HTSxVJIpbAfEl3+62sbcU01NeSU7eG4LqY=;
        b=FreXBkHKQUs0QyNxvj5ZoaDCcnTBf0/Ys8sSXc4s00kExy+PcG6nUR14BfaeRrCnj0
         xI8nHfYUbVRX/1mXsqx2aBSm6vOnM4IBEKq5r1ULdyVImF+jCD96Fn0IvCSbI58h4VE8
         Bjrvnn3Hg3tma/wZmeWgO5oW5OaaDYipZdR5paajWGN35CueURymJbDEzSF/4Hv1xJFf
         Iswx0ge/IUcKchWnOhM+7ztc1TD5bn9IgAW4pQ5XwnKm2/EVhnniEfVK9wyq6pTA3FSJ
         NHH0/eWrI6LdLHkTHQqWQ2VO5dY3wW55tW06Q6GaO0gwk4B0BhAP5NsN7VCib+rLYmw3
         7Stg==
X-Gm-Message-State: APjAAAWRu6T8r4w2JDXkv1T/mdmD8e6WhsQpM6sWTBvkSHSluiNiaqGa
        4ZLvS1zrufrlwjn4tGZ+6/Ucc6XCOonMzK7JYVkndA==
X-Google-Smtp-Source: APXvYqzIoyvaXbrjboO82pq9HbUiv4XbYQZhJ+E6TRlLc9GG+m0ukGOgfxcjEGQG58Y44wkqcLgO7h1hPaR44lh3y9I=
X-Received: by 2002:a02:b156:: with SMTP id s22mr2834772jah.102.1570007375665;
 Wed, 02 Oct 2019 02:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191001132333.20146-1-brgl@bgdev.pl> <20191001133807.GB3563296@ulmo>
In-Reply-To: <20191001133807.GB3563296@ulmo>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 2 Oct 2019 11:09:24 +0200
Message-ID: <CAMRc=Me5tC2pFc56oWrcdLqu3YULYWPFXLXLW6uciZ5OPO7_Ug@mail.gmail.com>
Subject: Re: [PATCH 0/3] tegra: use regulator_bulk_set_supply_names()
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 1 pa=C5=BA 2019 o 15:38 Thierry Reding <thierry.reding@gmail.com> napi=
sa=C5=82(a):
>
> On Tue, Oct 01, 2019 at 03:23:30PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The regulator_bulk_set_supply_names() helper was merged upstream. Use i=
t
> > in a couple tegra drivers.
> >
> > Bartosz Golaszewski (3):
> >   ahci: tegra: use regulator_bulk_set_supply_names()
> >   phy: tegra: use regulator_bulk_set_supply_names()
> >   usb: host: xhci-tegra: use regulator_bulk_set_supply_names()
> >
> >  drivers/ata/ahci_tegra.c      | 6 +++---
> >  drivers/phy/tegra/xusb.c      | 6 +++---
> >  drivers/usb/host/xhci-tegra.c | 5 +++--
> >  3 files changed, 9 insertions(+), 8 deletions(-)
>
> I really don't see the point here. You've got a positive diffstat here,
> which means all that churn is without benefit.
>

A hand-coded for loop is replaced with a single function call. The
actual generated code is smaller - I posted bloat-o-meter results last
time. The only reason the number of lines of code doesn't really
change is because the line is broken due to the function and argument
names being too long.

> Is there some subsequent work based on this that will actually improve
> things?

I'd argue that replacing a common operation that's reimplemented
explicitly by hand in many places with a helper function is already an
improvement. Consolidation is almost always good.

That being said, I like your idea about the regulator_get_from_names
helper, but it will take more time as we have to cover optional
multiple regulators as well. In other words: it's on my TODO list, but
in the meantime there's no harm in using this since Mark decided to
make it a part of the regulator API anyway.

Bart
