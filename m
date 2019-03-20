Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C86C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE8021841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfCTTIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:08:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfCTTIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:08:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A36B307EAA2;
        Wed, 20 Mar 2019 19:08:48 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A88B600C1;
        Wed, 20 Mar 2019 19:08:37 +0000 (UTC)
Message-ID: <42f444d22363bc747f4ad75e9f0c27b40a810631.camel@redhat.com>
Subject: Re:
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Felipe Franciosi <felipe@nutanix.com>
Cc:     Fam Zheng <fam@euphon.net>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Harris, James R" <james.r.harris@intel.com>,
        Liang Cunming <cunming.liang@intel.com>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Thanos Makatos <thanos.makatos@nutanix.com>,
        John Ferlan <jferlan@redhat.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Amnon Ilan <ailan@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Date:   Wed, 20 Mar 2019 21:08:37 +0200
In-Reply-To: <488768D7-1396-4DD1-A648-C86E5CF7DB2F@nutanix.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
         <488768D7-1396-4DD1-A648-C86E5CF7DB2F@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 20 Mar 2019 19:08:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-20 at 11:03 +0000, Felipe Franciosi wrote:
> > On Mar 19, 2019, at 2:41 PM, Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > 
> > Date: Tue, 19 Mar 2019 14:45:45 +0200
> > Subject: [PATCH 0/9] RFC: NVME VFIO mediated device
> > 
> > Hi everyone!
> > 
> > In this patch series, I would like to introduce my take on the problem of
> > doing 
> > as fast as possible virtualization of storage with emphasis on low latency.
> > 
> > In this patch series I implemented a kernel vfio based, mediated device
> > that 
> > allows the user to pass through a partition and/or whole namespace to a
> > guest.
> 
> Hey Maxim!
> 
> I'm really excited to see this series, as it aligns to some extent with what
> we discussed in last year's KVM Forum VFIO BoF.
> 
> There's no arguing that we need a better story to efficiently virtualise NVMe
> devices. So far, for Qemu-based VMs, Changpeng's vhost-user-nvme is the best
> attempt at that. However, I seem to recall there was some pushback from qemu-
> devel in the sense that they would rather see investment in virtio-blk. I'm
> not sure what's the latest on that work and what are the next steps.
I agree with that. All my benchmarks were agains his vhost-user-nvme driver, and
I am able to get pretty much the same througput and latency.

The ssd I tested on died just recently (Murphy law), not due to bug in my driver
but some internal fault (even though most of my tests were reads, plus
occassional 'nvme format's.
We are in process of buying an replacement.

> 
> The pushback drove the discussion towards pursuing an mdev approach, which is
> why I'm excited to see your patches.
> 
> What I'm thinking is that passing through namespaces or partitions is very
> restrictive. It leaves no room to implement more elaborate virtualisation
> stacks like replicating data across multiple devices (local or remote),
> storage migration, software-managed thin provisioning, encryption,
> deduplication, compression, etc. In summary, anything that requires software
> intervention in the datapath. (Worth noting: vhost-user-nvme allows all of
> that to be easily done in SPDK's bdev layer.)

Hi Felipe!

I guess that my driver is not geared toward more complicated use cases like you
mentioned, but instead it is focused to get as fast as possible performance for
the common case.

One thing that I can do which would solve several of the above problems is to
accept an map betwent virtual and real logical blocks, pretty much in exactly
the same way as EPT does it.
Then userspace can map any portions of the device anywhere, while still keeping
the dataplane in the kernel, and having minimal overhead.

On top of that, note that the direction of IO virtualization is to do dataplane
in hardware, which will probably give you even worse partition granuality /
features but will be the fastest option aviable,
like for instance SR-IOV which alrady exists and just allows to split by
namespaces without any more fine grained control.

Think of nvme-mdev as a very low level driver, which currntly uses polling, but
eventually will use PASID based IOMMU to provide the guest with raw PCI device.
The userspace / qemu can build on top of that with varios software layers.

On top of that I am thinking to solve the problem of migration in Qemu, by
creating a 'vfio-nvme' driver which would bind vfio to bind to device exposed by
the kernel, and would pass through all the doorbells and queues to the guest,
while intercepting the admin queue. Such driver I think can be made to support
migration while beeing able to run on top both SR-IOV device, my vfio-nvme abit
with double admin queue emulation (its a bit ugly but won't affect performance
at all) and on top of even regular NVME device vfio assigned to guest.


Best regards,
	Maxim Levitsky

> 
> These complicated stacks should probably not be implemented in the kernel,
> though. So I'm wondering whether we could talk about mechanisms to allow
> efficient and performant userspace datapath intervention  in your approach or
> pursue a mechanism to completely offload the device emulation to userspace
> (and align with what SPDK has to offer).
> 
> Thoughts welcome!
> Felipe
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme


