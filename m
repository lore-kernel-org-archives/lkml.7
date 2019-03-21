Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54058C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4A0218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfCURIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:08:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfCURIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:08:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED1E583F3A;
        Thu, 21 Mar 2019 17:08:05 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8254F5D9C5;
        Thu, 21 Mar 2019 17:07:40 +0000 (UTC)
Message-ID: <a4dc67e66cd126892468011311ff516853754cdb.camel@redhat.com>
Subject: Re: your mail
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liang Cunming <cunming.liang@intel.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        Fam Zheng <fam@euphon.net>, Amnon Ilan <ailan@redhat.com>,
        John Ferlan <jferlan@redhat.com>
Date:   Thu, 21 Mar 2019 19:07:38 +0200
In-Reply-To: <20190321161352.GA21682@stefanha-x1.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
         <20190321161352.GA21682@stefanha-x1.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 21 Mar 2019 17:08:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-21 at 16:13 +0000, Stefan Hajnoczi wrote:
> On Tue, Mar 19, 2019 at 04:41:07PM +0200, Maxim Levitsky wrote:
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
> > 
> > The idea behind this driver is based on paper you can find at
> > https://www.usenix.org/conference/atc18/presentation/peng,
> > 
> > Although note that I stared the development prior to reading this paper, 
> > independently.
> > 
> > In addition to that implementation is not based on code used in the paper
> > as 
> > I wasn't being able at that time to make the source available to me.
> > 
> > ***Key points about the implementation:***
> > 
> > * Polling kernel thread is used. The polling is stopped after a 
> > predefined timeout (1/2 sec by default).
> > Support for all interrupt driven mode is planned, and it shows promising
> > results.
> > 
> > * Guest sees a standard NVME device - this allows to run guest with 
> > unmodified drivers, for example windows guests.
> > 
> > * The NVMe device is shared between host and guest.
> > That means that even a single namespace can be split between host 
> > and guest based on different partitions.
> > 
> > * Simple configuration
> > 
> > *** Performance ***
> > 
> > Performance was tested on Intel DC P3700, With Xeon E5-2620 v2 
> > and both latency and throughput is very similar to SPDK.
> > 
> > Soon I will test this on a better server and nvme device and provide
> > more formal performance numbers.
> > 
> > Latency numbers:
> > ~80ms - spdk with fio plugin on the host.
> > ~84ms - nvme driver on the host
> > ~87ms - mdev-nvme + nvme driver in the guest
> 
> You mentioned the spdk numbers are with vhost-user-nvme.  Have you
> measured SPDK's vhost-user-blk?

I had lot of measuments of vhost-user-blk vs vhost-user-nvme.
vhost-user-nvme was always a bit faster but only a bit.
Thus I don't think it makes sense to benchamrk against vhost-user-blk.

Best regards,
	Maxim Levitsky



