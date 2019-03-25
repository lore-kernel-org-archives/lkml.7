Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A19BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143062084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfCYN11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:27:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45853 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCYN11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:27:27 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8PdM-0005T7-CQ; Mon, 25 Mar 2019 14:27:24 +0100
Date:   Mon, 25 Mar 2019 14:27:23 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Xu <peterx@redhat.com>
cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, minlei@redhat.com
Subject: Re: Virtio-scsi multiqueue irq affinity
In-Reply-To: <20190325094340.GJ9149@xz-x1>
Message-ID: <alpine.DEB.2.21.1903251425470.1656@nanos.tec.linutronix.de>
References: <20190318062150.GC6654@xz-x1> <alpine.DEB.2.21.1903231805310.1798@nanos.tec.linutronix.de> <20190325050213.GH9149@xz-x1> <20190325070616.GA9642@ming.t460p> <alpine.DEB.2.21.1903250948490.1798@nanos.tec.linutronix.de>
 <20190325094340.GJ9149@xz-x1>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On Mon, 25 Mar 2019, Peter Xu wrote:
> Now I understand it can be guaranteed so it should not break
> determinism of the real-time applications.  But again, I'm curious
> whether we can specify how to spread the hardware queues of a block
> controller (as I asked in my previous post) instead of the default one
> (which is to spread the queues upon all the cores)?  I'll try to give
> a detailed example on this one this time: Let's assume we've had a
> host with 2 nodes and 8 cores (Node 0 with CPUs 0-3, Node 1 with CPUs
> 4-7), and a SCSI controller with 4 queues.  We want to take the 2nd
> node to run the real-time applications so we do isolcpus=4-7.  By
> default, IIUC the hardware queues will be allocated like this:
> 
>   - queue 1: CPU 0,1
>   - queue 2: CPU 2,3
>   - queue 3: CPU 4,5
>   - queue 4: CPU 6,7
> 
> And the IRQs of the queues will be bound to the same cpuset that the
> queue is bound to.
> 
> So my previous question is: since we know that CPU 4-7 won't generate
> any IO after all (and they shouldn't), could it be possible that we
> configure the system somehow to reflect a mapping like below:
> 
>   - queue 1: CPU 0
>   - qeueu 2: CPU 1
>   - queue 3: CPU 2
>   - queue 4: CPU 3
> 
> Then we disallow the CPUs 4-7 to generate IO and return failure if
> they tries to.
> 
> Again, I'm pretty uncertain on whether this case can be anything close
> to useful...  It just came out of my pure curiosity.  I think it at
> least has some benefits like: we will guarantee that the realtime CPUs
> won't send block IO requests (which could be good because it could
> simply break real-time determinism), and we'll save two queues from
> being totally idle (so if we run non-real-time block applications on
> cores 0-3 we still gain 4 hardware queues's throughput rather than 2).

If that _IS_ useful, then the affinity spreading logic can be changed to
accomodate that. It's not really hard to do so, but we'd need a proper
usecase for justification.

Thanks,

	tglx
