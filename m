Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB28C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6AC218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRuUC7r2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbfIRPWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:22:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35633 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfIRPWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:22:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id w6so1921lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q3kqXbCuXzUR+QDY1B1nlYInDO9mhyaxcVaOhfCtnWg=;
        b=bRuUC7r2Bvm7UCAqg46Gbdzlj7Y29fy5tCUodXlTe64frzKCY51U6NeGZNL7ETN4hn
         aPTP0M8nHB+1xxxUQ/kNg1rx+Z3CJYTJ+vqWLZOooL0n0J6z7k6j8TINwhysjzyKWoLH
         A6vXR0QJz9+BRCn/w55aLvskhl4szShg2rdZywvz3GU5vLSs8nEmMid/x+QXjyMs13fL
         LnH6ddqD51ZMi8rm1wjTLxVCixE+tXs3Rk7ExKxjhCcbBp22u16MUlqfTrI6EroVHpjp
         mNLqqdUp0i8VPkGIzSLPDlQvFIgokdqGjYicNbDPYzGAsHO+ydWZuc8SzYd4jGm0SaYg
         Ju/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q3kqXbCuXzUR+QDY1B1nlYInDO9mhyaxcVaOhfCtnWg=;
        b=Wp5Mwn5MPZ7/KGVcWCGUnFcJCefdcj0he7k1yhgXzMN3+X2Niz7ujoIgylUBF5ThKm
         oDASau4hpfL6dQ9j67hFTiJxuXEa09VKFDlAI5UaFVTbRU9QoFAkSmwHjAKVNgtZYm30
         ykzXohdWeIImKHxkHCfHz/EkI53wDpkkIXzP/7dozCiktwGkO3zkk0R/T7BtHvZ3xEyQ
         WTqnEkFqD45f4gxm1zl7cUDG8DusM7izNywrZmkEdoxJfgGvXk9UdI3Ayep4wT+cnD7d
         xAxAek258A1QzDR3xr3SE6ARtFNcvdMgjYfbuQ5FCrugEOOxWZ5loUxgOOlAXkAjwjZb
         hJkA==
X-Gm-Message-State: APjAAAWzC2XmDPzxgGm2T3TMAdmNZnRaXzPc4u8tERD8UO4LJ7/86Hrf
        9Ja4SjmsFnKV/1NVkyohWlYDdYTzj7U4/1WBIZ/xeXmS
X-Google-Smtp-Source: APXvYqz41tStrsr6VcKArPLyVIsckZCB/GjypmKG0m/oeOz3I4VjCyTWaLAHjHqeJfMVRb/I6+ASEK9IISPY0EobKSI=
X-Received: by 2002:ac2:568c:: with SMTP id 12mr2390595lfr.133.1568820163576;
 Wed, 18 Sep 2019 08:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <3e5c3f36-b806-5bcc-e666-14dc759a2d7b@linux.ibm.com> <87woe51ydd.fsf@arm.com>
In-Reply-To: <87woe51ydd.fsf@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 18 Sep 2019 17:22:32 +0200
Message-ID: <CAKfTPtAF1WM6tCktgyyj=SLfJGT0qT5e_2Fu+SVheyfrJ-pg2A@mail.gmail.com>
Subject: Re: Usecases for the per-task latency-nice attribute
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Parth Shah <parth@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        subhra mazumdar <subhra.mazumdar@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 at 16:19, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
>
> On Wed, Sep 18, 2019 at 13:41:04 +0100, Parth Shah wrote...
>
> > Hello everyone,
>
> Hi Parth,
> thanks for staring this discussion.
>
> [ + patrick.bellasi@matbug.net ] my new email address, since with
> @arm.com I will not be reachable anymore starting next week.
>
> > As per the discussion in LPC2019, new per-task property like latency-nice
> > can be useful in certain scenarios. The scheduler can take proper decision
> > by knowing latency requirement of a task from the end-user itself.
> >
> > There has already been an effort from Subhra for introducing Task
> > latency-nice [1] values and have seen several possibilities where this type of
> > interface can be used.
> >
> > From the best of my understanding of the discussion on the mail thread and
> > in the LPC2019, it seems that there are two dilemmas;
> >
> > 1. Name: What should be the name for such attr for all the possible usecases?
> > =============
> > Latency nice is the proposed name as of now where the lower value indicates
> > that the task doesn't care much for the latency
>
> If by "lower value" you mean -19 (in the proposed [-20,19] range), then
> I think the meaning should be the opposite.
>
> A -19 latency-nice task is a task which is not willing to give up
> latency. For those tasks for example we want to reduce the wake-up
> latency at maximum.
>
> This will keep its semantic aligned to that of process niceness values
> which range from -20 (most favourable to the process) to 19 (least
> favourable to the process).
>
> > and we can spend some more time in the kernel to decide a better
> > placement of a task (to save time, energy, etc.)
>
> Tasks with an high latency-nice value (e.g. 19) are "less sensible to
> latency". These are tasks we wanna optimize mainly for throughput and
> thus, for example, we can spend some more time to find out a better task
> placement at wakeup time.
>
> Does that makes sense?
>
> > But there seems to be a bit of confusion on whether we want biasing as well
> > (latency-biased) or something similar, in which case "latency-nice" may
> > confuse the end-user.
>
> AFAIU PeterZ point was "just" that if we call it "-nice" it has to
> behave as "nice values" to avoid confusions to users. But, if we come up
> with a different naming maybe we will have more freedom.
>
> Personally, I like both "latency-nice" or "latency-tolerant", where:
>
>  - latency-nice:
>    should have a better understanding based on pre-existing concepts
>
>  - latency-tolerant:
>    decouples a bit its meaning from the niceness thus giving maybe a bit
>    more freedom in its complete definition and perhaps avoid any
>    possible interpretation confusion like the one I commented above.
>
> Fun fact: there was also the latency-nasty proposal from PaulMK :)
>
> > 2. Value: What should be the range of possible values supported by this new
> > attr?
> > ==============
> > The possible values of such task attribute still need community attention.
> > Do we need a range of values or just binary/ternary values are sufficient?
> > Also signed or unsigned and so the length of the variable (u64, s32,
> > etc)?
>
> AFAIR, the proposal on the table are essentially two:
>
>  A) use a [-20,19] range
>
>     Which has similarities with the niceness concept and gives a minimal
>     continuous range. This can be on hand for things like scaling the
>     vruntime normalization [3]
>
>  B) use some sort of "profile tagging"
>     e.g. background, latency-sensible, etc...
>
>     If I correctly got what PaulT was proposing toward the end of the
>     discussion at LPC.
>
> This last option deserves better exploration.
>
> At first glance I'm more for option A, I see a range as something that:
>
>   - gives us a bit of flexibility in terms of the possible internal
>     usages of the actual value
>
>   - better supports some kind of linear/proportional mapping
>
>   - still supports a "profile tagging" by (possible) exposing to
>     user-space some kind of system wide knobs defining threshold that
>     maps the continuous value into a "profile"
>     e.g. latency-nice >= 15: use SCHED_BATCH
>
>     In the following discussion I'll call "threshold based profiling"
>     this approach.
>
>
> > This mail is to initiate the discussion regarding the possible usecases of
> > such per task attribute and to come up with a specific name and value for
> > the same.
> >
> > Hopefully, interested one should plot out their usecase for which this new
> > attr can potentially help in solving or optimizing it.
>
> +1
>
> > Well, to start with, here is my usecase.
> >
> > -------------------
> > **Usecases**
> > -------------------
> >
> > $> TurboSched
> > ====================
> > TurboSched [2] tries to minimize the number of active cores in a socket by
> > packing an un-important and low-utilization (named jitter) task on an
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> We should really come up with a different name, since jitters clashes
> with other RT related concepts.
>
> Maybe we don't even need a name at all, the other two attributes you
> specify are good enough to identify those tasks: they are just "small
> background" tasks.
>
>   small      : because on their small util_est value
>   background : because of their high latency-nice value
>
> > already active core and thus refrains from waking up of a new core if
> > possible. This requires tagging of tasks from the userspace hinting which
> > tasks are un-important and thus waking-up a new core to minimize the
> > latency is un-necessary for such tasks.
> > As per the discussion on the posted RFC, it will be appropriate to use the
> > task latency property where a task with the highest latency-nice value can
> > be packed.
>
> We should better defined here what you mean with "highest" latency-nice
> value, do you really mean the top of the range, e.g. 19?
>
> Or...
>
> > But for this specific use-cases, having just a binary value to know which
> > task is latency-sensitive and which not is sufficient enough, but having a
> > range is also a good way to go where above some threshold the task can be
> > packed.
>
> ... yes, maybe we can reason about a "threshold based profiling" where
> something like for example:
>
>    /proc/sys/kernel/sched_packing_util_max    : 200
>    /proc/sys/kernel/sched_packing_latency_min : 17
>
> means that a task with latency-nice >= 17 and util_est <= 200 will be packed?
>
>
> $> Wakeup path tunings
> ==========================
>
> Some additional possible use-cases was already discussed in [3]:
>
>  - dynamically tune the policy of a task among SCHED_{OTHER,BATCH,IDLE}
>    depending on crossing certain pre-configured threshold of latency
>    niceness.
>
>  - dynamically bias the vruntime updates we do in place_entity()
>    depending on the actual latency niceness of a task.
>
>    PeterZ thinks this is dangerous but that we can "(carefully) fumble a
>    bit there."

I agree with Peter that we can easily break the fairness if we bias vruntime

>
>  - bias the decisions we take in check_preempt_tick() still depending
>    on a relative comparison of the current and wakeup task latency
>    niceness values.

This one seems possible as it will mainly enable a task to preempt
"earlier" the running task but will not break the fairness
So the main impact will be the number of context switch between tasks
to favor or not the scheduling latency

>
> > References:
> > ===========
> > [1]. https://lkml.org/lkml/2019/8/30/829
> > [2]. https://lkml.org/lkml/2019/7/25/296
>
>   [3]. Message-ID: <20190905114709.GM2349@hirez.programming.kicks-ass.net>
>        https://lore.kernel.org/lkml/20190905114709.GM2349@hirez.programming.kicks-ass.net/
>
>
> Best,
> Patrick
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
