Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECDEECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DB2206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfJGQHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:07:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbfJGQHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:07:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92F211895A40;
        Mon,  7 Oct 2019 16:07:38 +0000 (UTC)
Received: from gondolin (ovpn-116-231.ams2.redhat.com [10.36.116.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDC9B6012A;
        Mon,  7 Oct 2019 16:07:35 +0000 (UTC)
Date:   Mon, 7 Oct 2019 18:07:32 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] s390/cio: fix virtio-ccw DMA without PV
Message-ID: <20191007180732.7a38ff0b.cohuck@redhat.com>
In-Reply-To: <20190930153803.7958-1-pasic@linux.ibm.com>
References: <20190930153803.7958-1-pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Mon, 07 Oct 2019 16:07:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2019 17:38:02 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Commit 37db8985b211 ("s390/cio: add basic protected virtualization
> support") breaks virtio-ccw devices with VIRTIO_F_IOMMU_PLATFORM for non
> Protected Virtualization (PV) guests. The problem is that the dma_mask

Hm, I should probably add that to my test configs.

> of the ccw device, which is used by virtio core, gets changed from 64 to
> 31 bit, because some of the DMA allocations do require 31 bit
> addressable memory. For PV the only drawback is that some of the virtio
> structures must end up in ZONE_DMA because we have the bounce the
> buffers mapped via DMA API anyway.
> 
> But for non PV guests we have a problem: because of the 31 bit mask
> guests bigger than 2G are likely to try bouncing buffers. The swiotlb
> however is only initialized for PV guests, because we don't want to
> bounce anything for non PV guests. The first such map kills the guest.
> 
> Since the DMA API won't allow us to specify for each allocation whether
> we need memory from ZONE_DMA (31 bit addressable) or any DMA capable
> memory will do, let us use coherent_dma_mask (which is used for
> allocations) to force allocating form ZONE_DMA while changing dma_mask
> to DMA_BIT_MASK(64) so that at least the streaming API will regard
> the whole memory DMA capable.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Fixes: 37db8985b211 ("s390/cio: add basic protected virtualization support")
> ---
> 
> v1 --> v2:
> * Fixed comment: dropped the sentence with workaround.
> 
> The idea of enabling the client code to specify on s390 whether a chunk
> of allocated DMA memory is to be allocated form ZONE_DMA for each
> allocation was not well received [1]. 
> 
> Making the streaming API threat all addresses as DMA capable, while
> restricting the DMA API allocations to  ZONE_DMA (regardless of needed
> or not) is the next best thing we can do (from s390 perspective).
> 
> [1] https://lkml.org/lkml/2019/9/23/531 
> ---
> ---
>  drivers/s390/cio/cio.h    | 1 +
>  drivers/s390/cio/css.c    | 7 ++++++-
>  drivers/s390/cio/device.c | 2 +-
>  3 files changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
