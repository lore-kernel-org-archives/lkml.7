Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EE3C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69D1222BE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="APqGrdpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfJBU30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 16:29:26 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34008 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfJBU30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 16:29:26 -0400
Received: by mail-vs1-f68.google.com with SMTP id d3so157485vsr.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 13:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=f1uPZnw3jQ7XkJ0CCk+XRv8aHVS8VCW7XiwQkjgkuhk=;
        b=APqGrdpdkYEA5HmtGEspH/HP6wxxy4q59sbp1I5FOGjoRVE0ISlMc8A6+70SzcEUid
         kRvgxHonJJf2ee1TDY3oPKkwtpF6oIJZEu+4xupLOgZIUFc8Bnro1MJXJApbzFRIORrZ
         0quYQNafcCSI5jxhN6Mnvz+rSS2mMvwYZhmQJpKHGCZjQ0EzmCCevvgvhWRDJ1hcBCaZ
         /3tzEcXU1RVdAPA91CPtxlXpFRS6b3mQ36TC3EaDDfXSU0LDJDwrgm1iVDOiLMb8K3Dk
         I1wHC15oAagULEzw9Kb8b3wmMFJkP5adrpuOU7HYEIDikER4ifmZzHH/SUxrW8SVOzH/
         c8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=f1uPZnw3jQ7XkJ0CCk+XRv8aHVS8VCW7XiwQkjgkuhk=;
        b=U7w0ycDx9l35oA6l0kzsdNd9vPC6q5L6A6KjqrxtKd+O9FjRm72QhIQ3Idb1ydXK7q
         CZZinCskwsHnk2HSnX3qc4X8wwLyfLLfO3V0RDWX5ugdA9cFbSjWYuHytMKKCRaSxKfg
         1NrRNT6D5+LqiEgOO5SGoXkkL8mGgoSErlC6G86zLwABS2Q1a1GOnhtR+WFJdyvfT4BQ
         oRuldXkGyx/2F/VmKCjVOn/dKWz1AW1eRbm9nkIQ1KKrfqppQnq1oFBnRPZ4bl8MRhQm
         CeT7m3GH/7F2pB5jJeFFMhGASttwOcJgBObkoqaJHI6rnz0T0Sf1/sxNQfavFLGh7o01
         ibXA==
X-Gm-Message-State: APjAAAW/aB2LB8B2ZyEeulseA+ZVErWLpZOJUaBJfYbkylL43V2UkeG+
        NpYyDXSIn8Yi376KkJh1RBZEvYIpFXxJ3PpbeFHifw==
X-Google-Smtp-Source: APXvYqyQ7Wq5Q3hw3po2gtjaPw6idAVmlRaPK+hz2ZH+0kRGhFYI4E3DuDdG2MkLLMzUS/2pjp+eTCPKK2ByzG2OQpo=
X-Received: by 2002:a67:c81c:: with SMTP id u28mr3280729vsk.149.1570048164504;
 Wed, 02 Oct 2019 13:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191002202436.202731-1-dancol@google.com>
In-Reply-To: <20191002202436.202731-1-dancol@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 2 Oct 2019 13:28:48 -0700
Message-ID: <CAKOZuesMoBj-APjCipJmWcAgSzkbD1mvyOp0UvHLnkwR-EU4Ww@mail.gmail.com>
Subject: Re: [PATCH] Make SPLIT_RSS_COUNTING configurable
To:     Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-mm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the correct linux-mm address.


On Wed, Oct 2, 2019 at 1:25 PM Daniel Colascione <dancol@google.com> wrote:
>
> Using the new config option, users can disable SPLIT_RSS_COUNTING to
> get increased accuracy in user-visible mm counters.
>
> Signed-off-by: Daniel Colascione <dancol@google.com>
> ---
>  include/linux/mm.h            |  4 ++--
>  include/linux/mm_types_task.h |  5 ++---
>  include/linux/sched.h         |  2 +-
>  kernel/fork.c                 |  2 +-
>  mm/Kconfig                    | 11 +++++++++++
>  mm/memory.c                   |  6 +++---
>  6 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cc292273e6ba..221395de3cb4 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1637,7 +1637,7 @@ static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
>  {
>         long val = atomic_long_read(&mm->rss_stat.count[member]);
>
> -#ifdef SPLIT_RSS_COUNTING
> +#ifdef CONFIG_SPLIT_RSS_COUNTING
>         /*
>          * counter is updated in asynchronous manner and may go to minus.
>          * But it's never be expected number for users.
> @@ -1723,7 +1723,7 @@ static inline void setmax_mm_hiwater_rss(unsigned long *maxrss,
>                 *maxrss = hiwater_rss;
>  }
>
> -#if defined(SPLIT_RSS_COUNTING)
> +#ifdef CONFIG_SPLIT_RSS_COUNTING
>  void sync_mm_rss(struct mm_struct *mm);
>  #else
>  static inline void sync_mm_rss(struct mm_struct *mm)
> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
> index c1bc6731125c..d2adc8057e65 100644
> --- a/include/linux/mm_types_task.h
> +++ b/include/linux/mm_types_task.h
> @@ -48,14 +48,13 @@ enum {
>         NR_MM_COUNTERS
>  };
>
> -#if USE_SPLIT_PTE_PTLOCKS && defined(CONFIG_MMU)
> -#define SPLIT_RSS_COUNTING
> +#ifdef CONFIG_SPLIT_RSS_COUNTING
>  /* per-thread cached information, */
>  struct task_rss_stat {
>         int events;     /* for synchronization threshold */
>         int count[NR_MM_COUNTERS];
>  };
> -#endif /* USE_SPLIT_PTE_PTLOCKS */
> +#endif /* CONFIG_SPLIT_RSS_COUNTING */
>
>  struct mm_rss_stat {
>         atomic_long_t count[NR_MM_COUNTERS];
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 2c2e56bd8913..22f354774540 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -729,7 +729,7 @@ struct task_struct {
>         /* Per-thread vma caching: */
>         struct vmacache                 vmacache;
>
> -#ifdef SPLIT_RSS_COUNTING
> +#ifdef CONFIG_SPLIT_RSS_COUNTING
>         struct task_rss_stat            rss_stat;
>  #endif
>         int                             exit_state;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index f9572f416126..fc5e0889922b 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1917,7 +1917,7 @@ static __latent_entropy struct task_struct *copy_process(
>         p->vtime.state = VTIME_INACTIVE;
>  #endif
>
> -#if defined(SPLIT_RSS_COUNTING)
> +#ifdef CONFIG_SPLIT_RSS_COUNTING
>         memset(&p->rss_stat, 0, sizeof(p->rss_stat));
>  #endif
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index a5dae9a7eb51..372ef9449924 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -736,4 +736,15 @@ config ARCH_HAS_PTE_SPECIAL
>  config ARCH_HAS_HUGEPD
>         bool
>
> +config SPLIT_RSS_COUNTING
> +       bool "Per-thread mm counter caching"
> +       depends on MMU
> +       default y if NR_CPUS >= SPLIT_PTLOCK_CPUS
> +       help
> +         Cache mm counter updates in thread structures and
> +         flush them to visible per-process statistics in batches.
> +         Say Y here to slightly reduce cache contention in processes
> +         with many threads at the expense of decreasing the accuracy
> +         of memory statistics in /proc.
> +
>  endmenu
> diff --git a/mm/memory.c b/mm/memory.c
> index b1ca51a079f2..bf557ed5ba23 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -141,7 +141,7 @@ static int __init init_zero_pfn(void)
>  core_initcall(init_zero_pfn);
>
>
> -#if defined(SPLIT_RSS_COUNTING)
> +#ifdef CONFIG_SPLIT_RSS_COUNTING
>
>  void sync_mm_rss(struct mm_struct *mm)
>  {
> @@ -177,7 +177,7 @@ static void check_sync_rss_stat(struct task_struct *task)
>         if (unlikely(task->rss_stat.events++ > TASK_RSS_EVENTS_THRESH))
>                 sync_mm_rss(task->mm);
>  }
> -#else /* SPLIT_RSS_COUNTING */
> +#else /* CONFIG_SPLIT_RSS_COUNTING */
>
>  #define inc_mm_counter_fast(mm, member) inc_mm_counter(mm, member)
>  #define dec_mm_counter_fast(mm, member) dec_mm_counter(mm, member)
> @@ -186,7 +186,7 @@ static void check_sync_rss_stat(struct task_struct *task)
>  {
>  }
>
> -#endif /* SPLIT_RSS_COUNTING */
> +#endif /* CONFIG_SPLIT_RSS_COUNTING */
>
>  /*
>   * Note: this doesn't free the actual pages themselves. That
> --
> 2.23.0.581.g78d2f28ef7-goog
>
