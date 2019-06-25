Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F293C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E615120883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561500044;
	bh=F3zOuj+AQCm4B3i9sQrKyEWYHwxAH26odI9Vxhs+EvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ghG5L6oJYf3az+XeRtY1qkRxlL4SRBgfeAW3cyzqPzi343bXN3KTKwgq227RcuB7O
	 p9yVv0UjLevcxq3aW9x+gnDkpgVLuF9zl8KGTrmfjlsN3G5X1xQLDRB+TtSmcAiA08
	 /fkBv/LpjZn2NtnFQub6UbPKmYcNLp6mPDbhXtWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfFYWAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfFYWAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:00:42 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14F962080C;
        Tue, 25 Jun 2019 22:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561500041;
        bh=F3zOuj+AQCm4B3i9sQrKyEWYHwxAH26odI9Vxhs+EvI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hxkgJe/pFbcy2wWEYYVcugv6LTv99BMAZVGwtVsElaZXu3NeeoVr7u5ZvvMtKXuhl
         VfsD5X/2GkepCxINxodk4b0M6ZVxwm3RoAZAoPobGTwN4rcTC2prnyg4ExCfL3ujQb
         n3OvN+ZqeLnPYNafzBYElyBLgUP29Ys135xarID0=
Date:   Tue, 25 Jun 2019 15:00:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 4/4] mm: thp: make deferred split shrinker memcg
 aware
Message-Id: <20190625150040.feb6ea9d11fff73a57320a3c@linux-foundation.org>
In-Reply-To: <1560376609-113689-5-git-send-email-yang.shi@linux.alibaba.com>
References: <1560376609-113689-1-git-send-email-yang.shi@linux.alibaba.com>
        <1560376609-113689-5-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019 05:56:49 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> Currently THP deferred split shrinker is not memcg aware, this may cause
> premature OOM with some configuration. For example the below test would
> run into premature OOM easily:
> 
> $ cgcreate -g memory:thp
> $ echo 4G > /sys/fs/cgroup/memory/thp/memory/limit_in_bytes
> $ cgexec -g memory:thp transhuge-stress 4000
> 
> transhuge-stress comes from kernel selftest.
> 
> It is easy to hit OOM, but there are still a lot THP on the deferred
> split queue, memcg direct reclaim can't touch them since the deferred
> split shrinker is not memcg aware.
> 
> Convert deferred split shrinker memcg aware by introducing per memcg
> deferred split queue.  The THP should be on either per node or per memcg
> deferred split queue if it belongs to a memcg.  When the page is
> immigrated to the other memcg, it will be immigrated to the target
> memcg's deferred split queue too.
> 
> Reuse the second tail page's deferred_list for per memcg list since the
> same THP can't be on multiple deferred split queues.
> 
> ...
>
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4579,6 +4579,11 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  	INIT_LIST_HEAD(&memcg->cgwb_list);
>  #endif
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	spin_lock_init(&memcg->deferred_split_queue.split_queue_lock);
> +	INIT_LIST_HEAD(&memcg->deferred_split_queue.split_queue);
> +	memcg->deferred_split_queue.split_queue_len = 0;
> +#endif
>  	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
>  	return memcg;
>  fail:
> @@ -4949,6 +4954,14 @@ static int mem_cgroup_move_account(struct page *page,
>  		__mod_memcg_state(to, NR_WRITEBACK, nr_pages);
>  	}
>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (compound && !list_empty(page_deferred_list(page))) {
> +		spin_lock(&from->deferred_split_queue.split_queue_lock);
> +		list_del(page_deferred_list(page));

It's worrisome that this page still appears to be on the deferred_list
and that the above if() would still succeed.  Should this be
list_del_init()?

> +		from->deferred_split_queue.split_queue_len--;
> +		spin_unlock(&from->deferred_split_queue.split_queue_lock);
> +	}
> +#endif

