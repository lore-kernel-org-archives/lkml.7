Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608EBC47404
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 02:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33431222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 02:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ovk93Uox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfJCCIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 22:08:55 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37966 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfJCCIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 22:08:54 -0400
Received: by mail-vs1-f68.google.com with SMTP id b123so621956vsb.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 19:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCQGlGZ8Y+oVDG1Ma6bLrg91foqSNXoF97NZ5ZFwA/Q=;
        b=Ovk93Uox7JXnsQtTFYgx2Nsi6AhN0kIgTPhfn9/Ibu3FWsaIoNsskyitFtm9f8MS/Y
         GsUw61dgeePnDZEMKu/fDvcsVbMQDn8Dnyx6kv6k10smk4yKuXecq2x/iX2gopVCgOWn
         2akggopW8lb7P4ztlteq7SpOJpSzawaocQkuCzcuL15bSzdqQlHTGySJ/kQWq66thRXy
         ypkvq/Ulvidr3YtZ2tfEG4s5txrnFE73oWSBNuCM1CYgop4kGmWa3JuJx1TcOXnSz3td
         o4/ppDp2yLaGKiLXp3hZZxwzd6WIeiQ9eckn7yI7KEsiEoB6YbNV7lovQJ5huOGVXNS1
         /RGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCQGlGZ8Y+oVDG1Ma6bLrg91foqSNXoF97NZ5ZFwA/Q=;
        b=tJ9pqcGHEvykwrNt9Q+tAkazU9QozcApDT9E3nbS40bQc7+uXxj/7CdmFFsEclndXz
         DQTebhQbIJWZ8JUwyOC+kiGg5vHpHUfiiXAYpTnpihy7Gi0QLeIy4DN5XTLDF/ElYgBn
         hNPW2A1DK2XOa2X88NRbBPSRVV3B9H19P742ihjdr7LwApTTPWn1C1Tpev7HYh0jBuoq
         UklToxuNrISRL5eMQ00LjbFdA0whwz2aaWDcVtNc6C6jEy1j7h3Cys4jyTaUPGry83ZY
         9AGITyRJEMc+WICRFKeQQfNtBF8YoVNCTDIUYICrxG/rA4A7POnrF9Xoa7PsSdvPqIl4
         Y0YQ==
X-Gm-Message-State: APjAAAXqLPeWO8JYFDCo2vkRuAxX41lZhdrhIro0CEcPBBRA6Rpgs74r
        NaruP3/1elKXw4wpTtPt1QNdTzgaV7OV2VEqzZlfNg==
X-Google-Smtp-Source: APXvYqyi0m2Ede72KrDlWODF8m+LzvY0aTakQKoIvxaf/PDUucc/aAOF/PTV+/ueCyA8VW2bLR96Ab0ft94lN+2AmtQ=
X-Received: by 2002:a67:f0cd:: with SMTP id j13mr3958561vsl.183.1570068532914;
 Wed, 02 Oct 2019 19:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAKOZuesMoBj-APjCipJmWcAgSzkbD1mvyOp0UvHLnkwR-EU4Ww@mail.gmail.com>
 <1C584B5C-E04E-4B04-A3B5-4DC8E5E67366@lca.pw>
In-Reply-To: <1C584B5C-E04E-4B04-A3B5-4DC8E5E67366@lca.pw>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 2 Oct 2019 19:08:16 -0700
Message-ID: <CAKOZuesKY_=qkSXfmDO_1ALaqQtU0kz5Z+fBh05c8BR7oCDxKw@mail.gmail.com>
Subject: Re: [PATCH] Make SPLIT_RSS_COUNTING configurable
To:     Qian Cai <cai@lca.pw>
Cc:     Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-mm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 6:56 PM Qian Cai <cai@lca.pw> wrote:
> > On Oct 2, 2019, at 4:29 PM, Daniel Colascione <dancol@google.com> wrote:
> >
> > Adding the correct linux-mm address.
> >
> >
> >> On Wed, Oct 2, 2019 at 1:25 PM Daniel Colascione <dancol@google.com> wrote:
> >>
> >> Using the new config option, users can disable SPLIT_RSS_COUNTING to
> >> get increased accuracy in user-visible mm counters.
> >>
> >> Signed-off-by: Daniel Colascione <dancol@google.com>
> >> ---
> >> include/linux/mm.h            |  4 ++--
> >> include/linux/mm_types_task.h |  5 ++---
> >> include/linux/sched.h         |  2 +-
> >> kernel/fork.c                 |  2 +-
> >> mm/Kconfig                    | 11 +++++++++++
> >> mm/memory.c                   |  6 +++---
> >> 6 files changed, 20 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> index cc292273e6ba..221395de3cb4 100644
> >> --- a/include/linux/mm.h
> >> +++ b/include/linux/mm.h
> >> @@ -1637,7 +1637,7 @@ static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
> >> {
> >>        long val = atomic_long_read(&mm->rss_stat.count[member]);
> >>
> >> -#ifdef SPLIT_RSS_COUNTING
> >> +#ifdef CONFIG_SPLIT_RSS_COUNTING
> >>        /*
> >>         * counter is updated in asynchronous manner and may go to minus.
> >>         * But it's never be expected number for users.
> >> @@ -1723,7 +1723,7 @@ static inline void setmax_mm_hiwater_rss(unsigned long *maxrss,
> >>                *maxrss = hiwater_rss;
> >> }
> >>
> >> -#if defined(SPLIT_RSS_COUNTING)
> >> +#ifdef CONFIG_SPLIT_RSS_COUNTING
> >> void sync_mm_rss(struct mm_struct *mm);
> >> #else
> >> static inline void sync_mm_rss(struct mm_struct *mm)
> >> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
> >> index c1bc6731125c..d2adc8057e65 100644
> >> --- a/include/linux/mm_types_task.h
> >> +++ b/include/linux/mm_types_task.h
> >> @@ -48,14 +48,13 @@ enum {
> >>        NR_MM_COUNTERS
> >> };
> >>
> >> -#if USE_SPLIT_PTE_PTLOCKS && defined(CONFIG_MMU)
> >> -#define SPLIT_RSS_COUNTING
> >> +#ifdef CONFIG_SPLIT_RSS_COUNTING
> >> /* per-thread cached information, */
> >> struct task_rss_stat {
> >>        int events;     /* for synchronization threshold */
> >>        int count[NR_MM_COUNTERS];
> >> };
> >> -#endif /* USE_SPLIT_PTE_PTLOCKS */
> >> +#endif /* CONFIG_SPLIT_RSS_COUNTING */
> >>
> >> struct mm_rss_stat {
> >>        atomic_long_t count[NR_MM_COUNTERS];
> >> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >> index 2c2e56bd8913..22f354774540 100644
> >> --- a/include/linux/sched.h
> >> +++ b/include/linux/sched.h
> >> @@ -729,7 +729,7 @@ struct task_struct {
> >>        /* Per-thread vma caching: */
> >>        struct vmacache                 vmacache;
> >>
> >> -#ifdef SPLIT_RSS_COUNTING
> >> +#ifdef CONFIG_SPLIT_RSS_COUNTING
> >>        struct task_rss_stat            rss_stat;
> >> #endif
> >>        int                             exit_state;
> >> diff --git a/kernel/fork.c b/kernel/fork.c
> >> index f9572f416126..fc5e0889922b 100644
> >> --- a/kernel/fork.c
> >> +++ b/kernel/fork.c
> >> @@ -1917,7 +1917,7 @@ static __latent_entropy struct task_struct *copy_process(
> >>        p->vtime.state = VTIME_INACTIVE;
> >> #endif
> >>
> >> -#if defined(SPLIT_RSS_COUNTING)
> >> +#ifdef CONFIG_SPLIT_RSS_COUNTING
> >>        memset(&p->rss_stat, 0, sizeof(p->rss_stat));
> >> #endif
> >>
> >> diff --git a/mm/Kconfig b/mm/Kconfig
> >> index a5dae9a7eb51..372ef9449924 100644
> >> --- a/mm/Kconfig
> >> +++ b/mm/Kconfig
> >> @@ -736,4 +736,15 @@ config ARCH_HAS_PTE_SPECIAL
> >> config ARCH_HAS_HUGEPD
> >>        bool
> >>
> >> +config SPLIT_RSS_COUNTING
> >> +       bool "Per-thread mm counter caching"
> >> +       depends on MMU
> >> +       default y if NR_CPUS >= SPLIT_PTLOCK_CPUS
> >> +       help
> >> +         Cache mm counter updates in thread structures and
> >> +         flush them to visible per-process statistics in batches.
> >> +         Say Y here to slightly reduce cache contention in processes
> >> +         with many threads at the expense of decreasing the accuracy
> >> +         of memory statistics in /proc.
> >> +
> >> endmenu
>
> All those vague words are going to make developers almost impossible to decide the right selection here. It sounds like we should kill SPLIT_RSS_COUNTING at all to simplify the code as the benefit is so small vs the side-effect?

Killing SPLIT_RSS_COUNTING would be my first choice; IME, on mobile
and a basic desktop, it doesn't make a difference. I figured making it
a knob would help allay concerns about the performance impact in more
extreme configurations.
