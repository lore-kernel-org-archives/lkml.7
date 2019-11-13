Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33283C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046AF21E6F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573606963;
	bh=/hW9FHZPg5BWRf7H8t76WQKq6Qjzqsg1D2yflq0K+YU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=s7fhyLHUv+np97+aWPp3bA/u3i7uQaFE4WlHqp5R4D8bAgxrH5W+eaLLwwsuD7RMw
	 5Z8BHiwMaH020FnuzGB6KRjsrieNuvBokevphLDJaUrMR4+iZDzQ5dbuhAalMOi4G2
	 Gs+rZpI+JHCIN11bCj25+aEvnVIUIcu+whOja6ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfKMBCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:02:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbfKMBCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:02:41 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6348D21925;
        Wed, 13 Nov 2019 01:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573606958;
        bh=/hW9FHZPg5BWRf7H8t76WQKq6Qjzqsg1D2yflq0K+YU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vAnwxRPZXm4t8J6BBOltStfDVyZ7wMD1RuxQjyvUWAbukgyqsPE+897Yitroaue8p
         f0dc3+Vu97f0hzZemTJ3PAbLMr06QYRbQQVuZWB0vw8EjYlRxUtzvMWNp8+uKNK/kE
         q/3UyoPOY00zQDHJ1vlLOKCXds+UnrHncsMzpweU=
Date:   Tue, 12 Nov 2019 17:02:36 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>, Rong Chen <rong.a.chen@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3] writeback: add elastic bdi in cgwb bdp
Message-Id: <20191112170236.7aa81718af795f123a540d55@linux-foundation.org>
In-Reply-To: <20191112034227.3112-1-hdanton@sina.com>
References: <20191112034227.3112-1-hdanton@sina.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 11:42:27 +0800 Hillf Danton <hdanton@sina.com> wrote:

> 
> The elastic bdi (ebdi) which is the mirror bdi of spinning disk,
> SSD and USB key on market is introduced to balancing dirty pages
> (bdp).
> 
> The risk arises that system runs out of free memory, when dirty
> pages are produced too many too soon, so bdp is needed in field.
> 
> Ebdi facilitates bdp in elastic time intervals e.g. from a jiffy
> to one HZ, depending on the time it would take to increase dirty
> pages by the amount which is defined by the variable
> ratelimit_pages.
> 
> During cgroup writeback (cgwb) bdp, ebdi helps observe the
> changes both in cgwb's dirty pages (dirty speed) and in
> written-out pages (laundry speed) in elastic time intervals,
> until a balance is established between the two parties i.e.
> the two speeds statistically equal.
> 
> The above mechanism of elastic equilibrium effectively prevents
> dirty page hogs, as no chance is left for dirty pages to pile up,
> thus cuts the risk that system free memory falls to unsafe level.
> 
> Thanks to Rong Chen for testing.

That sounds like a Tested-by:

The changelog has no testing results.  Please prepare results which
show, amongst other things, the change in performance when the kernel
isn't tight on memory.  As well as the alteration in behaviour when
memory is short.

Generally, please work on making this code much more understandable?

>
> ...
>
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -811,6 +811,8 @@ static long wb_split_bdi_pages(struct bd
>  	if (nr_pages == LONG_MAX)
>  		return LONG_MAX;
>  
> +	return nr_pages;
> +
>  	/*
>  	 * This may be called on clean wb's and proportional distribution
>  	 * may not make sense, just use the original @nr_pages in those
> @@ -1604,6 +1606,7 @@ static long writeback_chunk_size(struct
>  		pages = min(pages, work->nr_pages);
>  		pages = round_down(pages + MIN_WRITEBACK_PAGES,
>  				   MIN_WRITEBACK_PAGES);
> +		pages = work->nr_pages;

It's unclear what this is doing, but it makes the three preceding
statements non-operative.

>  	}
>  
>  	return pages;
> @@ -2092,6 +2095,9 @@ void wb_workfn(struct work_struct *work)
>  		wb_wakeup_delayed(wb);
>  
>  	current->flags &= ~PF_SWAPWRITE;
> +
> +	if (waitqueue_active(&wb->bdp_waitq))
> +		wake_up_all(&wb->bdp_waitq);

Please add a comment explaining why this is being done here.

>  }
>  
>  /*
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1830,6 +1830,67 @@ pause:
>  		wb_start_background_writeback(wb);
>  }
>  
> +/**
> + * cgwb_bdp_should_throttle()	tell if a wb should be throttled
> + * @wb bdi_writeback to throttle
> + *
> + * To avoid the risk of exhausting the system free memory, we check
> + * and try much to prevent too many dirty pages from being produced
> + * too soon.
> + *
> + * For cgroup writeback, it is essencially to keep an equilibrium

"it is essential"?

> + * between its dirty speed and laundry speed i.e. dirty pages are
> + * written out as fast as they are produced in an ideal state.
> + */
> +static bool cgwb_bdp_should_throttle(struct bdi_writeback *wb)
> +{
> +	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
> +
> +	if (fatal_signal_pending(current))
> +		return false;
> +
> +	gdtc.avail = global_dirtyable_memory();
> +
> +	domain_dirty_limits(&gdtc);
> +
> +	gdtc.dirty = global_node_page_state(NR_FILE_DIRTY) +
> +		     global_node_page_state(NR_UNSTABLE_NFS) +
> +		     global_node_page_state(NR_WRITEBACK);
> +
> +	if (gdtc.dirty < gdtc.bg_thresh)
> +		return false;
> +
> +	if (!writeback_in_progress(wb))
> +		wb_start_background_writeback(wb);

This is a bit ugly.  Something called "bool cgwb_bdp_should_throttle()"
shoiuld just check whether we should throttle.  But here it is, also
initiating writeback.  That's an inappropriate thing for this function
to do?

Also, we don't know *why* this is being done here, because there's no
code comment explaining the reasoning to us.


> +	if (gdtc.dirty < gdtc.thresh)
> +		return false;
> +
> +	/*
> +	 * throttle wb if there is the risk that wb's dirty speed is
> +	 * running away from its laundry speed, better with statistic
> +	 * error taken into account.
> +	 */
> +	return  wb_stat(wb, WB_DIRTIED) >
> +		wb_stat(wb, WB_WRITTEN) + wb_stat_error();
> +}
> +
>
> ...
>
> @@ -1888,29 +1945,38 @@ void balance_dirty_pages_ratelimited(str
>  	 * 1000+ tasks, all of them start dirtying pages at exactly the same
>  	 * time, hence all honoured too large initial task->nr_dirtied_pause.
>  	 */
> -	p =  this_cpu_ptr(&bdp_ratelimits);
> -	if (unlikely(current->nr_dirtied >= ratelimit))
> -		*p = 0;
> -	else if (unlikely(*p >= ratelimit_pages)) {
> -		*p = 0;
> -		ratelimit = 0;
> -	}
> +	dirty = this_cpu_ptr(&bdp_ratelimits);
> +
>  	/*
>  	 * Pick up the dirtied pages by the exited tasks. This avoids lots of
>  	 * short-lived tasks (eg. gcc invocations in a kernel build) escaping
>  	 * the dirty throttling and livelock other long-run dirtiers.
>  	 */
> -	p = this_cpu_ptr(&dirty_throttle_leaks);
> -	if (*p > 0 && current->nr_dirtied < ratelimit) {
> -		unsigned long nr_pages_dirtied;
> -		nr_pages_dirtied = min(*p, ratelimit - current->nr_dirtied);
> -		*p -= nr_pages_dirtied;
> -		current->nr_dirtied += nr_pages_dirtied;
> +	leak = this_cpu_ptr(&dirty_throttle_leaks);
> +
> +	if (*dirty + *leak < ratelimit_pages) {
> +		/*
> +		 * nothing to do as it would take some more time to
> +		 * eat out ratelimit_pages
> +		 */
> +		try_bdp = false;
> +	} else {
> +		try_bdp = true;
> +
> +		/*
> +		 * bdp in flight helps detect dirty page hogs soon
> +		 */

How?  Please expand on this comment a lot.  

> +		flights = this_cpu_ptr(&bdp_in_flight);
> +
> +		if ((*flights)++ & 1) {

What is that "& 1" doing?

> +			*dirty = *dirty + *leak - ratelimit_pages;
> +			*leak = 0;
> +		}
>  	}
>  	preempt_enable();
>  
> -	if (unlikely(current->nr_dirtied >= ratelimit))
> -		balance_dirty_pages(wb, current->nr_dirtied);
> +	if (try_bdp)
> +		cgwb_bdp(wb);
>  
>  	wb_put(wb);

