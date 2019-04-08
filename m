Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A052C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27A620883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDHKEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:04:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfDHKEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:04:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C46730027B5;
        Mon,  8 Apr 2019 10:04:12 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5042B60471;
        Mon,  8 Apr 2019 10:04:05 +0000 (UTC)
Message-ID: <4a3d473c8f671d59c57ec26ff5ec0879ad38bf9a.camel@redhat.com>
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
Date:   Mon, 08 Apr 2019 13:04:03 +0300
In-Reply-To: <20190319152212.GC24176@localhost.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
         <20190319152212.GC24176@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 08 Apr 2019 10:04:12 +0000 (UTC)
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
> 
> I think you should send 6/9 "nvme/pci: init shadow doorbell after each
> reset" separately for immediate inclusion.
> 
> I like the idea in principle, but it will take me a little time to get
> through reviewing your implementation. I would have guessed we could
> have leveraged something from the existing nvme/target for the mediating
> controller register access and admin commands. Maybe even start with
> implementing an nvme passthrough namespace target type (we currently
> have block and file).


Hi!

Sorry to bother you, but any update?

I was somewhat sick for the last week, now finally back in shape to continue
working on this and other tasks I have.

I am studing now the nvme target code and the io_uring to evaluate the
difficultiy of using something similiar to talk to the block device instead of /
in addtion to the  direct connection I implemented.

I would be glad to hear more feedback on this project.

I will also soon post the few fixes separately as you suggested.

Best regards,
    Maxim Levitskky




