Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB22C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 06:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6672073B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 06:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ds/yTXh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfKPG2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 01:28:46 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33658 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfKPG2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 01:28:46 -0500
Received: by mail-oi1-f195.google.com with SMTP id m193so10709825oig.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 22:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x6J0isZQHyJs2DrQydkqyktOVewrDtoAG6sLNljnc8o=;
        b=ds/yTXh6/ej0deTlmg0Wf+HJq81afq++LbAIEYRM1Io96xJ1ODG3OqvHeBWHEo/T4z
         VfTFsAUv3uuHun2bhemwzDi/b38W+LPrMfTK5Jp4QR5O1vp6FQkBjWuYX6DRVNMUVlpg
         pGlhm2Ln8qOyjhYoMS7ObVBR+eOZ/ampFt04oQFB02vv3mbRm9Wp3grLqtgSXBgQD/ZI
         33QsdPlRHlq/68ChvEMO7PgA8fCDWU3WG4RnVUqvlqjcY97h5D+vkvDi2obaO0dzz7db
         RRev2gKBaWw/p8OYK3k/1s/tnj8k1wg0+55J3eeV+ck2KgFXOU31HceFgAUDxi+x4yMZ
         33Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x6J0isZQHyJs2DrQydkqyktOVewrDtoAG6sLNljnc8o=;
        b=Az+aFk3GD77KQpu1VvGiV/y4j7qFp86FdHc2TvxkPVm5NRf5a5PBYINGMlQqp5ORxQ
         v4WSjm6S4LnTNGzQhPBx9qX2aOxBSYOpB19Wpo6VhnoYj1lI8C0+C3FMdnK6qoU1+omL
         DeT3ndi/9/uLQTI3/6r1oxVeoB3LCvLrgn2xrHIT+LwL7K+pLagrwRaiUo1tZafLKzhE
         1AyXXCYsldejG9vf7th5u+WLue38ppyYjSdl9cshvwTErQ1JuUvcKHZ93mhrUBMe5wTM
         yS3h3pFbF/emQDVDCULdnb7/O6x1FtJz+xiGL7W0r6u2pXc7fNBiKk2F633zeWe0nrsV
         EYjw==
X-Gm-Message-State: APjAAAUxhBGVQHPGSwTwKoz9m6DxpfcSX9sPy1poplOaZLSpJJ17M0oE
        jzq7gKIduaxmrgodFOK4bNzZCcDrUhSFlKJLR7ZmNQ==
X-Google-Smtp-Source: APXvYqx5m4pdYig8DD+m1t7wvcy1mCcaITh+t2RzgZY7YOJ9ckjbLoiqINDaze7TlNWJVZuCzupzggJ79vL1ja/dT9w=
X-Received: by 2002:aca:f1c5:: with SMTP id p188mr10735867oih.125.1573885725077;
 Fri, 15 Nov 2019 22:28:45 -0800 (PST)
MIME-Version: 1.0
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com> <1573874106-23802-2-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1573874106-23802-2-git-send-email-alex.shi@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 15 Nov 2019 22:28:34 -0800
Message-ID: <CALvZod77568+TozRXpERDDap__jbj+oJBY8zD=UBd40XNJC2zg@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] mm/lru: add per lruvec lock for memcg
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Arun KS <arunks@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 7:15 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> Currently memcg still use per node pgdat->lru_lock to guard its lruvec.
> That causes some lru_lock contention in a high container density system.
>
> If we can use per lruvec lock, that could relief much of the lru_lock
> contention.
>
> The later patches will replace the pgdat->lru_lock with lruvec->lru_lock
> and show the performance benefit by benchmarks.

Merge this patch with actual usage. No need to have a separate patch.

>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/mmzone.h | 2 ++
>  mm/mmzone.c            | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 07b784ffbb14..a13b8a602ee5 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -267,6 +267,8 @@ struct lruvec {
>         unsigned long                   refaults;
>         /* Various lruvec state flags (enum lruvec_flags) */
>         unsigned long                   flags;
> +       /* per lruvec lru_lock for memcg */
> +       spinlock_t                      lru_lock;
>  #ifdef CONFIG_MEMCG
>         struct pglist_data *pgdat;
>  #endif
> diff --git a/mm/mmzone.c b/mm/mmzone.c
> index 4686fdc23bb9..3750a90ed4a0 100644
> --- a/mm/mmzone.c
> +++ b/mm/mmzone.c
> @@ -91,6 +91,7 @@ void lruvec_init(struct lruvec *lruvec)
>         enum lru_list lru;
>
>         memset(lruvec, 0, sizeof(struct lruvec));
> +       spin_lock_init(&lruvec->lru_lock);
>
>         for_each_lru(lru)
>                 INIT_LIST_HEAD(&lruvec->lists[lru]);
> --
> 1.8.3.1
>
