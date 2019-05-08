Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E62C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7252053B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfEHJJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:09:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35144 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfEHJJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:09:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so2247177wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 02:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=78s6BKgtcqTpXSDR87S8iwsLLYq7TFH1AkHESOn6xdQ=;
        b=ZyukzDvS7PWuP4WgsDsDU7PMxT5xaOC70mAhTrRmf2vFiu3aIj+FIrM0Ge69MZY7oB
         qXqm6G6R5xWFviVQnNTm3gma7puNduE8/kI93t1gXewtnu5J7OzfSHzg7lvnP5woGV6X
         USRCQSk/bJXOTDi/Uc3FTHcaXXs/maDgZtuGiqbLiCnJC9LZ5noi0lPIOpqaxCD3Lt7U
         LxDTpcdtbyuTokHPYWr3/ut268yHe4YYBaQyW28hW0c7QwPb7oGqwv2RmJZ3lu0bTqv5
         hZ0NU2G1BK1rQzsDMHrTpNQAE4bitcpdjmrB7f2pxgXOfnksg313FzDnD0q5cmrSuAmi
         GaCA==
X-Gm-Message-State: APjAAAXWy3HQD3yhpWdyovf8BNq9o9woxbvwtP7b0baRnLREWTNVd4PP
        0lvBqOXGteQyj5IydeZQn3nLkw==
X-Google-Smtp-Source: APXvYqxrc+/Fp3gQOFmiOvxTQ3d8Lhs3ICeo+L9TySIt0NQkplmBF99E6iZaPTTYTh4YXt3wpaFwcw==
X-Received: by 2002:a7b:ce03:: with SMTP id m3mr2013588wmc.99.1557306538566;
        Wed, 08 May 2019 02:08:58 -0700 (PDT)
Received: from localhost.localdomain ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id o4sm1417936wmc.38.2019.05.08.02.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 02:08:57 -0700 (PDT)
Date:   Wed, 8 May 2019 11:08:55 +0200
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
Subject: Re: [RFC PATCH 4/6] sched/dl: Improve capacity-aware wakeup
Message-ID: <20190508090855.GG6551@localhost.localdomain>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-5-luca.abeni@santannapisa.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506044836.2914-5-luca.abeni@santannapisa.it>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/19 06:48, Luca Abeni wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Instead of considering the "static CPU bandwidth" allocated to
> a SCHED_DEADLINE task (ratio between its maximum runtime and
> reservation period), try to use the remaining runtime and time
> to scheduling deadline.
> 
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> ---
>  kernel/sched/cpudeadline.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> index d21f7905b9c1..111dd9ac837b 100644
> --- a/kernel/sched/cpudeadline.c
> +++ b/kernel/sched/cpudeadline.c
> @@ -114,8 +114,13 @@ static inline int dl_task_fit(const struct sched_dl_entity *dl_se,
>  			      int cpu, u64 *c)
>  {
>  	u64 cap = (arch_scale_cpu_capacity(NULL, cpu) * arch_scale_freq_capacity(cpu)) >> SCHED_CAPACITY_SHIFT;
> -	s64 rel_deadline = dl_se->dl_deadline;
> -	u64 rem_runtime  = dl_se->dl_runtime;
> +	s64 rel_deadline = dl_se->deadline - sched_clock_cpu(smp_processor_id());
> +	u64 rem_runtime  = dl_se->runtime;
> +
> +	if ((rel_deadline < 0) || (rel_deadline * dl_se->dl_runtime < dl_se->dl_deadline * rem_runtime)) {
> +		rel_deadline = dl_se->dl_deadline;
> +		rem_runtime  = dl_se->dl_runtime;
> +	}

So, are you basically checking if current remaining bw can be consumed
safely?

I'm not actually sure if looking at dynamic values is what we need to do
at this stage. By considering static values we fix admission control
(and scheduling). Aren't dynamic values more to do with energy tradeoffs
(and so to be introduced when starting to look at the energy model)?

Another pair of hands maybe is to look at the dynamic spare bw of CPUs
(to check that we don't overload CPUs).

Thanks,

- Juri
