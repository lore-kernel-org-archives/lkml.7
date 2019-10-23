Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1144EC47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD0920B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I65uEKOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbfJWAI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 20:08:28 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45967 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfJWAI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:08:28 -0400
Received: by mail-yw1-f67.google.com with SMTP id x65so6853247ywf.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 17:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwswcDh5bJ2bT2C14GST9xfOvFECPkeSkCMn/Gf+Iag=;
        b=I65uEKOP1nbsrV1NBkO4Is/QD8xWqYkYP+7YR78ahSMhdSLdutBNFrrAGINV5xwia9
         hcYOWYimdjD+ZqSlGvlHABBtfxvyZrSRk660wM6yIqABizn99/xaGQJxYJFoT82vZHu1
         1AHmCnZZXgP3oAErl7Uiwq8lFYPWjX6t9a6YvLrDoe7FeAmcKpkt61zq1FhxrUZeYLJv
         +FVDY0zAmXNXM/W6Z+gMMkPirS1LKZY4eLc2+26ez0k/jM1Ao/zcPifBZHOc6U+Ks1zY
         9vfRuBnkZinVPuSNZjtRkgw3EdM90ULjEjcdrXCtc5U6CqJ/GnzPWFQD3OyZ8vbH3E9i
         TpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwswcDh5bJ2bT2C14GST9xfOvFECPkeSkCMn/Gf+Iag=;
        b=GlvxuHfQUN0/7kEF0zgOCRCLeESueSXN/7zTzwQy9irQK57nQkMGLzbVFBXSuuEFf9
         jeBa3FP5tSLLpuMNOFzZggururS9qazLEx32iP680nhNeznodstqezb7I2KIbIxq57Gl
         E+aedjrPNkDrcbHYDen8sWkLzBxzvSa7r/ELeatQwywvM9XlghHGpV2lyUNdKamkdynj
         ixgfGZkt3SFOQtcUui8EI9/NBPfkJ5B6eyCUY0Ltg+U8O/aKj3K62JiwzY+czSf624cd
         Ip4AszwPhxLG6zYRQz0vpF7psFa6l9y3nW6HpXW2QUNlue7FevRckdDmTtyw9KBfOtad
         y5CA==
X-Gm-Message-State: APjAAAUH0lrdxUgpQt3t7j1YabnjJWnd3OeSOxS53Dzarz+BWs+0Ikzu
        lJdLc+H9kB0YnHmDf9ZvJuTXUGFV8vRbzBHpsdZR5g==
X-Google-Smtp-Source: APXvYqw/vLI4wyle5SOG0ri01u7tHHlrq9svEB89OCfd5IrD54quGW4uI1wIMYXqPmjUV3dn7URF2xqaPTgdPZnWBbg=
X-Received: by 2002:a81:c8c:: with SMTP id 134mr855677ywm.205.1571789307033;
 Tue, 22 Oct 2019 17:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191022233708.365764-1-hannes@cmpxchg.org>
In-Reply-To: <20191022233708.365764-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 22 Oct 2019 17:08:15 -0700
Message-ID: <CALvZod7EPi+vt-C8_uAtzybpnkP_yqvWaO7AJ24K9EkFH3oAJA@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix network errors from failing
 __GFP_ATOMIC charges
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, netdev@vger.kernel.org,
        Kernel Team <kernel-team@fb.com>,
        Suleiman Souhlal <suleiman@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Suleiman Souhlal

On Tue, Oct 22, 2019 at 4:37 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> While upgrading from 4.16 to 5.2, we noticed these allocation errors
> in the log of the new kernel:
>
> [ 8642.253395] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
> [ 8642.269170]   cache: tw_sock_TCPv6(960:helper-logs), object size: 232, buffer size: 240, default order: 1, min order: 0
> [ 8642.293009]   node 0: slabs: 5, objs: 170, free: 0
>
>         slab_out_of_memory+1
>         ___slab_alloc+969
>         __slab_alloc+14
>         kmem_cache_alloc+346
>         inet_twsk_alloc+60
>         tcp_time_wait+46
>         tcp_fin+206
>         tcp_data_queue+2034
>         tcp_rcv_state_process+784
>         tcp_v6_do_rcv+405
>         __release_sock+118
>         tcp_close+385
>         inet_release+46
>         __sock_release+55
>         sock_close+17
>         __fput+170
>         task_work_run+127
>         exit_to_usermode_loop+191
>         do_syscall_64+212
>         entry_SYSCALL_64_after_hwframe+68
>
> accompanied by an increase in machines going completely radio silent
> under memory pressure.
>
> One thing that changed since 4.16 is e699e2c6a654 ("net, mm: account
> sock objects to kmemcg"), which made these slab caches subject to
> cgroup memory accounting and control.
>
> The problem with that is that cgroups, unlike the page allocator, do
> not maintain dedicated atomic reserves. As a cgroup's usage hovers at
> its limit, atomic allocations - such as done during network rx - can
> fail consistently for extended periods of time. The kernel is not able
> to operate under these conditions.
>
> We don't want to revert the culprit patch, because it indeed tracks a
> potentially substantial amount of memory used by a cgroup.
>
> We also don't want to implement dedicated atomic reserves for cgroups.
> There is no point in keeping a fixed margin of unused bytes in the
> cgroup's memory budget to accomodate a consumer that is impossible to
> predict - we'd be wasting memory and get into configuration headaches,
> not unlike what we have going with min_free_kbytes. We do this for
> physical mem because we have to, but cgroups are an accounting game.
>
> Instead, account these privileged allocations to the cgroup, but let
> them bypass the configured limit if they have to. This way, we get the
> benefits of accounting the consumed memory and have it exert pressure
> on the rest of the cgroup, but like with the page allocator, we shift
> the burden of reclaimining on behalf of atomic allocations onto the
> regular allocations that can block.
>
> Cc: stable@kernel.org # 4.18+
> Fixes: e699e2c6a654 ("net, mm: account sock objects to kmemcg")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  mm/memcontrol.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8090b4c99ac7..c7e3e758c165 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2528,6 +2528,15 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>                 goto retry;
>         }
>
> +       /*
> +        * Memcg doesn't have a dedicated reserve for atomic
> +        * allocations. But like the global atomic pool, we need to
> +        * put the burden of reclaim on regular allocation requests
> +        * and let these go through as privileged allocations.
> +        */
> +       if (gfp_mask & __GFP_ATOMIC)
> +               goto force;
> +

Actually we (Google) already have a similar internal patch where we
check for __GFP_HIGH and then go for force charging with similar
reasoning.

>         /*
>          * Unlike in global OOM situations, memcg is not in a physical
>          * memory shortage.  Allow dying and OOM-killed tasks to
> --
> 2.23.0
>
