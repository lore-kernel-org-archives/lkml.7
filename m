Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF48C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1384D20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="HUGRb+vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfGAQ3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:29:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36091 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfGAQ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:29:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id p15so15310384qtl.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 09:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZNtJviwglfM1/JQVLs8kmOz0uXCHglpeXoPPbkiM4Wg=;
        b=HUGRb+vy64kDiGXZhXgSf18dCporjW9t06hcgxxld7xlGITcRzV40ZMZPD29NQmgFq
         G7CZNQBgqDpW1tv+xXL1J4nnV6hyaBq2xH4LBUIG7CKe0HICwfMsdJFZBpS3nUv7a5fh
         UPS2oxEFATizPR1AZFvQPnNATvxuAs1eNT+ksb73tmtC1rW602ptLh6mLqIl0Flj9AKD
         EqCvAcunIxXzYWtLMrqg6jcY0rfYvs6ocOkUSGdFpRg89uyKnfy1jyUWuOboaOGnOyZn
         QsFRd1okGOJvZ4btedne+43035xdygDoNeJh6PDLSV3zud52ip9yNYcgrPHl3wNV2vIh
         L1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZNtJviwglfM1/JQVLs8kmOz0uXCHglpeXoPPbkiM4Wg=;
        b=Xz3UYlAAcsPHIodIzXxI4BcnfI3w1ctR0hOhkg94A+7VL7nsQ6ApfTiUGvu8NzUZrc
         cDEB6Csy5DFxjDM5ijQanbRAYTVphcFc+I2R+psuWU9QSHGTQrYkeW1diSQd5NUX9dlk
         A+zCRvKpH9SlsQmeuUzhIjkj8EhxleXH9b3BrIjhOlhSnptmvnOkR6bAQfzoO8yOQ2vP
         WWMQMzfB2DQf/XsfYakYZIE1blMPfy/dZPW5v9GiVFKPT9S+0qxfRB+0Eu2vQHJMDd8e
         1WCYv74WaWMlQZWeM4mrv5kiU+vmErDhBqBK+Iot63Tj4c/YERldTvz2bvInEJ6jsyzU
         7qbQ==
X-Gm-Message-State: APjAAAVCS9pILbr39AL+YK3BksRS45aYwNeSoJUuMw6cYcVBl5qi1fMn
        tzuxBBnOzUrYfo7mhTj85plrOg==
X-Google-Smtp-Source: APXvYqw4y7mEIwVoKHaixLm/NcSj0fbPTEu+vVOVlGU9hUyVnOF5LHEZUIj/wcGoMgj+kDxBkWgUDg==
X-Received: by 2002:a0c:b998:: with SMTP id v24mr22492689qvf.132.1561998592219;
        Mon, 01 Jul 2019 09:29:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::2ce6])
        by smtp.gmail.com with ESMTPSA id z11sm4601070qkl.90.2019.07.01.09.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 09:29:52 -0700 (PDT)
Date:   Mon, 1 Jul 2019 12:29:50 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Subject: Re: [PATCH 03/10] sched,fair: redefine runnable_load_avg as the sum
 of task_h_load
Message-ID: <20190701162949.vhxjndychoamhkbq@MacBook-Pro-91.local.dhcp.thefacebook.com>
References: <20190628204913.10287-1-riel@surriel.com>
 <20190628204913.10287-4-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628204913.10287-4-riel@surriel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 04:49:06PM -0400, Rik van Riel wrote:
> The runnable_load magic is used to quickly propagate information about
> runnable tasks up the hierarchy of runqueues. The runnable_load_avg is
> mostly used for the load balancing code, which only examines the value at
> the root cfs_rq.
> 
> Redefine the root cfs_rq runnable_load_avg to be the sum of task_h_loads
> of the runnable tasks. This works because the hierarchical runnable_load of
> a task is already equal to the task_se_h_load today. This provides enough
> information to the load balancer.
> 
> The runnable_load_avg of the cgroup cfs_rqs does not appear to be
> used for anything, so don't bother calculating those.
> 
> This removes one of the things that the code currently traverses the
> cgroup hierarchy for, and getting rid of it brings us one step closer
> to a flat runqueue for the CPU controller.
> 

My memory on this stuff is very hazy, but IIRC we had the runnable_sum and the
runnable_avg separated out because you could have the avg lag behind the sum.
So like you enqueue a bunch of new entities who's avg may have decayed a bunch
and so their overall load is not felt on the CPU until they start running, and
now you've overloaded that CPU.  The sum was there to make sure new things
coming onto the CPU added actual load to the queue instead of looking like there
was no load.

Is this going to be a problem now with this new code?

<snip>

> +static inline void
> +update_runnable_load_avg(struct sched_entity *se)
> +{
> +	struct cfs_rq *root_cfs_rq = &cfs_rq_of(se)->rq->cfs;
> +	long new_h_load, delta;
> +
> +	SCHED_WARN_ON(!entity_is_task(se));
> +
> +	if (!se->on_rq)
> +		return;
>  
> -	sub_positive(&cfs_rq->avg.runnable_load_avg, se->avg.runnable_load_avg);
> -	sub_positive(&cfs_rq->avg.runnable_load_sum,
> -		     se_runnable(se) * se->avg.runnable_load_sum);
> +	new_h_load = task_se_h_load(se);
> +	delta = new_h_load - se->enqueued_h_load;
> +	root_cfs_rq->avg.runnable_load_avg += delta;

Should we use add_positive here?  Thanks,

Josef
