Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E11C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFD122387
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbfGVS5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:57:49 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42067 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732052AbfGVS5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:57:11 -0400
Received: by mail-vs1-f65.google.com with SMTP id 190so26989752vsf.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G3LydhjrGZyGaJaE+altqgbzUT7GXQbjY/6XoX/pvZc=;
        b=Rj0FpiVegyhkEFGvH5FwPsP+HS2oOwKd3h+1as5pPLM1XprqjfBJZax8/KoJAv6NEl
         ATF9b5ukrKTAShLbuniOdv+bex1gZBZs5vunpMsmJWGm1MtMSEtdCW2Xmuqo/BTzkP0E
         KeSaLDJayhuO0HqKXiJlVPbr0zXbj7kMddeSDB5eGSAoTwfmzxeoJB2gyYvoHXDAEljT
         JYpagba4Ge7AzgtT21LwkiwmMmJfoxn3giE3jvKdaGKntkIwWMPfdgo4H5VJ5jwgt+cb
         rfS0dARCYA1RQcofaWdW1fvgXPcboqkhIA1I4X+2rEJv1bzHo06eiXtc5AX5Y9FDUjuu
         uEVg==
X-Gm-Message-State: APjAAAWcp76wDlr/IR3nxAxV96KMUvGOmn6XLvQykbFgtXRC7JtjLSUb
        NQxGIzgWokyCS/p5nlCUaWrqzw==
X-Google-Smtp-Source: APXvYqzW0y3QVeCN9/3wXCNVqVYfu/ELakwZssJ444dY3sQr1CJFwY193H4yB3WcP4zsonz0yfKcug==
X-Received: by 2002:a67:8c84:: with SMTP id o126mr44506592vsd.122.1563821830405;
        Mon, 22 Jul 2019 11:57:10 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id l129sm38783525vki.45.2019.07.22.11.57.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:57:09 -0700 (PDT)
Date:   Mon, 22 Jul 2019 14:57:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma-mapping: Use dma_get_mask in
 dma_addressing_limited
Message-ID: <20190722145639-mutt-send-email-mst@kernel.org>
References: <20190722165149.3763-1-eric.auger@redhat.com>
 <77ba1061-08b6-421e-a6dd-d5db9851325b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77ba1061-08b6-421e-a6dd-d5db9851325b@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 06:56:49PM +0200, Auger Eric wrote:
> Hi Christoph,
> 
> On 7/22/19 6:51 PM, Eric Auger wrote:
> > We currently have cases where the dma_addressing_limited() gets
> > called with dma_mask unset. This causes a NULL pointer dereference.
> > 
> > Use dma_get_mask() accessor to prevent the crash.
> > 
> > Fixes: b866455423e0 ("dma-mapping: add a dma_addressing_limited helper")
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> As a follow-up of my last email, here is a patch featuring
> dma_get_mask(). But you don't have the WARN_ON_ONCE anymore, pointing
> out suspect users.

OTOH these users then simply become okay so no need for WARN_ON_ONCE
then :)

> Feel free to pick up your preferred approach
> 
> Thanks
> 
> Eric
> > 
> > ---
> > 
> > v1 -> v2:
> > - was [PATCH 1/2] dma-mapping: Protect dma_addressing_limited
> >   against NULL dma_mask
> > - Use dma_get_mask
> > ---
> >  include/linux/dma-mapping.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index e11b115dd0e4..f7d1eea32c78 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -689,8 +689,8 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
> >   */
> >  static inline bool dma_addressing_limited(struct device *dev)
> >  {
> > -	return min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
> > -		dma_get_required_mask(dev);
> > +	return min_not_zero(dma_get_mask(dev), dev->bus_dma_mask) <
> > +			    dma_get_required_mask(dev);
> >  }
> >  
> >  #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
> > 
