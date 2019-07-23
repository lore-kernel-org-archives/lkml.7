Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BE5C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA10218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbfGWPrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:47:35 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39680 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfGWPrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:47:35 -0400
Received: by mail-ua1-f65.google.com with SMTP id j8so17075072uan.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 08:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EVAD8Vf0X0incVqfNJDqjZVDQjwtcJn0P5gsd+3TH3w=;
        b=Tvd16/uMoLKLGq1S66bHVGyTAF+u81/kWgrZJuFvEQb75Yl04clJoziU+7EwQf1fsg
         f8G7GsEL0qeIimikfwEKama/v8nnJf8cWaqLwan6fksUsIgSln4RelzOpJyrT8hBZD/y
         cfWOt2c1dVVIF6DCO+RhQrfm7yoqVJflmWg1k6DituW6/sq0Og/uwZYzZWQwZzrgnqT2
         aZuBYzsrYFaS0tyPjZ79zOJbnSUsghpDFt8w5mKkvh7wLhWr2knlEjw/k6EFMKv48SsH
         EF3qbFYSwYFGgVTDt6YhiH6Spv1zvOS+VLsT+7HywlPuYXhXZwFd5Ut41aPCEfOSKFag
         nurQ==
X-Gm-Message-State: APjAAAVDfuToNaFHBGJrBjBuJQa7qmhqRUQTWVJmpQ4iB6SZXNed6uDu
        sF7uMjJvdOkQz/4w8Ig7g3qbQw==
X-Google-Smtp-Source: APXvYqzIzHEVdbHcpvt3jUNOAipVxZHK2T6eMul3vNE3BHOosQ4+ZcwjKuMyZs2L9p2YrV6mjmClLw==
X-Received: by 2002:ab0:734f:: with SMTP id k15mr19186395uap.28.1563896853769;
        Tue, 23 Jul 2019 08:47:33 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id j138sm17625220vka.11.2019.07.23.08.47.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 08:47:32 -0700 (PDT)
Date:   Tue, 23 Jul 2019 11:47:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size call
Message-ID: <20190723114504-mutt-send-email-mst@kernel.org>
References: <20190722145509.1284-1-eric.auger@redhat.com>
 <20190722145509.1284-3-eric.auger@redhat.com>
 <20190722112704-mutt-send-email-mst@kernel.org>
 <20190723153830.GD720@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723153830.GD720@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 05:38:30PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 22, 2019 at 11:33:35AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jul 22, 2019 at 04:55:09PM +0200, Eric Auger wrote:
> > > Do not call dma_max_mapping_size for devices that have no DMA
> > > mask set, otherwise we can hit a NULL pointer dereference.
> > > 
> > > This occurs when a virtio-blk-pci device is protected with
> > > a virtual IOMMU.
> > > 
> > > Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
> > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > Suggested-by: Christoph Hellwig <hch@lst.de>
> > 
> > Christoph, I wonder why did you suggest this?
> > The connection between dma_mask and dma_max_mapping_size
> > is far from obvious.  The documentation doesn't exist.
> > Do we really have to teach all users about this hack?
> > Why not just make dma_max_mapping_size DTRT?
> 
> Because we should not call into dma API functions for devices that
> are not DMA capable.

I'd rather call is_device_dma_capable then, better than poking
at DMA internals.

-- 
MST
