Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13621C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F2E218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNZsrUD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfGZTVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:21:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44419 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfGZTVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:21:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so24930955pfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Rz9/+cZDdXi6JgpgzZoSTYFdovjC7oAOseUIfVaYjY=;
        b=JNZsrUD/q13t3xzQM7rEE7Z/nNqSFpGoghgy4pCBk9v0qMjLLgADL7XyQXynYhvH1a
         tjZUKZ5qQ55lkcjdKhccnh4DSidp/MQxoR0DglCs2c9x3E7uDDfx0LZzC6PLxaqQNRzj
         YhnHKs5l9MVSS7SSzrrWccaDnDohB2H0wToRbLsRmdYhG5j/s760M7YftOdy4qK2esz9
         DP45nqNS08w2azq61yXgDrvEpnrlVci4zdeephVnjt2shmKikLRteGY/kxrEwxXQdzXY
         IbGQrMXQzp2PGrAMgLx4TkXGNtMXvVrXNaBQTSy2Xtw5w4yHpU0n4SRti5nJ6Tb+JkU1
         sbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Rz9/+cZDdXi6JgpgzZoSTYFdovjC7oAOseUIfVaYjY=;
        b=qpnXQhAjuRGYhL4p1Fl/4UPBUsZEyAkkXbou1PKKwwc+Ek51I6MNUebW2nFtYp3g3R
         z07IoWbjQbXpupk+LGcMq4T8l30AShB/zDu0vtlEXZwm+qrFhISrfg5IB0m/utRcdiA2
         wLG8Vi4dbqH28oq9RHc/M1q65Y273Prvspmjv2+K223Tmtz9lctq7NCIInTv+rq/RXnq
         FXiOYhbVZzri46oKlyj7t4tSqY8bLk+PC5FNr/ZP9fD5KFHKOdM+LaYbGa5jZ54P4wp6
         jOCMLA8f+i8LXNANt2L3fIavKH0PlBMf1tr7l9t5pRh+1nPsGyyqtTjlJGqLIDmkEw/H
         khOA==
X-Gm-Message-State: APjAAAWKCxzBdtJWB36Mf7y6zJzL+/l2Qe4kV/Eco+S3/rhNETwoNOI9
        6gmFCOK+ZMoFs155uShY/7o=
X-Google-Smtp-Source: APXvYqzLKB5X+aflbN9I1nljyryl4PPtNW4+gbR3wsVeOLLZw2lp7KPhRX8Jp5GQ0WHsaev+ZOkl4w==
X-Received: by 2002:a17:90a:8c90:: with SMTP id b16mr98899278pjo.133.1564168911656;
        Fri, 26 Jul 2019 12:21:51 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id i3sm58842258pfo.138.2019.07.26.12.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jul 2019 12:21:51 -0700 (PDT)
Date:   Fri, 26 Jul 2019 12:22:35 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dafna.hirschfeld@collabora.com, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma-contiguous: do not overwrite align in
 dma_alloc_contiguous()
Message-ID: <20190726192235.GA32144@Asurada-Nvidia.nvidia.com>
References: <20190725233959.15129-1-nicoleotsuka@gmail.com>
 <20190725233959.15129-2-nicoleotsuka@gmail.com>
 <20190726062849.GE22881@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726062849.GE22881@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 08:28:49AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 25, 2019 at 04:39:58PM -0700, Nicolin Chen wrote:
> > The dma_alloc_contiguous() limits align at CONFIG_CMA_ALIGNMENT for
> > cma_alloc() however it does not restore it for the fallback routine.
> > This will result in a size mismatch between the allocation and free
> > when running in the fallback routines, if the align is larger than
> > CONFIG_CMA_ALIGNMENT.
> > 
> > This patch adds a cma_align to take care of cma_alloc() and prevent
> > the align from being overwritten.
> > 
> > Fixes: fdaeec198ada ("dma-contiguous: add dma_{alloc,free}_contiguous() helpers")
> > Reported-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> >  kernel/dma/contiguous.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index bfc0c17f2a3d..fa8cd0f0512e 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -233,6 +233,7 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
> >  	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
> >  	size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> >  	size_t align = get_order(PAGE_ALIGN(size));
> > +	size_t cma_align = CONFIG_CMA_ALIGNMENT;
> >  	struct page *page = NULL;
> >  	struct cma *cma = NULL;
> >  
> > @@ -241,11 +242,11 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
> >  	else if (count > 1)
> >  		cma = dma_contiguous_default_area;
> >  
> > +	cma_align = min_t(size_t, align, cma_align);
> > +
> >  	/* CMA can be used only in the context which permits sleeping */
> > -	if (cma && gfpflags_allow_blocking(gfp)) {
> > -		align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
> > -		page = cma_alloc(cma, count, align, gfp & __GFP_NOWARN);
> > -	}
> > +	if (cma && gfpflags_allow_blocking(gfp))
> > +		page = cma_alloc(cma, count, cma_align, gfp & __GFP_NOWARN);
> 
> Shouldn't cma_align be confined to the block guarded by
> "if (cma && gfpflags_allow_blocking(gfp))" so that we can optimize it
> away for configurations that do not support CMA?

Had my local 1st version doing just like that but then wanted to
simplify the statement within that if-condition so redid in this
way. Will change it back as you suggested. Thanks
