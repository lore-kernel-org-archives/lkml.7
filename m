Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E1CC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0247021479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfEHIEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:04:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35973 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfEHIEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:04:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id o4so25907680wra.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 01:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9quD3rUlId3s9xE5WQ9qfoKtV1iDyOxaETbvD2qMUps=;
        b=ptAXye10M1bTT8akY8EXX5jtyYLwORy6rwfrSlsTJzqZ7GHUn9wO+9SKoI1CKY45IV
         JtOmzO0R+UVVEiJ5+IvGEZzgqz+9NjVh7UZd1b2Po/ucAUXK1QSfw4Y1OrHi8eEQhd0j
         b0ZvyxOut/TqonmqGKZWwKZTjyVTlswqRxHL9g0rGKDwKi+88UMLyTIs6mZY858BUwmM
         XcbICoRe16IpBB117JvRxknvJHxYaYvQAdK26xT1k85DeBmbaXghNlijPZKszMLIhC+k
         VEB2njJWBudSTZiEQ3PQ2Mu9sDb36lORdUSZtN9qm6LTaupO1lxkqvcSaaTCUB4vLEKQ
         F+oA==
X-Gm-Message-State: APjAAAXHsJdFKisAqPKHHYCUxVHCUTilvU24CAmS6WcRA3rYjpwT/6dW
        gwGXdDXKbePA6/M6dBjHyXpLQQ==
X-Google-Smtp-Source: APXvYqzAEwmmUYMoGs4NEbM6WU7pAt/xG2XWKvEyTFAozN1NCDztWyNXuGXYGqCVLdIj3/dOobUUZA==
X-Received: by 2002:adf:f803:: with SMTP id s3mr5103478wrp.153.1557302679450;
        Wed, 08 May 2019 01:04:39 -0700 (PDT)
Received: from localhost.localdomain ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id t15sm1407934wmt.2.2019.05.08.01.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 01:04:38 -0700 (PDT)
Date:   Wed, 8 May 2019 10:04:36 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Luca Abeni <luca.abeni@santannapisa.it>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 2/6] sched/dl: Capacity-aware migrations
Message-ID: <20190508080436.GF6551@localhost.localdomain>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-3-luca.abeni@santannapisa.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506044836.2914-3-luca.abeni@santannapisa.it>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On 06/05/19 06:48, Luca Abeni wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Currently, the SCHED_DEADLINE scheduler uses a global EDF scheduling
> algorithm, migrating tasks to CPU cores without considering the core
> capacity and the task utilization. This works well on homogeneous
> systems (SCHED_DEADLINE tasks are guaranteed to have a bounded
> tardiness), but presents some issues on heterogeneous systems. For
> example, a SCHED_DEADLINE task might be migrated on a core that has not
> enough processing capacity to correctly serve the task (think about a
> task with runtime 70ms and period 100ms migrated to a core with
> processing capacity 0.5)
> 
> This commit is a first step to address the issue: When a task wakes
> up or migrates away from a CPU core, the scheduler tries to find an
> idle core having enough processing capacity to serve the task.
> 
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> ---
>  kernel/sched/cpudeadline.c | 31 +++++++++++++++++++++++++++++--
>  kernel/sched/deadline.c    |  8 ++++++--
>  kernel/sched/sched.h       |  7 ++++++-
>  3 files changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> index 50316455ea66..d21f7905b9c1 100644
> --- a/kernel/sched/cpudeadline.c
> +++ b/kernel/sched/cpudeadline.c
> @@ -110,6 +110,22 @@ static inline int cpudl_maximum(struct cpudl *cp)
>  	return cp->elements[0].cpu;
>  }
>  
> +static inline int dl_task_fit(const struct sched_dl_entity *dl_se,
> +			      int cpu, u64 *c)
> +{
> +	u64 cap = (arch_scale_cpu_capacity(NULL, cpu) * arch_scale_freq_capacity(cpu)) >> SCHED_CAPACITY_SHIFT;
> +	s64 rel_deadline = dl_se->dl_deadline;
> +	u64 rem_runtime  = dl_se->dl_runtime;

This is not the dynamic remaining one, is it?

I see however 4/6.. lemme better look at that.

Best,

- Juri
