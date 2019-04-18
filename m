Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E18C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DAD218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWEA3zXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbfDRBzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 21:55:25 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38452 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730037AbfDRBzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 21:55:24 -0400
Received: by mail-yb1-f194.google.com with SMTP id w206so296783ybg.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 18:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCQ+0ux3f2lhz2JQz+sODUn7gTy6oTF+cvFWZuiFK1k=;
        b=lWEA3zXd1uUNwv1sfs/UBAcFEGV7gzD1mipY5IZjzjsWevuBoSGre2ffvv0LXhiX4/
         il0RgAxHngPy2TypBkVVpVhebvUuicEOsLe69KHZgTg2Zena0Fg5SHPJGeGcJUlix0KX
         weKb4jER8526L50m+2MUd9bNeIw/1seMQ5k/0Z9qBKWVfB5W7YQF7LwAeFzykqOcPsyl
         2EEp3IbR6TfHeeiJW5IAuOiQa+KVTjR9+cqCX6OraglnF6lFsaoXFgMyDt6OtNR3uKYk
         0WCmXgoVwQMwrGnETEOjRHfIB7v11L7+Pesh8yrqNVI1oU/z4JfX2WzzMZLRH801nTP+
         3YwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCQ+0ux3f2lhz2JQz+sODUn7gTy6oTF+cvFWZuiFK1k=;
        b=IkyEUUFBSgz1JVUpyUq3OevxYwijOpr5koEdK/4mHeElNKOTzhMsNso761YElsvWRC
         CWc4jMSIareYHS4H2OlfhqWXO1LZeez15veaRbDoKJuPauB/cWyZd4i46hLeaZ6M1Z6w
         dlGy6FQ6yIyksDsnJ32mBBSPmRUUOT84E5YzMFU7DLuHgOeR8HdoVa9ta6HO73eEuAmT
         rohuWm37SH9dTy9qS1zfOBz8HKjZqw9ZZnge8pM0a4q40GNuD9OzqfS3NBNF6giPWhhG
         byK+Rh3SMA8gvygCQtYvt80kMLrI2XxNyXqUtPsxEXGefTx0YsSawmdi0PsgpPnecGP8
         eG7Q==
X-Gm-Message-State: APjAAAWeJA7jHfb86xlL6SykAIGmw/LKINBqygSBmOIbjz5cte8O3ig/
        20IWVr8h+11KPRYt4h2VLXDw0VYUi/+5Rm/OPQ7t0A==
X-Google-Smtp-Source: APXvYqyG3Qa/sADVmtgfR8FKB8zQ5pNAcFMTM0KK3pvwUWD2+SmxAIyLgj1W5jy5fx0yF+lk8/gSatle6wvaeXaR8H8=
X-Received: by 2002:a25:2bc4:: with SMTP id r187mr52894861ybr.150.1555552523533;
 Wed, 17 Apr 2019 18:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190417215434.25897-1-guro@fb.com> <20190417215434.25897-5-guro@fb.com>
 <CALvZod5K8SM2EQFH1WM9bbwWBtyXWb_PvzJGvF5dg1Z=bdR7zg@mail.gmail.com> <20190418003850.GA13977@tower.DHCP.thefacebook.com>
In-Reply-To: <20190418003850.GA13977@tower.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 17 Apr 2019 18:55:12 -0700
Message-ID: <CALvZod6UiTeN40RgpE-4zE5zagSifqh3o_AXaw8o-ubVUWf=4w@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: rework non-root kmem_cache lifecycle management
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 5:39 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Apr 17, 2019 at 04:41:01PM -0700, Shakeel Butt wrote:
> > On Wed, Apr 17, 2019 at 2:55 PM Roman Gushchin <guroan@gmail.com> wrote:
> > >
> > > This commit makes several important changes in the lifecycle
> > > of a non-root kmem_cache, which also affect the lifecycle
> > > of a memory cgroup.
> > >
> > > Currently each charged slab page has a page->mem_cgroup pointer
> > > to the memory cgroup and holds a reference to it.
> > > Kmem_caches are held by the cgroup. On offlining empty kmem_caches
> > > are freed, all other are freed on cgroup release.
> >
> > No, they are not freed (i.e. destroyed) on offlining, only
> > deactivated. All memcg kmem_caches are freed/destroyed on memcg's
> > css_free.
>
> You're right, my bad. I was thinking about the corresponding sysfs entry
> when was writing it. We try to free it from the deactivation path too.
>
> >
> > >
> > > So the current scheme can be illustrated as:
> > > page->mem_cgroup->kmem_cache.
> > >
> > > To implement the slab memory reparenting we need to invert the scheme
> > > into: page->kmem_cache->mem_cgroup.
> > >
> > > Let's make every page to hold a reference to the kmem_cache (we
> > > already have a stable pointer), and make kmem_caches to hold a single
> > > reference to the memory cgroup.
> >
> > What about memcg_kmem_get_cache()? That function assumes that by
> > taking reference on memcg, it's kmem_caches will stay. I think you
> > need to get reference on the kmem_cache in memcg_kmem_get_cache()
> > within the rcu lock where you get the memcg through css_tryget_online.
>
> Yeah, a very good question.
>
> I believe it's safe because css_tryget_online() guarantees that
> the cgroup is online and won't go offline before css_free() in
> slab_post_alloc_hook(). I do initialize kmem_cache's refcount to 1
> and drop it on offlining, so it protects the online kmem_cache.
>

Let's suppose a thread doing a remote charging calls
memcg_kmem_get_cache() and gets an empty kmem_cache of the remote
memcg having refcnt equal to 1. That thread got a reference on the
remote memcg but no reference on the kmem_cache. Let's suppose that
thread got stuck in the reclaim and scheduled away. In the meantime
that remote memcg got offlined and decremented the refcnt of all of
its kmem_caches. The empty kmem_cache which the thread stuck in
reclaim have pointer to can get deleted and may be using an already
destroyed kmem_cache after coming back from reclaim.

I think the above situation is possible unless the thread gets the
reference on the kmem_cache in memcg_kmem_get_cache().

Shakeel
