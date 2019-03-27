Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2716AC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E749221738
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aaHOcKbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbfC0WaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:30:00 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36592 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbfC0W37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:29:59 -0400
Received: by mail-it1-f194.google.com with SMTP id h9so2917643itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vb2BrBH4oYQzGEnJbFomSh/8BX3FsNmxH+IKvRIF5+g=;
        b=aaHOcKbm5Wc46HDgM0FNGAZSYg9x419T2E4bP/s3ZwTQLA9ox/5uOx2GUg/90BNxUW
         M2CKIwOqOdGMqbRA5XNTOz2kS8EGFKgjQDK1hg7Jd3PcPXTqc6U8nbIweLaYifp0OEeZ
         O9xVFdcDEc6GJDMcS7uAiBs+ciCYga8pyBIUdE0oRC15/Uzh9sOxl3aNDI65KAnA6Lhl
         29F7vhGLOooseb0bAFP1tLmTc8mJ4dDNv3yGDnhNApFuB1df+TWZ6Ni1Tum3JYVMtwuP
         fWN/9v6axFdkX3QeS9QwpCiTnlKk3dSD3dGU0YqoHnYGdkxDPP1zxiG0zBKmrT0oRbH3
         1/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vb2BrBH4oYQzGEnJbFomSh/8BX3FsNmxH+IKvRIF5+g=;
        b=H7oZX+XpQcXnqs0kv6U+aJ/lTGZlFY/f8yMnYK00q2ud88448ouNEq/WmJDgvB+c92
         NdxWzdWqdXOe/Fuh3tjRRdcBN/YKmkO0GmU0VhqeeBWob418jX2dd1mVYVYH+9+zWItQ
         uVPRyjP0OPAa4r73XuKzouAOgA3wa6u/xH17+4P2BzOPlA2CktnBABNEDe6anCvJXcLI
         PFGqQkKLLHYTqafiVRPFMvwBHxij/D2F9GXvpNy41J3JTCwuoJyRfX71zDTkxRE1lbso
         nKOsF2g7Pk6oynqO9V1HlrgKVbEu3Gh4b9XCJZcpebewYJK+ZWIwGIxdFDDYeYaBi1sw
         QgwQ==
X-Gm-Message-State: APjAAAXh+paxDeFo+VZ3QOG6QpZgEpooYAZxX3my07H0K9/+aG5usj3I
        MOGN8G26UjjIGLX8mFCLEQIeyR86HZNWVlXMTm686A==
X-Google-Smtp-Source: APXvYqwbULKznaKem+4hXQUdPX78evLmKmtf4Atst3mQOe19/U0Y/XdBnE+P0iiiSkUWIKDzxNN/KlZIjlos60rc5eM=
X-Received: by 2002:a05:660c:9c3:: with SMTP id i3mr4960093itl.168.1553725798322;
 Wed, 27 Mar 2019 15:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190307165632.35810-1-gthelen@google.com> <20190322181517.GA12378@tower.DHCP.thefacebook.com>
In-Reply-To: <20190322181517.GA12378@tower.DHCP.thefacebook.com>
From:   Greg Thelen <gthelen@google.com>
Date:   Wed, 27 Mar 2019 15:29:47 -0700
Message-ID: <CAHH2K0ZqTXhdA+RSZU0a4kjeJexQ5Kh+rMaspzhMCwjKjJvHug@mail.gmail.com>
Subject: Re: [PATCH] writeback: sum memcg dirty counters as needed
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 11:15 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Mar 07, 2019 at 08:56:32AM -0800, Greg Thelen wrote:
> > Since commit a983b5ebee57 ("mm: memcontrol: fix excessive complexity in
> > memory.stat reporting") memcg dirty and writeback counters are managed
> > as:
> > 1) per-memcg per-cpu values in range of [-32..32]
> > 2) per-memcg atomic counter
> > When a per-cpu counter cannot fit in [-32..32] it's flushed to the
> > atomic.  Stat readers only check the atomic.
> > Thus readers such as balance_dirty_pages() may see a nontrivial error
> > margin: 32 pages per cpu.
> > Assuming 100 cpus:
> >    4k x86 page_size:  13 MiB error per memcg
> >   64k ppc page_size: 200 MiB error per memcg
> > Considering that dirty+writeback are used together for some decisions
> > the errors double.
> >
> > This inaccuracy can lead to undeserved oom kills.  One nasty case is
> > when all per-cpu counters hold positive values offsetting an atomic
> > negative value (i.e. per_cpu[*]=32, atomic=n_cpu*-32).
> > balance_dirty_pages() only consults the atomic and does not consider
> > throttling the next n_cpu*32 dirty pages.  If the file_lru is in the
> > 13..200 MiB range then there's absolutely no dirty throttling, which
> > burdens vmscan with only dirty+writeback pages thus resorting to oom
> > kill.
> >
> > It could be argued that tiny containers are not supported, but it's more
> > subtle.  It's the amount the space available for file lru that matters.
> > If a container has memory.max-200MiB of non reclaimable memory, then it
> > will also suffer such oom kills on a 100 cpu machine.
> >
> > The following test reliably ooms without this patch.  This patch avoids
> > oom kills.
> >
> > ...
> >
> > Make balance_dirty_pages() and wb_over_bg_thresh() work harder to
> > collect exact per memcg counters when a memcg is close to the
> > throttling/writeback threshold.  This avoids the aforementioned oom
> > kills.
> >
> > This does not affect the overhead of memory.stat, which still reads the
> > single atomic counter.
> >
> > Why not use percpu_counter?  memcg already handles cpus going offline,
> > so no need for that overhead from percpu_counter.  And the
> > percpu_counter spinlocks are more heavyweight than is required.
> >
> > It probably also makes sense to include exact dirty and writeback
> > counters in memcg oom reports.  But that is saved for later.
> >
> > Signed-off-by: Greg Thelen <gthelen@google.com>
> > ---
> >  include/linux/memcontrol.h | 33 +++++++++++++++++++++++++--------
> >  mm/memcontrol.c            | 26 ++++++++++++++++++++------
> >  mm/page-writeback.c        | 27 +++++++++++++++++++++------
> >  3 files changed, 66 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 83ae11cbd12c..6a133c90138c 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -573,6 +573,22 @@ static inline unsigned long memcg_page_state(struct mem_cgroup *memcg,
> >       return x;
> >  }
>
> Hi Greg!
>
> Thank you for the patch, definitely a good problem to be fixed!
>
> >
> > +/* idx can be of type enum memcg_stat_item or node_stat_item */
> > +static inline unsigned long
> > +memcg_exact_page_state(struct mem_cgroup *memcg, int idx)
> > +{
> > +     long x = atomic_long_read(&memcg->stat[idx]);
> > +#ifdef CONFIG_SMP
>
> I doubt that this #ifdef is correct without corresponding changes
> in __mod_memcg_state(). As now, we do use per-cpu buffer which spills
> to an atomic value event if !CONFIG_SMP. It's probably something
> that we want to change, but as now, #ifdef CONFIG_SMP should protect
> only "if (x < 0)" part.

Ack.  I'll fix it.

> > +     int cpu;
> > +
> > +     for_each_online_cpu(cpu)
> > +             x += per_cpu_ptr(memcg->stat_cpu, cpu)->count[idx];
> > +     if (x < 0)
> > +             x = 0;
> > +#endif
> > +     return x;
> > +}
>
> Also, isn't it worth it to generalize memcg_page_state() instead?
> By adding an bool exact argument? I believe dirty balance is not
> the only place, where we need a better accuracy.

Nod.  I'll provide a more general version of memcg_page_state().  I'm
testing updated (forthcoming v2) patch set now with feedback from
Andrew and Roman.
