Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FFBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87582087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YlrQgeSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfCLAUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:20:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40838 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfCLAUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:20:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id f11so682963qti.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 17:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UT0ImJxTjHCkD4z2A531RVNWlnRVlywYZW2iWfcNVqA=;
        b=YlrQgeSrk1hr14+o0Jh36NvnjwmvireGJFK8QFKx4aTqfkTVUXRKfE9ERO7BrX/Oax
         jkUnhCvYXqdrahMzvG0SEXJOsjPwTDZPumKSnFm0qWHZ2I0cyr0WeMxKnRdItr0n+NHN
         JKylKQkfUUgjeM+H1afQj02gGwYaPpTt1iArUR41/0IFjrHP+qAQ/hzhE0p8hzPU03t2
         5tKgdU3w4agtJQW9h7ISEAOhghFunJdS5DSuAZGJGacpubYJC0pmECn8PeDctoBXCljN
         gd9Vp6lnpkJ/Ql2+mVt6XmGwvbyBrKBbhRc0piSyziJGCuUSLAE8xm3+Z4JdmRQXNeYe
         wwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UT0ImJxTjHCkD4z2A531RVNWlnRVlywYZW2iWfcNVqA=;
        b=LiEfDUZtSH7ul/uw9FROCa+slNrbismyL87ZgY2Kzl1ckayO4H2Lb6KS2AND51HGh6
         b8CL5TYkIQuyOMlQ2mfBs/Mj3YPv9XtFFZmeQJKBeaBeETgS1aZMqjeTvdIJnEcOCuwj
         yuueTYDsP9jqZpi9zPLvIQ+wbilVdVBSbZD4ERipOcRqOqZHyiwsrCRO0StVceF9dGGj
         18+m6QVVwc+y0RydDMqkamWWpnCOeDkCEGiKK0BhEBxwo9+9ETBtfwquc/edSeMDZYib
         ZNsnsNGcLHaVP3HUhbkPnAOzPoNHv1BET5rOZxW1iC3DVGoU1LW5GGgs9BQE/X2C0QI0
         C6PQ==
X-Gm-Message-State: APjAAAUxyBWb/v+LHtf4l65e0dlKCHO70buMAK3O7rpTlVf/CTqevnyS
        mb2uwTS3/VBEiXfhi5pGSHgA7B7+vtUtyVlywkJlOQ==
X-Google-Smtp-Source: APXvYqxBfnO/tXZ5gRIGb8OjhquzDZtHdRosWpXhXgas3qBgAW5w7saBa73iYy25TxnGmIyFBqiKw7BjcrvZ6c+j3gU=
X-Received: by 2002:ac8:2827:: with SMTP id 36mr27428681qtq.359.1552350030998;
 Mon, 11 Mar 2019 17:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190218165620.383905466@infradead.org> <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <20190222124544.GY9565@techsingularity.net> <14a9adf7-9b50-1dfa-0c35-d04e976081c2@oracle.com>
 <CAERHkru9DzvszvdGHWp8PhEAqeUc-wVR1Gey-KtQ6aMRLx68bQ@mail.gmail.com>
 <19d5d492-a4c1-b3c8-cae4-da2fdfcb872b@oracle.com> <ac10b8fd-da1a-2cc2-afee-4e2b9b4278ee@oracle.com>
In-Reply-To: <ac10b8fd-da1a-2cc2-afee-4e2b9b4278ee@oracle.com>
From:   Greg Kerr <kerrnel@google.com>
Date:   Mon, 11 Mar 2019 17:20:19 -0700
Message-ID: <CAJGSLMuLVDXhffOWbnzt8-P7u68OODkN_pwvSt9MBH5mbyAfQQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Fr?d?ric Weisbecker" <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>, Greg Kerr <greg@kerrnel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 4:36 PM Subhra Mazumdar
<subhra.mazumdar@oracle.com> wrote:
>
>
> On 3/11/19 11:34 AM, Subhra Mazumdar wrote:
> >
> > On 3/10/19 9:23 PM, Aubrey Li wrote:
> >> On Sat, Mar 9, 2019 at 3:50 AM Subhra Mazumdar
> >> <subhra.mazumdar@oracle.com> wrote:
> >>> expected. Most of the performance recovery happens in patch 15 which,
> >>> unfortunately, is also the one that introduces the hard lockup.
> >>>
> >> After applied Subhra's patch, the following is triggered by enabling
> >> core sched when a cgroup is
> >> under heavy load.
> >>
> > It seems you are facing some other deadlock where printk is involved.
> > Can you
> > drop the last patch (patch 16 sched: Debug bits...) and try?
> >
> > Thanks,
> > Subhra
> >
> Never Mind, I am seeing the same lockdep deadlock output even w/o patch
> 16. Btw
> the NULL fix had something missing, following works.

Is this panic below, which occurs when I tag the first process,
related or known? If not, I will debug it tomorrow.

[   46.831828] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000000
[   46.831829] core sched enabled
[   46.834261] #PF error: [WRITE]
[   46.834899] PGD 0 P4D 0
[   46.835438] Oops: 0002 [#1] SMP PTI
[   46.836158] CPU: 0 PID: 11 Comm: migration/0 Not tainted
5.0.0everyday-glory-03949-g2d8fdbb66245-dirty #7
[   46.838206] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[   46.839844] RIP: 0010:_raw_spin_lock+0x7/0x20
[   46.840448] Code: 00 00 00 65 81 05 25 ca 5c 51 00 02 00 00 31 c0
ba ff 00 00 00 f0 0f b1 17 74 05 e9 93 80 46 ff f3 c3 90 31 c0 ba 01
00 00 00 <f0> 0f b1 17 74 07 89 c6 e9 1c 6e 46 ff f3 c3 66 2e 0f 1f 84
00 00
[   46.843000] RSP: 0018:ffffb9d300cabe38 EFLAGS: 00010046
[   46.843744] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
[   46.844709] RDX: 0000000000000001 RSI: ffffffffaea435ae RDI: 0000000000000000
[   46.845689] RBP: ffffb9d300cabed8 R08: 0000000000000000 R09: 0000000000020800
[   46.846651] R10: ffffffffaf603ea0 R11: 0000000000000001 R12: ffffffffaf6576c0
[   46.847619] R13: ffff9a57366c8000 R14: ffff9a5737401300 R15: ffffffffade868f0
[   46.848584] FS:  0000000000000000(0000) GS:ffff9a5737a00000(0000)
knlGS:0000000000000000
[   46.849680] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   46.850455] CR2: 0000000000000000 CR3: 00000001d36fa000 CR4: 00000000000006f0
[   46.851415] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   46.852371] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   46.853326] Call Trace:
[   46.853678]  __schedule+0x139/0x11f0
[   46.854167]  ? cpumask_next+0x16/0x20
[   46.854668]  ? cpu_stop_queue_work+0xc0/0xc0
[   46.855252]  ? sort_range+0x20/0x20
[   46.855742]  schedule+0x4e/0x60
[   46.856171]  smpboot_thread_fn+0x12a/0x160
[   46.856725]  kthread+0x112/0x120
[   46.857164]  ? kthread_stop+0xf0/0xf0
[   46.857661]  ret_from_fork+0x35/0x40
[   46.858146] Modules linked in:
[   46.858562] CR2: 0000000000000000
[   46.859022] ---[ end trace e9fff08f17bfd2be ]---

- Greg

>
> --------->8------------
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1d0dac4..27cbc64 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4131,7 +4131,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct
> sched_entity *curr)
>           * Avoid running the skip buddy, if running something else can
>           * be done without getting too unfair.
> */
> -       if (cfs_rq->skip == se) {
> +       if (cfs_rq->skip && cfs_rq->skip == se) {
>                  struct sched_entity *second;
>
>                  if (se == curr) {
> @@ -4149,13 +4149,15 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct
> sched_entity *curr)
> /*
>           * Prefer last buddy, try to return the CPU to a preempted task.
> */
> -       if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
> +       if (left && cfs_rq->last && wakeup_preempt_entity(cfs_rq->last,
> left)
> +           < 1)
>                  se = cfs_rq->last;
>
> /*
>           * Someone really wants this to run. If it's not unfair, run it.
> */
> -       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
> +       if (left && cfs_rq->next && wakeup_preempt_entity(cfs_rq->next,
> left)
> +           < 1)
>                  se = cfs_rq->next;
>
>          clear_buddies(cfs_rq, se);
> @@ -6958,6 +6960,9 @@ pick_task_fair(struct rq *rq)
>
>                  se = pick_next_entity(cfs_rq, NULL);
>
> +               if (!(se || curr))
> +                       return NULL;
> +
>                  if (curr) {
>                          if (se && curr->on_rq)
> update_curr(cfs_rq);
>
