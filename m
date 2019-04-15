Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93298C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F77520651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356172;
	bh=1whlbDkVOjC9NZbWP6oG4nHV6LXVhiDVReMq4n5B37w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SeY2jUzLz1b00be4Dsaq73ilVbsxFM1mOAji/14B/p91EYQyPRMR1KHM566jTKvp/
	 1L3d0nOs8jlT7T/ZtQA35lF3v0+9NSmJ4+mgb9VtA667Zw8Z8eeAGZxkpT73wlSJEf
	 VnulSi8lYFMxUGmTtSY6zCqNYgeg/WrTF+4H/8Jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbfDOTWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731009AbfDOTWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:22:46 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1287218D3;
        Mon, 15 Apr 2019 19:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555356165;
        bh=1whlbDkVOjC9NZbWP6oG4nHV6LXVhiDVReMq4n5B37w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EUaYmZE5tGV7AUHei6+EYHXGERYaBBBVoCl2lux89oDaGyZAxBM97Upnh+MJYe7EH
         2QdFdrencPfGKYbDdglSb2vy/oAsBkeO5ydEgw2MI+n95/z60rVQ+8IoJyMWIIhhK6
         EQOWMzF+pqUI9BKS+lf+egQDrrkPm1B/Hy4rALeE=
Received: by mail-ed1-f42.google.com with SMTP id a6so4466504edv.1;
        Mon, 15 Apr 2019 12:22:45 -0700 (PDT)
X-Gm-Message-State: APjAAAXTa+BHpzulL1bmmHWiO6F9VOO3uJ5vUHMv5hDMDYUc2eB3j28z
        KmSRyvYcmlcuYY+IJytHRzwAYCcbrVQ/nbDVa6w=
X-Google-Smtp-Source: APXvYqxUe0FV1sPT9E8JRLmhhEtCqNg+T+vLsJConGhq1fIu+Wd7ZWGqKQWITGyKLIw9PrRchN12fKBaNOL/2Y0sm8E=
X-Received: by 2002:a17:906:3fc4:: with SMTP id k4mr41366100ejj.166.1555356164198;
 Mon, 15 Apr 2019 12:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190410215327.8024-1-swood@redhat.com> <20190411123314.GA19198@hao-dev>
 <CAJYdmeNX9F_EmTPBjQ1SXOOU=JBA1kBO6WEjBXTmJux4O-CR5A@mail.gmail.com>
In-Reply-To: <CAJYdmeNX9F_EmTPBjQ1SXOOU=JBA1kBO6WEjBXTmJux4O-CR5A@mail.gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 15 Apr 2019 14:22:08 -0500
X-Gmail-Original-Message-ID: <CANk1AXTv2DFpRDAJ9UH9+LRo=wrmcbP02zbWbtTXku6iwPAhOw@mail.gmail.com>
Message-ID: <CANk1AXTv2DFpRDAJ9UH9+LRo=wrmcbP02zbWbtTXku6iwPAhOw@mail.gmail.com>
Subject: Re: [PATCH] fpga: dfl: afu: Pass the correct device to dma_mapping_error()
To:     Moritz Fischer <moritz.fischer.private@gmail.com>
Cc:     Wu Hao <hao.wu@intel.com>, Scott Wood <swood@redhat.com>,
        Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 11:36 AM Moritz Fischer
<moritz.fischer.private@gmail.com> wrote:

Hi Scott,

Thanks!

>
> Hi Scott,
>
> good catch!
>
> On Thu, Apr 11, 2019 at 5:49 AM Wu Hao <hao.wu@intel.com> wrote:
> >
> > On Wed, Apr 10, 2019 at 04:53:27PM -0500, Scott Wood wrote:
> > > dma_mapping_error() was being called on a different device struct than
> > > what was passed to map/unmap.  Besides rendering the error checking
> > > ineffective, it caused a debug splat with CONFIG_DMA_API_DEBUG.
> > >
> > > Signed-off-by: Scott Wood <swood@redhat.com>
> >
> > Hi Scott,
> >
> > Looks good to me. Thanks for catching this issue.
> >
> > Acked-by: Wu Hao <hao.wu@intel.com>
> >
> > Hao
> >
> > > ---
> > >  drivers/fpga/dfl-afu-dma-region.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> > > index e18a786fc943..cd68002ac097 100644
> > > --- a/drivers/fpga/dfl-afu-dma-region.c
> > > +++ b/drivers/fpga/dfl-afu-dma-region.c
> > > @@ -399,7 +399,7 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
> > >                                   region->pages[0], 0,
> > >                                   region->length,
> > >                                   DMA_BIDIRECTIONAL);
> > > -     if (dma_mapping_error(&pdata->dev->dev, region->iova)) {
> > > +     if (dma_mapping_error(dfl_fpga_pdata_to_parent(pdata), region->iova)) {
> > >               dev_err(&pdata->dev->dev, "failed to map for dma\n");
> > >               ret = -EFAULT;
> > >               goto unpin_pages;
> > > --
> > > 1.8.3.1
>
> Acked-by: Moritz Fischer <mdf@kernel.org>

Acked-by: Alan Tull <atull@kernel.org>

>
> Thanks
> Moritz

Alan
