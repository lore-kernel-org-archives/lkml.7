Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E638DC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7136222C6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLQ96LKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfKMNar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:30:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41962 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfKMNar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:30:47 -0500
Received: by mail-lj1-f193.google.com with SMTP id d22so2568927lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 05:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OOnEuO9COFi4aqj08qcvAhg7573JPt49e4+HEFPh3cQ=;
        b=pLQ96LKUVUgrh2Xs8imGdJTUy4dQn1wyCiKhmMGZK2M+TBn9MlFaeIycIXKeJ0LG0f
         qZmGjLSYiy1WoBKwpJsMoMVg+tQCJhv+OPRUdvq940V2jVsjNl2+BA4wYL4UQ6384gNu
         bwfMOGUvHyyCkUv4obZsVStsWgTwWa0JOKDFPHy4WOLd8MwuNIYBa3JH6FjmWuHVqFat
         P761xD9lH9Mlkz6EHM3hn6glre11aj3gTxq58kgym9ed6jzOhpm/zLejtjdbisgfMwsS
         1JP2041OTjxXLsF/tWujkv31qQuHtLaPvUfCohc98qSPbGJAmZX/MXFdpBd4bpCmCGnC
         W2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OOnEuO9COFi4aqj08qcvAhg7573JPt49e4+HEFPh3cQ=;
        b=Qjs66Ssj36SdA0W2k0UEit+hLcpynl8Lw7Fu+niJdRcgMLcYcl/RZ5jayRtIxmKJql
         TnQDbHxgQsR4WIUVaSz7VF1wxtDiMYGNzoO5g0THgvt13TEfcypZrSljuTMPjk5YPyZ1
         Lc0Cs+1oDiZUyCdOhfRl+NTwDeBtiYnN8Q52X0jBg5+rqYeEE3tVC5MfSuDt7OZc6ziQ
         7SkVjqS/2Wq78OChY4EqDFhKtzrETngSh1alYin1qeAY1Pps1sAMmkd1a6d26qcrMrRU
         ROVC4fMy3YvtAwTbiYqXfjK1v3DpZ7w711DuwLIjEl7kchjB9RRVQ9sIKmrY97uWLuay
         HUIw==
X-Gm-Message-State: APjAAAUsERgTqsNVcPPx8SPkU+4EqzBJQ0pAInhp2bMmKQYSHujOD+OQ
        9nNuUJlLWL0j+g9f5ONbrMQiDmww6iDVQsc8DZemTg==
X-Google-Smtp-Source: APXvYqwWujEGA3sqMgB0m8GdEybm4VNcXLjSY8U4Lgc3LKiZkpqhS7SrGPz5w9X1VeygVyGay7PJRPQtcQ+oSkJ8PQM=
X-Received: by 2002:a2e:9695:: with SMTP id q21mr2549457lji.206.1573651843281;
 Wed, 13 Nov 2019 05:30:43 -0800 (PST)
MIME-Version: 1.0
References: <1573570093-1340-1-git-send-email-vincent.guittot@linaro.org>
 <20191112150544.GA3664@linaro.org> <3b8cafb7-894d-c302-e6c6-b5844b1298b5@arm.com>
In-Reply-To: <3b8cafb7-894d-c302-e6c6-b5844b1298b5@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 13 Nov 2019 14:30:31 +0100
Message-ID: <CAKfTPtBMNnM2tTfb72VtufDpwBvqu6Ttj3dnLgoNOZ--Q6qo+Q@mail.gmail.com>
Subject: Re: [PATCH v2] sched/freq: move call to cpufreq_update_util
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019 at 11:50, Dietmar Eggemann <dietmar.eggemann@arm.com> w=
rote:
>
> On 12.11.19 16:05, Vincent Guittot wrote:
> > Le Tuesday 12 Nov 2019 =C3=A0 15:48:13 (+0100), Vincent Guittot a =C3=
=A9crit :
> >> update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt dec=
ays,
> >> which might be inefficient when cpufreq driver has rate limitation.
> >>
> >> When a task is attached on a CPU, we have call path:
> >>
> >> update_blocked_averages()
> >>   update_cfs_rq_load_avg()
> >>     cfs_rq_util_change -- > trig frequency update
> >>   attach_entity_load_avg()
> >>     cfs_rq_util_change -- > trig frequency update
>
> This looks like attach_entity_load_avg() is called from
> update_blocked_averages(). Do you refer to the attach_entity_load_avg()
> call from attach_entity_cfs_rq() or update_load_avg() here? I assume the
> former.

ah... typo mistake, i wanted to write update_load_avg
update_blocked_averages()
  update_cfs_rq_load_avg()
    cfs_rq_util_change -- > trig frequency update
  attach_entity_load_avg()
    cfs_rq_util_change -- > trig frequency update

>
> >> The 1st frequency update will not take into account the utilization of=
 the
> >> newly attached task and the 2nd one might be discard because of rate
> >> limitation of the cpufreq driver.
> >>
> >> update_cfs_rq_load_avg() is only called by update_blocked_averages()
> >> and update_load_avg() so we can move the call to
> >> {cfs_rq,cpufreq}_util_change() into these 2 functions. It's also
>
> s/cpufreq_util_change()/cpufreq_update_util() ?

yes

>
> [...]
>
> >> I have just rebased the patch on latest tip/sched/core and made it a p=
roper
> >> patchset after Doug reported that the problem has diseappeared accordi=
ng to
> >> his 1st results but tests results are not all based on the same v5.4-r=
cX
> >> and with menu instead of teo governor.
>
> I had some minor tweaks to do putting this on a0e813f26ebc ("sched/core:
> Further clarify sched_class::set_next_task()") ? I saw the '[tip:
> sched/urgent] sched/pelt: Fix update of blocked PELT ordering' tip-bot
> msg this morning though.

yes, a0e813f26ebc was item 1 and this patch is item 2 on top

>
> [...]
>
> >> @@ -7493,9 +7495,9 @@ static void update_blocked_averages(int cpu)
> >>       * that RT, DL and IRQ signals have been updated before updating =
CFS.
> >>       */
> >>      curr_class =3D rq->curr->sched_class;
> >> -    update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class =3D=3D &r=
t_sched_class);
> >> -    update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class =3D=3D &d=
l_sched_class);
> >> -    update_irq_load_avg(rq, 0);
> >> +    decayed |=3D update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_cl=
ass =3D=3D &rt_sched_class);
> >> +    decayed |=3D update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_cl=
ass =3D=3D &dl_sched_class);
> >> +    decayed |=3D update_irq_load_avg(rq, 0);
>
> Why not 'decayed  =3D update_cfs_rq_load_avg()' like in the
> !CONFIG_FAIR_GROUP_SCHED case?

Because it is handled by the update_load_avg() in
for_each_leaf_cfs_rq_safe() loop

This means that we can have 2 calls to cpufreq_update_util in
update_blocked_average() but at least the values will be up to date in
both calls unlike previously.

I'm going to prepare an additional patch to remove this useless call.
I have also seen some possible further optimization that i need to
study a bit more before preparing a patch


>
> [...]
