Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEE2C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EC5207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfIMIHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 04:07:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbfIMIHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 04:07:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7EFF30655F9;
        Fri, 13 Sep 2019 08:07:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E23360C63;
        Fri, 13 Sep 2019 08:07:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 6171A9D75; Fri, 13 Sep 2019 10:07:07 +0200 (CEST)
Date:   Fri, 13 Sep 2019 10:07:07 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stevensd@chromium.org,
        =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
        Zach Reizner <zachr@chromium.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Pawel Osciak <posciak@chromium.org>
Subject: Re: [RFC PATCH] drm/virtio: Export resource handles via DMA-buf API
Message-ID: <20190913080707.unhyoezesvfhx5np@sirius.home.kraxel.org>
References: <20190912094121.228435-1-tfiga@chromium.org>
 <20190912123821.rraib5entkcxt5p5@sirius.home.kraxel.org>
 <CAAFQd5AFXfu7ysFCi1XQS61DK8nbSk5-=UHkvpYWDtFae5YQ6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5AFXfu7ysFCi1XQS61DK8nbSk5-=UHkvpYWDtFae5YQ6Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 13 Sep 2019 08:07:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > > To seamlessly enable buffer sharing with drivers using such frameworks,
> > > make the virtio-gpu driver expose the resource handle as the DMA address
> > > of the buffer returned from the DMA-buf mapping operation.  Arguably, the
> > > resource handle is a kind of DMA address already, as it is the buffer
> > > identifier that the device needs to access the backing memory, which is
> > > exactly the same role a DMA address provides for native devices.
> 
> First of all, thanks for taking a look at this.
> 
> > No.  A scatter list has guest dma addresses, period.  Stuffing something
> > else into a scatterlist is asking for trouble, things will go seriously
> > wrong when someone tries to use such a fake scatterlist as real scatterlist.
> 
> What is a "guest dma address"? The definition of a DMA address in the
> Linux DMA API is an address internal to the DMA master address space.
> For virtio, the resource handle namespace may be such an address
> space.

No.  DMA master address space in virtual machines is pretty much the
same it is on physical machines.  So, on x86 without iommu, identical
to (guest) physical address space.  You can't re-define it like that.

> However, we could as well introduce a separate DMA address
> space if resource handles are not the right way to refer to the memory
> from other virtio devices.

s/other virtio devices/other devices/

dma-bufs are for buffer sharing between devices, not limited to virtio.
You can't re-define that in some virtio-specific way.

> > Also note that "the DMA address of the buffer" is bonkers in virtio-gpu
> > context.  virtio-gpu resources are not required to be physically
> > contigous in memory, so typically you actually need a scatter list to
> > describe them.
> 
> There is no such requirement even on a bare metal system, see any
> system that has an IOMMU, which is typical on ARM/ARM64. The DMA
> address space must be contiguous only from the DMA master point of
> view.

Yes, the iommu (if present) could remap your scatterlist that way.  You
can't depend on that though.

What is the plan here?  Host-side buffer sharing I guess?  So you are
looking for some way to pass buffer handles from the guest to the host,
even in case those buffers are not created by your driver but imported
from somewhere else?

cheers,
  Gerd

