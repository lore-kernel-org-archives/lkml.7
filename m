Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF84C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F76121D56
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwwo/Kcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390322AbfISM13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:27:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36427 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389301AbfISM13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:27:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so3411916ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 05:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ha8X1gKXM2OgP5GKW2tjKlU9Tsz3Jx+NT2gwBoAbABE=;
        b=cwwo/KcykJf98xSlrAY+vAVmmGvDO8Bn9SEgV585oayTN2l3r/qlG2aC7vKu/9HUN5
         rGD74FkjjOIILRuNlG1XLOumz0vYsdmWS6ORX7YXEP8pCc7ICYYeR3LGluvP4UWCITSg
         oVhc90ug2H7xKd2EuIaid23fT365NZd3hQfiJgUFXQsVhNsAJEnfgfs23pRtXTjilfmX
         xcEOoIwA9s/nn616bxCmWfpRU7VFXAqhWKrklmCqUisBDsgBG0pdLYkuKpAMf9YM2WcJ
         9pyhJiUtKKhyFCB+wHDLzpvvN0gcgF9ISsGbj7OmhZg/01dKL0hXhgAVpsFhTqcZZ+Zn
         iZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ha8X1gKXM2OgP5GKW2tjKlU9Tsz3Jx+NT2gwBoAbABE=;
        b=JD2bjDQJ/ipaf96X6P4/YR8gSJLDxTOXrAswd5yyd0RxW4KWs6PDAzeUgECpovcTVO
         tkHrJJ7VnuzieAsspV7MTJBfxPjZkmfmNNbqRcYSiEyjNi19LdZ2wu8lTBThg/DC3KEx
         dy7FNzoUXT6uGyfXsQ7jbLtdwaxxqR4DU+BWQIf7kZdQhk0fBf27hlouWNnnFcKbOXor
         780zDf+kPFvmC1KGn2stiup2GFOLV4U0psEiwd2iViGXgcEsFZZM+TDUVpSv4LRvjdnd
         QiUusnJ3m0bayfVPc1I1WlGVPY8uvrwWNUuvouhMVyTopdaD6fXaF1RMQuPieJsru70O
         oPNw==
X-Gm-Message-State: APjAAAXn6frNexOpmSIeF0zpo+LGtNmM/aJTFQI4lfVYQpKsVKqPLNUv
        fPJtNroGMmG+KoR+wo+LJ+crmgoEHbuKjc3z3larVQ==
X-Google-Smtp-Source: APXvYqxFLG5Rrlb4Yn4UZ9AF1znVYz0eTF1PaF1sJEcTRVYqMZm1CPPuMjs37H9GlpwvU6XSY5dmjKfCXH+ybaEQkrk=
X-Received: by 2002:a2e:9a0c:: with SMTP id o12mr1336490lji.204.1568896045516;
 Thu, 19 Sep 2019 05:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <1567048502-6064-1-git-send-email-jing-ting.wu@mediatek.com>
 <d5100b2d-46c4-5811-8274-8b06710d2594@arm.com> <20190830145501.zadfv2ffuu7j46ft@e107158-lin.cambridge.arm.com>
 <1567689999.2389.5.camel@mtkswgap22> <CAKfTPtC3txstND=6YkWBJ16i06cQ7xueUpD5j-j-UfuSf0-z-g@mail.gmail.com>
 <1568892135.4892.10.camel@mtkswgap22>
In-Reply-To: <1568892135.4892.10.camel@mtkswgap22>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 19 Sep 2019 14:27:13 +0200
Message-ID: <CAKfTPtCuWrpW_o6r5cmGhLf_84PFHJhBk0pJ3fcbU_YgcBnTkQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/rt: avoid contend with CFS task
To:     Jing-Ting Wu <jing-ting.wu@mediatek.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2019 at 13:22, Jing-Ting Wu <jing-ting.wu@mediatek.com> wrot=
e:
>
> On Thu, 2019-09-05 at 16:01 +0200, Vincent Guittot wrote:
> > Hi Jing-Ting,
> >
> > On Thu, 5 Sep 2019 at 15:26, Jing-Ting Wu <jing-ting.wu@mediatek.com> w=
rote:
> > >
> > > On Fri, 2019-08-30 at 15:55 +0100, Qais Yousef wrote:
> > > > On 08/29/19 11:38, Valentin Schneider wrote:
> > > > > On 29/08/2019 04:15, Jing-Ting Wu wrote:
> > > > > > At original linux design, RT & CFS scheduler are independent.
> > > > > > Current RT task placement policy will select the first cpu in
> > > > > > lowest_mask, even if the first CPU is running a CFS task.
> > > > > > This may put RT task to a running cpu and let CFS task runnable=
.
> > > > > >
> > > > > > So we select idle cpu in lowest_mask first to avoid preempting
> > > > > > CFS task.
> > > > > >
> > > > >
> > > > > Regarding the RT & CFS thing, that's working as intended. RT is a=
 whole
> > > > > class above CFS, it shouldn't have to worry about CFS.
> > > > >
> > > > > On the other side of things, CFS does worry about RT. We have the=
 concept
> > > > > of RT-pressure in the CFS scheduler, where RT tasks will reduce a=
 CPU's
> > > > > capacity (see fair.c::scale_rt_capacity()).
> > > > >
> > > > > CPU capacity is looked at on CFS wakeup (see wake_cap() and
> > > > > find_idlest_cpu()), and the periodic load balancer tries to sprea=
d load
> > > > > over capacity, so it'll tend to put less things on CPUs that are =
also
> > > > > running RT tasks.
> > > > >
> > > > > If RT were to start avoiding rqs with CFS tasks, we'd end up with=
 a nasty
> > > > > situation were both are avoiding each other. It's even more strik=
ing when
> > > > > you see that RT pressure is done with a rq-wide RT util_avg, whic=
h
> > > > > *doesn't* get migrated when a RT task migrates. So if you decide =
to move
> > > > > a RT task to an idle CPU "B" because CPU "A" had runnable CFS tas=
ks, the
> > > > > CFS scheduler will keep seeing CPU "B" as not significantly RT-pr=
essured
> > > > > while that util_avg signal ramps up, whereas it would correctly s=
ee CPU
> > > > > "A" as RT-pressured if the RT task previously ran there.
> > > > >
> > > > > So overall I think this is the wrong approach.
> > > >
> > > > I like the idea, but yeah tend to agree the current approach might =
not be
> > > > enough.
> > > >
> > > > I think the major problem here is that on generic systems where CFS=
 is a first
> > > > class citizen, RT tasks can be hostile to them - not always necessa=
rily for a
> > > > good reason.
> > > >
> > > > To further complicate the matter, even among CFS tasks we can't tel=
l which are
> > > > more important than the others - though hopefully latency-nice prop=
osal will
> > > > make the situation better.
> > > >
> > > > So I agree we have a problem here, but I think this patch is just a=
 temporary
> > > > band aid and we need to do better. Though I have no concrete sugges=
tion yet on
> > > > how to do that.
> > > >
> > > > Another thing I couldn't quantify yet how common and how severe thi=
s problem is
> > > > yet. Jing-Ting, if you can share the details of your use case that'=
d be great.
> > > >
> > > > Cheers
> > > >
> > > > --
> > > > Qais Yousef
> > >
> > >
> > > I agree that the nasty situation will happen.The current approach and=
 this patch might not be enough.
> >
> > RT task should not harm its cache hotness and responsiveness for the
> > benefit of a CFS task
> >
>
> Yes, it=E2=80=99s a good point to both consider cache hotness. We have re=
vised
> the implementation to select a better idle CPU in the same sched_domain
> of prev_cpu (with the same cache hotness) when the RT task wakeup.
>
> I modify the code of find_lowest_rq as following:
> @@ -1648,6 +1629,9 @@ static int find_lowest_rq(struct task_struct
> *task)
>         struct cpumask *lowest_mask =3D
> this_cpu_cpumask_var_ptr(local_cpu_mask);
>         int this_cpu =3D smp_processor_id();
>         int cpu      =3D task_cpu(task);
> +       int i;
> +       struct rq *prev_rq =3D cpu_rq(cpu);
> +       struct sched_domain *prev_sd;
>
>         /* Make sure the mask is initialized first */
>         if (unlikely(!lowest_mask))
> @@ -1659,6 +1643,24 @@ static int find_lowest_rq(struct task_struct
> *task)
>         if (!cpupri_find(&task_rq(task)->rd->cpupri, task, lowest_mask))
>                 return -1; /* No targets found */
>
> +       /* Choose previous cpu if it is idle and it fits lowest_mask */
> +       if (cpumask_test_cpu(cpu, lowest_mask) && idle_cpu(cpu))
> +               return cpu;
> +
> +       rcu_read_lock();
> +       prev_sd =3D rcu_dereference(prev_rq->sd);
> +
> +       if (prev_sd) {
> +               /* Choose idle_cpu among lowest_mask and it is closest
> to our hot cache data */
> +               for_each_cpu(i, lowest_mask) {
> +                       if (idle_cpu(i) && cpumask_test_cpu(i,
> sched_domain_span(prev_sd))) {
> +                               rcu_read_unlock();
> +                               return i;
> +                       }
> +               }
> +       }
> +       rcu_read_unlock();
> +
>         /*
>          * At this point we have built a mask of CPUs representing the
>          * lowest priority tasks in the system.  Now we want to elect
>
>
>
> > > But for requirement of performance, I think it is better to different=
iate between idle CPU and CPU has CFS task.
> > >
> > > For example, we use rt-app to evaluate runnable time on non-patched e=
nvironment.
> > > There are (NR_CPUS-1) heavy CFS tasks and 1 RT Task. When a CFS task =
is running, the RT task wakes up and choose the same CPU.
> > > The CFS task will be preempted and keep runnable until it is migrated=
 to another cpu by load balance.
> > > But load balance is not triggered immediately, it will be triggered u=
ntil timer tick hits with some condition satisfied(ex. rq->next_balance).
> >
> > Yes you will have to wait for the next tick that will trigger an idle
> > load balance because you have an idle cpu and 2 runnable tack (1 RT +
> > 1CFS) on the same CPU. But you should not wait for more than  1 tick
> >
> > The current load_balance doesn't handle correctly the situation of 1
> > CFS and 1 RT task on same CPU while 1 CPU is idle. There is a rework
> > of the load_balance that is under review on the mailing list that
> > fixes this problem and your CFS task should migrate to the idle CPU
> > faster than now
> >
>
> Period load balance should be triggered when current jiffies is behind
> rq->next_balance, but rq->next_balance is not often exactly the same
> with next tick.
> If cpu_busy, interval =3D sd->balance_interval * sd->busy_factor, and

But if there is an idle CPU on the system, the next idle load balance
should apply shortly because the busy_factor is not used for this CPU
which is  not busy.
In this case, the next_balance interval is sd_weight which is probably
4ms at cluster level and 8ms at system level in your case. This means
between 1 and 2 ticks

longer interval means that :
-all cpu are busy,
-the cpu has trigger an all_pinned case
-the idle load balance fails to migrate the task. And this is probably
the your case. https://lore.kernel.org/patchwork/patch/1129117/ should
reduce time before migrating the CFS task to 1-2 ticks

> interval is clamped by 1 to max_load_balance_interval.
> By experiment, in a system with HZ=3D250, available_cpus =3D 8, the
> max_load_balance_interval =3D HZ * available_cpus / 10 =3D 250 * 8 / 10 =
=3D
> 200 jiffies,
> It would let rq->next_balance =3D sd->last_balance + interval, the maximu=
m
> interval =3D 200 jiffies, result in more than 1 sched-tick to migrate a
> CFS task.
>
>
>
> > > CFS tasks may be runnable for a long time. In this test case, it incr=
ease 332.091 ms runnable time for CFS task.
> > >
> > > The detailed log is shown as following, CFS task(thread1-6580) is pre=
empted by RT task(thread0-6674) about 332ms:
> >
> > 332ms is quite long and is probably not an idle load blanace but a
> > busy load balance
> >
> > > thread1-6580  [003] dnh2    94.452898: sched_wakeup: comm=3Dthread0 p=
id=3D6674 prio=3D89 target_cpu=3D003
> > > thread1-6580  [003] d..2    94.452916: sched_switch: prev_comm=3Dthre=
ad1 prev_pid=3D6580 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=3Dthre=
ad0 next_pid=3D6674 next_prio=3D89
> > > .... 332.091ms
> > > krtatm-1930  [001] d..2    94.785007: sched_migrate_task: comm=3Dthre=
ad1 pid=3D6580 prio=3D120 orig_cpu=3D3 dest_cpu=3D1
> > > krtatm-1930  [001] d..2    94.785020: sched_switch: prev_comm=3Dkrtat=
m prev_pid=3D1930 prev_prio=3D100 prev_state=3DS =3D=3D> next_comm=3Dthread=
1 next_pid=3D6580 next_prio=3D120
> >
> > your CFS task has not moved on the idle CPU but has replaced another ta=
sk
> >
>
> I think it is minor and reasonable, because CPU1 has triggered idle
> balance (when krtatm task is the last task leaving CPU1) to pull the
> thread1-6580.

so it was a newly-idle load_balance not an idle load balance

>
>
>
> Best regards,
> Jing-Ting Wu
>
> > Regards,
> > Vincent
> > >
> > > So I think choose idle CPU at RT wake up flow could reduce the CFS ru=
nnable time.
> > >
> > >
> > > Best regards,
> > > Jing-Ting Wu
> > >
> > >
>
>
