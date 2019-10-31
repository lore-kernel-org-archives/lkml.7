Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69280CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 17:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F4F2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 17:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWAovb8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfJaRff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 13:35:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37757 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbfJaRfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 13:35:34 -0400
Received: by mail-ot1-f67.google.com with SMTP id 53so6116566otv.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 10:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8nHhOeCB21rInn6DQAiAV8vbd4SBCx2+rITPRP/LINw=;
        b=NWAovb8j6b4bCrSclwRlIdm3P3X0f76I1C0VTRCqw5fW7sAefQNegcuwZEid4CYym+
         g8PipMfn5chTH4Hh2B809wwMzl3p458yw6gsHKdkQyK8J7MhFiKKfAaLt/TNnL1Ha5Sz
         0MCcluPxysS1pce8wN4+hWAy5CopYR/uKTFa0Km7A8ctOvoG5ZGnwkJBtYEgmcR0nxk2
         YcQJGgyzLC+kdkl/kx0A+0zCXr9ahRcUMU2dexDOLqNKl0FIGThx98KIlW2nLLu2GBKa
         hGZeoibJZhuGgplZQ8ufkaBXDsgOwjnMMvwL4+GFteaBvoAH8MPLw2+7dlX7HkSlFQew
         CS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nHhOeCB21rInn6DQAiAV8vbd4SBCx2+rITPRP/LINw=;
        b=KM5yXJppLNu0l0rfd6QYFe0Jaj/sA4fbUXy/DqYhwIyLGQsHlps7Z+sVyJIww/yG1Z
         gIr0+rCYQxCypgqMtL4q/PQLuH6UyG0YnedZWh5h6MBMCBCgPiMy98JkAnGrahqr9iOI
         W6H7Vmcsz7u/L9FZCalVmrclANzijhyoBrMyy6LoFEi7Z5AYp23KG2uG5SOqIEw15dbn
         wU8tWUuYHZCg+F+MLkSNNLRVtegEQ/7ThmdneQAV+Bh+mfFmGc0CRtgst6XOmMLmaT+f
         YMax0M2s4W5zQVTtC/RKrQ59Z3nXE8Rx2dtDdR+rtq2pcN9nFFOnUZt7RVXy5mJIb+vv
         zleQ==
X-Gm-Message-State: APjAAAXuVrJuezIPaMnb2DY6DpY6i9CQ9HAnwsrj5BSR8Y+2sFU1mv92
        bffTJ9A0ZIxrdKyKeG4ZG/gJWmeSrUgiDR0ub2BZSA==
X-Google-Smtp-Source: APXvYqxRKjpEXDQzF8INXG/tzSx8jfjbl5+z4SFOuPDNtfo5hjLjm2JWL1VcJkUYBOVA3wI4sOu+WDGQ9DC4c5N89dQ=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr3131015oti.191.1572543332745;
 Thu, 31 Oct 2019 10:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191019170141.GQ18794@devbig004.ftw2.facebook.com> <20191024205027.GF3622521@devbig004.ftw2.facebook.com>
In-Reply-To: <20191024205027.GF3622521@devbig004.ftw2.facebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 31 Oct 2019 10:35:21 -0700
Message-ID: <CALvZod6=B-gMJJxhMRt6k5eRwB-3zdgJR5419orTq8-+36wbMQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: fix sk_page_frag() recursion from memory reclaim
To:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Michal Hocko

On Thu, Oct 24, 2019 at 1:50 PM Tejun Heo <tj@kernel.org> wrote:
>
> sk_page_frag() optimizes skb_frag allocations by using per-task
> skb_frag cache when it knows it's the only user.  The condition is
> determined by seeing whether the socket allocation mask allows
> blocking - if the allocation may block, it obviously owns the task's
> context and ergo exclusively owns current->task_frag.
>
> Unfortunately, this misses recursion through memory reclaim path.
> Please take a look at the following backtrace.
>
>  [2] RIP: 0010:tcp_sendmsg_locked+0xccf/0xe10
>      ...
>      tcp_sendmsg+0x27/0x40
>      sock_sendmsg+0x30/0x40
>      sock_xmit.isra.24+0xa1/0x170 [nbd]
>      nbd_send_cmd+0x1d2/0x690 [nbd]
>      nbd_queue_rq+0x1b5/0x3b0 [nbd]
>      __blk_mq_try_issue_directly+0x108/0x1b0
>      blk_mq_request_issue_directly+0xbd/0xe0
>      blk_mq_try_issue_list_directly+0x41/0xb0
>      blk_mq_sched_insert_requests+0xa2/0xe0
>      blk_mq_flush_plug_list+0x205/0x2a0
>      blk_flush_plug_list+0xc3/0xf0
>  [1] blk_finish_plug+0x21/0x2e
>      _xfs_buf_ioapply+0x313/0x460
>      __xfs_buf_submit+0x67/0x220
>      xfs_buf_read_map+0x113/0x1a0
>      xfs_trans_read_buf_map+0xbf/0x330
>      xfs_btree_read_buf_block.constprop.42+0x95/0xd0
>      xfs_btree_lookup_get_block+0x95/0x170
>      xfs_btree_lookup+0xcc/0x470
>      xfs_bmap_del_extent_real+0x254/0x9a0
>      __xfs_bunmapi+0x45c/0xab0
>      xfs_bunmapi+0x15/0x30
>      xfs_itruncate_extents_flags+0xca/0x250
>      xfs_free_eofblocks+0x181/0x1e0
>      xfs_fs_destroy_inode+0xa8/0x1b0
>      destroy_inode+0x38/0x70
>      dispose_list+0x35/0x50
>      prune_icache_sb+0x52/0x70
>      super_cache_scan+0x120/0x1a0
>      do_shrink_slab+0x120/0x290
>      shrink_slab+0x216/0x2b0
>      shrink_node+0x1b6/0x4a0
>      do_try_to_free_pages+0xc6/0x370
>      try_to_free_mem_cgroup_pages+0xe3/0x1e0
>      try_charge+0x29e/0x790
>      mem_cgroup_charge_skmem+0x6a/0x100
>      __sk_mem_raise_allocated+0x18e/0x390
>      __sk_mem_schedule+0x2a/0x40
>  [0] tcp_sendmsg_locked+0x8eb/0xe10
>      tcp_sendmsg+0x27/0x40
>      sock_sendmsg+0x30/0x40
>      ___sys_sendmsg+0x26d/0x2b0
>      __sys_sendmsg+0x57/0xa0
>      do_syscall_64+0x42/0x100
>      entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> In [0], tcp_send_msg_locked() was using current->page_frag when it
> called sk_wmem_schedule().  It already calculated how many bytes can
> be fit into current->page_frag.  Due to memory pressure,
> sk_wmem_schedule() called into memory reclaim path which called into
> xfs and then IO issue path.  Because the filesystem in question is
> backed by nbd, the control goes back into the tcp layer - back into
> tcp_sendmsg_locked().
>
> nbd sets sk_allocation to (GFP_NOIO | __GFP_MEMALLOC) which makes
> sense - it's in the process of freeing memory and wants to be able to,
> e.g., drop clean pages to make forward progress.  However, this
> confused sk_page_frag() called from [2].  Because it only tests
> whether the allocation allows blocking which it does, it now thinks
> current->page_frag can be used again although it already was being
> used in [0].
>
> After [2] used current->page_frag, the offset would be increased by
> the used amount.  When the control returns to [0],
> current->page_frag's offset is increased and the previously calculated
> number of bytes now may overrun the end of allocated memory leading to
> silent memory corruptions.
>
> Fix it by adding gfpflags_normal_context() which tests sleepable &&
> !reclaim and use it to determine whether to use current->task_frag.
>
> v2: Eric didn't like gfp flags being tested twice.  Introduce a new
>     helper gfpflags_normal_context() and combine the two tests.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  include/linux/gfp.h |   23 +++++++++++++++++++++++
>  include/net/sock.h  |   11 ++++++++---
>  2 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index fb07b503dc45..61f2f6ff9467 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -325,6 +325,29 @@ static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
>         return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
>  }
>
> +/**
> + * gfpflags_normal_context - is gfp_flags a normal sleepable context?
> + * @gfp_flags: gfp_flags to test
> + *
> + * Test whether @gfp_flags indicates that the allocation is from the
> + * %current context and allowed to sleep.
> + *
> + * An allocation being allowed to block doesn't mean it owns the %current
> + * context.  When direct reclaim path tries to allocate memory, the
> + * allocation context is nested inside whatever %current was doing at the
> + * time of the original allocation.  The nested allocation may be allowed
> + * to block but modifying anything %current owns can corrupt the outer
> + * context's expectations.
> + *
> + * %true result from this function indicates that the allocation context
> + * can sleep and use anything that's associated with %current.
> + */
> +static inline bool gfpflags_normal_context(const gfp_t gfp_flags)
> +{
> +       return (gfp_flags & (__GFP_DIRECT_RECLAIM | __GFP_MEMALLOC)) ==
> +               __GFP_DIRECT_RECLAIM;

I think we should be checking PF_MEMALLOC here instead. Something like:

return gfpflags_allow_blocking(gfp_flags) && !(current->flags & PF_MEMALLOC);

In my limited understanding, __GFP_MEMALLOC gives access to reserve
but we have overloaded PF_MEMALLOC to also define the reclaim context.
There are PF_MEMALLOC users which does not use __GFP_MEMALLOC like
iscsi_sw_tcp_pdu_xmit() which can call sock_sendmsg().


> +}
> +
>  #ifdef CONFIG_HIGHMEM
>  #define OPT_ZONE_HIGHMEM ZONE_HIGHMEM
>  #else
> diff --git a/include/net/sock.h b/include/net/sock.h
> index f69b58bff7e5..c31a9ed86d5a 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2242,12 +2242,17 @@ struct sk_buff *sk_stream_alloc_skb(struct sock *sk, int size, gfp_t gfp,
>   * sk_page_frag - return an appropriate page_frag
>   * @sk: socket
>   *
> - * If socket allocation mode allows current thread to sleep, it means its
> - * safe to use the per task page_frag instead of the per socket one.
> + * Use the per task page_frag instead of the per socket one for
> + * optimization when we know that we're in the normal context and owns
> + * everything that's associated with %current.
> + *
> + * gfpflags_allow_blocking() isn't enough here as direct reclaim may nest
> + * inside other socket operations and end up recursing into sk_page_frag()
> + * while it's already in use.
>   */
>  static inline struct page_frag *sk_page_frag(struct sock *sk)
>  {
> -       if (gfpflags_allow_blocking(sk->sk_allocation))
> +       if (gfpflags_normal_context(sk->sk_allocation))
>                 return &current->task_frag;
>
>         return &sk->sk_frag;
