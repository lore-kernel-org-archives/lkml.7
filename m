Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66723C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC0C218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1qAD8fv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfGDJeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:34:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42389 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfGDJeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:34:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id s19so3055586lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 02:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bbnl/1QRNnrJXWes6iiR1igoTLtbX1SM4SwlahpOBOQ=;
        b=V1qAD8fvU9ZlAjdcnAyNCm3heZtBMMaC4+JhDzVY0LxmxrMP+jmTTBkghymnvXaodZ
         5YqZlX4AHhwZlO1tKnYgWILWu6RBqIftA3kjbAVcfqFlTfue20zQu3qAA76fPohWNNlf
         MT0iyHjPFwsl3AjcQqxQa/KBpvowBNgIp7fbrZtx2nN/02dQXnI4cQOPLvKg9uvnAoUM
         e3Eg6vuVnLuiB+lQJMbfi01O2XKaCpSLXI3GPFlyDMh6ppogu2m4E32hRZ0Zqn6+qPep
         5f7qbG0ZnOnWHimnVvgCuUyfckHUAe0jyw0OQTBchwPg+nvL2rSDtgsfetCdFfFdDZw3
         5Ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bbnl/1QRNnrJXWes6iiR1igoTLtbX1SM4SwlahpOBOQ=;
        b=NT1nlApXdiCi0AIrUb/p+Qagpiw9IDiodw2xI0sWI/i0p81uU3lel3mUqPL/FtVwA7
         1/9PE2IPsHRBXoIAJUqzDEYMUUD86nqeOGrz4H39wCa+ceHbD3lqlsIxLsHP+92sLBZE
         MyT+aZPxF+yImaWQC9EdLKJNKlo5ovq/kF5dOwEGXInnc/0I3zdFNZNrQeGCKiY1xJcm
         UT6gaUCOw3YJ0WihdrN532HbGUUoTVcv99Pm3TVQuSlGCzMStFW3IypB2zSSrn6+USlt
         O+5QzLG/Aq/ANjqL3eZZ5MsRzcyy0OXTmpc79GeOSBVzKDMnBQnyWX7/XV29Nsc+w6TP
         haEQ==
X-Gm-Message-State: APjAAAVW7Z9AHnPjSNOhQVEk4rPlt/Ph8UOaez63hG2PkOlgh2smJevS
        +v+4LxD+qPTCXcnu3vniGWQ7K2vaWI+yEfi8CwHXMg==
X-Google-Smtp-Source: APXvYqyVHgB/XdPi+PhglaImDqJX2XrddFQFBQD9AnFh7Ea76Xr7PezvCVQknkOgvBk14iGgIZ9G5OBzJ3hvQcHrGvo=
X-Received: by 2002:a19:ec15:: with SMTP id b21mr22141110lfa.32.1562232841324;
 Thu, 04 Jul 2019 02:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190628204913.10287-1-riel@surriel.com> <20190628204913.10287-6-riel@surriel.com>
In-Reply-To: <20190628204913.10287-6-riel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 4 Jul 2019 11:33:50 +0200
Message-ID: <CAKfTPtBOWeEH1T77Cm92R3BfM85ii6mbocidtAPyWN4Vq0q7SA@mail.gmail.com>
Subject: Re: [PATCH 05/10] sched,fair: remove cfs rqs from leaf_cfs_rq_list
 bottom up
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2019 at 22:49, Rik van Riel <riel@surriel.com> wrote:
>
> Reducing the overhead of the CPU controller is achieved by not walking
> all the sched_entities every time a task is enqueued or dequeued.
>
> One of the things being checked every single time is whether the cfs_rq
> is on the rq->leaf_cfs_rq_list.
>
> By only removing a cfs_rq from the list once it no longer has children
> on the list, we can avoid walking the sched_entity hierarchy if the bottom
> cfs_rq is on the list, once the runqueues have been flattened.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  kernel/sched/fair.c  | 17 +++++++++++++++++
>  kernel/sched/sched.h |  1 +
>  2 files changed, 18 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 63cb40253b26..e41feacc45d9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -286,6 +286,13 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>
>         cfs_rq->on_list = 1;
>
> +       /*
> +        * If the tmp_alone_branch cursor was moved, it means a child cfs_rq
> +        * is already on the list ahead of us.
> +        */
> +       if (rq->tmp_alone_branch != &rq->leaf_cfs_rq_list)
> +               cfs_rq->children_on_list++;
> +
>         /*
>          * Ensure we either appear before our parent (if already
>          * enqueued) or force our parent to appear after us when it is
> @@ -311,6 +318,7 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>                  * list.
>                  */
>                 rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
> +               cfs_rq->tg->parent->cfs_rq[cpu]->children_on_list++;
>                 return true;
>         }
>
> @@ -359,6 +367,11 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>                 if (rq->tmp_alone_branch == &cfs_rq->leaf_cfs_rq_list)
>                         rq->tmp_alone_branch = cfs_rq->leaf_cfs_rq_list.prev;
>
> +               if (cfs_rq->tg->parent) {
> +                       int cpu = cpu_of(rq);
> +                       cfs_rq->tg->parent->cfs_rq[cpu]->children_on_list--;
> +               }
> +
>                 list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
>                 cfs_rq->on_list = 0;
>         }
> @@ -7687,6 +7700,10 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>         if (cfs_rq->avg.util_sum)
>                 return false;
>
> +       /* Remove decayed parents once their decayed children are gone. */
> +       if (cfs_rq->children_on_list)

I'm not sure that you really need to count whether childrens are on the list.
Instead you can take advantage of the list ordering and you only have
to test if the previous cfs_rq in the list is a child. If it's not
then there is no more child

and you can remove the new field children_on_list and inc/dec it

> +               return false;
> +
>         return true;
>  }
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 32978a8de8ce..4f8acbab0fb2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -557,6 +557,7 @@ struct cfs_rq {
>          * This list is used during load balance.
>          */
>         int                     on_list;
> +       int                     children_on_list;
>         struct list_head        leaf_cfs_rq_list;
>         struct task_group       *tg;    /* group that "owns" this runqueue */
>
> --
> 2.20.1
>
