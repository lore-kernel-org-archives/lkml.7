Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686AEC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDEE21655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569336530;
	bh=9jfKsFh+2Di0mpQIz6AMJh4zWidjQFnXzBAegAepz0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yZs+H7bi8EZXIFHJg7ytUh605+o1qXeissYQ26SOTf/VU/kdKWIJAG+8Xdbn/Xkkf
	 hQJcn00NgTbOJZjEjDMCT70sDkpzhMJ/xzPplIVNkHRgKXVpU4S9SLf3qZHIM/BQoe
	 C7fJZsIyvg8CVXl4DcmlEKbORNC6DH/Dq92qxtaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409722AbfIXOst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 10:48:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:54446 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbfIXOst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:48:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7792AC84;
        Tue, 24 Sep 2019 14:48:46 +0000 (UTC)
Date:   Tue, 24 Sep 2019 16:48:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't take the cpu_hotplug_lock
Message-ID: <20190924144846.GA23050@dhcp22.suse.cz>
References: <20190924143615.19628-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924143615.19628-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-09-19 16:36:15, David Hildenbrand wrote:
> Since commit 3f906ba23689 ("mm/memory-hotplug: switch locking to a percpu
> rwsem") we do a cpus_read_lock() in mem_hotplug_begin(). This was
> introduced to fix a potential deadlock between get_online_mems() and
> get_online_cpus() - the memory and cpu hotplug lock. The root issue was
> that build_all_zonelists() -> stop_machine() required the cpu hotplug lock:
>     The reason is that memory hotplug takes the memory hotplug lock and
>     then calls stop_machine() which calls get_online_cpus().  That's the
>     reverse lock order to get_online_cpus(); get_online_mems(); in
>     mm/slub_common.c
> 
> So memory hotplug never really required any cpu lock itself, only
> stop_machine() and lru_add_drain_all() required it. Back then,
> stop_machine_cpuslocked() and lru_add_drain_all_cpuslocked() were used
> as the cpu hotplug lock was now obtained in the caller.
> 
> Since commit 11cd8638c37f ("mm, page_alloc: remove stop_machine from build
> all_zonelists"), the stop_machine_cpuslocked() call is gone.
> build_all_zonelists() does no longer require the cpu lock and does no
> longer make use of stop_machine().
> 
> Since commit 9852a7212324 ("mm: drop hotplug lock from
> lru_add_drain_all()"), lru_add_drain_all() "Doesn't need any cpu hotplug
> locking because we do rely on per-cpu kworkers being shut down before our
> page_alloc_cpu_dead callback is executed on the offlined cpu.". The
> lru_add_drain_all_cpuslocked() variant was removed.
> 
> So there is nothing left that requires the cpu hotplug lock. The memory
> hotplug lock and the device hotplug lock are sufficient.

I would love to see this happen. The biggest offenders should be gone. 
I really hated how those two locks have been conflated which likely
resulted in some undocumented/unintended dependencies. So for now, I
cannot really tell you whether the patch is correct. It would really
require a lot of testing. I am not sure this is reasonably reviewable.

So please add some testing results (ideally cpu hotplug racing a lot
with the memory hotplug). Then I would be willing to give this a try
and see. First by keeping it in linux-next for a release or two and then
eyes closed, fingers crossed and go to the wild. Do we have a tag for
that Dared-by maybe?

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> RFC -> v1:
> - Reword and add more details why the cpu hotplug lock was needed here
>   in the first place, and why we no longer require it.
> 
> ---
>  mm/memory_hotplug.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c3e9aed6023f..5fa30f3010e1 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -88,14 +88,12 @@ __setup("memhp_default_state=", setup_memhp_default_state);
>  
>  void mem_hotplug_begin(void)
>  {
> -	cpus_read_lock();
>  	percpu_down_write(&mem_hotplug_lock);
>  }
>  
>  void mem_hotplug_done(void)
>  {
>  	percpu_up_write(&mem_hotplug_lock);
> -	cpus_read_unlock();
>  }
>  
>  u64 max_mem_size = U64_MAX;
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
