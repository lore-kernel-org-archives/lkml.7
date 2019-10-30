Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F452CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28279218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="sozm5qle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfJ3Ro6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:44:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35349 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfJ3Ro6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:44:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id h6so3666330qkf.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 10:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A6yVuPB6LXuICIv7poxF2BAaptyD1Hihg4TrEeI9+Jw=;
        b=sozm5qleGziX428szkw/H+7If3/x7loBPpt2oW5IYALdZ5UQ01sEahdB3jplMrxsZP
         8fkP990UWGINNKWje1T4f34YF9bVU4CocJAZRe0X6x9G225pyXyZnEYlJCtSHi60PaGA
         8xaOS1bCBt7dv+wXrcuytT6FOgqh2+DWU2Ib/zQKKFJRs7AN/rfFqn8yG/WuHsy+aqSM
         QOxb3zm841f/ZAP+4vCwBLxyu/4qHsWqYzju81lMDLtfsdk7p56sfVOJmU0IcjFYg4fY
         rFXxUpjxn4seusqGZzzFOSmhawfWX3VxePsC9Z5RLg6BdcH4X2d4YiOBfaIKt+nYFuVl
         Ry1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A6yVuPB6LXuICIv7poxF2BAaptyD1Hihg4TrEeI9+Jw=;
        b=EE5gZPUCeEJZGqRuggK31pJZmqYHDMvvbFSC9N72i6PRWSxOdBZZBHmpUPXzgrdsBZ
         PLDKOUSBnCEbnvh+1TGAbdC5/b0MGoz9UsLZautGERnIj4vFPpETsB2KFP28UvR8BuOA
         pdcX8tsWys9kofAp9cTkhR9I2YMR3d1isNRcDI8Jp0hf+Tvfro8Mnd3EhCsaofLtM1/I
         m/+/7L65ekYx9fbCtXNSvsR7R0gwIRReM+HGGG35vqQpUxT2vy04+Go9r7bBNUsrRh+H
         AKB0d9tCbi+CqV5VklOPdOAr2TBk9iwOI/4t2I5nsfBk2/Pm2U8lAIqoLmKgofpX+Bgz
         vYcw==
X-Gm-Message-State: APjAAAXhLZ1VftkF94vzbYK68BPGGioptXerpywwHnFCWaa0P7kl0QvB
        NK1T6XygFReRVZedj8SbWAaLWg==
X-Google-Smtp-Source: APXvYqxuyncJaALPCXtj3n2azDg0h+QVUSTGonCFW3/bvuRX1ZRhsMSbKmid5pM8JPhvxb2afrYisg==
X-Received: by 2002:a05:620a:12bb:: with SMTP id x27mr1126516qki.459.1572457497275;
        Wed, 30 Oct 2019 10:44:57 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id z17sm614026qtj.95.2019.10.30.10.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 10:44:56 -0700 (PDT)
Date:   Wed, 30 Oct 2019 13:44:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Greg Thelen <gthelen@google.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm: vmscan: memcontrol: remove
 mem_cgroup_select_victim_node()
Message-ID: <20191030174455.GA45135@cmpxchg.org>
References: <20191029234753.224143-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029234753.224143-1-shakeelb@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 04:47:53PM -0700, Shakeel Butt wrote:
> Since commit 1ba6fc9af35b ("mm: vmscan: do not share cgroup iteration
> between reclaimers"), the memcg reclaim does not bail out earlier based
> on sc->nr_reclaimed and will traverse all the nodes. All the reclaimable
> pages of the memcg on all the nodes will be scanned relative to the
> reclaim priority. So, there is no need to maintain state regarding which
> node to start the memcg reclaim from. Also KCSAN complains data races in
> the code maintaining the state.
> 
> This patch effectively reverts the commit 889976dbcb12 ("memcg: reclaim
> memory from nodes in round-robin order") and the commit 453a9bf347f1
> ("memcg: fix numa scan information update to be triggered by memory
> event").
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Reported-by: <syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com>

Excellent, thanks Shakeel!
Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Just a request on this bit:

> @@ -3360,16 +3358,9 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  		.may_unmap = 1,
>  		.may_swap = may_swap,
>  	};
> +	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
>  
>  	set_task_reclaim_state(current, &sc.reclaim_state);
> -	/*
> -	 * Unlike direct reclaim via alloc_pages(), memcg's reclaim doesn't
> -	 * take care of from where we get pages. So the node where we start the
> -	 * scan does not need to be the current node.
> -	 */
> -	nid = mem_cgroup_select_victim_node(memcg);
> -
> -	zonelist = &NODE_DATA(nid)->node_zonelists[ZONELIST_FALLBACK];

This works, but it *is* somewhat fragile if we decide to add bail-out
conditions to reclaim again. And some numa nodes receiving slightly
less pressure than others could be quite tricky to debug.

Can we add a comment here that points out the assumption that the
zonelist walk is comprehensive, and that all nodes receive equal
reclaim pressure?

Also, I think we should use sc.gfp_mask & ~__GFP_THISNODE, so that
allocations with a physical node preference still do node-agnostic
reclaim for the purpose of cgroup accounting.
