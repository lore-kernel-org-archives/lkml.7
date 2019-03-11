Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DE1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CE62063F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="uvoNHu+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfCKRi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:38:29 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39132 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCKRi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:38:29 -0400
Received: by mail-yw1-f67.google.com with SMTP id z191so4570862ywa.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4oG4uCayIgWYZNRmmqdLLn+2j4kMq1tiq/9bPpXuwD0=;
        b=uvoNHu+n+ofsYax2n2VYcXwbPB9A3egn/1//CzPHBUXHOyp0Fl6HK5v2VS3cnzwEgO
         ToESLrILE6fVDPyQmGGifAsI6ccvNrXjwVg4yiMVMMIHJw/IZs/WepusApJFfRoHcVot
         0aNoXaMYYfJ4PQBOlZSQnwPorOF6USCzPC+FjKvrD6eo3dQBWHNn1Woik3/o9/akR/if
         FWfyJdUkRYgDWhmsRYzxKAL1/I80JNoGCj070il+ZR+U4yiy87BDNmWS+zTriFVEr/6u
         N198aqSSyWYTH2puIMOx9GY+KOpaqyDs2e8Omh5qkvCF89HTixb4o7LWqugfV17TiqNS
         +nKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4oG4uCayIgWYZNRmmqdLLn+2j4kMq1tiq/9bPpXuwD0=;
        b=sTrP4g84/gqLzCBxsULVHafL/d3S06IMjFUetpgC4cYHi339Xr11IfIRiH8bcJHhCa
         i2aNmA7gK0fcGfaW2ceIAi0hN0Kg8+LwY8K0w0ORpuSr6CUBkuH/sHaAEG+SX/+6qU94
         tyDakAYmV6jC0L8xcl7VI4GTn8cQ30q56xjDQCov/ld86fxyoN2UoMTXu/QC3K+93C5f
         MXC6NtTH7fKfyXyXQwhONVwxunfzSw1zEQ9M1kchpNa12A7AWhUFO/BmRKtjtV7z3p0B
         KOpPHWV3pAh9cTR6XsnHLBqC3qijRX4rc/MhYn99ILOSUSEh63/+KQtg3lzq/PdZplqW
         12ug==
X-Gm-Message-State: APjAAAVgBUF5CqI5IbwDc7WcF6CojL+S2pmgvTWafi02yL6BfWzlNbTq
        7qWh16Vcnru/KYWOeyl39ACrEQ==
X-Google-Smtp-Source: APXvYqzIXaAlztXgyLzDw1doGyqIHYxIWXNOmebnA3qYLzj3f5vBWGOFMBwHZAiRBeiv2tR/lQ9LJw==
X-Received: by 2002:a25:57c4:: with SMTP id l187mr22693216ybb.435.1552325907846;
        Mon, 11 Mar 2019 10:38:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:3c60])
        by smtp.gmail.com with ESMTPSA id d9sm2385854ywd.82.2019.03.11.10.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 10:38:26 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:38:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 5/5] mm: spill memcg percpu stats and events before
 releasing
Message-ID: <20190311173825.GE10823@cmpxchg.org>
References: <20190307230033.31975-1-guro@fb.com>
 <20190307230033.31975-6-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307230033.31975-6-guro@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 03:00:33PM -0800, Roman Gushchin wrote:
> Spill percpu stats and events data to corresponding before releasing
> percpu memory.
> 
> Although per-cpu stats are never exactly precise, dropping them on
> floor regularly may lead to an accumulation of an error. So, it's
> safer to sync them before releasing.
> 
> To minimize the number of atomic updates, let's sum all stats/events
> on all cpus locally, and then make a single update per entry.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/memcontrol.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 18e863890392..b7eb6fac735e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4612,11 +4612,63 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  	return 0;
>  }
>  
> +/*
> + * Spill all per-cpu stats and events into atomics.
> + * Try to minimize the number of atomic writes by gathering data from
> + * all cpus locally, and then make one atomic update.
> + * No locking is required, because no one has an access to
> + * the offlined percpu data.
> + */
> +static void mem_cgroup_spill_offlined_percpu(struct mem_cgroup *memcg)
> +{
> +	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
> +	struct lruvec_stat __percpu *lruvec_stat_cpu;
> +	struct mem_cgroup_per_node *pn;
> +	int cpu, i;
> +	long x;
> +
> +	vmstats_percpu = memcg->vmstats_percpu_offlined;
> +
> +	for (i = 0; i < MEMCG_NR_STAT; i++) {
> +		int nid;
> +
> +		x = 0;
> +		for_each_possible_cpu(cpu)
> +			x += per_cpu(vmstats_percpu->stat[i], cpu);
> +		if (x)
> +			atomic_long_add(x, &memcg->vmstats[i]);
> +
> +		if (i >= NR_VM_NODE_STAT_ITEMS)
> +			continue;
> +
> +		for_each_node(nid) {
> +			pn = mem_cgroup_nodeinfo(memcg, nid);
> +			lruvec_stat_cpu = pn->lruvec_stat_cpu_offlined;
> +
> +			x = 0;
> +			for_each_possible_cpu(cpu)
> +				x += per_cpu(lruvec_stat_cpu->count[i], cpu);
> +			if (x)
> +				atomic_long_add(x, &pn->lruvec_stat[i]);
> +		}
> +	}
> +
> +	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
> +		x = 0;
> +		for_each_possible_cpu(cpu)
> +			x += per_cpu(vmstats_percpu->events[i], cpu);
> +		if (x)
> +			atomic_long_add(x, &memcg->vmevents[i]);
> +	}

This looks good, but couldn't this be merged with the cpu offlining?
It seems to be exactly the same code, except for the nesting of the
for_each_possible_cpu() iteration here.

This could be a function that takes a CPU argument and then iterates
the cgroups and stat items to collect and spill the counters of that
specified CPU; offlining would call it once, and this spill code here
would call it for_each_possible_cpu().

We shouldn't need the atomicity of this_cpu_xchg() during hotunplug,
the scheduler isn't even active on that CPU anymore when it's called.
