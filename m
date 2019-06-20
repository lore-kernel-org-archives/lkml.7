Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EA8C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E0E2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EsRX/z5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbfFTOju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:39:50 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35534 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfFTOjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:39:49 -0400
Received: by mail-yw1-f68.google.com with SMTP id k128so1281226ywf.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/xVTTO13YZRoWlxnmmyYUyBFZOvXu9iKc3UKSDiO8g=;
        b=EsRX/z5iufniFIHZi8C2aO9PnAZTemthqfhGRb0QeF4codH+ax/xP4mDwPcp+HFIAb
         1RKLsA5PGLighAEMsz2UdbWJU3hU3tmWZaIBlCRV4Ci95MQsPLogeoFRr7AVLWcdHKJT
         4SXBMXLaBsBRkaHlDljk+roS7qjO+i/yfSE5knLHMUzEI7d1ZE4d+Gk/0FAGzjPy/U4F
         bq0zPM2BtqNCW6xCYx0yh+y/M0+Sy9/oIGkNO8XadJL0dYpUZMgkGWlhKBKDYVKnVR/O
         2qGtMm0WgOCGkQzHLbf1aKQg9XXCYrOspw6tlyvHoC0RAuJA8INjbnTMkkdqITADAuCB
         AO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/xVTTO13YZRoWlxnmmyYUyBFZOvXu9iKc3UKSDiO8g=;
        b=rlD6brgUeomps7D3qfnKqn5CFCw5UjW6FSRSaog1xmRhHWWBRPv1LvB7Q2x/O783/R
         RWEiK2IWTXslfbCc/518wmUJ63WytASwVoCrdDLdxkDPnbwUhxn/vQsp7P8+MNOsCUmf
         U0H7z+Y6Hj8ZOMwtEIDnsxi9E6WYlQeplvBhp0aqBeIgCLGXNrD5v818JuK0aw5bxo4N
         M08h+Oe+fif1tMXRRCPeueEWPwcA5BMp9rq0rgNBpJPRs41sBnXBqnly1L/MlD7Kr7uh
         3dh8DmvG3wPOACOWJwsTjXEqkfCApVSQ8J1v4W8ezfk1c72hfc3Fj+vJdefhcXFcIbvr
         KpIw==
X-Gm-Message-State: APjAAAW8Nr6w6OufiIO/r0KKIpPf/VR0qJw0AfEDsBTw0Y9HFdwjRbjf
        TwvAZMDY1A/AeeWdTGG1vpQ5iwfEm9qiPKERSNrFQg==
X-Google-Smtp-Source: APXvYqxv+Tuq6d6FipBVznIuiXxZGa9UBLC4lTXMCQcA8rTWKFP8sUpjSIIHDESNxlTn8uv6nSiVgSh9rgCJkNNROhI=
X-Received: by 2002:a0d:c345:: with SMTP id f66mr26110539ywd.10.1561041587654;
 Thu, 20 Jun 2019 07:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190619171621.26209-1-longman@redhat.com> <CALvZod7pdOx0a1v4oX5-7ZfCykM8iwRwPkW-+gbO1B4+j1SXqw@mail.gmail.com>
 <cfc6c800-1cb4-e2f2-e6d9-f0571c11a47b@redhat.com>
In-Reply-To: <cfc6c800-1cb4-e2f2-e6d9-f0571c11a47b@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Jun 2019 07:39:36 -0700
Message-ID: <CALvZod4oOddDvuvuXyp=p2Dq=h354a-D72daagfya_Ewp_ggSA@mail.gmail.com>
Subject: Re: [PATCH v2] mm, memcg: Add a memcg_slabinfo debugfs file
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 7:24 AM Waiman Long <longman@redhat.com> wrote:
>
> On 6/19/19 7:48 PM, Shakeel Butt wrote:
> > Hi Waiman,
> >
> > On Wed, Jun 19, 2019 at 10:16 AM Waiman Long <longman@redhat.com> wrote:
> >> There are concerns about memory leaks from extensive use of memory
> >> cgroups as each memory cgroup creates its own set of kmem caches. There
> >> is a possiblity that the memcg kmem caches may remain even after the
> >> memory cgroups have been offlined. Therefore, it will be useful to show
> >> the status of each of memcg kmem caches.
> >>
> >> This patch introduces a new <debugfs>/memcg_slabinfo file which is
> >> somewhat similar to /proc/slabinfo in format, but lists only information
> >> about kmem caches that have child memcg kmem caches. Information
> >> available in /proc/slabinfo are not repeated in memcg_slabinfo.
> >>
> >> A portion of a sample output of the file was:
> >>
> >>   # <name> <css_id[:dead]> <active_objs> <num_objs> <active_slabs> <num_slabs>
> >>   rpc_inode_cache   root          13     51      1      1
> >>   rpc_inode_cache     48           0      0      0      0
> >>   fat_inode_cache   root           1     45      1      1
> >>   fat_inode_cache     41           2     45      1      1
> >>   xfs_inode         root         770    816     24     24
> >>   xfs_inode           92          22     34      1      1
> >>   xfs_inode           88:dead      1     34      1      1
> >>   xfs_inode           89:dead     23     34      1      1
> >>   xfs_inode           85           4     34      1      1
> >>   xfs_inode           84           9     34      1      1
> >>
> >> The css id of the memcg is also listed. If a memcg is not online,
> >> the tag ":dead" will be attached as shown above.
> >>
> >> Suggested-by: Shakeel Butt <shakeelb@google.com>
> >> Signed-off-by: Waiman Long <longman@redhat.com>
> >> ---
> >>  mm/slab_common.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 57 insertions(+)
> >>
> >> diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> index 58251ba63e4a..2bca1558a722 100644
> >> --- a/mm/slab_common.c
> >> +++ b/mm/slab_common.c
> >> @@ -17,6 +17,7 @@
> >>  #include <linux/uaccess.h>
> >>  #include <linux/seq_file.h>
> >>  #include <linux/proc_fs.h>
> >> +#include <linux/debugfs.h>
> >>  #include <asm/cacheflush.h>
> >>  #include <asm/tlbflush.h>
> >>  #include <asm/page.h>
> >> @@ -1498,6 +1499,62 @@ static int __init slab_proc_init(void)
> >>         return 0;
> >>  }
> >>  module_init(slab_proc_init);
> >> +
> >> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_MEMCG_KMEM)
> >> +/*
> >> + * Display information about kmem caches that have child memcg caches.
> >> + */
> >> +static int memcg_slabinfo_show(struct seq_file *m, void *unused)
> >> +{
> >> +       struct kmem_cache *s, *c;
> >> +       struct slabinfo sinfo;
> >> +
> >> +       mutex_lock(&slab_mutex);
> > On large machines there can be thousands of memcgs and potentially
> > each memcg can have hundreds of kmem caches. So, the slab_mutex can be
> > held for a very long time.
>
> But that is also what /proc/slabinfo does by doing mutex_lock() at
> slab_start() and mutex_unlock() at slab_stop(). So the same problem will
> happen when /proc/slabinfo is being read.
>
> When you are in a situation that reading /proc/slabinfo take a long time
> because of the large number of memcg's, the system is in some kind of
> trouble anyway. I am saying that we should not improve the scalability
> of this patch. It is just that some nasty race conditions may pop up if
> we release the lock and re-acquire it latter. That will greatly
> complicate the code to handle all those edge cases.
>

We have been using that interface and implementation for couple of
years and have not seen any race condition. However I am fine with
what you have here for now. We can always come back if we think we
need to improve it.

> > Our internal implementation traverses the memcg tree and then
> > traverses 'memcg->kmem_caches' within the slab_mutex (and
> > cond_resched() after unlock).
> For cgroup v1, the setting of the CONFIG_SLUB_DEBUG option will allow
> you to iterate and display slabinfo just for that particular memcg. I am
> thinking of extending the debug controller to do similar thing for
> cgroup v2.

I was also planning to look into that and it seems like you are
already on it. Do CC me the patches.

> >> +       seq_puts(m, "# <name> <css_id[:dead]> <active_objs> <num_objs>");
> >> +       seq_puts(m, " <active_slabs> <num_slabs>\n");
> >> +       list_for_each_entry(s, &slab_root_caches, root_caches_node) {
> >> +               /*
> >> +                * Skip kmem caches that don't have any memcg children.
> >> +                */
> >> +               if (list_empty(&s->memcg_params.children))
> >> +                       continue;
> >> +
> >> +               memset(&sinfo, 0, sizeof(sinfo));
> >> +               get_slabinfo(s, &sinfo);
> >> +               seq_printf(m, "%-17s root      %6lu %6lu %6lu %6lu\n",
> >> +                          cache_name(s), sinfo.active_objs, sinfo.num_objs,
> >> +                          sinfo.active_slabs, sinfo.num_slabs);
> >> +
> >> +               for_each_memcg_cache(c, s) {
> >> +                       struct cgroup_subsys_state *css;
> >> +                       char *dead = "";
> >> +
> >> +                       css = &c->memcg_params.memcg->css;
> >> +                       if (!(css->flags & CSS_ONLINE))
> >> +                               dead = ":dead";
> > Please note that Roman's kmem cache reparenting patch series have made
> > kmem caches of zombie memcgs a bit tricky. On memcg offlining the
> > memcg kmem caches are reparented and the css->id can get recycled. So,
> > we want to know that the a kmem cache is reparented and which memcg it
> > belonged to initially. Determining if a kmem cache is reparented, we
> > can store a flag on the kmem cache and for the previous memcg we can
> > use fhandle. However to not make this more complicated, for now, we
> > can just have the info that the kmem cache was reparented i.e. belongs
> > to an offlined memcg.
>
> I need to play with Roman's kmem cache reparenting patch a bit more to
> see how to properly recognize a reparent'ed kmem cache. What I have
> noticed is that the dead kmem caches that I saw at boot up were gone
> after applying his patch. So that is a good thing.
>

By gone, do you mean the kmem cache got freed or the kmem cache is not
part of online parent memcg and thus no more dead kmem cache?

> For now, I think the current patch is good enough for its purpose. I may
> send follow-up if I see something that can be improved.
>

I would like to see the recognition of reparent'ed kmem cache in this
patch. However if others are ok with the current status of the patch
then I will not stand in the way.

thanks,
Shakeel
