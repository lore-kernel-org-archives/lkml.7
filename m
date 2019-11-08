Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA90C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4FF21D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="QWtZEAWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfKHQQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:16:10 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:32843 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKHQQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:16:09 -0500
Received: by mail-io1-f66.google.com with SMTP id j13so6985855ioe.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 08:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2UYFEGLZmGQ7i41acAR9R0I3eSg77guyFjPWJWzrxs=;
        b=QWtZEAWaspw9OXu+FdJCQiHaUA9XGmXFN1ipdRUqfNCsmai8FbLuy1zibNwebgd1pj
         zl8ULIA0tLBbt9SoUJnNvG7cexMTOazJymra3Mxn8oep59n/CmI9GKgtGsEqBUjfzrH3
         iaGSFJUnCtNPTjatQ24fvZS1+Q6bZFjtVjLcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2UYFEGLZmGQ7i41acAR9R0I3eSg77guyFjPWJWzrxs=;
        b=VW4t94rxNPbeeu6a4Gk6jvlZv83xjftWDr9vYdItZ7XnTcC18p9iU3kdhH/+YI7wKq
         VwbphEmf+GGch8w4Ru4FdL6QbNINOlH815k6MkcN/0z2gvCRTm4udBSfN74EcBx7L0s8
         PROvyPAx49618LZ7KVPNOFToivoeEOe+Illk+XzD/HB0wKj0iqfgqcoi9nT4t8/fpe/c
         1r3gIsm/OhI//7k5IkpMOVnhrdr3HzD05C/B2voOb/O1czxJCpOKZNJktSCOmpfZ4sjH
         aVG7e38p0/8Ovexpp6pxUPOVvHhFzkYuNQ83uDl4SNeLd23tvxLHVAfSasWSHLjvUODq
         JnRA==
X-Gm-Message-State: APjAAAU9/ZJMe8t4lENtNk48QLg4rIXz39Cjb1j+qbub0FLLWuhzaCo8
        V7Hk/TpTzEwMjnxyo8M9voaNPE4dB8hiRFN0/EM=
X-Google-Smtp-Source: APXvYqw2TfirhTgas7/mfZxPe/h79SVO1NE+6f86D+suAhQFGlL9VEDUpWu94DgajYk+0nghZgE5EhbE5ftWwJIbs4A=
X-Received: by 2002:a05:6638:9:: with SMTP id z9mr11581662jao.35.1573229768364;
 Fri, 08 Nov 2019 08:16:08 -0800 (PST)
MIME-Version: 1.0
References: <1571111349-5041-1-git-send-email-teawater@gmail.com> <1571111349-5041-2-git-send-email-teawater@gmail.com>
In-Reply-To: <1571111349-5041-2-git-send-email-teawater@gmail.com>
From:   Dan Streetman <ddstreet@ieee.org>
Date:   Fri, 8 Nov 2019 11:15:31 -0500
Message-ID: <CALZtONA9Y9tvOJcHUyac770fSQhCoGMb7kDL1R5N9Bueqd+7_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm, zswap: Support THP
To:     Hui Zhu <teawater@gmail.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Hui Zhu <teawaterz@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 11:49 PM Hui Zhu <teawater@gmail.com> wrote:
>
> This commit let zswap treats THP as continuous normal pages
> in zswap_frontswap_store.
> It will store them to a lot of "zswap_entry".  These "zswap_entry"
> will be inserted to "zswap_tree" together.

why does zswap need to carry the added complexity of converting THP
into separate normal sized pages?  That should be done higher up in
the swap layer.

>
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> ---
>  mm/zswap.c | 170 +++++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 109 insertions(+), 61 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 46a3223..36aa10d 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -316,11 +316,7 @@ static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
>         }
>  }
>
> -/*
> - * Carries out the common pattern of freeing and entry's zpool allocation,
> - * freeing the entry itself, and decrementing the number of stored pages.
> - */
> -static void zswap_free_entry(struct zswap_entry *entry)
> +static void zswap_free_entry_1(struct zswap_entry *entry)
>  {
>         if (!entry->length)
>                 atomic_dec(&zswap_same_filled_pages);
> @@ -329,6 +325,15 @@ static void zswap_free_entry(struct zswap_entry *entry)
>                 zswap_pool_put(entry->pool);
>         }
>         zswap_entry_cache_free(entry);
> +}
> +
> +/*
> + * Carries out the common pattern of freeing and entry's zpool allocation,
> + * freeing the entry itself, and decrementing the number of stored pages.
> + */
> +static void zswap_free_entry(struct zswap_entry *entry)
> +{
> +       zswap_free_entry_1(entry);
>         atomic_dec(&zswap_stored_pages);
>         zswap_update_total_size();
>  }
> @@ -980,15 +985,11 @@ static void zswap_fill_page(void *ptr, unsigned long value)
>         memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
>  }
>
> -/*********************************
> -* frontswap hooks
> -**********************************/
> -/* attempts to compress and store an single page */
> -static int zswap_frontswap_store(unsigned type, pgoff_t offset,
> -                               struct page *page)
> +static int zswap_frontswap_store_1(unsigned type, pgoff_t offset,
> +                               struct page *page,
> +                               struct zswap_entry **entry_pointer)
>  {
> -       struct zswap_tree *tree = zswap_trees[type];
> -       struct zswap_entry *entry, *dupentry;
> +       struct zswap_entry *entry;
>         struct crypto_comp *tfm;
>         int ret;
>         unsigned int hlen, dlen = PAGE_SIZE;
> @@ -998,36 +999,6 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>         struct zswap_header zhdr = { .swpentry = swp_entry(type, offset) };
>         gfp_t gfp;
>
> -       /* THP isn't supported */
> -       if (PageTransHuge(page)) {
> -               ret = -EINVAL;
> -               goto reject;
> -       }
> -
> -       if (!zswap_enabled || !tree) {
> -               ret = -ENODEV;
> -               goto reject;
> -       }
> -
> -       /* reclaim space if needed */
> -       if (zswap_is_full()) {
> -               zswap_pool_limit_hit++;
> -               if (zswap_shrink()) {
> -                       zswap_reject_reclaim_fail++;
> -                       ret = -ENOMEM;
> -                       goto reject;
> -               }
> -
> -               /* A second zswap_is_full() check after
> -                * zswap_shrink() to make sure it's now
> -                * under the max_pool_percent
> -                */
> -               if (zswap_is_full()) {
> -                       ret = -ENOMEM;
> -                       goto reject;
> -               }
> -       }
> -
>         /* allocate entry */
>         entry = zswap_entry_cache_alloc(GFP_KERNEL);
>         if (!entry) {
> @@ -1035,6 +1006,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>                 ret = -ENOMEM;
>                 goto reject;
>         }
> +       *entry_pointer = entry;
>
>         if (zswap_same_filled_pages_enabled) {
>                 src = kmap_atomic(page);
> @@ -1044,7 +1016,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>                         entry->length = 0;
>                         entry->value = value;
>                         atomic_inc(&zswap_same_filled_pages);
> -                       goto insert_entry;
> +                       goto out;
>                 }
>                 kunmap_atomic(src);
>         }
> @@ -1093,31 +1065,105 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>         entry->handle = handle;
>         entry->length = dlen;
>
> -insert_entry:
> +out:
> +       return 0;
> +
> +put_dstmem:
> +       put_cpu_var(zswap_dstmem);
> +       zswap_pool_put(entry->pool);
> +freepage:
> +       zswap_entry_cache_free(entry);
> +reject:
> +       return ret;
> +}
> +
> +/*********************************
> +* frontswap hooks
> +**********************************/
> +/* attempts to compress and store an single page */
> +static int zswap_frontswap_store(unsigned type, pgoff_t offset,
> +                               struct page *page)
> +{
> +       struct zswap_tree *tree = zswap_trees[type];
> +       struct zswap_entry **entries = NULL, *dupentry;
> +       struct zswap_entry *single_entry[1];
> +       int ret;
> +       int i, nr;
> +
> +       if (!zswap_enabled || !tree) {
> +               ret = -ENODEV;
> +               goto reject;
> +       }
> +
> +       /* reclaim space if needed */
> +       if (zswap_is_full()) {
> +               zswap_pool_limit_hit++;
> +               if (zswap_shrink()) {
> +                       zswap_reject_reclaim_fail++;
> +                       ret = -ENOMEM;
> +                       goto reject;
> +               }
> +
> +               /* A second zswap_is_full() check after
> +                * zswap_shrink() to make sure it's now
> +                * under the max_pool_percent
> +                */
> +               if (zswap_is_full()) {
> +                       ret = -ENOMEM;
> +                       goto reject;
> +               }
> +       }
> +
> +       nr = hpage_nr_pages(page);
> +
> +       if (unlikely(nr > 1)) {
> +               entries = kvmalloc(sizeof(struct zswap_entry *) * nr,
> +                               GFP_KERNEL);
> +               if (!entries) {
> +                       ret = -ENOMEM;
> +                       goto reject;
> +               }
> +       } else
> +               entries = single_entry;
> +
> +       for (i = 0; i < nr; i++) {
> +               ret = zswap_frontswap_store_1(type, offset + i, page + i,
> +                                       &entries[i]);
> +               if (ret)
> +                       goto freepage;
> +       }
> +
>         /* map */
>         spin_lock(&tree->lock);
> -       do {
> -               ret = zswap_rb_insert(&tree->rbroot, entry, &dupentry);
> -               if (ret == -EEXIST) {
> -                       zswap_duplicate_entry++;
> -                       /* remove from rbtree */
> -                       zswap_rb_erase(&tree->rbroot, dupentry);
> -                       zswap_entry_put(tree, dupentry);
> -               }
> -       } while (ret == -EEXIST);
> +       for (i = 0; i < nr; i++) {
> +               do {
> +                       ret = zswap_rb_insert(&tree->rbroot, entries[i],
> +                                       &dupentry);
> +                       if (ret == -EEXIST) {
> +                               zswap_duplicate_entry++;
> +                               /* remove from rbtree */
> +                               zswap_rb_erase(&tree->rbroot, dupentry);
> +                               zswap_entry_put(tree, dupentry);
> +                       }
> +               } while (ret == -EEXIST);
> +       }
>         spin_unlock(&tree->lock);
>
>         /* update stats */
> -       atomic_inc(&zswap_stored_pages);
> +       atomic_add(nr, &zswap_stored_pages);
>         zswap_update_total_size();
>
> -       return 0;
> -
> -put_dstmem:
> -       put_cpu_var(zswap_dstmem);
> -       zswap_pool_put(entry->pool);
> +       ret = 0;
>  freepage:
> -       zswap_entry_cache_free(entry);
> +       if (unlikely(nr > 1)) {
> +               if (ret) {
> +                       int j;
> +
> +                       for (j = 0; j < i; j++)
> +                               zswap_free_entry_1(entries[j]);
> +               }
> +               kvfree(entries);
> +       }
>  reject:
>         return ret;
>  }
> @@ -1136,6 +1182,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
>         unsigned int dlen;
>         int ret;
>
> +       BUG_ON(PageTransHuge(page));
> +
>         /* find */
>         spin_lock(&tree->lock);
>         entry = zswap_entry_find_get(&tree->rbroot, offset);
> --
> 2.7.4
>
