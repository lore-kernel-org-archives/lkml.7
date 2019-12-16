Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B14C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9A02146E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHHL7O+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfLPUSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:18:48 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:38818 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfLPUSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:18:48 -0500
Received: by mail-il1-f196.google.com with SMTP id f5so6469231ilq.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 12:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KyCUVV3rdpr7tDeSg76g9nK9b781278O7KA2xbZ0dR0=;
        b=iHHL7O+as7eWolVxsmxzpxUyxvjNe8LFILfa7HkOK3iS7jup4IU/ntb2NK2sS1LAdZ
         YUvpju6Hy0xYjRvu0i18C3RxHU8A4ywJcP213xDCLThJteRskHpFGfq4zC9blpJzR8e5
         Kd43QUsSdDR3WU4L/dLU5D8TX6fJvEHMgUcFLH3bJdI35YopTcDXxT64L7GxyLjs4++W
         eWMlt8U5wKEs5/QFSgJhG79Qg4Pj5iqPMJ+MQet720XPq4NfPpcO5DuDuZ8qhrC7eVDn
         r+UWbDsF1gLq8Z2P+t8FLkB1Y5Vhj2/ZIQ2aob4JBnVSZy5cUTfiF06/fbyqSld4PJLe
         QfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyCUVV3rdpr7tDeSg76g9nK9b781278O7KA2xbZ0dR0=;
        b=b1lV93LHjmqLEoinWkZ2TPLwbfSuyYlqlbkHRkKjZTkSKjN7Vvu/RVgX3t8X6vUe5j
         3yfJP90A/CoDzT04YDdbLKUnSfWzCdhm4XMlnmf7rWK1zkbrzuYCeUzHlCaj41k5dmyf
         l6sclaUFIrQjQUwdnuPiDL1mSXSijGuIphIlfvR0XOT1b6q7jVhF9CYnYWMTUZpSZkd+
         s06SVa3+SGaT2E2VIt9RtxJFx9PsM5fwgqT9yZX3AdyjYFDfjfUtcv6FDVKO/yQTzn0G
         0qb1itRl2AbWXH0Otvz+Z3DFnIbBrVNtnVywFHUvZP5JjrX/GoPC+PrcIgGwqWOb8KWh
         ULZQ==
X-Gm-Message-State: APjAAAXQeAN138vZRTvb5OloqohN2iNSkRpaL0IQ947nN+KJva+OXZkw
        IZlpXxOnsLcg2lz8NUPwhx1XhoJ8MwrXNGU+Vfk=
X-Google-Smtp-Source: APXvYqzSEzu9t2auDYj+3nxgS4a5/G+lOTRzSkjO0L50ebyLT6+kDt8bpDOMCXv7X1n602yk6tYppRZnPhdejAau5WY=
X-Received: by 2002:a92:89c2:: with SMTP id w63mr13740064ilk.252.1576527527066;
 Mon, 16 Dec 2019 12:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20191215013306.18880-1-navid.emamdoost@gmail.com> <6159c10a-2f5f-e6ef-7a64-4b613e422efa@mev.co.uk>
In-Reply-To: <6159c10a-2f5f-e6ef-7a64-4b613e422efa@mev.co.uk>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Mon, 16 Dec 2019 14:18:35 -0600
Message-ID: <CAEkB2ERefAPHerg=F2V_-OHDH4P8sq2QjiP8+W=0HVgcCQNscw@mail.gmail.com>
Subject: Re: [PATCH] staging: comedi: drivers: Fix memory leak in gsc_hpdi_auto_attach
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ian, thanks for your feedback.

On Mon, Dec 16, 2019 at 4:36 AM Ian Abbott <abbotti@mev.co.uk> wrote:
>
> On 15/12/2019 01:33, Navid Emamdoost wrote:
> > In the implementation of gsc_hpdi_auto_attach(), the allocated dma
> > description is leaks in case of alignment error, or failure of
> > gsc_hpdi_setup_dma_descriptors() or comedi_alloc_subdevices(). Release
> > devpriv->dma_desc via dma_free_coherent().
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>
> Actually, there is no memory leak (although there is another problem
> that I'll mention below).  If the "auto_attach" handler
> gsc_hpdi_auto_attach() returns an error, then the "detach" handler
> gsc_hpdi_detach() will be called automatically to clean up.  (This is
> true for all comedi drivers).  gsc_hpdi_detach() calls
> gsc_hpdi_free_dma() to free the DMA buffers and DMA descriptors.
>
I was aware that comedi_alloc_devpriv() is a resource managed
allocation, but was not sure how subsequent dma_desc allocation will
be handled when device detach.

> > ---
> >   drivers/staging/comedi/drivers/gsc_hpdi.c | 16 +++++++++++++---
> >   1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/comedi/drivers/gsc_hpdi.c b/drivers/staging/comedi/drivers/gsc_hpdi.c
> > index 4bdf44d82879..c0c7047a6d1b 100644
> > --- a/drivers/staging/comedi/drivers/gsc_hpdi.c
> > +++ b/drivers/staging/comedi/drivers/gsc_hpdi.c
> > @@ -633,16 +633,17 @@ static int gsc_hpdi_auto_attach(struct comedi_device *dev,
> >       if (devpriv->dma_desc_phys_addr & 0xf) {
> >               dev_warn(dev->class_dev,
> >                        " dma descriptors not quad-word aligned (bug)\n");
> > -             return -EIO;
> > +             retval = -EIO;
> > +             goto release_dma_desc;
> >       }
> >
> >       retval = gsc_hpdi_setup_dma_descriptors(dev, 0x1000);
> >       if (retval < 0)
> > -             return retval;
> > +             goto release_dma_desc;
> >
> >       retval = comedi_alloc_subdevices(dev, 1);
> >       if (retval)
> > -             return retval;
> > +             goto release_dma_desc;
> >
> >       /* Digital I/O subdevice */
> >       s = &dev->subdevices[0];
> > @@ -660,6 +661,15 @@ static int gsc_hpdi_auto_attach(struct comedi_device *dev,
> >       s->cancel       = gsc_hpdi_cancel;
> >
> >       return gsc_hpdi_init(dev);
> > +
> > +release_dma_desc:
> > +     if (devpriv->dma_desc)
> > +             dma_free_coherent(&pcidev->dev,
> > +                               sizeof(struct plx_dma_desc) *
> > +                             NUM_DMA_DESCRIPTORS,
> > +                             devpriv->dma_desc,
> > +                             devpriv->dma_desc_phys_addr);
> > +     return retval;
> >   }
> >
> >   static void gsc_hpdi_detach(struct comedi_device *dev)
> >
>
> This patch could actually result in devpriv->dma_desc being freed twice
> - once in the 'release_dma_desc:' code and again when gsc_hpdi_detach()
> is called externally as part of the clean-up.
>
> The real bug in the original code is that it does not check whether any
> of the calls to dma_alloc_coherent() returned NULL.  If any of the calls
> to dma_alloc_coherent() returns NULL, gsc_hpdi_auto_attach() needs to
> return an error (-ENOMEM).  The subsequent call to gsc_hpdi_detach()
> will then free whatever DMA coherent buffers where allocated.
>
Yes, this potential null deref is another type of bug, which I will
send a patch for separately.

> --
> -=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
> -=( MEV Ltd. is a company registered in England & Wales. )=-
> -=( Registered number: 02862268.  Registered address:    )=-
> -=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-



-- 
Navid.
