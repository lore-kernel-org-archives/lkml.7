Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED368C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6822075B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfHEOG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:06:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfHEOG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:06:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39360883D7;
        Mon,  5 Aug 2019 14:06:56 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9633560C83;
        Mon,  5 Aug 2019 14:06:55 +0000 (UTC)
Date:   Mon, 5 Aug 2019 10:06:53 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: use rq_lock/unlock in online_fair_sched_group
Message-ID: <20190805140653.GA20173@pauld.bos.csb>
References: <20190801133749.11033-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801133749.11033-1-pauld@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 05 Aug 2019 14:06:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 05:20:38PM +0800 Hillf Danton wrote:
> 
> On Thu,  1 Aug 2019 09:37:49 -0400 Phil Auld wrote:
> >
> > Enabling WARN_DOUBLE_CLOCK in /sys/kernel/debug/sched_features causes
> > warning to fire in update_rq_clock. This seems to be caused by onlining
> > a new fair sched group not using the rq lock wrappers.
> > 
> > [472978.683085] rq->clock_update_flags & RQCF_UPDATED
> > [472978.683100] WARNING: CPU: 5 PID: 54385 at kernel/sched/core.c:210 update_rq_clock+0xec/0x150
> 
> Another option perhaps only if that wrappers are not mandatory.
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -212,10 +212,14 @@ void update_rq_clock(struct rq *rq)
>  #endif
>  
>  	delta = sched_clock_cpu(cpu_of(rq)) - rq->clock;
> -	if (delta < 0)
> -		return;
> -	rq->clock += delta;
> -	update_rq_clock_task(rq, delta);
> +	if (delta >= 0) {
> +		rq->clock += delta;
> +		update_rq_clock_task(rq, delta);
> +	}
> +
> +#ifdef CONFIG_SCHED_DEBUG
> +	rq->clock_update_flags &= ~RQCF_UPDATED;
> +#endif
>  }
>  
>  
> --
> 

I think that would silence the warning, but...

If we're to clear that flag right there, outside of the lock pinning code, 
then I think we might as well just remove the flag and all associated 
comments etc, no?


Cheers,
Phil

-- 
