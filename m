Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FFCC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62ED205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389127AbfFKOMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:12:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387447AbfFKOMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:12:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9FA4821CB;
        Tue, 11 Jun 2019 14:12:22 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23AC6600CD;
        Tue, 11 Jun 2019 14:12:21 +0000 (UTC)
Date:   Tue, 11 Jun 2019 10:12:19 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     bsegall@google.com, linux-kernel@vger.kernel.org,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2] sched/fair: don't push cfs_bandwith slack timers
 forward
Message-ID: <20190611141219.GD15412@pauld.bos.csb>
References: <xm26ef47yeyh.fsf@bsegall-linux.svl.corp.google.com>
 <eafe846f-d83c-b2f3-4458-45e3ae6e5823@linux.alibaba.com>
 <xm26a7euy6iq.fsf_-_@bsegall-linux.svl.corp.google.com>
 <20190611135325.GY3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611135325.GY3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 11 Jun 2019 14:12:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 03:53:25PM +0200 Peter Zijlstra wrote:
> On Thu, Jun 06, 2019 at 10:21:01AM -0700, bsegall@google.com wrote:
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index efa686eeff26..60219acda94b 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -356,6 +356,7 @@ struct cfs_bandwidth {
> >  	u64			throttled_time;
> >  
> >  	bool                    distribute_running;
> > +	bool                    slack_started;
> >  #endif
> >  };
> 
> I'm thinking we can this instead? afaict both idle and period_active are
> already effecitively booleans and don't need the full 16 bits.
> 
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -338,8 +338,10 @@ struct cfs_bandwidth {
>  	u64			runtime_expires;
>  	int			expires_seq;
>  
> -	short			idle;
> -	short			period_active;
> +	u8			idle;
> +	u8			period_active;
> +	u8			distribute_running;
> +	u8			slack_started;
>  	struct hrtimer		period_timer;
>  	struct hrtimer		slack_timer;
>  	struct list_head	throttled_cfs_rq;
> @@ -348,9 +350,6 @@ struct cfs_bandwidth {
>  	int			nr_periods;
>  	int			nr_throttled;
>  	u64			throttled_time;
> -
> -	bool                    distribute_running;
> -	bool                    slack_started;
>  #endif
>  };
>  


That looks reasonable to me. 

Out of curiosity, why not bool? Is sizeof bool architecture dependent?

-- 
