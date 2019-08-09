Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C10C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E9C214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X105Vy7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfHIThu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:37:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33145 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfHIThs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:37:48 -0400
Received: by mail-ot1-f65.google.com with SMTP id q20so136789822otl.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 12:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1zjsaY/5X9pgLr5EhZ6Dhm4kHVCrretdr/qFF1Np8A=;
        b=X105Vy7WLgr+xjAhRSnBDjw59MKMCD365GQvxhqK6dp8ABjh/cjQpB3KFzaNKJ9Wzv
         s+9+ef5b8d7DO4yrNC64EBP3yAKa0uEdIfTJYw6h3+s5e6wTd68vJs7ms+KPRBYptCLj
         vOmGejQSRxKmWPYLYb8UH7ToALVnDOLSFHviqf8qcfPmF86+7p1LixIwk5fq3bJeJolf
         jum8pTfWhB1MU+uvUPq1YLGxopjiHs9/xwiaT5QIn0BTD3lwtP+z3VHcID6z1YCg82pd
         mn1yKVPubYd+coEN88FlVAvl0eCDGswavgrI1X9aSFv/BVexXGOZkw4kQNmoSJ7bSIbM
         0drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1zjsaY/5X9pgLr5EhZ6Dhm4kHVCrretdr/qFF1Np8A=;
        b=fVcYVz2uhuZqShR9Np5fxqBZ4Tgr3evv+Do8POk9yckpVPzNWPaS6AO/yXWxS+W03R
         bYxc6Do5yiWTKPcxkGbhYOCGYiVomcQDvFXm9/WtrplFXbd5bT1COY4PsC50eZoEKKtc
         qHDngDcZ5qIq7RPLB/Qx/5wgGW8n9c+RTiRt1YMOj+Yvfa7PZZKWMlyyJvIi9Y2S3E5O
         pXpc8QBpIb6TUgoUrxJpcciOVhUV+kBHsO621gELdMZAivoQR9UEnq73FpM444T41JkQ
         eoA2VetsD6fM3PHT4sGQFQBrf4Gb2q4EubRNmF0UIjZ+91w4OQxavPqGwlnWgYtDiYbT
         NwdQ==
X-Gm-Message-State: APjAAAXKzGkNQda6PS3Vgbcy53DOzx6psBmBvXiVj9I/Yjk1K4tA4nXT
        NSdWu3PVAqARJVdRwtFT0+KnRuRDairx05C4BsdOeg==
X-Google-Smtp-Source: APXvYqy68srnKh4SexgO3Zncd4I5Uo4xelzxCYMO2rib83tF2sFznKjEVLp+1sCN5vVoGDpHxbI8Y5IJEQ/a/J6++UE=
X-Received: by 2002:a5e:9e03:: with SMTP id i3mr5084310ioq.66.1565379466849;
 Fri, 09 Aug 2019 12:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190809164643.5978-1-henryburns@google.com>
In-Reply-To: <20190809164643.5978-1-henryburns@google.com>
From:   Henry Burns <henryburns@google.com>
Date:   Fri, 9 Aug 2019 12:37:11 -0700
Message-ID: <CAGQXPThn2e8KPmeuH5urEz5e9unUL0CDRJDrEWuGezzboOo3wQ@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold.c: Fix race between migration and destruction
To:     Vitaly Wool <vitalywool@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vitaly Vul <vitaly.vul@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, henrywolfeburns@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've just CC'd a personal email here so that I can respond to any
replies after today.

On Fri, Aug 9, 2019 at 9:46 AM Henry Burns <henryburns@google.com> wrote:
>
> In z3fold_destroy_pool() we call destroy_workqueue(&pool->compact_wq).
> However, we have no guarantee that migration isn't happening in the
> background at that time.
>
> Migration directly calls queue_work_on(pool->compact_wq), if destruction
> wins that race we are using a destroyed workqueue.
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
