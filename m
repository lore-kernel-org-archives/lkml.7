Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B618C4CEC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 02:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5CF2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 02:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ov0Eu2b4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfIMCqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 22:46:39 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40419 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfIMCqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 22:46:16 -0400
Received: by mail-yw1-f66.google.com with SMTP id e205so6763322ywc.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 19:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLkW+74wc48chMaJ/KVuQ7uRrxWQIHDU9l5rh4JtIOY=;
        b=ov0Eu2b4I7Q12uq0yRcdvZeS638ThpP0iTtsvSfkqDaN3X5+nLqrTerinuZIfna51K
         ER7JlMfi5/Xu1xECvpsZcwQmhvhwoLwRqAPlPWqHJtZA7E3crnhbm2dtm58n6JAXzaQf
         2T0+yGLXET7Xb/mVjCPGiy29t7BebbCUCgQvtmhJenAsZrYgFnd3UBsdjOcz1nBBeixn
         RWF1cIKC/XL5R85ZJoORWeIr7lVJxbiTwBsMdRvb0/1jCmuU1W8iNdIVbzoEOl5sYa+C
         fS9XTVFXDaMoKeVfsnierV2HeVhjobRSLZFev3F2n/AbX8NhzyhVUqkaoCWdqZ+qdRob
         6p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLkW+74wc48chMaJ/KVuQ7uRrxWQIHDU9l5rh4JtIOY=;
        b=NJEO+/q3yfAT4wdMK6fQEvjb2C4ikLmro5uh08cDsciYT1EaaIDkB2sgQjwiBed2bG
         89VwGhYhf3XPEKCVez4CufTtXPSIHWBIDHOmC2DFBxvJwi42wC0ef/PDfDDYZu/PIodC
         IvvCp6GfrCS9WydITDU8HNcBg/2WNfkl7I6zKBnj1fVhRtj1VP1w6Di3X1Z9r/+Gn0EA
         DJ47l5KR653CBhDTdz/A0Gi99Ohb01MzJOgJcl6XGwpeB1BssgtfogFQZ2b1XgrP/PfT
         vEIf38YYx/shSgC1I/fud8IYG6tBOWVtOIuU3Yo+v983kyqni41RhMhJdMwQpKZzX5m7
         jXhw==
X-Gm-Message-State: APjAAAVXOxQweHK2L/rxuFhNXhdZQzUpXSyUgv+3wgO4FvmNgetzwy5J
        joBoliM2in05+d9I8pZm2sJJwMYPIujVFR0NEYHqCw==
X-Google-Smtp-Source: APXvYqxVM4s8F4BS1Zlcn5M6gNmvcyM6ChJG6gCcHFmoDtUB11R5vxC7LO/naIitvw995GJ4Ao0m100O1UmzFVjsq2k=
X-Received: by 2002:a81:30c3:: with SMTP id w186mr27042004yww.10.1568342775235;
 Thu, 12 Sep 2019 19:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <31131c2d-a936-8bbf-e58d-a3baaa457340@gmail.com>
 <20190906125608.32129-1-mhocko@kernel.org> <CALvZod5w72jH8fJSFRaw7wgQTnzF6nb=+St-sSXVGSiG6Bs3Lg@mail.gmail.com>
 <20190909112245.GH27159@dhcp22.suse.cz> <20190911120002.GQ4023@dhcp22.suse.cz>
 <20190911073740.b5c40cd47ea845884e25e265@linux-foundation.org> <20190911151612.GI4023@dhcp22.suse.cz>
In-Reply-To: <20190911151612.GI4023@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 12 Sep 2019 19:46:04 -0700
Message-ID: <CALvZod65jCCH+fHqAQwk0RTZhyhxG71F-sHE7qxrmZ_L1tDbvw@mail.gmail.com>
Subject: Re: [PATCH] memcg, kmem: do not fail __GFP_NOFAIL charges
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 8:16 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 11-09-19 07:37:40, Andrew Morton wrote:
> > On Wed, 11 Sep 2019 14:00:02 +0200 Michal Hocko <mhocko@kernel.org> wrote:
> >
> > > On Mon 09-09-19 13:22:45, Michal Hocko wrote:
> > > > On Fri 06-09-19 11:24:55, Shakeel Butt wrote:
> > > [...]
> > > > > I wonder what has changed since
> > > > > <http://lkml.kernel.org/r/20180525185501.82098-1-shakeelb@google.com/>.
> > > >
> > > > I have completely forgot about that one. It seems that we have just
> > > > repeated the same discussion again. This time we have a poor user who
> > > > actually enabled the kmem limit.
> > > >
> > > > I guess there was no real objection to the change back then. The primary
> > > > discussion revolved around the fact that the accounting will stay broken
> > > > even when this particular part was fixed. Considering this leads to easy
> > > > to trigger crash (with the limit enabled) then I guess we should just
> > > > make it less broken and backport to stable trees and have a serious
> > > > discussion about discontinuing of the limit. Start by simply failing to
> > > > set any limit in the current upstream kernels.
> > >
> > > Any more concerns/objections to the patch? I can add a reference to your
> > > earlier post Shakeel if you want or to credit you the way you prefer.
> > >
> > > Also are there any objections to start deprecating process of kmem
> > > limit? I would see it in two stages
> > > - 1st warn in the kernel log
> > >     pr_warn("kmem.limit_in_bytes is deprecated and will be removed.
> > >             "Please report your usecase to linux-mm@kvack.org if you "
> > >             "depend on this functionality."
> >
> > pr_warn_once() :)
> >
> > > - 2nd fail any write to kmem.limit_in_bytes
> > > - 3rd remove the control file completely
> >
> > Sounds good to me.
>
> Here we go
>
> From 512822e551fe2960040c23b12c7b27a5fdab9013 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Wed, 11 Sep 2019 17:02:33 +0200
> Subject: [PATCH] memcg, kmem: deprecate kmem.limit_in_bytes
>
> Cgroup v1 memcg controller has exposed a dedicated kmem limit to users
> which turned out to be really a bad idea because there are paths which
> cannot shrink the kernel memory usage enough to get below the limit
> (e.g. because the accounted memory is not reclaimable). There are cases
> when the failure is even not allowed (e.g. __GFP_NOFAIL). This means
> that the kmem limit is in excess to the hard limit without any way to
> shrink and thus completely useless. OOM killer cannot be invoked to
> handle the situation because that would lead to a premature oom killing.
>
> As a result many places might see ENOMEM returning from kmalloc and
> result in unexpected errors. E.g. a global OOM killer when there is a
> lot of free memory because ENOMEM is translated into VM_FAULT_OOM in #PF
> path and therefore pagefault_out_of_memory would result in OOM killer.
>
> Please note that the kernel memory is still accounted to the overall
> limit along with the user memory so removing the kmem specific limit
> should still allow to contain kernel memory consumption. Unlike the kmem
> one, though, it invokes memory reclaim and targeted memcg oom killing if
> necessary.
>
> Start the deprecation process by crying to the kernel log. Let's see
> whether there are relevant usecases and simply return to EINVAL in the
> second stage if nobody complains in few releases.
>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  Documentation/admin-guide/cgroup-v1/memory.rst | 3 +++
>  mm/memcontrol.c                                | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> index 41bdc038dad9..e53fc2f31549 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -87,6 +87,9 @@ Brief summary of control files.
>                                      node
>
>   memory.kmem.limit_in_bytes          set/show hard limit for kernel memory
> +                                     This knob is deprecated it shouldn't be
> +                                     used. It is planned to be removed in
> +                                     a foreseeable future.
>   memory.kmem.usage_in_bytes          show current kernel memory allocation
>   memory.kmem.failcnt                 show the number of kernel memory usage
>                                      hits limits
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e18108b2b786..113969bc57e8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3518,6 +3518,9 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
>                         ret = mem_cgroup_resize_max(memcg, nr_pages, true);
>                         break;
>                 case _KMEM:
> +                       pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. "
> +                                    "Please report your usecase to linux-mm@kvack.org if you "
> +                                    "depend on this functionality.\n");
>                         ret = memcg_update_kmem_max(memcg, nr_pages);
>                         break;
>                 case _TCP:
> --
> 2.20.1
>
>
> --
> Michal Hocko
> SUSE Labs
