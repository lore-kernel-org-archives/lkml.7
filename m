Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E71C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F5D21880
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfGXWLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:11:01 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38348 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfGXWLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:11:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id n11so47120788qtl.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZiT1oQ3le6gupTI0pwbmKNqZ9qeZj4CLKlZRplQnTAY=;
        b=LSAuPTNTddZAq11CV6juSDpR+59sYlFeW9uiUcpiYSFyxyth1tsl3zPWGvkh7hC78P
         4J8LZyQ14qxuNhhwNI8bPqBDk/XlAb+UAy9YXbeaXj5zE+YhatLmv/zpgl+Dtu+rgxCz
         GZTzYMseQpVM38RZDdQW4BJprQIIxEJfUnp8gDek9FS6GkFkR9Lt2eA5WYHJBeU4kj9z
         lVcvj9BslU1VTHSK+nRmHzjZdMhkvEabplYCbb/bnrl9ykzJj8k+Qp9z1Ru/mITExptz
         bsrsHIt/qxU4o1Rv3OPo48M9ylb4vtcuRBoCleYwqTCZF3reQjCFWoENI3abeS8s8wlN
         3KQw==
X-Gm-Message-State: APjAAAXsmkO34PyjaYq0PGtUMd4pfpY3aKBc6VIUmZ9vIg9GrUEA1FuU
        nKPNLXVfG/XzpV0DSXL9ILSqew==
X-Google-Smtp-Source: APXvYqwsl34mAeI1ycJq/WD6DI4M1e7pIzRNfVQKDNOWFybfH6EBHoRGki9/ggsy5dsu/ZaP8T89Pw==
X-Received: by 2002:ac8:3014:: with SMTP id f20mr59384146qte.69.1564006259498;
        Wed, 24 Jul 2019 15:10:59 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id g54sm28199760qtc.61.2019.07.24.15.10.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 15:10:58 -0700 (PDT)
Date:   Wed, 24 Jul 2019 18:10:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        m.szyprowski@samsung.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size call
Message-ID: <20190723114750-mutt-send-email-mst@kernel.org>
References: <20190722145509.1284-1-eric.auger@redhat.com>
 <20190722145509.1284-3-eric.auger@redhat.com>
 <e4a288f2-a93a-5ce4-32da-f5434302551f@arm.com>
 <20190723153851.GE720@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723153851.GE720@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 05:38:51PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 22, 2019 at 04:36:09PM +0100, Robin Murphy wrote:
> >> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> >> index c8be1c4f5b55..37c143971211 100644
> >> --- a/drivers/virtio/virtio_ring.c
> >> +++ b/drivers/virtio/virtio_ring.c
> >> @@ -262,7 +262,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev)
> >>   {
> >>   	size_t max_segment_size = SIZE_MAX;
> >>   -	if (vring_use_dma_api(vdev))
> >> +	if (vring_use_dma_api(vdev) && vdev->dev.dma_mask)
> >
> > Hmm, might it make sense to roll that check up into vring_use_dma_api() 
> > itself? After all, if the device has no mask then it's likely that other 
> > DMA API ops wouldn't really work as expected either.
> 
> Makes sense to me.

Christoph - would a documented API wrapping dma_mask make sense?
With the documentation explaining how users must
desist from using DMA APIs if that returns false ...


-- 
MST
