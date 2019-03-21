Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE59C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7D42190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553211899;
	bh=UpHbhHN1Zc5BHGT03KaWWWF0W9L5k2v3o9D99kG+1Dc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Wl+yvliRLnjQT9ZuVv7yZFUpQI7Cuk3JD+RjQZMjJs0nNk1fwX1YOhCLvqCqtiXvH
	 SafyJqQlekNPpQ2vjLCSSq2hhdkzCGBBA2pWIHrnP3zUnKkAoUJXE3kDdBcvGedYs8
	 ZVl/+Oa0vcfaE85JuhsULQL+HFu5jEwK6/IUTfz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfCUXo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:44:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfCUXo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:44:56 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 529FCE7A;
        Thu, 21 Mar 2019 23:44:54 +0000 (UTC)
Date:   Thu, 21 Mar 2019 16:44:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Greg Thelen <gthelen@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: sum memcg dirty counters as needed
Message-Id: <20190321164453.46143c8bf2dd8bfd0f91d71c@linux-foundation.org>
In-Reply-To: <20190307165632.35810-1-gthelen@google.com>
References: <20190307165632.35810-1-gthelen@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Mar 2019 08:56:32 -0800 Greg Thelen <gthelen@google.com> wrote:

> Since commit a983b5ebee57 ("mm: memcontrol: fix excessive complexity in
> memory.stat reporting") memcg dirty and writeback counters are managed
> as:
> 1) per-memcg per-cpu values in range of [-32..32]
> 2) per-memcg atomic counter
> When a per-cpu counter cannot fit in [-32..32] it's flushed to the
> atomic.  Stat readers only check the atomic.
> Thus readers such as balance_dirty_pages() may see a nontrivial error
> margin: 32 pages per cpu.
> Assuming 100 cpus:
>    4k x86 page_size:  13 MiB error per memcg
>   64k ppc page_size: 200 MiB error per memcg
> Considering that dirty+writeback are used together for some decisions
> the errors double.
> 
> This inaccuracy can lead to undeserved oom kills.  One nasty case is
> when all per-cpu counters hold positive values offsetting an atomic
> negative value (i.e. per_cpu[*]=32, atomic=n_cpu*-32).
> balance_dirty_pages() only consults the atomic and does not consider
> throttling the next n_cpu*32 dirty pages.  If the file_lru is in the
> 13..200 MiB range then there's absolutely no dirty throttling, which
> burdens vmscan with only dirty+writeback pages thus resorting to oom
> kill.
> 
> It could be argued that tiny containers are not supported, but it's more
> subtle.  It's the amount the space available for file lru that matters.
> If a container has memory.max-200MiB of non reclaimable memory, then it
> will also suffer such oom kills on a 100 cpu machine.
> 
> ...
> 
> Make balance_dirty_pages() and wb_over_bg_thresh() work harder to
> collect exact per memcg counters when a memcg is close to the
> throttling/writeback threshold.  This avoids the aforementioned oom
> kills.
> 
> This does not affect the overhead of memory.stat, which still reads the
> single atomic counter.
> 
> Why not use percpu_counter?  memcg already handles cpus going offline,
> so no need for that overhead from percpu_counter.  And the
> percpu_counter spinlocks are more heavyweight than is required.
> 
> It probably also makes sense to include exact dirty and writeback
> counters in memcg oom reports.  But that is saved for later.

Nice changelog, thanks.

> Signed-off-by: Greg Thelen <gthelen@google.com>

Did you consider cc:stable for this?  We may as well - the stablebots
backport everything which might look slightly like a fix anyway :(

> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -573,6 +573,22 @@ static inline unsigned long memcg_page_state(struct mem_cgroup *memcg,
>  	return x;
>  }
>  
> +/* idx can be of type enum memcg_stat_item or node_stat_item */
> +static inline unsigned long
> +memcg_exact_page_state(struct mem_cgroup *memcg, int idx)
> +{
> +	long x = atomic_long_read(&memcg->stat[idx]);
> +#ifdef CONFIG_SMP
> +	int cpu;
> +
> +	for_each_online_cpu(cpu)
> +		x += per_cpu_ptr(memcg->stat_cpu, cpu)->count[idx];
> +	if (x < 0)
> +		x = 0;
> +#endif
> +	return x;
> +}

This looks awfully heavyweight for an inline function.  Why not make it
a regular function and avoid the bloat and i-cache consumption?

Also, did you instead consider making this spill the percpu counters
into memcg->stat[idx]?  That might be more useful for potential future
callers.  It would become a little more expensive though.
