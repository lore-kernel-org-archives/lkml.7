Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CC5C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 23:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2DF2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 23:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3O+SExt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfLTXcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 18:32:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39244 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbfLTXcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 18:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576884721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0I7tRlX0mVn5vk+VIzw+jv3j0MYY94luXenim5wV+0c=;
        b=N3O+SExt9BtpKtb/xwGIbcpz8/QldPWCUI52ykiK1wRGh/fNCcj765Qn2tVbjUpaEk08L6
        dO00d2jqUn7GdA4any5UQt3mUYLr2GDsgar2zyXcSNVghNAefuVSRvpqYpNLqISyFlLvAe
        aR78w5yiddSxRaVbK31h6fZ4SJVXnFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-Ht9J4ufjPFWj1zKeZR5AqA-1; Fri, 20 Dec 2019 18:31:55 -0500
X-MC-Unique: Ht9J4ufjPFWj1zKeZR5AqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12FDB1856A60;
        Fri, 20 Dec 2019 23:31:53 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C484A5D9CA;
        Fri, 20 Dec 2019 23:31:43 +0000 (UTC)
Date:   Sat, 21 Dec 2019 07:31:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de,
        "chenxiang (M)" <chenxiang66@hisilicon.com>, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, hare@suse.com, hch@lst.de,
        axboe@kernel.dk, bvanassche@acm.org, peterz@infradead.org,
        mingo@redhat.com
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
Message-ID: <20191220233138.GB12403@ming.t460p>
References: <b7f3bcea-84ec-f9f6-a3aa-007ae712415f@huawei.com>
 <20191214135641.5a817512@why>
 <7db89b97-1b9e-8dd1-684a-3eef1b1af244@huawei.com>
 <50d9ba606e1e3ee1665a0328ffac67ac@www.loen.fr>
 <a5f6a542-2dbc-62de-52e2-bd5413b5db51@huawei.com>
 <68058fd28c939b8e065524715494de95@www.loen.fr>
 <ac5b5a25-df2e-18e9-6b0f-60af8c7cec3b@huawei.com>
 <687cbcc4-89d9-63ea-a246-ce2abaae501a@huawei.com>
 <0fd543f8ffd90f90deb691aea1c275b4@www.loen.fr>
 <a5154365-59c5-429b-559e-94ad6dffcdb0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5154365-59c5-429b-559e-94ad6dffcdb0@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 03:38:24PM +0000, John Garry wrote:
> > > We've got some more results and it looks promising.
> > > 
> > > So with your patch we get a performance boost of 3180.1K -> 3294.9K
> > > IOPS in the D06 SAS env. Then when we change the driver to use
> > > threaded interrupt handler (mainline currently uses tasklet), we get a
> > > boost again up to 3415K IOPS.
> > > 
> > > Now this is essentially the same figure we had with using threaded
> > > handler + the gen irq change in spreading the handler CPU affinity. We
> > > did also test your patch + gen irq change and got a performance drop,
> > > to 3347K IOPS.
> > > 
> > > So tentatively I'd say your patch may be all we need.
> > 
> > OK.
> > 
> > > FYI, here is how the effective affinity is looking for both SAS
> > > controllers with your patch:
> > > 
> > > 74:02.0
> > > irq 81, cpu list 24-29, effective list 24 cq
> > > irq 82, cpu list 30-35, effective list 30 cq
> > 
> > Cool.
> > 
> > [...]
> > 
> > > As for your patch itself, I'm still concerned of possible regressions
> > > if we don't apply this effective interrupt affinity spread policy to
> > > only managed interrupts.
> > 
> > I'll try and revise that as I post the patch, probably at some point
> > between now and Christmas. I still think we should find a way to
> > address this for the D05 SAS driver though, maybe by managing the
> > affinity yourself in the driver. But this requires experimentation.
> 
> I've already done something experimental for the driver to manage the
> affinity, and performance is generally much better:
> 
> https://github.com/hisilicon/kernel-dev/commit/e15bd404ed1086fed44da34ed3bd37a8433688a7
> 
> But I still think it's wise to only consider managed interrupts for now.
> 
> > 
> > > JFYI, about NVMe CPU lockup issue, there are 2 works on going here:
> > > 
> > > https://lore.kernel.org/linux-nvme/20191209175622.1964-1-kbusch@kernel.org/T/#t
> > > 
> > > 
> > > https://lore.kernel.org/linux-block/20191218071942.22336-1-ming.lei@redhat.com/T/#t
> > > 
> > 
> > I've also managed to trigger some of them now that I have access to
> > a decent box with nvme storage.
> 
> I only have 2x NVMe SSDs when this occurs - I should not be hitting this...
> 
> Out of curiosity, have you tried
> > with the SMMU disabled? I'm wondering whether we hit some livelock
> > condition on unmapping buffers...
> 
> No, but I can give it a try. Doing that should lower the CPU usage, though,
> so maybe masks the issue - probably not.

Lots of CPU lockup can is performance issue if there isn't obvious bug.

I am wondering if you may explain it a bit why enabling SMMU may save
CPU a it?

Thanks,
Ming

