Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD271C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E28120700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kqEE18js"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfJCB4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:56:10 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36637 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfJCB4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:56:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id y189so782283qkc.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 18:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=y2GjO+8c21wpS2L+fpFZZ/mTfKI97RccC2gS32Zsy/c=;
        b=kqEE18js5/CzpSK/1AWRDcA0HGC2W4qEIAnFt74tE+bnKy0YmvBPBheRYEWCt1gUC4
         xhjnJQakB3yu0iWcJpdACz8wJn0NjfWBdiGoOE8nK8niFPzzG1qmPCapJTdm6fuJ4LwY
         2xocpZI0IJNuPbprAp4AItXIoAIAibfTKwqgWeDpNM3MXzm/6uxC+Qmt82nXBQsrw6ww
         ns6uODJQrpMPptkS4uiwQW6oH1ST4AVKhDhLM9D1gCsfZtQAXZnx5mer60qqs21mRKF1
         3XQ4+ljG3TGhgMchYm8+2wh2ODF0ogVjyCE+5348+yyyGsYvyE/R5WU8BlglBCxia+kb
         pr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=y2GjO+8c21wpS2L+fpFZZ/mTfKI97RccC2gS32Zsy/c=;
        b=mzqTUfBnZHjSAaiPccHmU5uwQsSK+qC/LYxmZFTUtQEoF6PaTlpGVUa4kVrHRGLms2
         qV4BLtrEGB2G61P4kXHLoovSCcYOIosiIIHo81+MWsw+hXfYW1BZIJpORTCAUc/ejfgA
         MUfM3cqeVcVBD17RheBY0q5C/1tDT0uREiLwXvYJUvXm9IsJavPewbI5zax+OiKC0/dS
         szrYDiyI1bP+oC74uDdBw3pWtaHu3Fw+WZz4zYeOS2OfYAQWhw1FouBh9lyZHVEKekNW
         yvkrVi5EyGrcmmSw/9GiqR8LO+JZU96n22/lDvHI+sTEyS0+RGg1gu3B5PBzZOHc0oXF
         QqdQ==
X-Gm-Message-State: APjAAAWWk+dt/xDJkkGymTEIoTJyFES5cTXqkfhZPP79oGsC/gu3CWna
        HvKGS7olyKygduSVkMh5poE/bw==
X-Google-Smtp-Source: APXvYqzQfAMdFJl/bEzMhOHdqRTMv652DMnwuHLcfgozUp4lqmAbkhMXTQ7E833EG8XHUzU96IJk1g==
X-Received: by 2002:a05:620a:49b:: with SMTP id 27mr1911544qkr.89.1570067768873;
        Wed, 02 Oct 2019 18:56:08 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r7sm650004qkf.124.2019.10.02.18.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 18:56:08 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Make SPLIT_RSS_COUNTING configurable
Date:   Wed, 2 Oct 2019 21:56:06 -0400
Message-Id: <1C584B5C-E04E-4B04-A3B5-4DC8E5E67366@lca.pw>
References: <CAKOZuesMoBj-APjCipJmWcAgSzkbD1mvyOp0UvHLnkwR-EU4Ww@mail.gmail.com>
Cc:     Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-mm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
In-Reply-To: <CAKOZuesMoBj-APjCipJmWcAgSzkbD1mvyOp0UvHLnkwR-EU4Ww@mail.gmail.com>
To:     Daniel Colascione <dancol@google.com>
X-Mailer: iPhone Mail (17A844)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 2, 2019, at 4:29 PM, Daniel Colascione <dancol@google.com> wrote:
>=20
> Adding the correct linux-mm address.
>=20
>=20
>> On Wed, Oct 2, 2019 at 1:25 PM Daniel Colascione <dancol@google.com> wrot=
e:
>>=20
>> Using the new config option, users can disable SPLIT_RSS_COUNTING to
>> get increased accuracy in user-visible mm counters.
>>=20
>> Signed-off-by: Daniel Colascione <dancol@google.com>
>> ---
>> include/linux/mm.h            |  4 ++--
>> include/linux/mm_types_task.h |  5 ++---
>> include/linux/sched.h         |  2 +-
>> kernel/fork.c                 |  2 +-
>> mm/Kconfig                    | 11 +++++++++++
>> mm/memory.c                   |  6 +++---
>> 6 files changed, 20 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index cc292273e6ba..221395de3cb4 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1637,7 +1637,7 @@ static inline unsigned long get_mm_counter(struct m=
m_struct *mm, int member)
>> {
>>        long val =3D atomic_long_read(&mm->rss_stat.count[member]);
>>=20
>> -#ifdef SPLIT_RSS_COUNTING
>> +#ifdef CONFIG_SPLIT_RSS_COUNTING
>>        /*
>>         * counter is updated in asynchronous manner and may go to minus.
>>         * But it's never be expected number for users.
>> @@ -1723,7 +1723,7 @@ static inline void setmax_mm_hiwater_rss(unsigned l=
ong *maxrss,
>>                *maxrss =3D hiwater_rss;
>> }
>>=20
>> -#if defined(SPLIT_RSS_COUNTING)
>> +#ifdef CONFIG_SPLIT_RSS_COUNTING
>> void sync_mm_rss(struct mm_struct *mm);
>> #else
>> static inline void sync_mm_rss(struct mm_struct *mm)
>> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.=
h
>> index c1bc6731125c..d2adc8057e65 100644
>> --- a/include/linux/mm_types_task.h
>> +++ b/include/linux/mm_types_task.h
>> @@ -48,14 +48,13 @@ enum {
>>        NR_MM_COUNTERS
>> };
>>=20
>> -#if USE_SPLIT_PTE_PTLOCKS && defined(CONFIG_MMU)
>> -#define SPLIT_RSS_COUNTING
>> +#ifdef CONFIG_SPLIT_RSS_COUNTING
>> /* per-thread cached information, */
>> struct task_rss_stat {
>>        int events;     /* for synchronization threshold */
>>        int count[NR_MM_COUNTERS];
>> };
>> -#endif /* USE_SPLIT_PTE_PTLOCKS */
>> +#endif /* CONFIG_SPLIT_RSS_COUNTING */
>>=20
>> struct mm_rss_stat {
>>        atomic_long_t count[NR_MM_COUNTERS];
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 2c2e56bd8913..22f354774540 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -729,7 +729,7 @@ struct task_struct {
>>        /* Per-thread vma caching: */
>>        struct vmacache                 vmacache;
>>=20
>> -#ifdef SPLIT_RSS_COUNTING
>> +#ifdef CONFIG_SPLIT_RSS_COUNTING
>>        struct task_rss_stat            rss_stat;
>> #endif
>>        int                             exit_state;
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index f9572f416126..fc5e0889922b 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -1917,7 +1917,7 @@ static __latent_entropy struct task_struct *copy_pr=
ocess(
>>        p->vtime.state =3D VTIME_INACTIVE;
>> #endif
>>=20
>> -#if defined(SPLIT_RSS_COUNTING)
>> +#ifdef CONFIG_SPLIT_RSS_COUNTING
>>        memset(&p->rss_stat, 0, sizeof(p->rss_stat));
>> #endif
>>=20
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index a5dae9a7eb51..372ef9449924 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -736,4 +736,15 @@ config ARCH_HAS_PTE_SPECIAL
>> config ARCH_HAS_HUGEPD
>>        bool
>>=20
>> +config SPLIT_RSS_COUNTING
>> +       bool "Per-thread mm counter caching"
>> +       depends on MMU
>> +       default y if NR_CPUS >=3D SPLIT_PTLOCK_CPUS
>> +       help
>> +         Cache mm counter updates in thread structures and
>> +         flush them to visible per-process statistics in batches.
>> +         Say Y here to slightly reduce cache contention in processes
>> +         with many threads at the expense of decreasing the accuracy
>> +         of memory statistics in /proc.
>> +
>> endmenu

All those vague words are going to make developers almost impossible to deci=
de the right selection here. It sounds like we should kill SPLIT_RSS_COUNTIN=
G at all to simplify the code as the benefit is so small vs the side-effect?=


>> diff --git a/mm/memory.c b/mm/memory.c
>> index b1ca51a079f2..bf557ed5ba23 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -141,7 +141,7 @@ static int __init init_zero_pfn(void)
>> core_initcall(init_zero_pfn);
>>=20
>>=20
>> -#if defined(SPLIT_RSS_COUNTING)
>> +#ifdef CONFIG_SPLIT_RSS_COUNTING
>>=20
>> void sync_mm_rss(struct mm_struct *mm)
>> {
>> @@ -177,7 +177,7 @@ static void check_sync_rss_stat(struct task_struct *t=
ask)
>>        if (unlikely(task->rss_stat.events++ > TASK_RSS_EVENTS_THRESH))
>>                sync_mm_rss(task->mm);
>> }
>> -#else /* SPLIT_RSS_COUNTING */
>> +#else /* CONFIG_SPLIT_RSS_COUNTING */
>>=20
>> #define inc_mm_counter_fast(mm, member) inc_mm_counter(mm, member)
>> #define dec_mm_counter_fast(mm, member) dec_mm_counter(mm, member)
>> @@ -186,7 +186,7 @@ static void check_sync_rss_stat(struct task_struct *t=
ask)
>> {
>> }
>>=20
>> -#endif /* SPLIT_RSS_COUNTING */
>> +#endif /* CONFIG_SPLIT_RSS_COUNTING */
>>=20
>> /*
>>  * Note: this doesn't free the actual pages themselves. That
>> --
>> 2.23.0.581.g78d2f28ef7-goog
>>=20
