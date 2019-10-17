Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA26ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779B421835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4PBZeTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409386AbfJQRaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:30:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40508 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403997AbfJQRaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:30:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id m61so4742011qte.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 10:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mGX9vaIDCI1sotCJkjHfZClQz41tv8YOiR2cF1zYR8o=;
        b=r4PBZeTZRvmKSicf/qeeQ3WDUVJ0oxwq3nL78LEr2+yzBe+kclAGtXrIbpRwJmNe0Y
         4obRbiov/a45KfzMYulGIL9dUxX/zPY0JzDtt0i9paARxuFAe5e9rkqLuf1IMLMqEGh/
         gxV16Nx99yfyV7IfRHiL2riav95kMsGx5vhAlJzRmInpq2OhoNb1nMKlyTNxJrz1kWft
         VZH20v3B/X+y+hqkUijDx3FQuYC98fMwNQzUgz34QAzF9lwzd5iZmnWkRYk60EK9FtxA
         16XE9MUpAiMvZaJxS3Zd+h8wbqz7tAQKqo4iQtuUpimKBvH+MqoRYmb4jXrC5fQqAawr
         y4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mGX9vaIDCI1sotCJkjHfZClQz41tv8YOiR2cF1zYR8o=;
        b=mB3MaNpjTJLrqSKkXX/BkFEmdB2MFcLOkqiXPNqeUby6TRvRt5RRJxPKesx6EQsMq6
         AhO19cNnV7+H7zcLhkkKx99GJSpAO/gpHbPgKruxbEz+xfJKsB/wDyKvd1IhFrcaQlJR
         AHohSXg963ZVgzGBqSHnpsx/xe/6zjP3CKCPbXLpI0qRwpZydaGNxW6RzTqMp88w8FUs
         yzNDJs5x/j3TM1xindFdNnNIVk0LGnjNbs2Y+dkIb6z+fSFXpZX7CxVTuvFixKUdBOTF
         Gqzxt6KKoqz2F1aQB31K/QvsidxFZodE9arRG9BwgHgGfmqf6EHrmVL/ruoCUnhgWCby
         ZUbQ==
X-Gm-Message-State: APjAAAUPKCBJyKA+NXARUmleKI+dHClqUDhOJYxAuZrYPhihILie8jUU
        9AnBk4Fp2RjjNzabqGDc4Rk7n16k847sRtJ42Wk=
X-Google-Smtp-Source: APXvYqxi/0Y1+0VN4xY6fSyHkuKRpmFoO3njU6Rtkx5NAvOrmnVruOIHR9lBcMQHBCEBfPsBx860CU1nyde/HZOsMM0=
X-Received: by 2002:aed:3b65:: with SMTP id q34mr5153897qte.376.1571333410639;
 Thu, 17 Oct 2019 10:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191016221148.F9CCD155@viggo.jf.intel.com> <20191016221152.BF2171A3@viggo.jf.intel.com>
In-Reply-To: <20191016221152.BF2171A3@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 17 Oct 2019 10:30:00 -0700
Message-ID: <CAHbLzkp_2UD50Vt8f_atxKcz4x8J3GB3YzTqMOd6Src_y2Yg2g@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm/vmscan: Attempt to migrate page in lieu of discard
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 3:14 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
>
> From: Keith Busch <keith.busch@intel.com>
>
> If a memory node has a preferred migration path to demote cold pages,
> attempt to move those inactive pages to that migration node before
> reclaiming. This will better utilize available memory, provide a faster
> tier than swapping or discarding, and allow such pages to be reused
> immediately without IO to retrieve the data.
>
> Much like swap, this is an opt-in feature that requires user defining
> where to send pages when reclaiming them. When handling anonymous pages,
> this will be considered before swap if enabled. Should the demotion fail
> for any reason, the page reclaim will proceed as if the demotion feature
> was not enabled.
>
> Some places we would like to see this used:
>
>   1. Persistent memory being as a slower, cheaper DRAM replacement
>   2. Remote memory-only "expansion" NUMA nodes
>   3. Resolving memory imbalances where one NUMA node is seeing more
>      allocation activity than another.  This helps keep more recent
>      allocations closer to the CPUs on the node doing the allocating.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> Co-developed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>
>  b/include/linux/migrate.h        |    6 ++++
>  b/include/trace/events/migrate.h |    3 +-
>  b/mm/debug.c                     |    1
>  b/mm/migrate.c                   |   51 +++++++++++++++++++++++++++++++++++++++
>  b/mm/vmscan.c                    |   27 ++++++++++++++++++++
>  5 files changed, 87 insertions(+), 1 deletion(-)
>
> diff -puN include/linux/migrate.h~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard include/linux/migrate.h
> --- a/include/linux/migrate.h~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard 2019-10-16 15:06:58.090952593 -0700
> +++ b/include/linux/migrate.h   2019-10-16 15:06:58.103952593 -0700
> @@ -25,6 +25,7 @@ enum migrate_reason {
>         MR_MEMPOLICY_MBIND,
>         MR_NUMA_MISPLACED,
>         MR_CONTIG_RANGE,
> +       MR_DEMOTION,
>         MR_TYPES
>  };
>
> @@ -79,6 +80,7 @@ extern int migrate_huge_page_move_mappin
>  extern int migrate_page_move_mapping(struct address_space *mapping,
>                 struct page *newpage, struct page *page, enum migrate_mode mode,
>                 int extra_count);
> +extern int migrate_demote_mapping(struct page *page);
>  #else
>
>  static inline void putback_movable_pages(struct list_head *l) {}
> @@ -105,6 +107,10 @@ static inline int migrate_huge_page_move
>         return -ENOSYS;
>  }
>
> +static inline int migrate_demote_mapping(struct page *page)
> +{
> +       return -ENOSYS;
> +}
>  #endif /* CONFIG_MIGRATION */
>
>  #ifdef CONFIG_COMPACTION
> diff -puN include/trace/events/migrate.h~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard include/trace/events/migrate.h
> --- a/include/trace/events/migrate.h~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard  2019-10-16 15:06:58.092952593 -0700
> +++ b/include/trace/events/migrate.h    2019-10-16 15:06:58.103952593 -0700
> @@ -20,7 +20,8 @@
>         EM( MR_SYSCALL,         "syscall_or_cpuset")            \
>         EM( MR_MEMPOLICY_MBIND, "mempolicy_mbind")              \
>         EM( MR_NUMA_MISPLACED,  "numa_misplaced")               \
> -       EMe(MR_CONTIG_RANGE,    "contig_range")
> +       EM( MR_CONTIG_RANGE,    "contig_range")                 \
> +       EMe(MR_DEMOTION,        "demotion")
>
>  /*
>   * First define the enums in the above macros to be exported to userspace
> diff -puN mm/debug.c~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard mm/debug.c
> --- a/mm/debug.c~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard      2019-10-16 15:06:58.094952593 -0700
> +++ b/mm/debug.c        2019-10-16 15:06:58.103952593 -0700
> @@ -25,6 +25,7 @@ const char *migrate_reason_names[MR_TYPE
>         "mempolicy_mbind",
>         "numa_misplaced",
>         "cma",
> +       "demotion",
>  };
>
>  const struct trace_print_flags pageflag_names[] = {
> diff -puN mm/migrate.c~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard mm/migrate.c
> --- a/mm/migrate.c~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard    2019-10-16 15:06:58.097952593 -0700
> +++ b/mm/migrate.c      2019-10-16 15:06:58.104952593 -0700
> @@ -1119,6 +1119,57 @@ out:
>         return rc;
>  }
>
> +static struct page *alloc_demote_node_page(struct page *page, unsigned long node)
> +{
> +       /*
> +        * The flags are set to allocate only on the desired node in the
> +        * migration path, and to fail fast if not immediately available. We
> +        * are already doing memory reclaim, we don't want heroic efforts to
> +        * get a page.
> +        */
> +       gfp_t mask = GFP_NOWAIT | __GFP_NOWARN | __GFP_NORETRY |
> +                       __GFP_NOMEMALLOC | __GFP_THISNODE | __GFP_MOVABLE;
> +       struct page *newpage;
> +
> +       if (PageTransHuge(page)) {
> +               mask |= __GFP_COMP;
> +               newpage = alloc_pages_node(node, mask, HPAGE_PMD_ORDER);
> +               if (newpage)
> +                       prep_transhuge_page(newpage);
> +       } else
> +               newpage = alloc_pages_node(node, mask, 0);
> +
> +       return newpage;
> +}
> +
> +/**
> + * migrate_demote_mapping() - Migrate this page and its mappings to its
> + *                            demotion node.
> + * @page: A locked, isolated, non-huge page that should migrate to its current
> + *        node's demotion target, if available. Since this is intended to be
> + *        called during memory reclaim, all flag options are set to fail fast.
> + *
> + * @returns: MIGRATEPAGE_SUCCESS if successful, -errno otherwise.
> + */
> +int migrate_demote_mapping(struct page *page)
> +{
> +       int next_nid = next_migration_node(page_to_nid(page));
> +
> +       VM_BUG_ON_PAGE(!PageLocked(page), page);
> +       VM_BUG_ON_PAGE(PageHuge(page), page);
> +       VM_BUG_ON_PAGE(PageLRU(page), page);
> +
> +       if (next_nid < 0)
> +               return -ENOSYS;
> +       if (PageTransHuge(page) && !thp_migration_supported())
> +               return -ENOMEM;
> +
> +       /* MIGRATE_ASYNC is the most light weight and never blocks.*/
> +       return __unmap_and_move(alloc_demote_node_page, NULL, next_nid,
> +                               page, MIGRATE_ASYNC, MR_DEMOTION);
> +}
> +
> +
>  /*
>   * gcc 4.7 and 4.8 on arm get an ICEs when inlining unmap_and_move().  Work
>   * around it.
> diff -puN mm/vmscan.c~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard mm/vmscan.c
> --- a/mm/vmscan.c~0005-mm-vmscan-Attempt-to-migrate-page-in-lieu-of-discard     2019-10-16 15:06:58.099952593 -0700
> +++ b/mm/vmscan.c       2019-10-16 15:06:58.105952593 -0700
> @@ -1262,6 +1262,33 @@ static unsigned long shrink_page_list(st
>                         ; /* try to reclaim the page below */
>                 }
>
> +               if (!PageHuge(page)) {
> +                       int rc = migrate_demote_mapping(page);
> +
> +                       /*
> +                        * -ENOMEM on a THP may indicate either migration is
> +                        * unsupported or there was not enough contiguous
> +                        * space. Split the THP into base pages and retry the
> +                        * head immediately. The tail pages will be considered
> +                        * individually within the current loop's page list.
> +                        */
> +                       if (rc == -ENOMEM && PageTransHuge(page) &&
> +                           !split_huge_page_to_list(page, page_list))
> +                               rc = migrate_demote_mapping(page);

I recalled when Keith posted the patch at the first time, I raised
question about why not just migrating THP in a whole? The
migrate_pages() could handle this. If it fails, it just fallbacks to
base page.

Since the most optimistic gfp flags are used, it should not trap into
nested direct reclaim. The migrate_pages() should just return failure
then fallback to base page.

> +
> +                       if (rc == MIGRATEPAGE_SUCCESS) {
> +                               unlock_page(page);
> +                               if (likely(put_page_testzero(page)))
> +                                       goto free_it;
> +                               /*
> +                                * Speculative reference will free this page,
> +                                * so leave it off the LRU.
> +                                */
> +                               nr_reclaimed++;
> +                               continue;
> +                       }
> +               }
> +
>                 /*
>                  * Anonymous process memory has backing store?
>                  * Try to allocate it some swap space here.
> _
>
