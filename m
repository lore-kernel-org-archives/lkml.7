Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30926C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 15:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16892468D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 15:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgACPO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 10:14:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:43996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbgACPO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 10:14:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CF604AC69;
        Fri,  3 Jan 2020 15:14:55 +0000 (UTC)
Date:   Fri, 3 Jan 2020 16:14:49 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v6 1/2] sched/numa: introduce per-cgroup NUMA locality
 info
Message-ID: <20200103151449.GA25747@blackbody.suse.cz>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <040def80-9c38-4bcc-e4a8-8a0d10f131ed@linux.alibaba.com>
 <25cf7ef5-e37e-7578-eea7-29ad0b76c4ea@linux.alibaba.com>
 <443641e7-f968-0954-5ff6-3b7e7fed0e83@linux.alibaba.com>
 <d2c4cace-623a-9317-c957-807e3875aa4a@linux.alibaba.com>
 <275a98ed-35b8-b65f-3600-64ab722dd836@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <275a98ed-35b8-b65f-3600-64ab722dd836@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, Dec 13, 2019 at 09:47:36AM +0800, 王贇 <yun.wang@linux.alibaba.com> wrote:
> By monitoring the increments, we will be able to locate the per-cgroup
> workload which NUMA Balancing can't helpwith (usually caused by wrong
> CPU and memory node bindings), then we got chance to fix that in time.
I just wonder do the data based on increments match with those you
obtained previously?

> +static inline void
> +update_task_locality(struct task_struct *p, int pnid, int cnid, int pages)
> +{
> +	if (!static_branch_unlikely(&sched_numa_locality))
> +		return;
> +
> +	/*
> +	 * pnid != cnid --> remote idx 0
> +	 * pnid == cnid --> local idx 1
> +	 */
> +	p->numa_page_access[!!(pnid == cnid)] += pages;
If the per-task information isn't used anywhere, why not accumulate
directly into task's cfs_rq->{local,remote}_page_access?

> @@ -4298,6 +4359,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
>  	 */
>  	update_load_avg(cfs_rq, curr, UPDATE_TG);
>  	update_cfs_group(curr);
> +	update_group_locality(cfs_rq);
With the per-NUMA node time tracked separately, isn't it unnecessary
doing group updates inside entity_tick? 


Regards,
Michal
