Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E33EC606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1129620861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRm7CEmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfGHMYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:24:24 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36668 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbfGHMYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:24:24 -0400
Received: by mail-vs1-f68.google.com with SMTP id y16so4408633vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 05:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rg4MZJQiK2ZP4k/WMhKh/GPlODQc9jl1pEnyIDd5Q4=;
        b=FRm7CEmqQ5zN8esP8+5UvW+11WQYFj5D2lLoTdTyCLPW16RpjkAoqZhhc5A1uR88HD
         FeLtQA5s0KqDslLkWXQNvYz0io+Ym0eGFf5xYLbtCjwkHFUWZsKasTzqMxYvtTfWTX75
         5asYRDYf+soIzzkn7YmL/4bFuNKH+xcuM4SR7TdVgUZ9iOXFui3K4QSDmEQOlIPJ0cDX
         8e4LigwgCZhUZ70ZRGPv0VYTIIpyXIppMjN1rUlxIylXtl2v5WZNUsLGbj33mSFR+LNU
         6IOB9zTZDuHIh/yfUyEoNocwY5EUyDs9kWAum/zd1l6OAssr/7pyrcmceHkUmWcAF0mS
         NJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rg4MZJQiK2ZP4k/WMhKh/GPlODQc9jl1pEnyIDd5Q4=;
        b=S8DB7RzrEbdfmRCzO6/hIGFcFpPH1OuMfpXb8S14SYWTnWWgXTdaPFqfi1WH5aRDEw
         kQqeHP+jOgNimzihfmlmwSKFgtlE98vfI1mBxCVYZMRMtqpJe3u0g8xwziI0xA2DO8V3
         S2ACukI4eGHsmBW5QZdigPiucScXhFWC95BXr4FWuyJoJkcQa5YdEj3ig1WFft4BjeJo
         R4oxnNwPIjrA+GHvbmZVSsIURqnFy3qG6TmjvCDyo3Ua0l3kRcuCyxSRr8jsFCFB56RW
         eMCvY802VvPv1XOwZOmMMo28psbkXtpAG1EU3lODO6wmjE4sqYUh2cnZltjwlgFSmtW6
         3nEw==
X-Gm-Message-State: APjAAAXLigST9Xce8z202MbOk5Be+QtU5PX8uMZL1AupM7zbRMQR9jyX
        fnc2YVG32kv7vI8CnqFLvHAjmdDbmAqAJ5+BJyQsbw==
X-Google-Smtp-Source: APXvYqyeDVOlj7ZYfos3um5AYJlNGitashChx+cPvZv1rWiPezlJpBziwOJ8vi53WG7Sr+KQR8Y42auNxvZ1fb4DTzA=
X-Received: by 2002:a67:e98f:: with SMTP id b15mr10061249vso.209.1562588662601;
 Mon, 08 Jul 2019 05:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190703040156.56953-1-walken@google.com> <20190703040156.56953-3-walken@google.com>
In-Reply-To: <20190703040156.56953-3-walken@google.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Mon, 8 Jul 2019 05:24:09 -0700
Message-ID: <CANN689FXgK13wDYNh1zKxdipeTuALG4eKvKpsdZqKFJ-rvtGiQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] augmented rbtree: add new RB_DECLARE_CALLBACKS_MAX macro
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syncing up with v5.2, I see that there is a new use for augmented
rbtrees in mm/vmalloc.c which does not compile after applying my
patchset.

It's an easy fix though:

diff --git mm/vmalloc.c mm/vmalloc.c
index 0f76cca32a1c..fe2e8892188b 100644
--- mm/vmalloc.c
+++ mm/vmalloc.c
@@ -391,9 +391,8 @@ compute_subtree_max_size(struct vmap_area *va)
                get_subtree_max_size(va->rb_node.rb_right));
 }

-RB_DECLARE_CALLBACKS(static, free_vmap_area_rb_augment_cb,
-       struct vmap_area, rb_node, unsigned long, subtree_max_size,
-       compute_subtree_max_size)
+RB_DECLARE_CALLBACKS_MAX(static, free_vmap_area_rb_augment_cb,
+       struct vmap_area, rb_node, unsigned long, subtree_max_size, va_size)

 static void purge_vmap_area_lazy(void);
 static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);


(probably going to get mangled by gmail, but the gist of it is that
RB_DECLARE_CALLBACKS is replaced by RB_DECLARE_CALLBACKS_MAX and the
compute_subtree_max_size argument is replaced by va_size)


Note for Uladzislau Rezki, I noticed that the new augmented rbtree
code defines its own augment_tree_propagate_from function to update
the augmented subtree information after a node is modified; it would
probably be feasible to rely on the generated
free_vmap_area_rb_augment_cb_propagate function instead. mm/mmap.c
does something similar in vma_gap_update(), for a very similar use
case.

On Tue, Jul 2, 2019 at 9:02 PM Michel Lespinasse <walken@google.com> wrote:
>
> Add RB_DECLARE_CALLBACKS_MAX, which generates augmented rbtree callbacks
> for the case where the augmented value is a scalar whose definition
> follows a max(f(node)) pattern. This actually covers all present uses
> of RB_DECLARE_CALLBACKS, and saves some (source) code duplication in the
> various RBCOMPUTE function definitions.
>
> Signed-off-by: Michel Lespinasse <walken@google.com>
> ---
>  arch/x86/mm/pat_rbtree.c               | 19 +++-----------
>  drivers/block/drbd/drbd_interval.c     | 29 +++------------------
>  include/linux/interval_tree_generic.h  | 22 ++--------------
>  include/linux/rbtree_augmented.h       | 36 +++++++++++++++++++++++++-
>  lib/rbtree_test.c                      | 22 +++-------------
>  mm/mmap.c                              | 29 +++++++++++++--------
>  tools/include/linux/rbtree_augmented.h | 36 +++++++++++++++++++++++++-
>  7 files changed, 99 insertions(+), 94 deletions(-)
>
> diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
> index fa16036fa592..65ebe4b88f7c 100644
> --- a/arch/x86/mm/pat_rbtree.c
> +++ b/arch/x86/mm/pat_rbtree.c
> @@ -54,23 +54,10 @@ static u64 get_subtree_max_end(struct rb_node *node)
>         return ret;
>  }
>
> -static u64 compute_subtree_max_end(struct memtype *data)
> -{
> -       u64 max_end = data->end, child_max_end;
> -
> -       child_max_end = get_subtree_max_end(data->rb.rb_right);
> -       if (child_max_end > max_end)
> -               max_end = child_max_end;
> -
> -       child_max_end = get_subtree_max_end(data->rb.rb_left);
> -       if (child_max_end > max_end)
> -               max_end = child_max_end;
> -
> -       return max_end;
> -}
> +#define NODE_END(node) ((node)->end)
>
> -RB_DECLARE_CALLBACKS(static, memtype_rb_augment_cb, struct memtype, rb,
> -                    u64, subtree_max_end, compute_subtree_max_end)
> +RB_DECLARE_CALLBACKS_MAX(static, memtype_rb_augment_cb,
> +                        struct memtype, rb, u64, subtree_max_end, NODE_END)
>
>  /* Find the first (lowest start addr) overlapping range from rb tree */
>  static struct memtype *memtype_rb_lowest_match(struct rb_root *root,
> diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
> index c58986556161..651bd0236a99 100644
> --- a/drivers/block/drbd/drbd_interval.c
> +++ b/drivers/block/drbd/drbd_interval.c
> @@ -13,33 +13,10 @@ sector_t interval_end(struct rb_node *node)
>         return this->end;
>  }
>
> -/**
> - * compute_subtree_last  -  compute end of @node
> - *
> - * The end of an interval is the highest (start + (size >> 9)) value of this
> - * node and of its children.  Called for @node and its parents whenever the end
> - * may have changed.
> - */
> -static inline sector_t
> -compute_subtree_last(struct drbd_interval *node)
> -{
> -       sector_t max = node->sector + (node->size >> 9);
> -
> -       if (node->rb.rb_left) {
> -               sector_t left = interval_end(node->rb.rb_left);
> -               if (left > max)
> -                       max = left;
> -       }
> -       if (node->rb.rb_right) {
> -               sector_t right = interval_end(node->rb.rb_right);
> -               if (right > max)
> -                       max = right;
> -       }
> -       return max;
> -}
> +#define NODE_END(node) ((node)->sector + ((node)->size >> 9))
>
> -RB_DECLARE_CALLBACKS(static, augment_callbacks, struct drbd_interval, rb,
> -                    sector_t, end, compute_subtree_last);
> +RB_DECLARE_CALLBACKS_MAX(static, augment_callbacks,
> +                        struct drbd_interval, rb, sector_t, end, NODE_END);
>
>  /**
>   * drbd_insert_interval  -  insert a new interval into a tree
> diff --git a/include/linux/interval_tree_generic.h b/include/linux/interval_tree_generic.h
> index 1f97ce26cccc..205218a941e1 100644
> --- a/include/linux/interval_tree_generic.h
> +++ b/include/linux/interval_tree_generic.h
> @@ -42,26 +42,8 @@
>                                                                               \
>  /* Callbacks for augmented rbtree insert and remove */                       \
>                                                                               \
> -static inline ITTYPE ITPREFIX ## _compute_subtree_last(ITSTRUCT *node)       \
> -{                                                                            \
> -       ITTYPE max = ITLAST(node), subtree_last;                              \
> -       if (node->ITRB.rb_left) {                                             \
> -               subtree_last = rb_entry(node->ITRB.rb_left,                   \
> -                                       ITSTRUCT, ITRB)->ITSUBTREE;           \
> -               if (max < subtree_last)                                       \
> -                       max = subtree_last;                                   \
> -       }                                                                     \
> -       if (node->ITRB.rb_right) {                                            \
> -               subtree_last = rb_entry(node->ITRB.rb_right,                  \
> -                                       ITSTRUCT, ITRB)->ITSUBTREE;           \
> -               if (max < subtree_last)                                       \
> -                       max = subtree_last;                                   \
> -       }                                                                     \
> -       return max;                                                           \
> -}                                                                            \
> -                                                                             \
> -RB_DECLARE_CALLBACKS(static, ITPREFIX ## _augment, ITSTRUCT, ITRB,           \
> -                    ITTYPE, ITSUBTREE, ITPREFIX ## _compute_subtree_last)    \
> +RB_DECLARE_CALLBACKS_MAX(static, ITPREFIX ## _augment,                       \
> +                        ITSTRUCT, ITRB, ITTYPE, ITSUBTREE, ITLAST)           \
>                                                                               \
>  /* Insert / remove interval nodes from the tree */                           \
>                                                                               \
> diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
> index 5923495276e0..c5379d762fa9 100644
> --- a/include/linux/rbtree_augmented.h
> +++ b/include/linux/rbtree_augmented.h
> @@ -73,7 +73,7 @@ rb_insert_augmented_cached(struct rb_node *node,
>  }
>
>  /*
> - * Template for declaring augmented rbtree callbacks
> + * Template for declaring augmented rbtree callbacks (generic case)
>   *
>   * RBSTATIC:    'static' or empty
>   * RBNAME:      name of the rb_augment_callbacks structure
> @@ -119,6 +119,40 @@ RBSTATIC const struct rb_augment_callbacks RBNAME = {                      \
>         .rotate = RBNAME ## _rotate                                     \
>  };
>
> +/*
> + * Template for declaring augmented rbtree callbacks,
> + * computing RBAUGMENTED scalar as max(RBCOMPUTE(node)) for all subtree nodes.
> + *
> + * RBSTATIC:    'static' or empty
> + * RBNAME:      name of the rb_augment_callbacks structure
> + * RBSTRUCT:    struct type of the tree nodes
> + * RBFIELD:     name of struct rb_node field within RBSTRUCT
> + * RBTYPE:      type of the RBAUGMENTED field
> + * RBAUGMENTED: name of RBTYPE field within RBSTRUCT holding data for subtree
> + * RBCOMPUTE:   name of function that returns the per-node RBTYPE scalar
> + */
> +
> +#define RB_DECLARE_CALLBACKS_MAX(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,        \
> +                                RBTYPE, RBAUGMENTED, RBCOMPUTE)              \
> +static inline RBTYPE RBNAME ## _compute_max(RBSTRUCT *node)                  \
> +{                                                                            \
> +       RBSTRUCT *child;                                                      \
> +       RBTYPE max = RBCOMPUTE(node);                                         \
> +       if (node->RBFIELD.rb_left) {                                          \
> +               child = rb_entry(node->RBFIELD.rb_left, RBSTRUCT, RBFIELD);   \
> +               if (child->RBAUGMENTED > max)                                 \
> +                       max = child->RBAUGMENTED;                             \
> +       }                                                                     \
> +       if (node->RBFIELD.rb_right) {                                         \
> +               child = rb_entry(node->RBFIELD.rb_right, RBSTRUCT, RBFIELD);  \
> +               if (child->RBAUGMENTED > max)                                 \
> +                       max = child->RBAUGMENTED;                             \
> +       }                                                                     \
> +       return max;                                                           \
> +}                                                                            \
> +RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,                    \
> +                    RBTYPE, RBAUGMENTED, RBNAME ## _compute_max)
> +
>
>  #define        RB_RED          0
>  #define        RB_BLACK        1
> diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
> index b7055b2a07d3..2631bcaada41 100644
> --- a/lib/rbtree_test.c
> +++ b/lib/rbtree_test.c
> @@ -76,26 +76,10 @@ static inline void erase_cached(struct test_node *node, struct rb_root_cached *r
>  }
>
>
> -static inline u32 augment_recompute(struct test_node *node)
> -{
> -       u32 max = node->val, child_augmented;
> -       if (node->rb.rb_left) {
> -               child_augmented = rb_entry(node->rb.rb_left, struct test_node,
> -                                          rb)->augmented;
> -               if (max < child_augmented)
> -                       max = child_augmented;
> -       }
> -       if (node->rb.rb_right) {
> -               child_augmented = rb_entry(node->rb.rb_right, struct test_node,
> -                                          rb)->augmented;
> -               if (max < child_augmented)
> -                       max = child_augmented;
> -       }
> -       return max;
> -}
> +#define NODE_VAL(node) ((node)->val)
>
> -RB_DECLARE_CALLBACKS(static, augment_callbacks, struct test_node, rb,
> -                    u32, augmented, augment_recompute)
> +RB_DECLARE_CALLBACKS_MAX(static, augment_callbacks,
> +                        struct test_node, rb, u32, augmented, NODE_VAL)
>
>  static void insert_augmented(struct test_node *node,
>                              struct rb_root_cached *root)
> diff --git a/mm/mmap.c b/mm/mmap.c
> index bd7b9f293b39..39ce2acf4ec3 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -288,9 +288,9 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>         return retval;
>  }
>
> -static long vma_compute_subtree_gap(struct vm_area_struct *vma)
> +static inline unsigned long vma_compute_gap(struct vm_area_struct *vma)
>  {
> -       unsigned long max, prev_end, subtree_gap;
> +       unsigned long gap, prev_end;
>
>         /*
>          * Note: in the rare case of a VM_GROWSDOWN above a VM_GROWSUP, we
> @@ -298,14 +298,21 @@ static long vma_compute_subtree_gap(struct vm_area_struct *vma)
>          * an unmapped area; whereas when expanding we only require one.
>          * That's a little inconsistent, but keeps the code here simpler.
>          */
> -       max = vm_start_gap(vma);
> +       gap = vm_start_gap(vma);
>         if (vma->vm_prev) {
>                 prev_end = vm_end_gap(vma->vm_prev);
> -               if (max > prev_end)
> -                       max -= prev_end;
> +               if (gap > prev_end)
> +                       gap -= prev_end;
>                 else
> -                       max = 0;
> +                       gap = 0;
>         }
> +       return gap;
> +}
> +
> +#ifdef CONFIG_DEBUG_VM_RB
> +static unsigned long vma_compute_subtree_gap(struct vm_area_struct *vma)
> +{
> +       unsigned long max = vma_compute_gap(vma), subtree_gap;
>         if (vma->vm_rb.rb_left) {
>                 subtree_gap = rb_entry(vma->vm_rb.rb_left,
>                                 struct vm_area_struct, vm_rb)->rb_subtree_gap;
> @@ -321,7 +328,6 @@ static long vma_compute_subtree_gap(struct vm_area_struct *vma)
>         return max;
>  }
>
> -#ifdef CONFIG_DEBUG_VM_RB
>  static int browse_rb(struct mm_struct *mm)
>  {
>         struct rb_root *root = &mm->mm_rb;
> @@ -427,8 +433,9 @@ static void validate_mm(struct mm_struct *mm)
>  #define validate_mm(mm) do { } while (0)
>  #endif
>
> -RB_DECLARE_CALLBACKS(static, vma_gap_callbacks, struct vm_area_struct, vm_rb,
> -                    unsigned long, rb_subtree_gap, vma_compute_subtree_gap)
> +RB_DECLARE_CALLBACKS_MAX(static, vma_gap_callbacks,
> +                        struct vm_area_struct, vm_rb,
> +                        unsigned long, rb_subtree_gap, vma_compute_gap)
>
>  /*
>   * Update augmented rbtree rb_subtree_gap values after vma->vm_start or
> @@ -438,8 +445,8 @@ RB_DECLARE_CALLBACKS(static, vma_gap_callbacks, struct vm_area_struct, vm_rb,
>  static void vma_gap_update(struct vm_area_struct *vma)
>  {
>         /*
> -        * As it turns out, RB_DECLARE_CALLBACKS() already created a callback
> -        * function that does exactly what we want.
> +        * As it turns out, RB_DECLARE_CALLBACKS_MAX() already created
> +        * a callback function that does exactly what we want.
>          */
>         vma_gap_callbacks_propagate(&vma->vm_rb, NULL);
>  }
> diff --git a/tools/include/linux/rbtree_augmented.h b/tools/include/linux/rbtree_augmented.h
> index f46c1bf91f64..10a2f3f8c801 100644
> --- a/tools/include/linux/rbtree_augmented.h
> +++ b/tools/include/linux/rbtree_augmented.h
> @@ -75,7 +75,7 @@ rb_insert_augmented_cached(struct rb_node *node,
>  }
>
>  /*
> - * Template for declaring augmented rbtree callbacks
> + * Template for declaring augmented rbtree callbacks (generic case)
>   *
>   * RBSTATIC:    'static' or empty
>   * RBNAME:      name of the rb_augment_callbacks structure
> @@ -121,6 +121,40 @@ RBSTATIC const struct rb_augment_callbacks RBNAME = {                      \
>         .rotate = RBNAME ## _rotate                                     \
>  };
>
> +/*
> + * Template for declaring augmented rbtree callbacks,
> + * computing RBAUGMENTED scalar as max(RBCOMPUTE(node)) for all subtree nodes.
> + *
> + * RBSTATIC:    'static' or empty
> + * RBNAME:      name of the rb_augment_callbacks structure
> + * RBSTRUCT:    struct type of the tree nodes
> + * RBFIELD:     name of struct rb_node field within RBSTRUCT
> + * RBTYPE:      type of the RBAUGMENTED field
> + * RBAUGMENTED: name of RBTYPE field within RBSTRUCT holding data for subtree
> + * RBCOMPUTE:   name of function that returns the per-node RBTYPE scalar
> + */
> +
> +#define RB_DECLARE_CALLBACKS_MAX(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,        \
> +                                RBTYPE, RBAUGMENTED, RBCOMPUTE)              \
> +static inline RBTYPE RBNAME ## _compute_max(RBSTRUCT *node)                  \
> +{                                                                            \
> +       RBSTRUCT *child;                                                      \
> +       RBTYPE max = RBCOMPUTE(node);                                         \
> +       if (node->RBFIELD.rb_left) {                                          \
> +               child = rb_entry(node->RBFIELD.rb_left, RBSTRUCT, RBFIELD);   \
> +               if (child->RBAUGMENTED > max)                                 \
> +                       max = child->RBAUGMENTED;                             \
> +       }                                                                     \
> +       if (node->RBFIELD.rb_right) {                                         \
> +               child = rb_entry(node->RBFIELD.rb_right, RBSTRUCT, RBFIELD);  \
> +               if (child->RBAUGMENTED > max)                                 \
> +                       max = child->RBAUGMENTED;                             \
> +       }                                                                     \
> +       return max;                                                           \
> +}                                                                            \
> +RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,                    \
> +                    RBTYPE, RBAUGMENTED, RBNAME ## _compute_max)
> +
>
>  #define        RB_RED          0
>  #define        RB_BLACK        1
> --
> 2.22.0.410.gd8fdbe21b5-goog
>


-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
