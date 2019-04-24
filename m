Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E18C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293AD2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqLg0zPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387898AbfDXSdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:33:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42344 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733024AbfDXSdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:33:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so9788586pgh.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8TEy0tx0jHylJx7e47yPJO+qgMm3AFlPvz5zMS1qhSY=;
        b=eqLg0zPNqnOMeNBKAwLI6PomFBg1//aO8UxynQI5ck9qKMhfU30AOHPk5LfJnq7R3w
         Z693bDoY5BcWklK0yQyMjTKsv7XI2oN9DVtSFLjkzaow2O/nmJVKJxdmbQYaeYrWAdgC
         MB9QCGPCFzweWL8xdNjUylzB+tT9HbflspBwpDho0ZmKLVzEB9nWwPQWn7RebXNaKkaX
         GZP8VlrMejBnji+h4jFl+qSeR1YKgNKytt1IzHUeXUELql2koND7HL3mAhJl3jmX1D9w
         6ui9v+KD0tbMtJRny4Ow8MocSqRIze3m6r07tQlXmp3wmuwkGH1kA2lEcLf5LVuZN3CS
         m6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8TEy0tx0jHylJx7e47yPJO+qgMm3AFlPvz5zMS1qhSY=;
        b=Ea03MnSp2mws20Blx7YheYpcNIHrkkQ5o8s3CTqxXQxKT6ntwpoM86VDvbzHmIIWMK
         6TSO+LqNQNusXS/aDzs96GZ82P3IAr6G1iJ6bNqLsajN6SHvVbTiC6paRthl5SbATBIL
         BtC6FJZr4eOHnnnZNlO/6xamT//WtgOGhPFKwS+Eup7qxBFnLy+n8ype2O5pCUbyI237
         vQi0VMxo2XWc6kv3AmI/42SwrCdQ3z2MogT2rDdyNWHWNhjRC8nTAwhsPFZHRoMV1uxk
         DExz2Cz0N0nGR1Bi78Q8S+SuPhf3lCo5mYhZVZSQsMr7Jl9razNOuFrdNHTRVFth8skY
         3sRA==
X-Gm-Message-State: APjAAAVvNh6rJ7GuLL8i1TiyfH7A/V4TtMLAUdwQYr0KXS/ATwOSpZ2j
        GKhubWmuIdz4E+RiYOv4W7Y=
X-Google-Smtp-Source: APXvYqyY7PI6qWpkkSXcac3wixJyG1JL6PVz0l3idYqFErVnnnB1azTnKuYcgT6q0FkE26K1aXkecg==
X-Received: by 2002:a63:5a4b:: with SMTP id k11mr31878166pgm.119.1556130796862;
        Wed, 24 Apr 2019 11:33:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id c28sm9686899pgm.42.2019.04.24.11.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 11:33:16 -0700 (PDT)
Date:   Wed, 24 Apr 2019 11:33:11 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     robin.murphy@arm.com, vdumpa@nvidia.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, joro@8bytes.org,
        m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        tony@atomide.com
Subject: Re: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal
 page allocations
Message-ID: <20190424183310.GA6168@Asurada-Nvidia.nvidia.com>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
 <20190326230131.16275-2-nicoleotsuka@gmail.com>
 <20190424150638.GA22191@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424150638.GA22191@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Wed, Apr 24, 2019 at 05:06:38PM +0200, Christoph Hellwig wrote:
> On Tue, Mar 26, 2019 at 04:01:27PM -0700, Nicolin Chen wrote:
> >  	page = dma_alloc_from_contiguous(dev, count, order, gfp & __GFP_NOWARN);
> > +	if (!page)
> > +		page = alloc_pages(gfp, order);
> 
> We have this fallback in most callers already.  And with me adding
> it to the dma-iommu code in one series, and you to arm here I think
> we really need to take a step back and think of a better way
> to handle this, and the general mess that dma_alloc_from_contiguous.
> 
> So what about:

Thanks for the suggestion!

>  (1) change the dma_alloc_from_contiguous prototype to be:
> 
> struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp);
> 
>      that is: calculate order and count internally, pass the full gfp_t
>      and mask it internally, and drop the pointless from in the name.
>      I'd also use the oppurtunity to forbid a NULL dev argument and
>      opencode those uses.
>  
>  (2) handle the alloc_pages fallback internally.  Note that we should
>      use alloc_pages_node as we do in dma-direct.

I feel it's similar to my previous set, which did most of these
internally except the renaming part. But Catalin had a concern
that some platforms might have limits on CMA range [1]. Will it
be still okay to do the fallback internally?

[1: https://www.spinics.net/lists/arm-kernel/msg714295.html ]
