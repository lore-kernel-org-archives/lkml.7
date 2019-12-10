Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36262C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123E522464
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfLJKhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:37:01 -0500
Received: from foss.arm.com ([217.140.110.172]:38950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfLJKhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:37:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1B0E1FB;
        Tue, 10 Dec 2019 02:37:00 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 564973F6CF;
        Tue, 10 Dec 2019 02:36:59 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:36:57 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: fix find_idlest_group() to handle CPU
 affinity
Message-ID: <20191210103656.637xilg2egtdwv5b@e107158-lin.cambridge.arm.com>
References: <1575483700-22153-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1575483700-22153-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/19 19:21, Vincent Guittot wrote:
> Because of CPU affinity, the local group can be skipped which breaks the
> assumption that statistics are always collected for local group. With
> uninitialized local_sgs, the comparison is meaningless and the behavior
> unpredictable. This can even end up to use local pointer which is to
> NULL in this case.

For the record; I think this is safe and I can't see how the local_sgs can be
used uninitialized, but experience shows that if this happened once it's likely
to happen again when things change. So I think it'd be safer to always
initialize local_sgs to something sensible and avoid future trouble. I don't
see any cost to initializing it.

My 2p :-) The change is good for me as-is otherwise.

Cheers

--
Qais Yousef

> 
> If the local group has been skipped because of CPU affinity, we return
> the idlest group.
> 
> Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: John Stultz <john.stultz@linaro.org>
> ---
>  kernel/sched/fair.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 08a233e..146b6c8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8417,6 +8417,10 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
>  	if (!idlest)
>  		return NULL;
>  
> +	/* The local group has been skipped because of CPU affinity */
> +	if (!local)
> +		return idlest;
> +
>  	/*
>  	 * If the local group is idler than the selected idlest group
>  	 * don't try and push the task.
> -- 
> 2.7.4
> 
