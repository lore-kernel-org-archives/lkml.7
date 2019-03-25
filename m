Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12642C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77D420870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfCYJua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:50:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730216AbfCYJua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:50:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F0CD30832CD;
        Mon, 25 Mar 2019 09:50:30 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E14D17156;
        Mon, 25 Mar 2019 09:50:16 +0000 (UTC)
Date:   Mon, 25 Mar 2019 17:50:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Xu <peterx@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, minlei@redhat.com
Subject: Re: Virtio-scsi multiqueue irq affinity
Message-ID: <20190325095011.GA23225@ming.t460p>
References: <20190318062150.GC6654@xz-x1>
 <alpine.DEB.2.21.1903231805310.1798@nanos.tec.linutronix.de>
 <20190325050213.GH9149@xz-x1>
 <20190325070616.GA9642@ming.t460p>
 <alpine.DEB.2.21.1903250948490.1798@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903250948490.1798@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 25 Mar 2019 09:50:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 09:53:28AM +0100, Thomas Gleixner wrote:
> Ming,
> 
> On Mon, 25 Mar 2019, Ming Lei wrote:
> > On Mon, Mar 25, 2019 at 01:02:13PM +0800, Peter Xu wrote:
> > > One thing I can think of is the real-time scenario where "isolcpus="
> > > is provided, then logically we should not allow any isolated CPUs to
> > > be bound to any of the multi-queue IRQs.  Though Ming Lei and I had a
> > 
> > So far, this behaviour is made by user-space.
> > 
> > >From my understanding, IRQ subsystem doesn't handle "isolcpus=", even
> > though the Kconfig help doesn't mention irq affinity affect:
> > 
> >           Make sure that CPUs running critical tasks are not disturbed by
> >           any source of "noise" such as unbound workqueues, timers, kthreads...
> >           Unbound jobs get offloaded to housekeeping CPUs. This is driven by
> >           the "isolcpus=" boot parameter.
> 
> isolcpus has no effect on the interupts. That's what 'irqaffinity=' is for.

Indeed.

irq_default_affinity is built from 'irqaffinity=', however, we don't
consider irq_default_affinity for managed IRQ affinity.

Looks Peter wants to exclude some CPUs from the spread on managed IRQ.

Thanks,
Ming
