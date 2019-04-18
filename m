Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16333C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16D42083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PKLIIu/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389189AbfDROFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:05:37 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45318 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388392AbfDROFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:05:37 -0400
Received: by mail-yb1-f193.google.com with SMTP id b18so865282yba.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxZOPtOiRntngjfC1zUz7S6vThNcfbNwqp8rwY4BU+o=;
        b=PKLIIu/2p1mf1PwPOq/Dq4fgAcfc8HRGD9pYpQXnNgCf9RbbH0YRWi21j0rUDYr5wQ
         Eob7OjAetNA6zLyyXYPOL0nUEo98qJwiD3yTkPG/k5nGP6SimBhHkWL+LlSa6bnTTLo4
         GMxZZ/n2prtENzG93LCA1AE7rm0kn1+PyjMbZ5FAPSjbKY9CemkZ6yBzoJtz9ke26xjy
         iKnQP2356YiuOQxUNHDA5OeSj/ioRpaHWQCYsuEWVpL9SiId0bpGAb/Te1mqcI9aIPrj
         fu7IlcI8zKJ0kSR2a3dvrD3Mn9XC32xKmal7fY0PNo/p/vqCij5V1Mgnpw+aX+AnLUzk
         yhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxZOPtOiRntngjfC1zUz7S6vThNcfbNwqp8rwY4BU+o=;
        b=nHZR1aCRB9mJOfIX/kr8aPSjyqZF+VwgSQbZgYjCnKCDyNIR4rlwXPjwClVA8JkzOZ
         ayP8okLV1dzgyMxGQVLn5Hz7ZjXT5pXSSZK0J34CLghV7AOhe33mNvGeTRv1luKxfjxc
         ej4lI9QcVzVdZ2btfZGMpacRqt27/KjHUy1xKOxiiT7R7pyiqXDEQ5JS0UuWHFiFsyM/
         nsihpp9pctYNUv9I3t4Wi41HXxm7GQGr64pz7Jk+oUYMQykEPcyJC6jECYlYVMHH7Y3a
         FMHYmbTxmtnBwWhtvKQ+9amztEQjLpSjAATyNG7bKE+Jph3qBFyJUtZ7yzSQu6x8+ZvR
         woeA==
X-Gm-Message-State: APjAAAU6NJ+HS8DCniFHiRJzKGM+bX0V/fV6tA558FXl+qYkG6OumsY9
        XN2pq3zyiX+aSZZkaydKMhhus2fc4gYi8hqhPf/sRQ==
X-Google-Smtp-Source: APXvYqxVayXWw+tHK7hWSvZynRaOADWkL/7dyCgTmVc6P5Equy80JD+hVLds59IhUiVRwpl/bfjKkWQKxUgeKU9O4w0=
X-Received: by 2002:a25:ac41:: with SMTP id r1mr10138415ybd.377.1555596335704;
 Thu, 18 Apr 2019 07:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190417215434.25897-1-guro@fb.com> <20190417215434.25897-5-guro@fb.com>
 <CALvZod5K8SM2EQFH1WM9bbwWBtyXWb_PvzJGvF5dg1Z=bdR7zg@mail.gmail.com>
 <20190418003850.GA13977@tower.DHCP.thefacebook.com> <CALvZod6UiTeN40RgpE-4zE5zagSifqh3o_AXaw8o-ubVUWf=4w@mail.gmail.com>
 <20190418030729.GA5038@castle>
In-Reply-To: <20190418030729.GA5038@castle>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 18 Apr 2019 07:05:24 -0700
Message-ID: <CALvZod4K9HymKkG9hGoU-sFxZogqP+wrBRD9AighvfUzDGoTFQ@mail.gmail.com>
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

On Wed, Apr 17, 2019 at 8:07 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Apr 17, 2019 at 06:55:12PM -0700, Shakeel Butt wrote:
> > On Wed, Apr 17, 2019 at 5:39 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Wed, Apr 17, 2019 at 04:41:01PM -0700, Shakeel Butt wrote:
> > > > On Wed, Apr 17, 2019 at 2:55 PM Roman Gushchin <guroan@gmail.com> wrote:
> > > > >
> > > > > This commit makes several important changes in the lifecycle
> > > > > of a non-root kmem_cache, which also affect the lifecycle
> > > > > of a memory cgroup.
> > > > >
> > > > > Currently each charged slab page has a page->mem_cgroup pointer
> > > > > to the memory cgroup and holds a reference to it.
> > > > > Kmem_caches are held by the cgroup. On offlining empty kmem_caches
> > > > > are freed, all other are freed on cgroup release.
> > > >
> > > > No, they are not freed (i.e. destroyed) on offlining, only
> > > > deactivated. All memcg kmem_caches are freed/destroyed on memcg's
> > > > css_free.
> > >
> > > You're right, my bad. I was thinking about the corresponding sysfs entry
> > > when was writing it. We try to free it from the deactivation path too.
> > >
> > > >
> > > > >
> > > > > So the current scheme can be illustrated as:
> > > > > page->mem_cgroup->kmem_cache.
> > > > >
> > > > > To implement the slab memory reparenting we need to invert the scheme
> > > > > into: page->kmem_cache->mem_cgroup.
> > > > >
> > > > > Let's make every page to hold a reference to the kmem_cache (we
> > > > > already have a stable pointer), and make kmem_caches to hold a single
> > > > > reference to the memory cgroup.
> > > >
> > > > What about memcg_kmem_get_cache()? That function assumes that by
> > > > taking reference on memcg, it's kmem_caches will stay. I think you
> > > > need to get reference on the kmem_cache in memcg_kmem_get_cache()
> > > > within the rcu lock where you get the memcg through css_tryget_online.
> > >
> > > Yeah, a very good question.
> > >
> > > I believe it's safe because css_tryget_online() guarantees that
> > > the cgroup is online and won't go offline before css_free() in
> > > slab_post_alloc_hook(). I do initialize kmem_cache's refcount to 1
> > > and drop it on offlining, so it protects the online kmem_cache.
> > >
> >
> > Let's suppose a thread doing a remote charging calls
> > memcg_kmem_get_cache() and gets an empty kmem_cache of the remote
> > memcg having refcnt equal to 1. That thread got a reference on the
> > remote memcg but no reference on the kmem_cache. Let's suppose that
> > thread got stuck in the reclaim and scheduled away. In the meantime
> > that remote memcg got offlined and decremented the refcnt of all of
> > its kmem_caches. The empty kmem_cache which the thread stuck in
> > reclaim have pointer to can get deleted and may be using an already
> > destroyed kmem_cache after coming back from reclaim.
> >
> > I think the above situation is possible unless the thread gets the
> > reference on the kmem_cache in memcg_kmem_get_cache().
>
> Yes, you're right and I'm writing a nonsense: css_tryget_online()
> can't prevent the cgroup from being offlined.
>

The reason I knew about that race is because I tried something similar
but for different use-case:

https://lkml.org/lkml/2018/3/26/472

> So, the problem with getting a reference in memcg_kmem_get_cache()
> is that it's an atomic operation on the hot path, something I'd like
> to avoid.
>
> I can make the refcounter percpu, but it'll add some complexity and size
> to the kmem_cache object. Still an option, of course.
>

I kind of prefer this option.

> I wonder if we can use rcu_read_lock() instead, and bump the refcounter
> only if we're going into reclaim.
>
> What do you think?

Should it be just reclaim or anything that can reschedule the current thread?

I can tell how we resolve the similar issue for our
eager-kmem_cache-deletion use-case. Our solution (hack) works only for
CONFIG_SLAB (we only use SLAB) and non-preemptible kernel. The
underlying motivation was to reduce the overhead of slab reaper of
traversing thousands of empty offlined kmem caches. CONFIG_SLAB
disables interrupts before accessing the per-cpu caches and reenables
the interrupts if it has to fallback to the page allocation. We use
this window to call memcg_kmem_get_cache() and only increment the
refcnt of kmem_cache if going to the fallback. Thus no need to do
atomic operation on the hot path.

Anyways, I think having percpu refcounter for each memcg kmem_cache is
not that costy for CONFIG_MEMCG_KMEM users and to me that seems like
the most simple solution.

Shakeel
