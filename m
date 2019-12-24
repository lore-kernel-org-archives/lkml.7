Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6CAC2D0C0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09532075E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAp1Gnn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfLXB7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 20:59:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39162 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727008AbfLXB7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 20:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577152790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zwkq1OMYRFcOoNV3ORj1tDVlAaogqmYkae4w0Mmho3U=;
        b=HAp1Gnn32jZ/9B/eqKEPSCvaQEq9e76Tl8oNvZbBR8CgR3WkJPzPYZb6z61QJZJH9lo0cx
        cjlY/FB8AYKBiB1ISXILw4Lo7JcdpR6BCb+tXdcQQ+SEC2ys4Qjd1PHB4GpMl6Tn98q3jL
        7QfmsF1MO76ah+Y9713vY0gAOf9MrWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-4qPfLq_-N8CABWrZGZ8gLg-1; Mon, 23 Dec 2019 20:59:49 -0500
X-MC-Unique: 4qPfLq_-N8CABWrZGZ8gLg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C875800EBF;
        Tue, 24 Dec 2019 01:59:47 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6631968888;
        Tue, 24 Dec 2019 01:59:32 +0000 (UTC)
Date:   Tue, 24 Dec 2019 09:59:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, tglx@linutronix.de,
        "chenxiang (M)" <chenxiang66@hisilicon.com>, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, hare@suse.com, hch@lst.de,
        axboe@kernel.dk, bvanassche@acm.org, peterz@infradead.org,
        mingo@redhat.com, Zhang Yi <yi.zhang@redhat.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
  for managed interrupt
Message-ID: <20191224015926.GC13083@ming.t460p>
References: <a5f6a542-2dbc-62de-52e2-bd5413b5db51@huawei.com>
 <68058fd28c939b8e065524715494de95@www.loen.fr>
 <ac5b5a25-df2e-18e9-6b0f-60af8c7cec3b@huawei.com>
 <687cbcc4-89d9-63ea-a246-ce2abaae501a@huawei.com>
 <0fd543f8ffd90f90deb691aea1c275b4@www.loen.fr>
 <a5154365-59c5-429b-559e-94ad6dffcdb0@huawei.com>
 <20191220233138.GB12403@ming.t460p>
 <fffcd23dd8286615b6e2c99620836cb1@www.loen.fr>
 <d5774e2f-bb60-c27c-bf00-267b88400a12@huawei.com>
 <e815b5451ea86e99d42045f7067f455a@www.loen.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e815b5451ea86e99d42045f7067f455a@www.loen.fr>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 10:47:07AM +0000, Marc Zyngier wrote:
> On 2019-12-23 10:26, John Garry wrote:
> > > > > > I've also managed to trigger some of them now that I have
> > > > > access to
> > > > > > a decent box with nvme storage.
> > > > > 
> > > > > I only have 2x NVMe SSDs when this occurs - I should not be
> > > > > hitting this...
> > > > > 
> > > > > Out of curiosity, have you tried
> > > > > > with the SMMU disabled? I'm wondering whether we hit some
> > > > > livelock
> > > > > > condition on unmapping buffers...
> > > > > 
> > > > > No, but I can give it a try. Doing that should lower the CPU
> > > > > usage, though,
> > > > > so maybe masks the issue - probably not.
> > > > 
> > > > Lots of CPU lockup can is performance issue if there isn't
> > > > obvious bug.
> > > > 
> > > > I am wondering if you may explain it a bit why enabling SMMU may
> > > > save
> > > > CPU a it?
> > > The other way around. mapping/unmapping IOVAs doesn't comes for
> > > free.
> > > I'm trying to find out whether the NVMe map/unmap patterns trigger
> > > something unexpected in the SMMU driver, but that's a very long
> > > shot.
> > 
> > So I tested v5.5-rc3 with and without the SMMU enabled, and without
> > the SMMU enabled I don't get the lockup.
> 
> OK, so my hunch wasn't completely off... At least we have something
> to look into.
> 
> [...]
> 
> > Obviously this is not conclusive, especially with such limited
> > testing - 5 minute runs each. The CPU load goes up when disabling the
> > SMMU, but that could be attributed to extra throughput (1183K ->
> > 1539K) loading.
> > 
> > I do notice that since we complete the NVMe request in irq context,
> > we also do the DMA unmap, i.e. talk to the SMMU, in the same context,
> > which is less than ideal.
> 
> It depends on how much overhead invalidating the TLB adds to the
> equation, but we should be able to do some tracing and find out.
> 
> > I need to finish for the Christmas break today, so can't check this
> > much further ATM.
> 
> No worries. May I suggest creating a new thread in the new year, maybe
> involving Robin and Will as well?

Zhang Yi has observed the CPU lockup issue once when running heavy IO on
single nvme drive, and please CC him if you have new patch to try.

Then looks the DMA unmap cost is too big on aarch64 if SMMU is involved.


Thanks,
Ming

