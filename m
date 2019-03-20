Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F211BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94E52183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfCTQal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:30:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbfCTQal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:30:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5BBB30BC643;
        Wed, 20 Mar 2019 16:30:39 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FA025D788;
        Wed, 20 Mar 2019 16:30:29 +0000 (UTC)
Message-ID: <5a56e110b062de9d448c51cf0774c5e614133873.camel@redhat.com>
Subject: Re: your mail
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Fam Zheng <fam@euphon.net>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, kvm@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang Cunming <cunming.liang@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        "David S . Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Amnon Ilan <ailan@redhat.com>, Christoph Hellwig <hch@lst.de>,
        John Ferlan <jferlan@redhat.com>
Date:   Wed, 20 Mar 2019 18:30:29 +0200
In-Reply-To: <20190319152212.GC24176@localhost.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
         <20190319152212.GC24176@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 20 Mar 2019 16:30:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 09:22 -0600, Keith Busch wrote:
> On Tue, Mar 19, 2019 at 04:41:07PM +0200, Maxim Levitsky wrote:
> >   -> Share the NVMe device between host and guest. 
> >      Even in fully virtualized configurations,
> >      some partitions of nvme device could be used by guests as block
> > devices 
> >      while others passed through with nvme-mdev to achieve balance between
> >      all features of full IO stack emulation and performance.
> >   
> >   -> NVME-MDEV is a bit faster due to the fact that in-kernel driver 
> >      can send interrupts to the guest directly without a context 
> >      switch that can be expensive due to meltdown mitigation.
> > 
> >   -> Is able to utilize interrupts to get reasonable performance. 
> >      This is only implemented
> >      as a proof of concept and not included in the patches, 
> >      but interrupt driven mode shows reasonable performance
> >      
> >   -> This is a framework that later can be used to support NVMe devices 
> >      with more of the IO virtualization built-in 
> >      (IOMMU with PASID support coupled with device that supports it)
> 

> Would be very interested to see the PASID support. You wouldn't even
> need to mediate the IO doorbells or translations if assigning entire
> namespaces, and should be much faster than the shadow doorbells.

I fully agree with that.
Note that to enable PASID support two things have to happen in this vendor.

1. Mature support for IOMMU with PASID support. On Intel side I know that they
only have a spec released and currently the kernel bits to support it are
placed.
I still don't know when a product actually supporting this spec is going to be
released. For other vendors (ARM/AMD/) I haven't done yet a research on state of
PASID based IOMMU support on their platforms.

2. NVMe spec has to be extended to support PASID. At minimum, we need an ability
to assign an PASID to a sq/cq queue pair and ability to relocate the doorbells,
such as each guest would get its own (hardware backed) MMIO page with its own
doorbells. Plus of course the hardware vendors have to embrace the spec. I guess
these two things will happen in collaborative manner.


> 
> I think you should send 6/9 "nvme/pci: init shadow doorbell after each
> reset" separately for immediate inclusion.
I'll do this soon. 

Also '5/9 nvme/pci: add known admin effects to augment admin effects log page'
can be considered for immediate inclusion as well, as it works around a flaw
in the NVMe controller badly done admin side effects page with no side effects
(pun intended) for spec compliant controllers (I think so). 

This can be fixed with a quirk if you prefer though.

> 
> I like the idea in principle, but it will take me a little time to get
> through reviewing your implementation. I would have guessed we could
> have leveraged something from the existing nvme/target for the mediating
> controller register access and admin commands. Maybe even start with
> implementing an nvme passthrough namespace target type (we currently
> have block and file).

I fully agree with you on that I could have used some of the nvme/target code,
and I am planning to do so eventually.

For that I would need to make my driver, to be one of the target drivers, and I
would need to add another target back end, like you said to allow my target
driver to talk directly to the nvme hardware bypassing the block layer.

Or instead I can use the block backend, 
(but note that currently the block back-end doesn't support polling which is
critical for the performance).

Switch to the target code might though have some (probably minor) performance
impact, as it would probably lengthen the critical code path a bit (I might need
for instance to translate the PRP lists I am getting from the virtual controller
to a scattergather list and back).

This is why I did this the way I did, but now knowing that probably I can afford
to loose a bit of performance, I can look at doing that.

Best regards,
Thanks in advance for the review,
	Maxim Levitsky

PS:

For reference currently the IO path looks more or less like that:

My IO thread notices a doorbell write, reads a command from a submission queue,
translates it (without even looking at the data pointer) and sends it to the
nvme pci driver together with pointer to data iterator'.

The nvme pci driver calls the data iterator N times, which makes the iterator
translate and fetch the DMA addresses where the data is already mapped on the
its pci nvme device (the mdev driver maps all the guest memory to the nvme pci
device).
The nvme pci driver uses these addresses it receives, to create a prp list,
which it puts into the data pointer.

The nvme pci driver also allocates an free command id, from a list, puts it into
the command ID and sends the command to the real hardware.

Later the IO thread calls to the nvme pci driver to poll the queue. When
completions arrive, the nvme pci driver returns them back to the IO thread.

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme


