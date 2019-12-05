Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2435FC2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D784920707
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575546327;
	bh=30ZPV1fASogj5+7JQkC1ZJacf2HKDL4phV1nh3+N940=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iLXDUvR2PnT1o3gsMQ88ulpYwhNOg9qs72j4au7ZwKdLlSQOltE5/cQY/IqjetOy1
	 nPtZ4pFUR8Je4uu8nFkntL/ikna8rGVlfSMKqZP1lJAVHLPKbmcc4hxmSTIzw3bZ0f
	 DdFbH/93gXkyrw3Xr2brL2JIy75gXUuwejGYTj1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfLELp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 06:45:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40216 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfLELpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 06:45:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so3283870wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 03:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FqjNTT6coY6lOQrNhqII9hKDdSPswnOtW3O4CX9UYzE=;
        b=q2Ww6Z7gjGN8htEg5w1CGAn/sweIJySn37oD/ASo6A+eUo5ReGI6BJQKDs/qJl1qzk
         6n3bVR2HrUcLUXjWPKgwu2otklui8AT9LqlzlSCZ0oh6tGFoWPZzy+FFsZ4lM+vbbuQY
         64n+VcZ2mRoEfXznF5pkel8NE7YttUA00B0iyWX0JfnVx7TWiBTakLeGHBpx+tY9Y2xn
         HaWQG5QNa98n1Qqx8jWtl31QTac4CJh7V1cgwO8U9ZLN6R3NjV6025pzq//6aYMISw6+
         cG7pAsdvC9vrGGA5253nQX5l+gK6QYZOqyN+Rk/d9QukLCEH5KV/ZFoZEn/uo6Mqi9X3
         rVrQ==
X-Gm-Message-State: APjAAAUglRJeOeUbGyWLNxNwtmUv/iHWUrEGA0Io3h2+YXsQLFxs9H3m
        IYcl65Ucji7Q3v1HjBpEu5Q=
X-Google-Smtp-Source: APXvYqypYEtsGbwttnIbAz/amuCFqz2KBFl3pQq5IOrM218QwbC7Xmj0DinQhJ1Qh+hUdMUhDXKgmg==
X-Received: by 2002:a1c:c90e:: with SMTP id f14mr4794615wmb.35.1575546322970;
        Thu, 05 Dec 2019 03:45:22 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id i10sm12343249wru.16.2019.12.05.03.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 03:45:22 -0800 (PST)
Date:   Thu, 5 Dec 2019 12:45:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, hannes@cmpxchg.org,
        shakeelb@google.com, guro@fb.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: protect shrinker idr replace with
 CONFIG_MEMCG
Message-ID: <20191205114521.GF28317@dhcp22.suse.cz>
References: <1575486978-45249-1-git-send-email-yang.shi@linux.alibaba.com>
 <e320f8af-c164-ce5e-8964-8785b0bf5f2e@virtuozzo.com>
 <20191205094341.GC28317@dhcp22.suse.cz>
 <894b9951-449d-6d7e-84aa-a1c510417710@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <894b9951-449d-6d7e-84aa-a1c510417710@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-12-19 13:00:31, Kirill Tkhai wrote:
> On 05.12.2019 12:43, Michal Hocko wrote:
> > On Thu 05-12-19 11:23:28, Kirill Tkhai wrote:
> >> On 04.12.2019 22:16, Yang Shi wrote:
> >>> Since commit 0a432dcbeb32edcd211a5d8f7847d0da7642a8b4 ("mm: shrinker:
> >>> make shrinker not depend on memcg kmem"), shrinkers' idr is protected by
> >>> CONFIG_MEMCG instead of CONFIG_MEMCG_KMEM, so it makes no sense to
> >>> protect shrinker idr replace with CONFIG_MEMCG_KMEM.
> >>>
> >>> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> >>> Cc: Johannes Weiner <hannes@cmpxchg.org>
> >>> Cc: Michal Hocko <mhocko@suse.com>
> >>> Cc: Shakeel Butt <shakeelb@google.com>
> >>> Cc: Roman Gushchin <guro@fb.com>
> >>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> >>
> >> It looks like that in CONFIG_SLOB case we do not even call some shrinkers
> >> for subordinate mem cgroups (i.e., we don't call deferred_split_shrinker),
> >> since they never become completely registered.
> >>
> >> Fixes: 0a432dcbeb32edcd211a5d8f7847d0da7642a8b4 ("mm: shrinker: make shrinker not depend on memcg kmem")
> > 
> > I am confused. Why the Fixes tag? Nothing should be really broken with
> > KMEM config guard right?
> 
> idr_replace() is disabled in CONFIG_MEMCG && CONFIG_SLOB case, and this is
> wrong.
> 
> 0a432dcbeb32edcd211a5d8f7847d0da7642a8b4 goes in the series, which enables
> shrinker_idr infrastructure for huge_memory.c's deferred_split_shrinker
> in CONFIG_MEMCG case. Previously, all SHRINKER_MEMCG_AWARE shrinkers were
> based on LRUs, and they remain to base of CONFIG_MEMCG_KMEM.
> But deferred_split_shrinker is an exception.
> 
> In CONFIG_MEMCG && CONFIG_SLOB case, shrinker_idr contains only shrinker,
> and it is deferred_split_shrinker. But it is never actually called, since
> idr_replace() is never compiled. deferred_split_shrinker all the time is
> staying in half-registered state, and it's never called for subordinate
> mem cgroups.
> 
> So, this is a BUG, and this should go to stable.

OK, I see. The changelog should describe all that. Thanks for the
clarification.

> > This is a mere clean up AFAICS.
> > 
> >> Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> >>
> >>> ---
> >>>  mm/vmscan.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>> index ee4eecc..e7f10c4 100644
> >>> --- a/mm/vmscan.c
> >>> +++ b/mm/vmscan.c
> >>> @@ -422,7 +422,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
> >>>  {
> >>>  	down_write(&shrinker_rwsem);
> >>>  	list_add_tail(&shrinker->list, &shrinker_list);
> >>> -#ifdef CONFIG_MEMCG_KMEM
> >>> +#ifdef CONFIG_MEMCG
> >>>  	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> >>>  		idr_replace(&shrinker_idr, shrinker, shrinker->id);
> >>>  #endif
> >>>
> > 
> 

-- 
Michal Hocko
SUSE Labs
