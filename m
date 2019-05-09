Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA88C04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4CE214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557366957;
	bh=ozqYgXRJMRFe+AItTZSjOhcmBX9vg9ndN9W47uyCAJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T5y/7pWbFL0HcloFehQ8vsClgB7XV17ym0koh+gImM8dUztxr4+SmLPYLRk0qjadG
	 DWfZcsQ2t9vIm4VjoJLfwXdBKuOD/WFZrTbqQ/4YQiESdBVId29I7I62VnazFSAzEc
	 zO0o7OdBpYysICm4H3uFQYT5I4XDLtu/GM32krGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfEIBz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 21:55:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38962 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfEIBzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:55:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id g9so303015plm.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 18:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xe7404RtUM/sn+MoO5V1fONQ0OCW3SoYDedpXw7A92M=;
        b=DwZ1z5o93yTFkdaE2oDUSuJ502GwpumCfsB/L/YfSiVxGMzP3AJiW4DtORmA0EvjdD
         UqGs884WWjnGB5hcbIcFEUFxSNKYcV7YozG/Ma4n16thz6nwj1qaofHnhYQwzv69fpUR
         ugUpCJPHPrBdQcmDrgKC63PUoas5dMxISHwmnyNW+CmsHUjDWc2IVraIfpdSdMa6OoMA
         JA9/LxCsGAE6H+dyf97BZlA2wfQ1B36lvCl3BsWvJJ7WehBtWZRtQg30Zwbv9zJQJ7An
         tyAJ8mDhJ5F4u8XI9xA7gOFcDBwZpfW8Mfvv4YxZKn6PDYXLTf4IaHyrsSDgewr54SnA
         bkNw==
X-Gm-Message-State: APjAAAXmYs+GHtFSYnpz+ZxEiUFNWdlyadmMHsu9qKZfj4LGhFm5RnbC
        g9IsvbbsJN3D6ikq4nnE7+LqqA==
X-Google-Smtp-Source: APXvYqwl/oum57VOvei6JScraq/7JXaswNqtNC5Gr/Mc/MLpICDomEFbVEI3LV546l7mtW8BzUbLew==
X-Received: by 2002:a17:902:b70c:: with SMTP id d12mr1634368pls.178.1557366954793;
        Wed, 08 May 2019 18:55:54 -0700 (PDT)
Received: from localhost ([2601:647:4700:2953:ec49:968:583:9f8])
        by smtp.gmail.com with ESMTPSA id o37sm495163pgm.78.2019.05.08.18.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 18:55:53 -0700 (PDT)
Date:   Wed, 8 May 2019 18:55:52 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Alan Tull <atull@kernel.org>,
        Moritz Fischer <moritz.fischer.private@gmail.com>,
        Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fpga: dfl: afu: Pass the correct device to
 dma_mapping_error()
Message-ID: <20190509015552.GA13721@archbox>
References: <20190410215327.8024-1-swood@redhat.com>
 <20190411123314.GA19198@hao-dev>
 <CAJYdmeNX9F_EmTPBjQ1SXOOU=JBA1kBO6WEjBXTmJux4O-CR5A@mail.gmail.com>
 <CANk1AXTv2DFpRDAJ9UH9+LRo=wrmcbP02zbWbtTXku6iwPAhOw@mail.gmail.com>
 <7d3a76c0c9115726402cfc52da92fd8e2cac426c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d3a76c0c9115726402cfc52da92fd8e2cac426c.camel@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

On Wed, May 08, 2019 at 04:39:51PM -0500, Scott Wood wrote:
> On Mon, 2019-04-15 at 14:22 -0500, Alan Tull wrote:
> > On Thu, Apr 11, 2019 at 11:36 AM Moritz Fischer
> > <moritz.fischer.private@gmail.com> wrote:
> > 
> > Hi Scott,
> > 
> > Thanks!
> > 
> > > Hi Scott,
> > > 
> > > good catch!
> > > 
> > > On Thu, Apr 11, 2019 at 5:49 AM Wu Hao <hao.wu@intel.com> wrote:
> > > > On Wed, Apr 10, 2019 at 04:53:27PM -0500, Scott Wood wrote:
> > > > > dma_mapping_error() was being called on a different device struct
> > > > > than
> > > > > what was passed to map/unmap.  Besides rendering the error checking
> > > > > ineffective, it caused a debug splat with CONFIG_DMA_API_DEBUG.
> > > > > 
> > > > > Signed-off-by: Scott Wood <swood@redhat.com>
> > > > 
> > > > Hi Scott,
> > > > 
> > > > Looks good to me. Thanks for catching this issue.
> > > > 
> > > > Acked-by: Wu Hao <hao.wu@intel.com>
> > > > 
> > > > Hao
> > > > 
> > > > > ---
> > > > >  drivers/fpga/dfl-afu-dma-region.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-
> > > > > afu-dma-region.c
> > > > > index e18a786fc943..cd68002ac097 100644
> > > > > --- a/drivers/fpga/dfl-afu-dma-region.c
> > > > > +++ b/drivers/fpga/dfl-afu-dma-region.c
> > > > > @@ -399,7 +399,7 @@ int afu_dma_map_region(struct
> > > > > dfl_feature_platform_data *pdata,
> > > > >                                   region->pages[0], 0,
> > > > >                                   region->length,
> > > > >                                   DMA_BIDIRECTIONAL);
> > > > > -     if (dma_mapping_error(&pdata->dev->dev, region->iova)) {
> > > > > +     if (dma_mapping_error(dfl_fpga_pdata_to_parent(pdata), region-
> > > > > >iova)) {
> > > > >               dev_err(&pdata->dev->dev, "failed to map for dma\n");
> > > > >               ret = -EFAULT;
> > > > >               goto unpin_pages;
> > > > > --
> > > > > 1.8.3.1
> > > 
> > > Acked-by: Moritz Fischer <mdf@kernel.org>
> > 
> > Acked-by: Alan Tull <atull@kernel.org>
> 
> Whose tree would these patches be going through?

Greg, usually. We're a bit late this time... again ... But haven't forgotten about it.

Sorry,

Moritz
