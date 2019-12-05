Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D414AC2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E9E2464E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575539027;
	bh=Syig5wrWKP0Sn3hNKXEWvCZjSSInuJM0x3UjVn5ZGzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MM/VXw261eTXn/unchFQ8lPyEPvn+3qZFu/AieAb973k0Up0CN7YYCSAlzZ/pK0Yd
	 PPoSwqA5RdmMj4RF5yUKhU59RpeZPCjUmkB/6R68vwlGW5x9H1SbBTf/y134bA82oH
	 c6WmoXP0MP4n/ijps0C8DzM9lXD53PhCkK4iQY28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfLEJnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:43:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34931 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfLEJnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:43:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so2686038wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 01:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x2NY4RsN9EIpsZSpxJClccspscZUZls+ET6N9cgE4kc=;
        b=JHRpcgaAXJl8h313Awg0WaISpsF+N9C2KkbwEFDf57NhTIZIn2HDM5MvDpA4C0tHMV
         Gyjr/5605XS8+KEJMUc5GiQLNY/wOAetkVix7JqlhNF8d5Cg880hOoGWMcw7u2MUPrtO
         lEkbXxXjUqNNVgmcOxysxe/9doni4aNVFZFNYCD5gHftOUfeZMkt4grSfVsXRFiyGGti
         fGu0GxMb2WQ8cP9X3T+FbSJ6Gnm0Kc/f1BKun06EecBFaIxaWrVvaBdTnQtFoJCRpq+n
         mENWVlmX7v6uIZnhHRve6+5dqayhtR5oyqRWMqua3dJ4s6b+iiss9RjlWF+/04bf5Whc
         dPLw==
X-Gm-Message-State: APjAAAWUKpbU/9bomZYUy5FzbrFhpLM/GiRvuICX1FnBT8ED5zq1m4IZ
        DUcnAqEFaOYyJmXGqSgPAr8=
X-Google-Smtp-Source: APXvYqwoTreIVWXx2AHtCZXbwx/4wKo9v1WDlJAhlsuvcN/CjfFVnQDFjX0eJwsccVPt4FeM07XHgg==
X-Received: by 2002:adf:8041:: with SMTP id 59mr8603077wrk.257.1575539023465;
        Thu, 05 Dec 2019 01:43:43 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id 72sm12036760wrl.73.2019.12.05.01.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 01:43:42 -0800 (PST)
Date:   Thu, 5 Dec 2019 10:43:41 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, hannes@cmpxchg.org,
        shakeelb@google.com, guro@fb.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: protect shrinker idr replace with
 CONFIG_MEMCG
Message-ID: <20191205094341.GC28317@dhcp22.suse.cz>
References: <1575486978-45249-1-git-send-email-yang.shi@linux.alibaba.com>
 <e320f8af-c164-ce5e-8964-8785b0bf5f2e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e320f8af-c164-ce5e-8964-8785b0bf5f2e@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-12-19 11:23:28, Kirill Tkhai wrote:
> On 04.12.2019 22:16, Yang Shi wrote:
> > Since commit 0a432dcbeb32edcd211a5d8f7847d0da7642a8b4 ("mm: shrinker:
> > make shrinker not depend on memcg kmem"), shrinkers' idr is protected by
> > CONFIG_MEMCG instead of CONFIG_MEMCG_KMEM, so it makes no sense to
> > protect shrinker idr replace with CONFIG_MEMCG_KMEM.
> > 
> > Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: Roman Gushchin <guro@fb.com>
> > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> 
> It looks like that in CONFIG_SLOB case we do not even call some shrinkers
> for subordinate mem cgroups (i.e., we don't call deferred_split_shrinker),
> since they never become completely registered.
> 
> Fixes: 0a432dcbeb32edcd211a5d8f7847d0da7642a8b4 ("mm: shrinker: make shrinker not depend on memcg kmem")

I am confused. Why the Fixes tag? Nothing should be really broken with
KMEM config guard right?

This is a mere clean up AFAICS.

> Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> > ---
> >  mm/vmscan.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index ee4eecc..e7f10c4 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -422,7 +422,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
> >  {
> >  	down_write(&shrinker_rwsem);
> >  	list_add_tail(&shrinker->list, &shrinker_list);
> > -#ifdef CONFIG_MEMCG_KMEM
> > +#ifdef CONFIG_MEMCG
> >  	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> >  		idr_replace(&shrinker_idr, shrinker, shrinker->id);
> >  #endif
> > 

-- 
Michal Hocko
SUSE Labs
