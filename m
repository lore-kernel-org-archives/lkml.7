Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051FFC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9722064A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="arBrwtrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfHEQrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:47:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34968 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729787AbfHEQrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:47:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so85110026wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dRDr08uPogxhTZGq/1ByRD1tbOsg8bHIbNXG9ceNpJ0=;
        b=arBrwtrqjzcPidCkPy4YK35QiObyyISAwRxNvZtDsWbiHe+iznh3JBWPo5rYz8XTf+
         ARvSsvRgtG90ad0PN3O36XEaYXijeepXkr/jhLhvEjR/cbJfRUBykzmGPPeXivx8MJY/
         D61uYJfuNy81davBWnxqqLuWFg/gtMS2qx9+BUrVh5tVF4srSinaqOz/RWoswA8InxPx
         aGFEoqM62CBKoRK51Z/EDRlcvbs6aHkFFUAApruI7A8wRJ31/2AJk5xvDrbkthkobX/X
         P89XgrAhBRCd8RQRZseycTJ79IgmY4K/ljIdnplgfWHzZbjcvMI4eCWBG8oa7qhX7kud
         eHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRDr08uPogxhTZGq/1ByRD1tbOsg8bHIbNXG9ceNpJ0=;
        b=oceh3rCUVz9QE2bw68gzY9TuikT/8N/g1s1S7oKwAWL4GjLHAS8R2BgoebA2J0z+Ou
         v07vnUwhEsJtPhDKeLMmHneNYFeeOWvmskQKHAu8YlNvKzC55lRkfHW9W9JGBO9d6eaP
         FnXfG7EXxfu2KexGNEopH6x2bF1AoqxrQtpZFJqb3MmpS8k28ToW6sXRamc7RcqNWJGu
         KtedscQ7McAObnVYgjQzkTkKt32tl7nO+5a0bU4LJKclbROirarUpSJZwoxqjwhmKNFS
         LL54oFGNLShzXKLVb9eaTE2b01KFLAAf+FJXBKOzoprjKhiaY/7FZF0F+FGyNwmpTJv6
         Z9wQ==
X-Gm-Message-State: APjAAAWCQnu11ERqJdH0tvqF7pMZrtMuedU+UokZjYaS4J4wE+pUVvXS
        9fEqP00WtYNxBSuI0bpgi91EDELbOl/TWhdNRpemag==
X-Google-Smtp-Source: APXvYqwyY/v2aC746IDQvqdLVdBNEyOJ58IXoih74Iy0sZLsq4ATt/B3tBdU7ppCos+djxcvaRZww3qkKF9dHaSBEuI=
X-Received: by 2002:adf:e30c:: with SMTP id b12mr16323829wrj.300.1565023634745;
 Mon, 05 Aug 2019 09:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com> <ce102f29-3adc-d0fd-41ee-e32c1bcd7e8d@suse.cz>
 <20190805133119.GO7597@dhcp22.suse.cz>
In-Reply-To: <20190805133119.GO7597@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 5 Aug 2019 09:47:03 -0700
Message-ID: <CAJuCfpFL6c1eNp9eRBU434Etj5u+aN7tTKM_fBtQUqVbZ1yPSg@mail.gmail.com>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 6:31 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 05-08-19 14:13:16, Vlastimil Babka wrote:
> > On 8/4/19 11:23 AM, Artem S. Tashkinov wrote:
> > > Hello,
> > >
> > > There's this bug which has been bugging many people for many years
> > > already and which is reproducible in less than a few minutes under the
> > > latest and greatest kernel, 5.2.6. All the kernel parameters are set to
> > > defaults.
> > >
> > > Steps to reproduce:
> > >
> > > 1) Boot with mem=4G
> > > 2) Disable swap to make everything faster (sudo swapoff -a)
> > > 3) Launch a web browser, e.g. Chrome/Chromium or/and Firefox
> > > 4) Start opening tabs in either of them and watch your free RAM decrease
> > >
> > > Once you hit a situation when opening a new tab requires more RAM than
> > > is currently available, the system will stall hard. You will barely  be
> > > able to move the mouse pointer. Your disk LED will be flashing
> > > incessantly (I'm not entirely sure why). You will not be able to run new
> > > applications or close currently running ones.
> >
> > > This little crisis may continue for minutes or even longer. I think
> > > that's not how the system should behave in this situation. I believe
> > > something must be done about that to avoid this stall.
> >
> > Yeah that's a known problem, made worse SSD's in fact, as they are able
> > to keep refaulting the last remaining file pages fast enough, so there
> > is still apparent progress in reclaim and OOM doesn't kick in.
> >
> > At this point, the likely solution will be probably based on pressure
> > stall monitoring (PSI). I don't know how far we are from a built-in
> > monitor with reasonable defaults for a desktop workload, so CCing
> > relevant folks.
>
> Another potential approach would be to consider the refault information
> we have already for file backed pages. Once we start reclaiming only
> workingset pages then we should be trashing, right? It cannot be as
> precise as the cost model which can be defined around PSI but it might
> give us at least a fallback measure.
>
> This is a really just an idea for a primitive detection. Most likely
> incorrect one but it shows an idea at least. It is completely untested
> and might be completely broken so unless somebody is really brave and
> doesn't run anything that would be missed then I do not recommend to run
> it.

In Android we have a userspace lmkd process which polls for PSI events
and after they get triggered we check several metrics to determine if
we should kill anything. I believe Facebook has a similar userspace
process called oomd which as I heard is a more configurable rule
engine which also uses PSI and configurable rules to make kill
decisions. I've spent considerable time experimenting with different
metrics and thrashing is definitely one of the most useful ones.

>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 70394cabaf4e..7f30c78b4fbc 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -300,6 +300,7 @@ struct lruvec {
>         atomic_long_t                   inactive_age;
>         /* Refaults at the time of last reclaim cycle */
>         unsigned long                   refaults;
> +       atomic_t                        workingset_refaults;
>  #ifdef CONFIG_MEMCG
>         struct pglist_data *pgdat;
>  #endif
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 4bfb5c4ac108..4401753c3912 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -311,6 +311,15 @@ void *workingset_eviction(struct page *page);
>  void workingset_refault(struct page *page, void *shadow);
>  void workingset_activation(struct page *page);
>
> +bool lruvec_trashing(struct lruvec *lruvec)
> +{
> +       /*
> +        * One quarter of the inactive list is constantly refaulting.

I'm guessing one quarter is a guesstimate here and needs experimentation?

> +        * This suggests that we are trashing.
> +        */
> +       return 4 * atomic_read(&lruvec->workingset_refaults) > lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES);

Just wondering, why do you consider only inactive list here? The
complete workingset is active list + non-idle part of inactive list
isn't it? In my latest experiments I was using configurable percentage
of the active+inactive lists as a threshold to declare we are
thrashing and if thrashing continues after we kill that percentage
starts decaying which results in an earlier next kill (if interested
in details see https://android-review.googlesource.com/c/platform/system/core/+/1041778/14/lmkd/lmkd.c#1968).
I'm also using existing WORKINGSET_REFAULT node_stat_item as
workingset refault counter. Any reason you are not using it in this
reference implementation instead of introducing new
workingset_refaults atomic?

> +}
> +
>  /* Only track the nodes of mappings with shadow entries */
>  void workingset_update_node(struct xa_node *node);
>  #define mapping_set_update(xas, mapping) do {                          \
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7889f583ced9..d198594af0cd 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2381,6 +2381,11 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>                                                   denominator);
>                         break;
>                 case SCAN_FILE:
> +                       if (lruvec_trashing(lruvec)) {
> +                               size = 0;
> +                               scan = 0;
> +                               break;
> +                       }
>                 case SCAN_ANON:
>                         /* Scan one type exclusively */
>                         if ((scan_balance == SCAN_FILE) != file) {
> diff --git a/mm/workingset.c b/mm/workingset.c
> index e0b4edcb88c8..ee4c45b27e34 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -309,17 +309,25 @@ void workingset_refault(struct page *page, void *shadow)
>          * don't act on pages that couldn't stay resident even if all
>          * the memory was available to the page cache.
>          */
> -       if (refault_distance > active_file)
> +       if (refault_distance > active_file) {
> +               atomic_set(&lruvec->workingset_refaults, 0);
>                 goto out;
> +       }
>
>         SetPageActive(page);
>         atomic_long_inc(&lruvec->inactive_age);
>         inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE);
> +       atomic_inc(&lruvec->workingset_refaults);
>
>         /* Page was active prior to eviction */
>         if (workingset) {
>                 SetPageWorkingset(page);
>                 inc_lruvec_state(lruvec, WORKINGSET_RESTORE);
> +               /*
> +                * Double the trashing numbers for the actual working set.
> +                * refaults
> +                */
> +               atomic_inc(&lruvec->workingset_refaults);
>         }
>  out:
>         rcu_read_unlock();
> --
> Michal Hocko
> SUSE Labs
