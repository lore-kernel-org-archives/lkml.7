Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F505C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458C620830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfCZJu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:50:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfCZJu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:50:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C10CF308620D;
        Tue, 26 Mar 2019 09:50:55 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B16FA1712F;
        Tue, 26 Mar 2019 09:50:48 +0000 (UTC)
Message-ID: <ad88c611e6ce0df3d7e0137d7eaa0eff4c862a89.camel@redhat.com>
Subject: Re: [PATCH 0/9] RFC: NVME VFIO mediated device [BENCHMARKS]
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     linux-nvme@lists.infradead.org, Fam Zheng <fam@euphon.net>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, kvm@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang Cunming <cunming.liang@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        John Ferlan <jferlan@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Amnon Ilan <ailan@redhat.com>, Christoph Hellwig <hch@lst.de>
Date:   Tue, 26 Mar 2019 11:50:47 +0200
In-Reply-To: <20190326093858.GI21018@stefanha-x1.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
         <d41484848b1832192c6978c7054bec5c326afa6d.camel@redhat.com>
         <dbec1f2bee53ab786bb4f6204f9a930eac279970.camel@redhat.com>
         <20190326093858.GI21018@stefanha-x1.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 26 Mar 2019 09:50:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-26 at 09:38 +0000, Stefan Hajnoczi wrote:
> On Mon, Mar 25, 2019 at 08:52:32PM +0200, Maxim Levitsky wrote:
> > Hi
> > 
> > This is first round of benchmarks.
> > 
> > The system is Intel(R) Xeon(R) Gold 6128 CPU @ 3.40GHz
> > 
> > The system has 2 numa nodes, but only cpus and memory from node 0 were used to
> > avoid noise from numa.
> > 
> > The SSD is Intel® Optane™ SSD 900P Series, 280 GB version
> > 
> > 
> > https://ark.intel.com/content/www/us/en/ark/products/123628/intel-optane-ssd-900p-series-280gb-1-2-height-pcie-x4-20nm-3d-xpoint.html
> > 
> > 
> > ** Latency benchmark with no interrupts at all **
> > 
> > spdk was complited with fio plugin in the host and in the guest.
> > spdk was first run in the host
> > then vm was started with one of spdk,pci passthrough, mdev and inside the
> > vm spdk was run with fio plugin.
> > 
> > spdk was taken from my branch on gitlab, and fio was complied from source for
> > 3.4 branch as needed by the spdk fio plugin.
> > 
> > The following spdk command line was used:
> > 
> > $WORK/fio/fio \
> > 	--name=job --runtime=40 --ramp_time=0 --time_based \
> > 	 --filename="trtype=PCIe traddr=$DEVICE_FOR_FIO ns=1" --ioengine=spdk  \
> > 	--direct=1 --rw=randread --bs=4K --cpus_allowed=0 \
> > 	--iodepth=1 --thread
> > 
> > The average values for slat (submission latency), clat (completion latency) and
> > its sum (slat+clat) were noted.
> > 
> > The results:
> > 
> > spdk fio host: 
> > 	573 Mib/s - slat 112.00ns, clat 6.400us, lat 6.52ms
> > 	573 Mib/s - slat 111.50ns, clat 6.406us, lat 6.52ms
> > 
> > 
> > pci passthough host/
> > spdk fio guest
> > 	571 Mib/s - slat 124.56ns, clat 6.422us  lat 6.55ms
> > 	571 Mib/s - slat 122.86ns, clat 6.410us  lat 6.53ms
> > 	570 Mib/s - slat 124.95ns, clat 6.425us  lat 6.55ms
> > 
> > spdk host/
> > spdk fio guest:
> > 	535 Mib/s - slat 125.00ns, clat 6.895us  lat 7.02ms
> > 	534 Mib/s - slat 125.36ns, clat 6.896us  lat 7.02ms
> > 	534 Mib/s - slat 125.82ns, clat 6.892us  lat 7.02ms
> > 
> > mdev host/
> > spdk fio guest:
> > 	534 Mib/s - slat 128.04ns, clat 6.902us  lat 7.03ms
> > 	535 Mib/s - slat 126.97ns, clat 6.900us  lat 7.03ms
> > 	535 Mib/s - slat 127.00ns, clat 6.898us  lat 7.03ms
> > 
> > 
> > As you see, native latency is 6.52ms, pci passthrough barely adds any latency,
> > while both mdev/spdk added about (7.03/2 - 6.52) - 0.51ms/0.50ms of latency.
> 
> Milliseconds is surprising.  The SSD's spec says 10us read/write
> latency.  Did you mean microseconds?
Yea, this is typo - all of this is microseconds.


> 
> > 
> > In addtion to that I added few 'rdtsc' into my mdev driver to strategically
> > capture the cycle count it takes it to do 3 things:
> > 
> > 1. translate a just received command (till it is copied to the hardware
> > submission queue)
> > 
> > 2. receive a completion (divided by the number of completion received in one
> > round of polling)
> > 
> > 3. deliver an interupt to the guest (call to eventfd_signal)
> > 
> > This is not the whole latency as there is also a latency between the point the
> > submission entry is written and till it is visible on the polling cpu, plus
> > latency till polling cpu gets to the code which reads the submission entry,
> > and of course latency of interrupt delivery, but the above measurements mostly
> > capture the latency I can control.
> > 
> > The results are:
> > 
> > commands translated : avg cycles: 459.844     avg time(usec): 0.135        
> > commands completed  : avg cycles: 354.61      avg time(usec): 0.104        
> > interrupts sent     : avg cycles: 590.227     avg time(usec): 0.174
> > 
> > avg time total: 0.413 usec
> > 
> > All measurmenets done in the host kernel. the time calculated using tsc_khz
> > kernel variable.
> > 
> > The biggest take from this is that both spdk and my driver are very fast and
> > overhead is just a  thousand of cpu cycles give it or take.
> 
> Nice!
> 
> Stefan


Best regards,
	Maxim Levitsky


