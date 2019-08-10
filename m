Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA96C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 09:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2591A2166E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 09:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvlE/0bj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfHJJFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 05:05:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32851 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfHJJFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 05:05:39 -0400
Received: by mail-lj1-f193.google.com with SMTP id z17so5751430ljz.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 02:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/iVkWacMKBMI8tUTq90sb+qNE12YPEmDRdfDkGujEg=;
        b=WvlE/0bjif9cFAUGbIm/f0nu8+dOOpAZMPm9E+uI8zYm4MQUaeFnTN0/mLAbdeOfCI
         x3IN08Godktf7mrpJ4w+H6zi9+7XgTOBEnva1iHxVbFc3hU+4fq/w5vvz7mw0oYfAeuf
         eRNRgpMPMdbEH6h9IYz+5voskY5PFplpNp3SZQAe/tSwhdW2g8V3wR0i/fE2r7HXSxvt
         zmphBIxc1HKujLmnct8w+4coO6/9/COYW9sMx37l/pGHOVNi7vxizxw122bkUMEwiYkQ
         9B0b/5ViG93yQn/yadNuscw4Pd3eK/lthDz87lcR42UJ5iz/3m2qR+/GciYvZdbRmU9/
         4sjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/iVkWacMKBMI8tUTq90sb+qNE12YPEmDRdfDkGujEg=;
        b=rv2gXdTI/3aYCpnxpRbA6dXaco7zD0CDDm9crhMGOLoYqG0G/CCdW9Z3ysAvliZPGt
         0dKWRMD8F+/gUszUUpjPME9CQa4Ah8dgPSFeRIZtjyOxhYt1qvQxdh3Cyv05zCMsUbhT
         te3EtdIiQ+8pf7tehCXV39QXmrKjrifr4dCfk0uXZxmqq1JI7/whyELxubVh02Zccixs
         0B6G4AGC4kXVfmbOv9VGi48UhtJO556PP2dJhfFOpR82UpqSDts2nCq5I4a+gVzjpDXO
         LD928swqJLlug4IFQtMnnD8XTjSjSj6EZJmnOb/KPmEbeBjvmbRBvxgZDS+NyufSy+iN
         zFLA==
X-Gm-Message-State: APjAAAWSHahKp1GlSKwQ7SH8jFDoMkhz+MQnq8uRE5E7O/O6ffDYmSbr
        y8AEJhPr1xwB0Tcv8P4xoD/xvWL74nh6EkzeRS4=
X-Google-Smtp-Source: APXvYqyXg4louOiSmPQuA3Tvk5SIs5REwboG+lRAcYog6St+Vb6efmyfq6z/WGumJAIIF26yBbDsKB+52JdmLRLZQi8=
X-Received: by 2002:a2e:720b:: with SMTP id n11mr4092017ljc.213.1565427936877;
 Sat, 10 Aug 2019 02:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190809164643.5978-1-henryburns@google.com>
In-Reply-To: <20190809164643.5978-1-henryburns@google.com>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Sat, 10 Aug 2019 12:05:23 +0300
Message-ID: <CAMJBoFPi3bzRdC8J4tacSHOgP6Z4=KGuT2FLUNVY=EYZ6wEFKg@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold.c: Fix race between migration and destruction
To:     Henry Burns <henryburns@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henry,

Den fre 9 aug. 2019 6:46 emHenry Burns <henryburns@google.com> skrev:
>
> In z3fold_destroy_pool() we call destroy_workqueue(&pool->compact_wq).
> However, we have no guarantee that migration isn't happening in the
> background at that time.
>
> Migration directly calls queue_work_on(pool->compact_wq), if destruction
> wins that race we are using a destroyed workqueue.


Thanks for the fix. Would you please comment why adding
flush_workqueue() isn't enough?

~Vitaly
>
>
> Signed-off-by: Henry Burns <henryburns@google.com>
> ---
>  mm/z3fold.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 78447cecfffa..e136d97ce56e 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -40,6 +40,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/wait.h>
>  #include <linux/zpool.h>
>
>  /*
> @@ -161,8 +162,10 @@ struct z3fold_pool {
>         const struct zpool_ops *zpool_ops;
>         struct workqueue_struct *compact_wq;
>         struct workqueue_struct *release_wq;
> +       struct wait_queue_head isolate_wait;
>         struct work_struct work;
>         struct inode *inode;
> +       int isolated_pages;
>  };
>
>  /*
> @@ -772,6 +775,7 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
>                 goto out_c;
>         spin_lock_init(&pool->lock);
>         spin_lock_init(&pool->stale_lock);
> +       init_waitqueue_head(&pool->isolate_wait);
>         pool->unbuddied = __alloc_percpu(sizeof(struct list_head)*NCHUNKS, 2);
>         if (!pool->unbuddied)
>                 goto out_pool;
> @@ -811,6 +815,15 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
>         return NULL;
>  }
>
> +static bool pool_isolated_are_drained(struct z3fold_pool *pool)
> +{
> +       bool ret;
> +
> +       spin_lock(&pool->lock);
> +       ret = pool->isolated_pages == 0;
> +       spin_unlock(&pool->lock);
> +       return ret;
> +}
>  /**
>   * z3fold_destroy_pool() - destroys an existing z3fold pool
>   * @pool:      the z3fold pool to be destroyed
> @@ -821,6 +834,13 @@ static void z3fold_destroy_pool(struct z3fold_pool *pool)
>  {
>         kmem_cache_destroy(pool->c_handle);
>
> +       /*
> +        * We need to ensure that no pages are being migrated while we destroy
> +        * these workqueues, as migration can queue work on either of the
> +        * workqueues.
> +        */
> +       wait_event(pool->isolate_wait, !pool_isolated_are_drained(pool));
> +
>         /*
>          * We need to destroy pool->compact_wq before pool->release_wq,
>          * as any pending work on pool->compact_wq will call
> @@ -1317,6 +1337,28 @@ static u64 z3fold_get_pool_size(struct z3fold_pool *pool)
>         return atomic64_read(&pool->pages_nr);
>  }
>
> +/*
> + * z3fold_dec_isolated() expects to be called while pool->lock is held.
> + */
> +static void z3fold_dec_isolated(struct z3fold_pool *pool)
> +{
> +       assert_spin_locked(&pool->lock);
> +       VM_BUG_ON(pool->isolated_pages <= 0);
> +       pool->isolated_pages--;
> +
> +       /*
> +        * If we have no more isolated pages, we have to see if
> +        * z3fold_destroy_pool() is waiting for a signal.
> +        */
> +       if (pool->isolated_pages == 0 && waitqueue_active(&pool->isolate_wait))
> +               wake_up_all(&pool->isolate_wait);
> +}
> +
> +static void z3fold_inc_isolated(struct z3fold_pool *pool)
> +{
> +       pool->isolated_pages++;
> +}
> +
>  static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
>  {
>         struct z3fold_header *zhdr;
> @@ -1343,6 +1385,7 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
>                 spin_lock(&pool->lock);
>                 if (!list_empty(&page->lru))
>                         list_del(&page->lru);
> +               z3fold_inc_isolated(pool);
>                 spin_unlock(&pool->lock);
>                 z3fold_page_unlock(zhdr);
>                 return true;
> @@ -1417,6 +1460,10 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
>
>         queue_work_on(new_zhdr->cpu, pool->compact_wq, &new_zhdr->work);
>
> +       spin_lock(&pool->lock);
> +       z3fold_dec_isolated(pool);
> +       spin_unlock(&pool->lock);
> +
>         page_mapcount_reset(page);
>         put_page(page);
>         return 0;
> @@ -1436,10 +1483,14 @@ static void z3fold_page_putback(struct page *page)
>         INIT_LIST_HEAD(&page->lru);
>         if (kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
>                 atomic64_dec(&pool->pages_nr);
> +               spin_lock(&pool->lock);
> +               z3fold_dec_isolated(pool);
> +               spin_unlock(&pool->lock);
>                 return;
>         }
>         spin_lock(&pool->lock);
>         list_add(&page->lru, &pool->lru);
> +       z3fold_dec_isolated(pool);
>         spin_unlock(&pool->lock);
>         z3fold_page_unlock(zhdr);
>  }
> --
> 2.22.0.770.g0f2c4a37fd-goog
>
