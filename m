Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB4BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3882073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPfhqKtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfLJKGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:06:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43814 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726574AbfLJKGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575972399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xofJA06q0aAf7mmBMbesDQEGVShkpSJebRAROLMXhWk=;
        b=LPfhqKtDypyJzh4yB2l/pYee2pTwYpMgONXTYNRCgBNuSKeip0jMZHN04VJ+Q4at4Rm+e1
        n4SrEJ6Zos6ezES9AILMLY/UKA9xiSE75FPThU9OQqNYD76laJ31ZMHUp+Tm6+HIvTtdqh
        OEEKuTXC7sdVAQStGu2pfpORNnVMfm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-NrtGsatDPiyiaoUvvwbjyA-1; Tue, 10 Dec 2019 05:06:36 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E75C800C76;
        Tue, 10 Dec 2019 10:06:34 +0000 (UTC)
Received: from ming.t460p (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98DAE5C1B0;
        Tue, 10 Dec 2019 10:06:25 +0000 (UTC)
Date:   Tue, 10 Dec 2019 18:06:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     maz@kernel.org, tglx@linutronix.de, chenxiang66@hisilicon.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org, hare@suse.com,
        hch@lst.de, axboe@kernel.dk, bvanassche@acm.org,
        peterz@infradead.org, mingo@redhat.com
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
Message-ID: <20191210100621.GB5699@ming.t460p>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <20191207080335.GA6077@ming.t460p>
 <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
 <20191210014335.GA25022@ming.t460p>
 <28424a58-1159-c3f9-1efb-f1366993afcf@huawei.com>
MIME-Version: 1.0
In-Reply-To: <28424a58-1159-c3f9-1efb-f1366993afcf@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: NrtGsatDPiyiaoUvvwbjyA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 09:45:45AM +0000, John Garry wrote:
> On 10/12/2019 01:43, Ming Lei wrote:
> > On Mon, Dec 09, 2019 at 02:30:59PM +0000, John Garry wrote:
> > > On 07/12/2019 08:03, Ming Lei wrote:
> > > > On Fri, Dec 06, 2019 at 10:35:04PM +0800, John Garry wrote:
> > > > > Currently the cpu allowed mask for the threaded part of a threade=
d irq
> > > > > handler will be set to the effective affinity of the hard irq.
> > > > >=20
> > > > > Typically the effective affinity of the hard irq will be for a si=
ngle cpu. As such,
> > > > > the threaded handler would always run on the same cpu as the hard=
 irq.
> > > > >=20
> > > > > We have seen scenarios in high data-rate throughput testing that =
the cpu
> > > > > handling the interrupt can be totally saturated handling both the=
 hard
> > > > > interrupt and threaded handler parts, limiting throughput.
> > > >=20
>=20
> Hi Ming,
>=20
> > > > Frankly speaking, I never observed that single CPU is saturated by =
one storage
> > > > completion queue's interrupt load. Because CPU is still much quicke=
r than
> > > > current storage device.
> > > >=20
> > > > If there are more drives, one CPU won't handle more than one queue(=
drive)'s
> > > > interrupt if (nr_drive * nr_hw_queues) < nr_cpu_cores.
> > >=20
> > > Are things this simple? I mean, can you guarantee that fio processes =
are
> > > evenly distributed as such?
> >=20
> > That is why I ask you for the details of your test.
> >=20
> > If you mean hisilicon SAS,
>=20
> Yes, it is.
>=20
>  the interrupt load should have been distributed
> > well given the device has multiple reply queues for distributing interr=
upt
> > load.
> >=20
> > >=20
> > > >=20
> > > > So could you describe your case in a bit detail? Then we can confir=
m
> > > > if this change is really needed.
> > >=20
> > > The issue is that the CPU is saturated in servicing the hard and thre=
aded
> > > part of the interrupt together - here's the sort of thing which we sa=
w
> > > previously:
> > > Before:
> > > CPU=09%usr=09%sys=09%irq=09%soft=09%idle
> > > all=092.9=0913.1=091.2=094.6=0978.2=09=09=09=09
> > > 0=090.0=0929.3=0910.1=0958.6=092.0
> > > 1=0918.2=0939.4=090.0=091.0=0941.4
> > > 2=090.0=092.0=090.0=090.0=0998.0
> > >=20
> > > CPU0 has no effectively no idle.
> >=20
> > The result just shows the saturation, we need to root cause it instead
> > of workaround it via random changes.
> >=20
> > >=20
> > > Then, by allowing the threaded part to roam:
> > > After:
> > > CPU=09%usr=09%sys=09%irq=09%soft=09%idle
> > > all=093.5=0918.4=092.7=096.8=0968.6
> > > 0=090.0=0920.6=0929.9=0929.9=0919.6
> > > 1=090.0=0939.8=090.0=0950.0=0910.2
> > >=20
> > > Note: I think that I may be able to reduce the irq hard part load in =
the
> > > endpoint driver, but not that much such that we see still this issue.
> > >=20
> > > >=20
> > > > >=20
> > > > > For when the interrupt is managed, allow the threaded part to run=
 on all
> > > > > cpus in the irq affinity mask.
> > > >=20
> > > > I remembered that performance drop is observed by this approach in =
some
> > > > test.
> > >=20
> > >  From checking the thread about the NVMe interrupt swamp, just switch=
ing to
> > > threaded handler alone degrades performance. I didn't see any specifi=
c
> > > results for this change from Long Li - https://lkml.org/lkml/2019/8/2=
1/128
> >=20
> > I am pretty clear the reason for Azure, which is caused by aggressive i=
nterrupt
> > coalescing, and this behavior shouldn't be very common, and it can be
> > addressed by the following patch:
> >=20
> > http://lists.infradead.org/pipermail/linux-nvme/2019-November/028008.ht=
ml
> >=20
> > Then please share your lockup story, such as, which HBA/drivers, test s=
teps,
> > if you complete IOs from multiple disks(LUNs) on single CPU, if you hav=
e
> > multiple queues, how many active LUNs involved in the test, ...
>=20
> There is no lockup, just a potential performance boost in this change.
>=20
> My colleague Xiang Chen can provide specifics of the test, as he is the o=
ne
> running it.
>=20
> But one key bit of info - which I did not think most relevant before - th=
at
> is we have 2x SAS controllers running the throughput test on the same hos=
t.
>=20
> As such, the completion queue interrupts would be spread identically over
> the CPUs for each controller. I notice that ARM GICv3 ITS interrupt
> controller (which we use) does not use the generic irq matrix allocator,
> which I think would really help with this.

Yeah, looks only x86 uses irq matrix which seems abstracted from x86
arch code, and multiple NVMe may perform worse on non-x86 server.

Also when running IO against multiple LUNs in single HBA, there is
chance to saturate the completion CPU given multiple disks may be
quicker than the single CPU. IRQ matrix can't help this case.


Thanks,=20
Ming

