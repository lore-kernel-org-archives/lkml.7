Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D423C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 01:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A1E20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 01:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAnRX4GK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLJBoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 20:44:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22862 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726502AbfLJBoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 20:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575942238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rx07KaVJ8I4rPd4Qc9E0QToLdVk7p8IvSuIUJPkT0Zg=;
        b=YAnRX4GK9EOKOATih+vj54b+dyIAuB/on1vKlrT3dcUcvqZblkjNY4OXkkByPqTl0Du39Y
        w9RBcWISh7+/4GFviWCdALLQqQ1NJ1CxhyOun6SP6PMl90PElOUToNgNwYUJPknFUACjjT
        IVivg46c+siSMQLUPm3iRKe2tsEhD3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-EcKFFzLtOgSiq6ajvwjvDg-1; Mon, 09 Dec 2019 20:43:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F12788AB939;
        Tue, 10 Dec 2019 01:43:52 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04BB86E51C;
        Tue, 10 Dec 2019 01:43:39 +0000 (UTC)
Date:   Tue, 10 Dec 2019 09:43:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     tglx@linutronix.de, chenxiang66@hisilicon.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        maz@kernel.org, hare@suse.com, hch@lst.de, axboe@kernel.dk,
        bvanassche@acm.org, peterz@infradead.org, mingo@redhat.com
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
Message-ID: <20191210014335.GA25022@ming.t460p>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <20191207080335.GA6077@ming.t460p>
 <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
MIME-Version: 1.0
In-Reply-To: <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: EcKFFzLtOgSiq6ajvwjvDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 02:30:59PM +0000, John Garry wrote:
> On 07/12/2019 08:03, Ming Lei wrote:
> > On Fri, Dec 06, 2019 at 10:35:04PM +0800, John Garry wrote:
> > > Currently the cpu allowed mask for the threaded part of a threaded ir=
q
> > > handler will be set to the effective affinity of the hard irq.
> > >=20
> > > Typically the effective affinity of the hard irq will be for a single=
 cpu. As such,
> > > the threaded handler would always run on the same cpu as the hard irq=
.
> > >=20
> > > We have seen scenarios in high data-rate throughput testing that the =
cpu
> > > handling the interrupt can be totally saturated handling both the har=
d
> > > interrupt and threaded handler parts, limiting throughput.
> >=20
>=20
> Hi Ming,
>=20
> > Frankly speaking, I never observed that single CPU is saturated by one =
storage
> > completion queue's interrupt load. Because CPU is still much quicker th=
an
> > current storage device.
> >=20
> > If there are more drives, one CPU won't handle more than one queue(driv=
e)'s
> > interrupt if (nr_drive * nr_hw_queues) < nr_cpu_cores.
>=20
> Are things this simple? I mean, can you guarantee that fio processes are
> evenly distributed as such?

That is why I ask you for the details of your test.

If you mean hisilicon SAS, the interrupt load should have been distributed
well given the device has multiple reply queues for distributing interrupt
load.

>=20
> >=20
> > So could you describe your case in a bit detail? Then we can confirm
> > if this change is really needed.
>=20
> The issue is that the CPU is saturated in servicing the hard and threaded
> part of the interrupt together - here's the sort of thing which we saw
> previously:
> Before:
> CPU=09%usr=09%sys=09%irq=09%soft=09%idle
> all=092.9=0913.1=091.2=094.6=0978.2=09=09=09=09
> 0=090.0=0929.3=0910.1=0958.6=092.0
> 1=0918.2=0939.4=090.0=091.0=0941.4
> 2=090.0=092.0=090.0=090.0=0998.0
>=20
> CPU0 has no effectively no idle.

The result just shows the saturation, we need to root cause it instead
of workaround it via random changes.

>=20
> Then, by allowing the threaded part to roam:
> After:
> CPU=09%usr=09%sys=09%irq=09%soft=09%idle
> all=093.5=0918.4=092.7=096.8=0968.6
> 0=090.0=0920.6=0929.9=0929.9=0919.6
> 1=090.0=0939.8=090.0=0950.0=0910.2
>=20
> Note: I think that I may be able to reduce the irq hard part load in the
> endpoint driver, but not that much such that we see still this issue.
>=20
> >=20
> > >=20
> > > For when the interrupt is managed, allow the threaded part to run on =
all
> > > cpus in the irq affinity mask.
> >=20
> > I remembered that performance drop is observed by this approach in some
> > test.
>=20
> From checking the thread about the NVMe interrupt swamp, just switching t=
o
> threaded handler alone degrades performance. I didn't see any specific
> results for this change from Long Li - https://lkml.org/lkml/2019/8/21/12=
8

I am pretty clear the reason for Azure, which is caused by aggressive inter=
rupt
coalescing, and this behavior shouldn't be very common, and it can be
addressed by the following patch:

http://lists.infradead.org/pipermail/linux-nvme/2019-November/028008.html

Then please share your lockup story, such as, which HBA/drivers, test steps=
,
if you complete IOs from multiple disks(LUNs) on single CPU, if you have
multiple queues, how many active LUNs involved in the test, ...


Thanks,
Ming

