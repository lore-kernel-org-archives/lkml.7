Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7A3C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864B8218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjorYCcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfIQNYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:24:42 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46239 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbfIQNYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:24:41 -0400
Received: by mail-ot1-f67.google.com with SMTP id g19so2972349otg.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OsdTAgCF26FzGhTn9OIgSahAZGDk0D+ef/kwXj+ZNdU=;
        b=mjorYCcgCqtRNpoNVDUFLTsinc5a4Vx0M18+lFbhTNuOfpzFkGWqWFPPtp4xpB5/l+
         jm49DKIc/rmUEsRYyiQfx1HXnk5B/ZIGbugeS5YRTwEodkOi81Y30DlntEjUsbf0W5gU
         HkrxmpX7ki5EDiexfSMIaroCmeoIONxPagkjE87FA7h7rd99yYzZ752XwYx1sbgJZj5u
         Mjx9gBSjx57tzLMS9djRGK7c+FbYNFEdkudiAZ6574xRJ3XeF7FYFrGENR9S/4GCbgrq
         grXuVyPQPInkgNG7NjsDdGI/dS8KYavdWXwekHV3xkvEBO8nM0TmNfMcG3aO3Ozn/VM7
         vE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OsdTAgCF26FzGhTn9OIgSahAZGDk0D+ef/kwXj+ZNdU=;
        b=VWlpfw9MhcbSHqXIyZPk3NLas/2XBkVLAcOKDE7cMEVhKGkMjHyEHQsFXWrPl6T2ip
         rGBQkQQUV/Hx1KLIWUy4buGZRGdiTLewlzN9+Ue6aQF2DMRIW+b4T8kT9MawI/KDo7Vj
         Eb27NGi24q/ikuUHRQ9yjviPPHlQgAmd4+l9FMhnfYfxDytDyLGA1LpDYpieXJVfe3jI
         LRuNnOvRSNGpAuJ7RszLVxI5c1JtLZezpH7SOZH9jJX/xqpm2Ae3cgDiVcye1qoPNJPz
         m4EZZmVN4W46CVZpN+bFweG8PVnCnLRer/Gj2ox4kbnzHrZ7fQQ0Ytc9BlNte54nl5rb
         DeQA==
X-Gm-Message-State: APjAAAUCEZTdVkMLXHZ128NpMK442XnDwEzPnTLmhg5Irus2wKYAmKMJ
        6S3eizeojMdAH62O9qhvf0O4Pao9MyD8AXWoldk=
X-Google-Smtp-Source: APXvYqzl78E9UBc7RKfHFvoRETKcham24EDV7g6CmsnN0sRuPdMdRd1oA/VK8ViDWYzx5XE3sgAR9qaGVmSEGYFF0DI=
X-Received: by 2002:a9d:6218:: with SMTP id g24mr2527384otj.326.1568726678873;
 Tue, 17 Sep 2019 06:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <1568650294-8579-1-git-send-email-cai@lca.pw> <alpine.DEB.2.21.1909161128480.105847@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1909161128480.105847@chino.kir.corp.google.com>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Tue, 17 Sep 2019 21:24:27 +0800
Message-ID: <CAD7_sbEDd+CVvMR3AGx7xvvpBHcAK8z=MBSopmXHpBepBBwPAQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/slub: remove left-over debugging code
To:     David Rientjes <rientjes@google.com>
Cc:     Qian Cai <cai@lca.pw>, Christopher Lameter <cl@linux.com>,
        penberg@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 2:32 AM David Rientjes <rientjes@google.com> wrote:
>
> On Mon, 16 Sep 2019, Qian Cai wrote:
>
> > SLUB_RESILIENCY_TEST and SLUB_DEBUG_CMPXCHG look like some left-over
> > debugging code during the internal development that probably nobody uses
> > it anymore. Remove them to make the world greener.
>
> Adding Pengfei Li who has been working on a patchset for modified handling
> of kmalloc cache initialization and touches the resiliency test.
>

Thanks for looping me in.

My opinion is the same as David Rientjes.
The resiliency test should not be removed but should be improved.

> I still find the resiliency test to be helpful/instructional for handling
> unexpected conditions in these caches, so I'd suggest against removing it:
> the only downside is that it's additional source code.  But it's helpful
> source code for reference.
>
> The cmpxchg failures could likely be more generalized beyond SLUB since
> there will be other dependencies in the kernel than just this allocator.
>
> (I assume you didn't send a Signed-off-by line because this is an RFC.)
>
> > ---
> >  mm/slub.c | 110 --------------------------------------------------------------
> >  1 file changed, 110 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 8834563cdb4b..f97155ba097d 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -150,12 +150,6 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
> >   * - Variable sizing of the per node arrays
> >   */
> >
> > -/* Enable to test recovery from slab corruption on boot */
> > -#undef SLUB_RESILIENCY_TEST
> > -
> > -/* Enable to log cmpxchg failures */
> > -#undef SLUB_DEBUG_CMPXCHG
> > -
> >  /*
> >   * Mininum number of partial slabs. These will be left on the partial
> >   * lists even if they are empty. kmem_cache_shrink may reclaim them.
> > @@ -392,10 +386,6 @@ static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct page *page
> >       cpu_relax();
> >       stat(s, CMPXCHG_DOUBLE_FAIL);
> >
> > -#ifdef SLUB_DEBUG_CMPXCHG
> > -     pr_info("%s %s: cmpxchg double redo ", n, s->name);
> > -#endif
> > -
> >       return false;
> >  }
> >
> > @@ -433,10 +423,6 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
> >       cpu_relax();
> >       stat(s, CMPXCHG_DOUBLE_FAIL);
> >
> > -#ifdef SLUB_DEBUG_CMPXCHG
> > -     pr_info("%s %s: cmpxchg double redo ", n, s->name);
> > -#endif
> > -
> >       return false;
> >  }
> >
> > @@ -2004,45 +1990,11 @@ static inline unsigned long next_tid(unsigned long tid)
> >       return tid + TID_STEP;
> >  }
> >
> > -static inline unsigned int tid_to_cpu(unsigned long tid)
> > -{
> > -     return tid % TID_STEP;
> > -}
> > -
> > -static inline unsigned long tid_to_event(unsigned long tid)
> > -{
> > -     return tid / TID_STEP;
> > -}
> > -
> >  static inline unsigned int init_tid(int cpu)
> >  {
> >       return cpu;
> >  }
> >
> > -static inline void note_cmpxchg_failure(const char *n,
> > -             const struct kmem_cache *s, unsigned long tid)
> > -{
> > -#ifdef SLUB_DEBUG_CMPXCHG
> > -     unsigned long actual_tid = __this_cpu_read(s->cpu_slab->tid);
> > -
> > -     pr_info("%s %s: cmpxchg redo ", n, s->name);
> > -
> > -#ifdef CONFIG_PREEMPT
> > -     if (tid_to_cpu(tid) != tid_to_cpu(actual_tid))
> > -             pr_warn("due to cpu change %d -> %d\n",
> > -                     tid_to_cpu(tid), tid_to_cpu(actual_tid));
> > -     else
> > -#endif
> > -     if (tid_to_event(tid) != tid_to_event(actual_tid))
> > -             pr_warn("due to cpu running other code. Event %ld->%ld\n",
> > -                     tid_to_event(tid), tid_to_event(actual_tid));
> > -     else
> > -             pr_warn("for unknown reason: actual=%lx was=%lx target=%lx\n",
> > -                     actual_tid, tid, next_tid(tid));
> > -#endif
> > -     stat(s, CMPXCHG_DOUBLE_CPU_FAIL);
> > -}
> > -
> >  static void init_kmem_cache_cpus(struct kmem_cache *s)
> >  {
> >       int cpu;
> > @@ -2751,7 +2703,6 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
> >                               object, tid,
> >                               next_object, next_tid(tid)))) {
> >
> > -                     note_cmpxchg_failure("slab_alloc", s, tid);
> >                       goto redo;
> >               }
> >               prefetch_freepointer(s, next_object);
> > @@ -4694,66 +4645,6 @@ static int list_locations(struct kmem_cache *s, char *buf,
> >  }
> >  #endif       /* CONFIG_SLUB_DEBUG */
> >
> > -#ifdef SLUB_RESILIENCY_TEST
> > -static void __init resiliency_test(void)
> > -{
> > -     u8 *p;
> > -     int type = KMALLOC_NORMAL;
> > -
> > -     BUILD_BUG_ON(KMALLOC_MIN_SIZE > 16 || KMALLOC_SHIFT_HIGH < 10);
> > -
> > -     pr_err("SLUB resiliency testing\n");
> > -     pr_err("-----------------------\n");
> > -     pr_err("A. Corruption after allocation\n");
> > -
> > -     p = kzalloc(16, GFP_KERNEL);
> > -     p[16] = 0x12;
> > -     pr_err("\n1. kmalloc-16: Clobber Redzone/next pointer 0x12->0x%p\n\n",
> > -            p + 16);
> > -
> > -     validate_slab_cache(kmalloc_caches[type][4]);
> > -
> > -     /* Hmmm... The next two are dangerous */
> > -     p = kzalloc(32, GFP_KERNEL);
> > -     p[32 + sizeof(void *)] = 0x34;
> > -     pr_err("\n2. kmalloc-32: Clobber next pointer/next slab 0x34 -> -0x%p\n",
> > -            p);
> > -     pr_err("If allocated object is overwritten then not detectable\n\n");
> > -
> > -     validate_slab_cache(kmalloc_caches[type][5]);
> > -     p = kzalloc(64, GFP_KERNEL);
> > -     p += 64 + (get_cycles() & 0xff) * sizeof(void *);
> > -     *p = 0x56;
> > -     pr_err("\n3. kmalloc-64: corrupting random byte 0x56->0x%p\n",
> > -            p);
> > -     pr_err("If allocated object is overwritten then not detectable\n\n");
> > -     validate_slab_cache(kmalloc_caches[type][6]);
> > -
> > -     pr_err("\nB. Corruption after free\n");
> > -     p = kzalloc(128, GFP_KERNEL);
> > -     kfree(p);
> > -     *p = 0x78;
> > -     pr_err("1. kmalloc-128: Clobber first word 0x78->0x%p\n\n", p);
> > -     validate_slab_cache(kmalloc_caches[type][7]);
> > -
> > -     p = kzalloc(256, GFP_KERNEL);
> > -     kfree(p);
> > -     p[50] = 0x9a;
> > -     pr_err("\n2. kmalloc-256: Clobber 50th byte 0x9a->0x%p\n\n", p);
> > -     validate_slab_cache(kmalloc_caches[type][8]);
> > -
> > -     p = kzalloc(512, GFP_KERNEL);
> > -     kfree(p);
> > -     p[512] = 0xab;
> > -     pr_err("\n3. kmalloc-512: Clobber redzone 0xab->0x%p\n\n", p);
> > -     validate_slab_cache(kmalloc_caches[type][9]);
> > -}
> > -#else
> > -#ifdef CONFIG_SYSFS
> > -static void resiliency_test(void) {};
> > -#endif
> > -#endif       /* SLUB_RESILIENCY_TEST */
> > -
> >  #ifdef CONFIG_SYSFS
> >  enum slab_stat_type {
> >       SL_ALL,                 /* All slabs */
> > @@ -5875,7 +5766,6 @@ static int __init slab_sysfs_init(void)
> >       }
> >
> >       mutex_unlock(&slab_mutex);
> > -     resiliency_test();
> >       return 0;
> >  }
> >
> > --
> > 1.8.3.1
> >
> >
