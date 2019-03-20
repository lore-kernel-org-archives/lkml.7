Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA19C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FCD213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCTQmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:42:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfCTQmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:42:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D512756;
        Wed, 20 Mar 2019 16:42:12 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 633F660148;
        Wed, 20 Mar 2019 16:42:03 +0000 (UTC)
Message-ID: <8994f43d26ebf6040b9d5d5e3866ee81abcf1a1c.camel@redhat.com>
Subject: Re: [PATCH 0/9] RFC: NVME VFIO mediated device
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        linux-nvme@lists.infradead.org
Cc:     Fam Zheng <fam@euphon.net>, Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, kvm@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang Cunming <cunming.liang@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org,
        Liu Changpeng <changpeng.liu@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        John Ferlan <jferlan@redhat.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Amnon Ilan <ailan@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Date:   Wed, 20 Mar 2019 18:42:02 +0200
In-Reply-To: <1553095686.65329.36.camel@acm.org>
References: <20190319144116.400-1-mlevitsk@redhat.com>
         <1553095686.65329.36.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 20 Mar 2019 16:42:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-20 at 08:28 -0700, Bart Van Assche wrote:
> On Tue, 2019-03-19 at 16:41 +0200, Maxim Levitsky wrote:
> > *  All guest memory is mapped into the physical nvme device 
> >    but not 1:1 as vfio-pci would do this.
> >    This allows very efficient DMA.
> >    To support this, patch 2 adds ability for a mdev device to listen on 
> >    guest's memory map events. 
> >    Any such memory is immediately pinned and then DMA mapped.
> >    (Support for fabric drivers where this is not possible exits too,
> >     in which case the fabric driver will do its own DMA mapping)
> 
> Does this mean that all guest memory is pinned all the time? If so, are you
> sure that's acceptable?
I think so. The VFIO pci passthrough also pins all the guest memory.
SPDK also does this (pins and dma maps) all the guest memory.

I agree that this is not an ideal solution but this is a fastest and simplest
solution possible.

> 
> Additionally, what is the performance overhead of the IOMMU notifier added
> by patch 8/9? How often was that notifier called per second in your tests
> and how much time was spent per call in the notifier callbacks?

To be honest I haven't optimized my IOMMU notifier at all, so when it is called,
it stops the IO thread, does its work and then restarts it which is very slow.

Fortunelly it is not called at all during normal operation as VFIO dma map/unmap
events are really rare and happen only on guest boot.

The same is even true for nested guests, as nested guest startup causes a wave
of map unmap events while shadow IOMMU updates, but then it just uses these
mapping without changing them.

The only case when performance is really bad is when you boot a guest with
iommu=on intel_iommu=on and then use the nvme driver there. In this case, the
driver in the guest does itself IOMMU maps/unmaps (on the virtual IOMMU) and for
each such event my VFIO map/unmap callback is called.

This can be optimized though to be much better using also some kind of queued
invalidation in my driver. iommu=pt meanwhile in the guest solves that issue.

Best regards,
	Maxim Levitsky

> 
> Thanks,
> 
> Bart.
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

