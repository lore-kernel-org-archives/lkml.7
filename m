Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC88C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 15:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2643208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 15:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8YDqdqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfERPiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 11:38:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45852 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfERPiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 11:38:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id r76so8767457lja.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 08:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgDTtTVERTwNjf8NMddtgWRCGgsVHMJrNwjmnQAs6TM=;
        b=k8YDqdqRXdEePrdxfXoKGAEWCqYY/m2N4+AnEqDSjDLui4DPfn/p2PBx+mGFa0xqtS
         QrZgrUybPoxk/XSZDATQCrnFBTEjV/n9xCaVkrFuznjdQxOenKEU+aFQTyJwhJtSNmeT
         Xw6Z0ZD/vjp1BF7Gjdds3LryCA5yyldHFbHSNo78vByjwPHZFIRBuIzEdveCTGar9NqS
         sGwuPLU/Lp1QT8Su0hLNEMixl+nEJ5F7JbYYmve5qDyeg2HsyMc2RSlYrdLLMt7KOqdx
         T28HylTfFdbwVFaGS+1myxk93Ef43ECARBucmWS/ItDrzuUhkHO34jOEW1zjhVUTJc/g
         CYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgDTtTVERTwNjf8NMddtgWRCGgsVHMJrNwjmnQAs6TM=;
        b=r37lNGE5W3QxkQ1oE4ZNG0RFw4UdnCmlKlmysKe/oXwbhAEY7QrEzTz/KUmzBI9AxQ
         JBOUbYYjQn1qJLBbyWCFfRbLsSHaNgGY8HSf6AOmITiajluFHiZjvZwW6njXXdSfRFc0
         9kV6xeg0OCWS1rPcdd7bgtSPCrEShoAkp/Ztn/GLdK6rFZX2Flj8Padi0YqaLnQ9oM4q
         vEtvWkP2OTItkHx/x2NSMYka1Qc9gLIoCuD+mGrh7KZ5Hj+xfQHBMlH0NrC6tHcnycE4
         5oPSlOGngYOiJKqMPENfhEw2MOwclXgeMvLsZmYqbb0WBxRrv5KzFJxXG5hc9lcec8pN
         PiRA==
X-Gm-Message-State: APjAAAUitHJzWzQwSQleNZEHE1JmgxKzQVTk6h1q77fgs4mOgRgeasd+
        eUWvFEweVwiNjNfn8IJKHUrBx1X+DUOZWcz8iKc=
X-Google-Smtp-Source: APXvYqwnHnmolT7aodwUgYuyvWwBQq0v9bTk3/4cpuxlMuJf7P8HytXGTiZ9JthrM2+jvTBMLLKUDqciD6qmAjGVg/A=
X-Received: by 2002:a2e:8197:: with SMTP id e23mr4386226ljg.28.1558193887975;
 Sat, 18 May 2019 08:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556025155.git.vpillai@digitalocean.com> <edd4c014e69b68b90160766c6049f2ed922793c7.1556025155.git.vpillai@digitalocean.com>
In-Reply-To: <edd4c014e69b68b90160766c6049f2ed922793c7.1556025155.git.vpillai@digitalocean.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Sat, 18 May 2019 23:37:56 +0800
Message-ID: <CAERHkrtZo0BQg_u9ZPNY_Rk2JY4YT8d5NDRKFQMWeYyAviVShA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/17] sched: Add core wide task selection and scheduling.
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:18 AM Vineeth Remanan Pillai
<vpillai@digitalocean.com> wrote:
>
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Instead of only selecting a local task, select a task for all SMT
> siblings for every reschedule on the core (irrespective which logical
> CPU does the reschedule).
>
> NOTE: there is still potential for siblings rivalry.
> NOTE: this is far too complicated; but thus far I've failed to
>       simplify it further.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c  | 222 ++++++++++++++++++++++++++++++++++++++++++-
>  kernel/sched/sched.h |   5 +-
>  2 files changed, 224 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e5bdc1c4d8d7..9e6e90c6f9b9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3574,7 +3574,7 @@ static inline void schedule_debug(struct task_struct *prev)
>   * Pick up the highest-prio task:
>   */
>  static inline struct task_struct *
> -pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> +__pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
>         const struct sched_class *class;
>         struct task_struct *p;
> @@ -3619,6 +3619,220 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>         BUG();
>  }
>
> +#ifdef CONFIG_SCHED_CORE
> +
> +static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
> +{
> +       if (is_idle_task(a) || is_idle_task(b))
> +               return true;
> +
> +       return a->core_cookie == b->core_cookie;
> +}
> +
> +// XXX fairness/fwd progress conditions
> +static struct task_struct *
> +pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
> +{
> +       struct task_struct *class_pick, *cookie_pick;
> +       unsigned long cookie = 0UL;
> +
> +       /*
> +        * We must not rely on rq->core->core_cookie here, because we fail to reset
> +        * rq->core->core_cookie on new picks, such that we can detect if we need
> +        * to do single vs multi rq task selection.
> +        */
> +
> +       if (max && max->core_cookie) {
> +               WARN_ON_ONCE(rq->core->core_cookie != max->core_cookie);
> +               cookie = max->core_cookie;
> +       }
> +
> +       class_pick = class->pick_task(rq);
> +       if (!cookie)
> +               return class_pick;
> +
> +       cookie_pick = sched_core_find(rq, cookie);
> +       if (!class_pick)
> +               return cookie_pick;
> +
> +       /*
> +        * If class > max && class > cookie, it is the highest priority task on
> +        * the core (so far) and it must be selected, otherwise we must go with
> +        * the cookie pick in order to satisfy the constraint.
> +        */
> +       if (cpu_prio_less(cookie_pick, class_pick) && core_prio_less(max, class_pick))
> +               return class_pick;
> +
> +       return cookie_pick;
> +}
> +
> +static struct task_struct *
> +pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> +{
> +       struct task_struct *next, *max = NULL;
> +       const struct sched_class *class;
> +       const struct cpumask *smt_mask;
> +       int i, j, cpu;
> +
> +       if (!sched_core_enabled(rq))
> +               return __pick_next_task(rq, prev, rf);
> +
> +       /*
> +        * If there were no {en,de}queues since we picked (IOW, the task
> +        * pointers are all still valid), and we haven't scheduled the last
> +        * pick yet, do so now.
> +        */
> +       if (rq->core->core_pick_seq == rq->core->core_task_seq &&
> +           rq->core->core_pick_seq != rq->core_sched_seq) {
> +               WRITE_ONCE(rq->core_sched_seq, rq->core->core_pick_seq);
> +
> +               next = rq->core_pick;
> +               if (next != prev) {
> +                       put_prev_task(rq, prev);
> +                       set_next_task(rq, next);
> +               }
> +               return next;
> +       }
> +

The following patch improved my test cases.
Welcome any comments.

Thanks,
-Aubrey

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3e3162f..86031f4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3685,10 +3685,12 @@ pick_next_task(struct rq *rq, struct
task_struct *prev, struct rq_flags *rf)
        /*
         * If there were no {en,de}queues since we picked (IOW, the task
         * pointers are all still valid), and we haven't scheduled the last
-        * pick yet, do so now.
+        * pick yet, do so now. If the last pick is idle task, we abandon
+        * last pick and try to pick up task this time.
         */
        if (rq->core->core_pick_seq == rq->core->core_task_seq &&
-           rq->core->core_pick_seq != rq->core_sched_seq) {
+           rq->core->core_pick_seq != rq->core_sched_seq &&
+           !is_idle_task(rq->core_pick)) {
                WRITE_ONCE(rq->core_sched_seq, rq->core->core_pick_seq);

                next = rq->core_pick;
