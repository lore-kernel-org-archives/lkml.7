Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06384C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD48A21835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCjjPbiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgACL3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:29:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38894 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727453AbgACL3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578050970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JyQ3qNGHTBqHtk3VlrCemOWYln8i4ZY0r6Vn9in7FBk=;
        b=PCjjPbivkxa4PEXO0gj329WWV5q0zxpvwaaRj3WzYgkFOsHtbRW6hvHgwsc6LB6vIlpVXS
        dFRszDYJuX/W4hsTc6tu1j3mJqndg81m6ckI9DnDAUDdfzr+FTn2XnVIR5wcJrFo3wuP6i
        eiEfLrg5hYQg5nT8tO+++oINWi3OX6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-yHE6HHsJPGugG8HkrfPnfA-1; Fri, 03 Jan 2020 06:29:27 -0500
X-MC-Unique: yHE6HHsJPGugG8HkrfPnfA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66E40801E70;
        Fri,  3 Jan 2020 11:29:25 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CF0860BF7;
        Fri,  3 Jan 2020 11:29:13 +0000 (UTC)
Date:   Fri, 3 Jan 2020 19:29:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "hch@lst.de" <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Zhang Yi <yi.zhang@redhat.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
Message-ID: <20200103112908.GA20353@ming.t460p>
References: <20191220233138.GB12403@ming.t460p>
 <fffcd23dd8286615b6e2c99620836cb1@www.loen.fr>
 <d5774e2f-bb60-c27c-bf00-267b88400a12@huawei.com>
 <e815b5451ea86e99d42045f7067f455a@www.loen.fr>
 <20191224015926.GC13083@ming.t460p>
 <7a961950624c414bb9d0c11c914d5c62@www.loen.fr>
 <20191225004822.GA12280@ming.t460p>
 <72a6a738-f04b-3792-627a-fbfcb7b297e1@huawei.com>
 <20200103004625.GA5219@ming.t460p>
 <2b070d25-ee35-aa1f-3254-d086c6b872b1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b070d25-ee35-aa1f-3254-d086c6b872b1@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 10:41:48AM +0000, John Garry wrote:
> On 03/01/2020 00:46, Ming Lei wrote:
> > > > > d the
> > > > > DMA API more than an architecture-specific problem.
> > > > > 
> > > > > Given that we have so far very little data, I'd hold off any conclusion.
> > > > We can start to collect latency data of dma unmapping vs nvme_irq()
> > > > on both x86 and arm64.
> > > > 
> > > > I will see if I can get a such box for collecting the latency data.
> > > To reiterate what I mentioned before about IOMMU DMA unmap on x86, a key
> > > difference is that by default it uses the non-strict (lazy) mode unmap, i.e.
> > > we unmap in batches. ARM64 uses general default, which is strict mode, i.e.
> > > every unmap results in an IOTLB fluch.
> > > 
> > > In my setup, if I switch to lazy unmap (set iommu.strict=0 on cmdline), then
> > > no lockup.
> > > 
> > > Are any special IOMMU setups being used for x86, like enabling strict mode?
> > > I don't know...
> > BTW, I have run the test on one 224-core ARM64 with one 32-hw_queue NVMe, the
> > softlock issue can be triggered in one minute.
> > 
> > nvme_irq() often takes ~5us to complete on this machine, then there is really
> > risk of cpu lockup when IOPS is > 200K.
> 
> Do you have a typical nvme_irq() completion time for a mid-range x86 server?

~1us.

It is done via bcc script, and ebpf itself may introduce some overhead.

> 
> > 
> > The soft lockup can be triggered too if 'iommu.strict=0' is passed in,
> > just takes a bit longer by starting more IO jobs.
> > 
> > In above test, I submit IO to one single NVMe drive from 4 CPU cores via 8 or
> > 12 jobs(iommu.strict=0), meantime make the nvme interrupt handled just in one
> > dedicated CPU core.
> 
> Well a problem with so many CPUs is that it does not scale (well) with MQ
> devices, like NVMe.
> 
> As CPU count goes up, device queue count doesn't and we get more contention.

The problem is worse on ARM64 system, in which there are more CPU cores,
and each single CPU core is often slower than x86's. Meantime each
hardware interrupt has to be handled on single CPU target.

Also the storage device(such as NVMe) itself should be same for both
from performance viewpoint.

> 
> > 
> > Is there lock contention among iommu dma map and unmap callback?
> 
> There would be the IOVA management, but that would be common to x86. Each
> CPU keeps an IOVA cache, and there is a central pool of cached IOVAs, so
> that reduces any contention, unless the caches are exhausted.
> 
> I think most contention/bottleneck is at the SMMU HW interface, which has a
> single queue interface.

Not sure if it is related with single queue interface, given my test just
uses single hw queue by pushing several CPU cores to submit IO and
handling the single queue's interrupt on one dedicated CPU core.


Thanks,
Ming

