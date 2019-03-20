Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4F3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED8C213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCTQpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:45:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfCTQpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:45:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1FAE307D981;
        Wed, 20 Mar 2019 16:45:12 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 392DC5D70A;
        Wed, 20 Mar 2019 16:44:59 +0000 (UTC)
Message-ID: <964d501e1141b2e58665b89dd82a8b65d8db2b53.camel@redhat.com>
Subject: Re: your mail
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     Fam Zheng <fam@euphon.net>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang Cunming <cunming.liang@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Amnon Ilan <ailan@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        John Ferlan <jferlan@redhat.com>
Date:   Wed, 20 Mar 2019 18:44:59 +0200
In-Reply-To: <SN6PR04MB4527810F605C8ADE388E958286400@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
         <20190319152212.GC24176@localhost.localdomain>
         <SN6PR04MB4527810F605C8ADE388E958286400@SN6PR04MB4527.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 20 Mar 2019 16:45:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 23:49 +0000, Chaitanya Kulkarni wrote:
> Hi Keith,
> On 03/19/2019 08:21 AM, Keith Busch wrote:
> > On Tue, Mar 19, 2019 at 04:41:07PM +0200, Maxim Levitsky wrote:
> > >    -> Share the NVMe device between host and guest.
> > >       Even in fully virtualized configurations,
> > >       some partitions of nvme device could be used by guests as block
> > > devices
> > >       while others passed through with nvme-mdev to achieve balance
> > > between
> > >       all features of full IO stack emulation and performance.
> > > 
> > >    -> NVME-MDEV is a bit faster due to the fact that in-kernel driver
> > >       can send interrupts to the guest directly without a context
> > >       switch that can be expensive due to meltdown mitigation.
> > > 
> > >    -> Is able to utilize interrupts to get reasonable performance.
> > >       This is only implemented
> > >       as a proof of concept and not included in the patches,
> > >       but interrupt driven mode shows reasonable performance
> > > 
> > >    -> This is a framework that later can be used to support NVMe devices
> > >       with more of the IO virtualization built-in
> > >       (IOMMU with PASID support coupled with device that supports it)
> > 
> > Would be very interested to see the PASID support. You wouldn't even
> > need to mediate the IO doorbells or translations if assigning entire
> > namespaces, and should be much faster than the shadow doorbells.
> > 
> > I think you should send 6/9 "nvme/pci: init shadow doorbell after each
> > reset" separately for immediate inclusion.
> > 
> > I like the idea in principle, but it will take me a little time to get
> > through reviewing your implementation. I would have guessed we could
> > have leveraged something from the existing nvme/target for the mediating
> > controller register access and admin commands. Maybe even start with
> > implementing an nvme passthrough namespace target type (we currently
> > have block and file).
> 
> I have the code for the NVMeOf target passthru-ctrl, I think we can use 
> that as it is if you are looking for the passthru for NVMeOF.
> 
> I'll post patch-series based on the latest code base soon.

I am very intersing in this code. 
Could you explain how your NVMeOF target passthrough works? 
Which components of the NVME stack does it involve?

Best regards,
	Maxim Levitsky

> > 
> > _______________________________________________
> > Linux-nvme mailing list
> > Linux-nvme@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-nvme
> > 
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme


