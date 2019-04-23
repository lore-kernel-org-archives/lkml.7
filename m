Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE67C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DDF21773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfDWPB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:01:56 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46026 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbfDWPB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:01:56 -0400
Received: by mail-ua1-f68.google.com with SMTP id o11so757912uad.12;
        Tue, 23 Apr 2019 08:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UjKcQDchuiRrcdQ7wcg9oiUE5P+pgqbYSsnauAwr8CU=;
        b=W0xZMQM1meloMyH9ruUynHtXgKLk3pGjW0f8RgmUPMlTFpCtvpRtD2FfrsxHNIl49n
         cj53F5FfSVsLZfql+LJ3i9riteRtgGIUC2HW4l6Rust2J7ldpzuoWJnx6sBNh/s9twZ3
         yAKD6DBhO/yoPPz2AYk93wGkO1UkYxBVpjg62OlB7NB4IQZC5hQUBQ6/6mOqXkRzqgNh
         ZAHaftJXhWy8nOn6yMAtGFEcV9RFLvTdOv++AxbRosq2GHDIJL9obntrH71isP+oiK+g
         cW/z9FhHhK/yY67aUfVsCiVuoqxrxGnBCYGN0CUU586Y8tqgDgPgIa1AupJ/pTsEl/50
         DscQ==
X-Gm-Message-State: APjAAAXbyYxEiakxWjI+mdjlbiCwdBiAhVWw25Yf3YYO+H6L0vOgo8qM
        1PGhtGawBJ/bksI70Q5/4veo+M2NYFN9MxNudHaWLg==
X-Google-Smtp-Source: APXvYqyK6XZDn6WHU0lafDyk+j0Bwmz5Fd1MzX0SG1EaZoHTo12JiitjmIbrukG4caSY8uDaMZKGV0J40RchVZfCyMQ=
X-Received: by 2002:ab0:6419:: with SMTP id x25mr13100402uao.86.1556031714469;
 Tue, 23 Apr 2019 08:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190403182148.18058-1-geert+renesas@glider.be>
 <20190403182148.18058-2-geert+renesas@glider.be> <20190411081028.b2wf3nnzx4tw7xdr@verge.net.au>
 <20190411081214.pgdztqdlud5ta466@verge.net.au>
In-Reply-To: <20190411081214.pgdztqdlud5ta466@verge.net.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 23 Apr 2019 17:01:42 +0200
Message-ID: <CAMuHMdUXK_TKJuWwuJ0XCPNK-gQo1bY4OPGB674hH3nTc2hTxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] iommu/ipmmu-vmsa: Link IOMMUs and devices in sysfs
To:     Simon Horman <horms@verge.net.au>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Thu, Apr 11, 2019 at 10:12 AM Simon Horman <horms@verge.net.au> wrote:
> On Thu, Apr 11, 2019 at 10:10:28AM +0200, Simon Horman wrote:
> > On Wed, Apr 03, 2019 at 08:21:43PM +0200, Geert Uytterhoeven wrote:
> > > As of commit 7af9a5fdb9e0ca33 ("iommu/ipmmu-vmsa: Use
> > > iommu_device_sysfs_add()/remove()"), IOMMU devices show up under
> > > /sys/class/iommus/, but their "devices" subdirectories are empty.
> >
> > Should the path be /sys/class/iommu/ (no trailing 's') ?

Yes it does, thanks. Will fix.

> > > Likewise, devices tied to an IOMMU do not have an "iommu" backlink.
> > >
> > > Make sure all links are created, on both arm32 and arm64.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > ---
> > > v2:
> > >   - Add Reviewed-by.
> > > ---
> > >  drivers/iommu/ipmmu-vmsa.c | 24 +++++++++++++++++-------
> > >  1 file changed, 17 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > > index 9a380c10655e182d..9f2b781e20a0eba6 100644
> > > --- a/drivers/iommu/ipmmu-vmsa.c
> > > +++ b/drivers/iommu/ipmmu-vmsa.c
> > > @@ -885,27 +885,37 @@ static int ipmmu_init_arm_mapping(struct device *dev)
> > >
> > >  static int ipmmu_add_device(struct device *dev)
> > >  {
> > > +   struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
> > >     struct iommu_group *group;
> > > +   int ret;
> > >
> > >     /*
> > >      * Only let through devices that have been verified in xlate()
> > >      */
> > > -   if (!to_ipmmu(dev))
> > > +   if (!mmu)
> > >             return -ENODEV;
> > >
> > > -   if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA))
> > > -           return ipmmu_init_arm_mapping(dev);
> > > +   if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)) {
> > > +           ret = ipmmu_init_arm_mapping(dev);
> > > +           if (ret)
> > > +                   return ret;
> > > +   } else {
> > > +           group = iommu_group_get_for_dev(dev);
> > > +           if (IS_ERR(group))
> > > +                   return PTR_ERR(group);
> > >
> > > -   group = iommu_group_get_for_dev(dev);
> > > -   if (IS_ERR(group))
> > > -           return PTR_ERR(group);
> > > +           iommu_group_put(group);
> > > +   }
> > >
> > > -   iommu_group_put(group);
> > > +   iommu_device_link(&mmu->iommu, dev);
>
> Also, is there any value in propagating the return value
> of iommu_device_link() ?

I don't think so.  Sysfs information is not super-critical, and most
drivers just
ignore such return values.  Also, the sysfs cleanup code handles cleanup
after failed setup fine.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
