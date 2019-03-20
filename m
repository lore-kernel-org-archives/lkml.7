Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA090C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DEA2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfCTRD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:03:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbfCTRD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:03:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA2CE3078AB3;
        Wed, 20 Mar 2019 17:03:27 +0000 (UTC)
Received: from x1.home (ovpn-116-218.phx2.redhat.com [10.3.116.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 572D660BE2;
        Wed, 20 Mar 2019 17:03:26 +0000 (UTC)
Date:   Wed, 20 Mar 2019 11:03:25 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-nvme@lists.infradead.org, Fam Zheng <fam@euphon.net>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        kvm@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
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
Subject: Re: [PATCH 0/9] RFC: NVME VFIO mediated device
Message-ID: <20190320110325.465c1dff@x1.home>
In-Reply-To: <8994f43d26ebf6040b9d5d5e3866ee81abcf1a1c.camel@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
        <1553095686.65329.36.camel@acm.org>
        <8994f43d26ebf6040b9d5d5e3866ee81abcf1a1c.camel@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 20 Mar 2019 17:03:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 18:42:02 +0200
Maxim Levitsky <mlevitsk@redhat.com> wrote:

> On Wed, 2019-03-20 at 08:28 -0700, Bart Van Assche wrote:
> > On Tue, 2019-03-19 at 16:41 +0200, Maxim Levitsky wrote:  
> > > *  All guest memory is mapped into the physical nvme device 
> > >    but not 1:1 as vfio-pci would do this.
> > >    This allows very efficient DMA.
> > >    To support this, patch 2 adds ability for a mdev device to listen on 
> > >    guest's memory map events. 
> > >    Any such memory is immediately pinned and then DMA mapped.
> > >    (Support for fabric drivers where this is not possible exits too,
> > >     in which case the fabric driver will do its own DMA mapping)  
> > 
> > Does this mean that all guest memory is pinned all the time? If so, are you
> > sure that's acceptable?  
> I think so. The VFIO pci passthrough also pins all the guest memory.
> SPDK also does this (pins and dma maps) all the guest memory.
> 
> I agree that this is not an ideal solution but this is a fastest and simplest
> solution possible.

FWIW, the pinned memory request up through the vfio iommu driver count
against the user's locked memory limits, if that's the concern.  Thanks,

Alex
