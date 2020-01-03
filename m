Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998ABC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A0A215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="otHt/I+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgACT3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 14:29:08 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35051 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbgACT3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:29:08 -0500
Received: by mail-pj1-f68.google.com with SMTP id s7so5088275pjc.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 11:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xiCyHmcnUXsbcQ7aHolyREhLRtQlcm0tNcQpv0xj54g=;
        b=otHt/I+pw8YEKdneORJaQbqVOMxTvFzuxsTLLo7ZOfnkm7+sA/s/x+b5ZiwnwdyNsM
         mfRl/YbfDdxHzR2Rfe0dAizN3JrCsQ76Os4SjYyo9S1ECVmqUOML8K8S/YBi5lHfUumH
         I5sRO4W4LYYWzpp+g2tfXYM8x+1i2fRx+TVLGkGcDO7rAoq4BzN5giqoCdnq10C+hw+o
         NVmD4trJFm7qSbm58YTvtBPmdSOVfFH9OlPvaUYGTkLBuR4W1QJa14C5GlU267SLGDIk
         nJvj1z52hjwCB/qZkkakQbkJqE7ovBP/lPjUGrjm7HuF9J8UTNwBPO9jMGL9+KBvpBx7
         97Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xiCyHmcnUXsbcQ7aHolyREhLRtQlcm0tNcQpv0xj54g=;
        b=MWNzux7wlrk18UBmFnJmL8f0J+AuS27G9rux8MeHKu4omoQ6IOct7Z8AsNUtBjHevk
         /9aJvD4wz+36mevgE6GFzWgAm+J9Nor1+eM84ZbQAwFj2vj1zxWitplyb7KLn+mE3uGa
         9L6DpewpTXdzcQNTX8LrUxTnx40MMZvnw97s4SBGTl0BI44jU9jNu1wSe9SBRVa/h7Wu
         3KttIU6VIQoES+ib2vXujRMJoiPaQUh+k7Wpma3pRnMpB1lTEk+dZp4NZCeKw37hZdrv
         vpa4ioWFc7s8/+/F4twpnSCi9Ey5JFfM9ra0k1zlmoSUzsr6TKiCQ40QHBRPzA6f2omW
         h1tQ==
X-Gm-Message-State: APjAAAWRm4iMujlFvS0T6Dp6+ykarr6xm68SmcJQRMho2RB9vwUgh5PS
        dXIlX2R7AE2upoUhre/4HA/Olg==
X-Google-Smtp-Source: APXvYqwNpsVSpllqMOsBw0KVEfj6ixi9vpK94YoxKUCK8BvVN+K2rt+0zmH9iLuSgofxUQodtrJbFA==
X-Received: by 2002:a17:902:9a42:: with SMTP id x2mr15707448plv.194.1578079747357;
        Fri, 03 Jan 2020 11:29:07 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u23sm68353574pfm.29.2020.01.03.11.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 11:29:06 -0800 (PST)
Date:   Fri, 3 Jan 2020 11:29:06 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer
 list
In-Reply-To: <20200103143407.1089-1-richardw.yang@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2001031128200.160920@chino.kir.corp.google.com>
References: <20200103143407.1089-1-richardw.yang@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2020, Wei Yang wrote:

> As all the other places, we grab the lock before manipulate the defer list.
> Current implementation may face a race condition.
> 
> Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> 
> ---
> I notice the difference during code reading and just confused about the
> difference. No specific test is done since limited knowledge about cgroup.
> 
> Maybe I miss something important?

The check for !list_empty(page_deferred_list(page)) must certainly be 
serialized with doing list_del_init(page_deferred_list(page)).

> ---
>  mm/memcontrol.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index bc01423277c5..62b7ec34ef1a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5368,12 +5368,12 @@ static int mem_cgroup_move_account(struct page *page,
>  	}
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	spin_lock(&from->deferred_split_queue.split_queue_lock);
>  	if (compound && !list_empty(page_deferred_list(page))) {
> -		spin_lock(&from->deferred_split_queue.split_queue_lock);
>  		list_del_init(page_deferred_list(page));
>  		from->deferred_split_queue.split_queue_len--;
> -		spin_unlock(&from->deferred_split_queue.split_queue_lock);
>  	}
> +	spin_unlock(&from->deferred_split_queue.split_queue_lock);
>  #endif
>  	/*
>  	 * It is safe to change page->mem_cgroup here because the page
> @@ -5385,13 +5385,13 @@ static int mem_cgroup_move_account(struct page *page,
>  	page->mem_cgroup = to;
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	spin_lock(&to->deferred_split_queue.split_queue_lock);
>  	if (compound && list_empty(page_deferred_list(page))) {
> -		spin_lock(&to->deferred_split_queue.split_queue_lock);
>  		list_add_tail(page_deferred_list(page),
>  			      &to->deferred_split_queue.split_queue);
>  		to->deferred_split_queue.split_queue_len++;
> -		spin_unlock(&to->deferred_split_queue.split_queue_lock);
>  	}
> +	spin_unlock(&to->deferred_split_queue.split_queue_lock);
>  #endif
>  
>  	spin_unlock_irqrestore(&from->move_lock, flags);
> -- 
> 2.17.1
> 
> 
> 
