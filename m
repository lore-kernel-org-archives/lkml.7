Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC24C28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A09C241C8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="AfFmHZA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfE2VCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:02:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33994 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfE2VCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:02:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so4006206edn.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 14:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Px0QqNXBx7zb8DTbIgHM/u4AHM3hp5BrmRWZ2MUl+c=;
        b=AfFmHZA9P6Vj1FUFXm32F5wcN9QjZQ8Gr++foUi9M4Z60gUbc/YtzwRB4u72etrH/G
         QoI7xJZhvcPglm6kFyoZ2dNxc4Z5DetfDnpmTK3M6btz5CK3SFs6Kh8URQ118ib5evBZ
         JUDkfqqu5SwYOIged3UZvy2LD3d+xMt3osF8wJWf8rsUC1LCG5mmcbnRCKkW6C92GjAt
         vgTX1kOK4VuRjAxZMY/FzQekMcNbCg0k+UL3THdW9soa44sMoKKBizBhEDrIsLWtlqpm
         unKBC6nnNfPCDeMQj+jQucrtGyzYa8/Z71UJUdPQmUDh0HH0T3gAbrLEpjL78lvSYddI
         6YFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Px0QqNXBx7zb8DTbIgHM/u4AHM3hp5BrmRWZ2MUl+c=;
        b=oNeBNRWF2WdWp/PK0MvyOgJ3CDRjhHkj3suv0cn26pJu4lR4I9rvTP9nylspMNdooU
         4JPKH/RoD2cbPR+RIk9l5CqT54VDuh5jo0/IayKPREsVtpbs0vPfQ94eLO2kZfXrcjz+
         lfMYNxLnlmW8DF+Fkf3KKXcdARFG8WSomO6Ep1IMonMXH0BsureSGVgfczvq8LESESXH
         z6RZc+CskNHTRvjezNKzQiiPlHFLgP3zVUnFV+5Q0IqLMY8FINde3lqo7C0sfrXWpKYG
         FxrYN40lvv/pCMS6AJrwZ9XgdrqnIvCii8J7oHqNj1R87PE4Cplx4WHXcDAmDqjw+VDt
         aIbQ==
X-Gm-Message-State: APjAAAVd4LSWhDIZxQZhIz2dAOLQ792iWtPmolegCioPBt1JVBzhRZQs
        oYq+MKdrZ5CdK0nOF7N/3dGt7Tqd4zYAbvFQc1UmTw==
X-Google-Smtp-Source: APXvYqzjL5MUYoBAy8DVwWU8o8EztO46lH9ZOukgHNK96rSaPoD+Ll+/SrzWBmOI5/wuign7t+FYZ4Tu2E4KYXWpBAU=
X-Received: by 2002:a17:906:c103:: with SMTP id h3mr207937ejz.232.1559163760745;
 Wed, 29 May 2019 14:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559129225.git.vpillai@digitalocean.com> <c1fd166d42ded9cc9839eb2722174549059dd36f.1559129225.git.vpillai@digitalocean.com>
In-Reply-To: <c1fd166d42ded9cc9839eb2722174549059dd36f.1559129225.git.vpillai@digitalocean.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Wed, 29 May 2019 14:02:30 -0700
Message-ID: <CAFTs51V+z-zjGaMAysdR4pPPKJO4rWVekjzRk3mc+wMwwYbvDg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 16/16] sched: Debug bits...
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        subhra.mazumdar@oracle.com, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 1:37 PM Vineeth Remanan Pillai
<vpillai@digitalocean.com> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> Not-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

No commit message, not-signed-off-by...

> ---
>  kernel/sched/core.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5b8223c9a723..90655c9ad937 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -92,6 +92,10 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
>
>         int pa = __task_prio(a), pb = __task_prio(b);
>
> +       trace_printk("(%s/%d;%d,%Lu,%Lu) ?< (%s/%d;%d,%Lu,%Lu)\n",
> +                    a->comm, a->pid, pa, a->se.vruntime, a->dl.deadline,
> +                    b->comm, b->pid, pb, b->se.vruntime, b->dl.deadline);
> +
>         if (-pa < -pb)
>                 return true;
>
> @@ -246,6 +250,8 @@ static void __sched_core_enable(void)
>
>         static_branch_enable(&__sched_core_enabled);
>         stop_machine(__sched_core_stopper, (void *)true, NULL);
> +
> +       printk("core sched enabled\n");
>  }
>
>  static void __sched_core_disable(void)
> @@ -254,6 +260,8 @@ static void __sched_core_disable(void)
>
>         stop_machine(__sched_core_stopper, (void *)false, NULL);
>         static_branch_disable(&__sched_core_enabled);
> +
> +       printk("core sched disabled\n");
>  }
>
>  void sched_core_get(void)
> @@ -3707,6 +3715,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>                         put_prev_task(rq, prev);
>                         set_next_task(rq, next);
>                 }
> +
> +               trace_printk("pick pre selected (%u %u %u): %s/%d %lx\n",
> +                            rq->core->core_task_seq,
> +                            rq->core->core_pick_seq,
> +                            rq->core_sched_seq,
> +                            next->comm, next->pid,
> +                            next->core_cookie);
> +
>                 return next;
>         }
>
> @@ -3786,6 +3802,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>                          */
>                         if (i == cpu && !need_sync && !p->core_cookie) {
>                                 next = p;
> +                               trace_printk("unconstrained pick: %s/%d %lx\n",
> +                                            next->comm, next->pid, next->core_cookie);
> +
>                                 goto done;
>                         }
>
> @@ -3794,6 +3813,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>
>                         rq_i->core_pick = p;
>
> +                       trace_printk("cpu(%d): selected: %s/%d %lx\n",
> +                                    i, p->comm, p->pid, p->core_cookie);
> +
>                         /*
>                          * If this new candidate is of higher priority than the
>                          * previous; and they're incompatible; we need to wipe
> @@ -3810,6 +3832,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>                                 rq->core->core_cookie = p->core_cookie;
>                                 max = p;
>
> +                               trace_printk("max: %s/%d %lx\n", max->comm, max->pid, max->core_cookie);
> +
>                                 if (old_max) {
>                                         for_each_cpu(j, smt_mask) {
>                                                 if (j == i)
> @@ -3837,6 +3861,7 @@ next_class:;
>         rq->core->core_pick_seq = rq->core->core_task_seq;
>         next = rq->core_pick;
>         rq->core_sched_seq = rq->core->core_pick_seq;
> +       trace_printk("picked: %s/%d %lx\n", next->comm, next->pid, next->core_cookie);
>
>         /*
>          * Reschedule siblings
> @@ -3862,11 +3887,20 @@ next_class:;
>                 if (i == cpu)
>                         continue;
>
> -               if (rq_i->curr != rq_i->core_pick)
> +               if (rq_i->curr != rq_i->core_pick) {
> +                       trace_printk("IPI(%d)\n", i);
>                         resched_curr(rq_i);
> +               }
>
>                 /* Did we break L1TF mitigation requirements? */
> -               WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
> +               if (unlikely(!cookie_match(next, rq_i->core_pick))) {
> +                       trace_printk("[%d]: cookie mismatch. %s/%d/0x%lx/0x%lx\n",
> +                                    rq_i->cpu, rq_i->core_pick->comm,
> +                                    rq_i->core_pick->pid,
> +                                    rq_i->core_pick->core_cookie,
> +                                    rq_i->core->core_cookie);
> +                       WARN_ON_ONCE(1);
> +               }
>         }
>
>  done:
> @@ -3905,6 +3939,10 @@ static bool try_steal_cookie(int this, int that)
>                 if (p->core_occupation > dst->idle->core_occupation)
>                         goto next;
>
> +               trace_printk("core fill: %s/%d (%d->%d) %d %d %lx\n",
> +                            p->comm, p->pid, that, this,
> +                            p->core_occupation, dst->idle->core_occupation, cookie);
> +
>                 p->on_rq = TASK_ON_RQ_MIGRATING;
>                 deactivate_task(src, p, 0);
>                 set_task_cpu(p, this);
> @@ -6501,6 +6539,8 @@ int sched_cpu_starting(unsigned int cpu)
>                 WARN_ON_ONCE(rq->core && rq->core != core_rq);
>                 rq->core = core_rq;
>         }
> +
> +       printk("core: %d -> %d\n", cpu, cpu_of(core_rq));
>  #endif /* CONFIG_SCHED_CORE */
>
>         sched_rq_cpu_starting(cpu);
> --
> 2.17.1
>
