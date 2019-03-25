Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6C9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EB52075D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfCYSwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:52:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbfCYSwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:52:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 649C2AB965;
        Mon, 25 Mar 2019 18:52:40 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E8115DC1B;
        Mon, 25 Mar 2019 18:52:33 +0000 (UTC)
Message-ID: <dbec1f2bee53ab786bb4f6204f9a930eac279970.camel@redhat.com>
Subject: Re: [PATCH 0/9] RFC: NVME VFIO mediated device [BENCHMARKS]
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-nvme@lists.infradead.org
Cc:     Fam Zheng <fam@euphon.net>, Keith Busch <keith.busch@intel.com>,
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
Date:   Mon, 25 Mar 2019 20:52:32 +0200
In-Reply-To: <d41484848b1832192c6978c7054bec5c326afa6d.camel@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
         <d41484848b1832192c6978c7054bec5c326afa6d.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 25 Mar 2019 18:52:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This is first round of benchmarks.

The system is Intel(R) Xeon(R) Gold 6128 CPU @ 3.40GHz

The system has 2 numa nodes, but only cpus and memory from node 0 were used to
avoid noise from numa.

The SSD is Intel® Optane™ SSD 900P Series, 280 GB version


https://ark.intel.com/content/www/us/en/ark/products/123628/intel-optane-ssd-900p-series-280gb-1-2-height-pcie-x4-20nm-3d-xpoint.html


** Latency benchmark with no interrupts at all **

spdk was complited with fio plugin in the host and in the guest.
spdk was first run in the host
then vm was started with one of spdk,pci passthrough, mdev and inside the
vm spdk was run with fio plugin.

spdk was taken from my branch on gitlab, and fio was complied from source for
3.4 branch as needed by the spdk fio plugin.

The following spdk command line was used:

$WORK/fio/fio \
	--name=job --runtime=40 --ramp_time=0 --time_based \
	 --filename="trtype=PCIe traddr=$DEVICE_FOR_FIO ns=1" --ioengine=spdk  \
	--direct=1 --rw=randread --bs=4K --cpus_allowed=0 \
	--iodepth=1 --thread

The average values for slat (submission latency), clat (completion latency) and
its sum (slat+clat) were noted.

The results:

spdk fio host: 
	573 Mib/s - slat 112.00ns, clat 6.400us, lat 6.52ms
	573 Mib/s - slat 111.50ns, clat 6.406us, lat 6.52ms


pci passthough host/
spdk fio guest
	571 Mib/s - slat 124.56ns, clat 6.422us  lat 6.55ms
	571 Mib/s - slat 122.86ns, clat 6.410us  lat 6.53ms
	570 Mib/s - slat 124.95ns, clat 6.425us  lat 6.55ms

spdk host/
spdk fio guest:
	535 Mib/s - slat 125.00ns, clat 6.895us  lat 7.02ms
	534 Mib/s - slat 125.36ns, clat 6.896us  lat 7.02ms
	534 Mib/s - slat 125.82ns, clat 6.892us  lat 7.02ms

mdev host/
spdk fio guest:
	534 Mib/s - slat 128.04ns, clat 6.902us  lat 7.03ms
	535 Mib/s - slat 126.97ns, clat 6.900us  lat 7.03ms
	535 Mib/s - slat 127.00ns, clat 6.898us  lat 7.03ms


As you see, native latency is 6.52ms, pci passthrough barely adds any latency,
while both mdev/spdk added about (7.03/2 - 6.52) - 0.51ms/0.50ms of latency.

In addtion to that I added few 'rdtsc' into my mdev driver to strategically
capture the cycle count it takes it to do 3 things:

1. translate a just received command (till it is copied to the hardware
submission queue)

2. receive a completion (divided by the number of completion received in one
round of polling)

3. deliver an interupt to the guest (call to eventfd_signal)

This is not the whole latency as there is also a latency between the point the
submission entry is written and till it is visible on the polling cpu, plus
latency till polling cpu gets to the code which reads the submission entry,
and of course latency of interrupt delivery, but the above measurements mostly
capture the latency I can control.

The results are:

commands translated : avg cycles: 459.844     avg time(usec): 0.135        
commands completed  : avg cycles: 354.61      avg time(usec): 0.104        
interrupts sent     : avg cycles: 590.227     avg time(usec): 0.174

avg time total: 0.413 usec

All measurmenets done in the host kernel. the time calculated using tsc_khz
kernel variable.

The biggest take from this is that both spdk and my driver are very fast and
overhead is just a  thousand of cpu cycles give it or take.

*** Throughput benchmarks ***

https://paste.fedoraproject.org/paste/ecijclLMG2B11MVCVIst-w

Here you can find the throughput benchmarks.

The biggest take is that when using no interrupts (spdk fio in guest or spdk fio
in host), the bottelneck is in the device, and througput is about 2290 Mib/s

And mdev vs spdk, with interrupts, my driver sligly wins by giving throughput of
about 2015 Mib/s while spdk is about 2005 Mib/s
mostly due to slightly different timings as the latency of both is about the
same.

Disabling meltdown mitigation didn't had much effect on the performance.

Best regards,
	Maxim Levitsky

