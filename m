Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E594C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074EC2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbfCZMbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:31:38 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35502 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfCZMbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:31:38 -0400
Received: by mail-vs1-f65.google.com with SMTP id e1so7497138vsp.2;
        Tue, 26 Mar 2019 05:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Og7vdbY8Zlxbz+OaNnaaLhysuvTuuNBMaupoXTYuY/A=;
        b=nkLxY5iylbXqm46nUJReFrUzIWPpwqB+PCO4bTB4ZZ9GDxcoiI94kPe4NRN3dCR4+A
         Dywyvce54WqMbxp+k/zcA9QDYe9e1GAHze5q3CdiBDqQife6qpBFuVfni4KGEAvwOzTd
         +MHjI2bUurZ3H9QeKjSIVponLb04CUkkSirHL2E8p8tswxuAJGRTGerLtXfdYB03rWsp
         XpuIVzXIODNwRGlZe1Ge+bVB8Ac729nhchIuRiN/NtPOKZ/l9bD2sejmWW3t8oExqXeG
         ywrM9WHSr6/q6lByd3RRDUxtfB/d0gLvTR1lyVrgSh+TVczyu0YD8KEkGSTXkgOqu2B7
         Ot7g==
X-Gm-Message-State: APjAAAVcuGS1BVCJ/KE9XkH/HtXu8DQCGZirJ4W7xhnszOllMgyNgcNf
        FVhYbT30GvcEYRRuIjRHCmiu3gsCHRmbdhLhZ/Q=
X-Google-Smtp-Source: APXvYqwQWvs/2oJLyylBiJvkDb0StrAwTuDYnxz0QPtx4fYTYIAonMQsBKYzQv5EJPPyOO7VaaUbwOYcOoI5ndWJ8ac=
X-Received: by 2002:a67:f843:: with SMTP id b3mr18270214vsp.152.1553603496656;
 Tue, 26 Mar 2019 05:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190207193653.18221-1-geert+renesas@glider.be> <9966a420-b081-a8ed-7f7b-20d97c9f7996@huawei.com>
In-Reply-To: <9966a420-b081-a8ed-7f7b-20d97c9f7996@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Mar 2019 13:31:23 +0100
Message-ID: <CAMuHMdUTkPoCoL7jRz2MRRSjLVSrzE4kPx2uMKCKMGfmVayT6A@mail.gmail.com>
Subject: Re: [PATCH/RFC] driver core: Postpone DMA tear-down until after
 devres release
To:     John Garry <john.garry@huawei.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        chenxiang <chenxiang66@hisilicon.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

CC robh

On Tue, Mar 26, 2019 at 12:42 PM John Garry <john.garry@huawei.com> wrote:
> > Memory is incorrectly freed using the direct ops, as dma_map_ops = NULL.
> > Oops...
> >
> > After reversing the order of the calls to arch_teardown_dma_ops() and
> > devres_release_all(), dma_map_ops is still valid, and the DMA memory is
> > now released using __iommu_free_attrs():
> >
> >     +sata_rcar ee300000.sata: dmam_release:32: size 2048 vaddr ffffff8012145000 dma_handle 0x0x00000000fffff000 attrs 0x0
> >     +sata_rcar ee300000.sata: dma_free_attrs:289: size 2048, ops = iommu_dma_ops
> >     +sata_rcar ee300000.sata: dma_free_attrs:311: calling __iommu_free_attrs()
> > ---
> >  drivers/base/dd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 8ac10af17c0043a3..d62487d024559620 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -968,9 +968,9 @@ static void __device_release_driver(struct device *dev, struct device *parent)
> >                       drv->remove(dev);
> >
> >               device_links_driver_cleanup(dev);
> > -             arch_teardown_dma_ops(dev);
> >
> >               devres_release_all(dev);
> > +             arch_teardown_dma_ops(dev);
> >               dev->driver = NULL;
>
> Hi guys,
>
> Could there still be the same problem in the error path of really_probe():
>
> static int really_probe(struct device *dev, struct device_driver *drv)
> {
>
>         [...]
>
>         goto done;
>
> probe_failed:
>         arch_teardown_dma_ops(dev);
> dma_failed:
>         if (dev->bus)
>                 blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>                                      BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
> pinctrl_bind_failed:
>         device_links_no_driver(dev);
>         devres_release_all(dev);
>         driver_sysfs_remove(dev);
>         dev->driver = NULL;
>         dev_set_drvdata(dev, NULL);
>
> We seem to be able to call arch_teardown_dma_ops() prior to
> devres_release_all() if we reach probe_failed label.

Yes, this looks like another instance of the same problem.
And test_remove doesn't expose this, as it doesn't exercise the full cycle.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
