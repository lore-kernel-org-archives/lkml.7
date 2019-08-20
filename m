Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD688C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8DF22CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cX79k9qI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfHTJw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:52:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35056 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbfHTJw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m/VeeB1txYl9LrpUKmYi6hLIqRVHICwSEO8ccK7zPqQ=; b=cX79k9qIGHk70iAtA7L+kNknE
        IcD6MPHy79ORNPM6Q+lm6OtmMmNlK7OEpIeSxsQ3qhK0xvi8qrs5++FxxuSVOe38r2pzDeW6eeWAs
        y+VAGxO5XfKlxP3Y6NSjU0wWqwoX529OrDYScvq8oQF3DSDaPSHXJLIJz70PNMMz1a0k9OoG26mT6
        2kvU+U2hYZPuxuyu5Yo8SeB5+VUG4JSGYGl3yHWlkAi2oGFgoGkxTVW7aPBMJT9XULb5Iej+0oJjl
        Z1T5D9xGTtpYhZdE8YBN5Fsx+PVHQ6sX/MSf1N+739V6aG+rSmhe2KlJRIByfAmzg8XT7EIsR3l8a
        ZhZ4n2T5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i00ok-00068l-08; Tue, 20 Aug 2019 09:52:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48E32307603;
        Tue, 20 Aug 2019 11:52:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6FEBB20CE7743; Tue, 20 Aug 2019 11:52:40 +0200 (CEST)
Date:   Tue, 20 Aug 2019 11:52:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     longli@linuxonhyperv.com
Cc:     Ingo Molnar <mingo@redhat.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>
Subject: Re: [PATCH 3/3] nvme: complete request in work queue on CPU with
 flooded interrupts
Message-ID: <20190820095240.GH2332@hirez.programming.kicks-ass.net>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <1566281669-48212-4-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566281669-48212-4-git-send-email-longli@linuxonhyperv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 11:14:29PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> When a NVMe hardware queue is mapped to several CPU queues, it is possible
> that the CPU this hardware queue is bound to is flooded by returning I/O for
> other CPUs.
> 
> For example, consider the following scenario:
> 1. CPU 0, 1, 2 and 3 share the same hardware queue
> 2. the hardware queue interrupts CPU 0 for I/O response
> 3. processes from CPU 1, 2 and 3 keep sending I/Os
> 
> CPU 0 may be flooded with interrupts from NVMe device that are I/O responses
> for CPU 1, 2 and 3. Under heavy I/O load, it is possible that CPU 0 spends
> all the time serving NVMe and other system interrupts, but doesn't have a
> chance to run in process context.

Ideally -- and there is some code to affect this, the load-balancer will
move tasks away from this CPU.

> To fix this, CPU 0 can schedule a work to complete the I/O request when it
> detects the scheduler is not making progress. This serves multiple purposes:

Suppose the task waiting for the IO completion is a RT task, and you've
just queued it to a regular work. This is an instant priority inversion.

> 1. This CPU has to be scheduled to complete the request. The other CPUs can't
> issue more I/Os until some previous I/Os are completed. This helps this CPU
> get out of NVMe interrupts.
> 
> 2. This acts a throttling mechanisum for NVMe devices, in that it can not
> starve a CPU while servicing I/Os from other CPUs.
> 
> 3. This CPU can make progress on RCU and other work items on its queue.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/nvme/host/core.c | 57 +++++++++++++++++++++++++++++++++++++++-
>  drivers/nvme/host/nvme.h |  1 +
>  2 files changed, 57 insertions(+), 1 deletion(-)

WTH does this live in the NVME driver? Surely something like this should
be in the block layer. I'm thinking there's fiber channel connected
storage that should be able to trigger much the same issues.

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6a9dd68c0f4f..576bb6fce293 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c

> @@ -260,9 +270,54 @@ static void nvme_retry_req(struct request *req)
>  	blk_mq_delay_kick_requeue_list(req->q, delay);
>  }
>  
> +static void nvme_complete_rq_work(struct work_struct *work)
> +{
> +	struct nvme_request *nvme_rq =
> +		container_of(work, struct nvme_request, work);
> +	struct request *req = blk_mq_rq_from_pdu(nvme_rq);
> +
> +	nvme_complete_rq(req);
> +}
> +
> +
>  void nvme_complete_rq(struct request *req)
>  {
> -	blk_status_t status = nvme_error_status(req);
> +	blk_status_t status;
> +	int cpu;
> +	u64 switches;
> +	struct nvme_request *nvme_rq;
> +
> +	if (!in_interrupt())
> +		goto skip_check;
> +
> +	nvme_rq = nvme_req(req);
> +	cpu = smp_processor_id();
> +	if (idle_cpu(cpu))
> +		goto skip_check;
> +
> +	/* Check if this CPU is flooded with interrupts */
> +	switches = get_cpu_rq_switches(cpu);
> +	if (this_cpu_read(last_switch) == switches) {
> +		/*
> +		 * If this CPU hasn't made a context switch in
> +		 * MAX_SCHED_TIMEOUT ns (and it's not idle), schedule a work to
> +		 * complete this I/O. This forces this CPU run non-interrupt
> +		 * code and throttle the other CPU issuing the I/O
> +		 */

What if there was only a single task on that CPU? Then we'd never
need/want to context switch in the first place.

AFAICT all this is just a whole bunch of gruesome hacks piled on top one
another.

> +		if (sched_clock() - this_cpu_read(last_clock)
> +				> MAX_SCHED_TIMEOUT) {
> +			INIT_WORK(&nvme_rq->work, nvme_complete_rq_work);
> +			schedule_work_on(cpu, &nvme_rq->work);
> +			return;
> +		}
> +
> +	} else {
> +		this_cpu_write(last_switch, switches);
> +		this_cpu_write(last_clock, sched_clock());
> +	}
> +
> +skip_check:

Aside from everything else; this is just sodding poor coding style. What
is wrong with something like:

	if (nvme_complete_throttle(...))
		return;

> +	status = nvme_error_status(req);
>  
>  	trace_nvme_complete_rq(req);
>  
