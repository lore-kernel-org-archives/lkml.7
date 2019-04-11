Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3146BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F237020449
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsVRITft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDKQgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:36:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35365 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfDKQgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:36:04 -0400
Received: by mail-qk1-f196.google.com with SMTP id a71so3864926qkg.2;
        Thu, 11 Apr 2019 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnWbAVSPkZ/oS5T8HpO7s244t3/8PNs6v9jinA7AWcc=;
        b=DsVRITftZZEzAZ1QY89nT0Q/BJLPkD/TcNGc07ua0oEMnSCGHV6iJ6uLvxkJVhm+TQ
         DXvq26tqPACoX3nNwGtbMOdmTP6Uttvsvm4WCKuLo7rhTzap/wqtmmbCNgVpt5Omr+3+
         s3CFuTrfF0yseVafIcQp8fw/5+HrmXJ+fof/OihMEaU5KqY1hDe8C1dinFBfaBfQVCGs
         Y3b6sJE+ypF7x1k4hDm0PNlNrzYhdjjhv4RzRYZ/TqWw5VMhGXXfzOIoceI7rGFmaGSg
         5CwcStLQ5+h3gk/XY8ImQDp0oNjZ+1VhjiXlx/tMe4kwIcLEKqzd5HjlkY5Kco7EeLjv
         V0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnWbAVSPkZ/oS5T8HpO7s244t3/8PNs6v9jinA7AWcc=;
        b=d6dUCQ+nTFUrK2HAJhNwPh7zHMtXWpinT63LLawk/Ll8GfezqKnCmcKFuwfdBKvPeD
         FkUv/z8P8jGMSmM1jvbhVIUyAEraFJI3L1GUAYn2YtNpNJT5J8KwUMMlI5Y3pitpbS6a
         usTFsfmOYBGoK004+iVCFfvFgUCJJ1RPD6C44mcrQP0LRRXxPX3kZTXi42dmJmWGrmd6
         36tG0iS6DFy/q7heoF/oYmfXPhrYIf21qfBoaqvvLbe0DDQfc8q344DMob+pWaY704y8
         GYpV8fqX6gvgxLe71PfbEwji6NNL7VG6c0iDopRaYrGAD9A75WemOBZgrRROll+er1GQ
         EULA==
X-Gm-Message-State: APjAAAWKQhEOvrzObr4+yIjttLczdNTDZkIOY1Obo/33zt31EVDVQszH
        OSSJ6zHE+powh48N09a47HDyvDGwInKzZNftwYQ=
X-Google-Smtp-Source: APXvYqzBb4SbmTJs8Pvc/DQzv3ppLSC2HxUenWyuIVDqLCm73DaBH4483fSy1w3noHSLKvNOi81KJJGPLRzuwgOXjxc=
X-Received: by 2002:a05:620a:130a:: with SMTP id o10mr39318195qkj.123.1555000562890;
 Thu, 11 Apr 2019 09:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190410215327.8024-1-swood@redhat.com> <20190411123314.GA19198@hao-dev>
In-Reply-To: <20190411123314.GA19198@hao-dev>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Thu, 11 Apr 2019 09:35:52 -0700
Message-ID: <CAJYdmeNX9F_EmTPBjQ1SXOOU=JBA1kBO6WEjBXTmJux4O-CR5A@mail.gmail.com>
Subject: Re: [PATCH] fpga: dfl: afu: Pass the correct device to dma_mapping_error()
To:     Wu Hao <hao.wu@intel.com>
Cc:     Scott Wood <swood@redhat.com>, Alan Tull <atull@kernel.org>,
        linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

good catch!

On Thu, Apr 11, 2019 at 5:49 AM Wu Hao <hao.wu@intel.com> wrote:
>
> On Wed, Apr 10, 2019 at 04:53:27PM -0500, Scott Wood wrote:
> > dma_mapping_error() was being called on a different device struct than
> > what was passed to map/unmap.  Besides rendering the error checking
> > ineffective, it caused a debug splat with CONFIG_DMA_API_DEBUG.
> >
> > Signed-off-by: Scott Wood <swood@redhat.com>
>
> Hi Scott,
>
> Looks good to me. Thanks for catching this issue.
>
> Acked-by: Wu Hao <hao.wu@intel.com>
>
> Hao
>
> > ---
> >  drivers/fpga/dfl-afu-dma-region.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> > index e18a786fc943..cd68002ac097 100644
> > --- a/drivers/fpga/dfl-afu-dma-region.c
> > +++ b/drivers/fpga/dfl-afu-dma-region.c
> > @@ -399,7 +399,7 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
> >                                   region->pages[0], 0,
> >                                   region->length,
> >                                   DMA_BIDIRECTIONAL);
> > -     if (dma_mapping_error(&pdata->dev->dev, region->iova)) {
> > +     if (dma_mapping_error(dfl_fpga_pdata_to_parent(pdata), region->iova)) {
> >               dev_err(&pdata->dev->dev, "failed to map for dma\n");
> >               ret = -EFAULT;
> >               goto unpin_pages;
> > --
> > 1.8.3.1

Acked-by: Moritz Fischer <mdf@kernel.org>

Thanks
Moritz
