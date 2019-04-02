Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEB4C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB8B2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554240755;
	bh=YCs9ALT43RrMOyhVj/RVmlUky/kNqSo6pLF4Sn7oRXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hL12KJhC2HUJdGtZFIweeqHKcNaIctthWznIosja/ojCuZZukV310OEG06abKI+sO
	 TIkGaYX9CHaekEO9EfJvYpnXpnzNfo35RdHW6dAJZauMcdBrtle84oobM0wBtKQR4V
	 6pY8+YQEbQ6J/SEDwv5zcKF3HRT6JDrGQSJAvT+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDBVcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:32:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDBVcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:32:33 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E45E3D88;
        Tue,  2 Apr 2019 21:32:31 +0000 (UTC)
Date:   Tue, 2 Apr 2019 14:32:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Greg Thelen <gthelen@google.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] writeback: use exact memcg dirty counts
Message-Id: <20190402143230.3ea53a7d599b2d78c39b77b0@linux-foundation.org>
In-Reply-To: <20190401182044.GA3694@cmpxchg.org>
References: <20190329174609.164344-1-gthelen@google.com>
        <20190401182044.GA3694@cmpxchg.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019 14:20:44 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Fri, Mar 29, 2019 at 10:46:09AM -0700, Greg Thelen wrote:
> > @@ -3907,10 +3923,10 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
> >  	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
> >  	struct mem_cgroup *parent;
> >  
> > -	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
> > +	*pdirty = memcg_exact_page_state(memcg, NR_FILE_DIRTY);
> >  
> >  	/* this should eventually include NR_UNSTABLE_NFS */
> > -	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
> > +	*pwriteback = memcg_exact_page_state(memcg, NR_WRITEBACK);
> >  	*pfilepages = mem_cgroup_nr_lru_pages(memcg, (1 << LRU_INACTIVE_FILE) |
> >  						     (1 << LRU_ACTIVE_FILE));
> 
> Andrew,
> 
> just a head-up: -mm has that LRU stat cleanup series queued ("mm:
> memcontrol: clean up the LRU counts tracking") that changes the
> mem_cgroup_nr_lru_pages() call here to two memcg_page_state().
> 
> I'm assuming Greg's fix here will get merged before the cleanup. When
> it gets picked up, it'll conflict with "mm: memcontrol: push down
> mem_cgroup_nr_lru_pages()".
> 
> "mm: memcontrol: push down mem_cgroup_nr_lru_pages()" will need to be
> changed to use memcg_exact_page_state() calls instead of the plain
> memcg_page_state() for *pfilepages.
> 

Thanks.  Like this?

void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
			 unsigned long *pheadroom, unsigned long *pdirty,
			 unsigned long *pwriteback)
{
	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
	struct mem_cgroup *parent;

	*pdirty = memcg_exact_page_state(memcg, NR_FILE_DIRTY);

	/* this should eventually include NR_UNSTABLE_NFS */
	*pwriteback = memcg_exact_page_state(memcg, NR_WRITEBACK);
	*pfilepages = memcg_exact_page_state(memcg, NR_INACTIVE_FILE) +
			memcg_exact_page_state(memcg, NR_ACTIVE_FILE);
	*pheadroom = PAGE_COUNTER_MAX;

	while ((parent = parent_mem_cgroup(memcg))) {
		unsigned long ceiling = min(memcg->memory.max, memcg->high);
		unsigned long used = page_counter_read(&memcg->memory);

		*pheadroom = min(*pheadroom, ceiling - min(ceiling, used));
		memcg = parent;
	}
}

