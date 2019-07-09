Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF624C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74B021670
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q8ZfTANu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfGIPg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 11:36:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41051 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfGIPg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:36:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id 62so13741626lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 08:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TPh3jTfJYH1mQPE+p+Ui1THek54wI3/7w2x9Ph54Pz8=;
        b=Q8ZfTANuiOZegcKM3Bn/7vasHoE1CJXz7mI7QutoG/PgSuLA2LEb0FYQLBJPWlYg6v
         0w3zjRFtfSNdS1RkmdWgR1zGcEBFTfVMOBqACsV7OuqRNJy4/Q8mBEaEdqx+NLpkzEEI
         8ngITUf62eH9XQQog2Dc1jDd52dhr3grD6CU0iKlOtixwKyBO8f7rMdxZIXiNQqKq89Q
         rxdqrRTS78t+GqAVIh2oxvoO6oIJ4yUdMedO0XcfREmQQG/6K+qiRaOQuLnZs0OsXOjW
         WaHhD+th2ws68cHyYANIweMa81TcMtWmIMsk8oB8vdh6Zd3DjbKGHEp2QSPb8vwKO7uA
         JaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TPh3jTfJYH1mQPE+p+Ui1THek54wI3/7w2x9Ph54Pz8=;
        b=mewFFS3vlHTnO9RwzX8ySLJODOs13dnrocFoWqBqjolxkuNXOZ9uOeCZJNsgMdMzob
         i1YWxVWlrrCFqIjZLh5UbXpw8ovExCeo6j+1t2ZtysrtR4DQLJW3As9foC3scDC/bzFz
         7BFVfZ+duXfhKUz7czA82JsVw2M0UXmdbDgmy3V9anJxbRRESyW6vwO3a43T1Iea/z5r
         +NVz3XiQDu6pAbe3qdQlDjvob+MQsPEl0Lvq++jQBXmfVoXNovYKLczrtkiY3zHAXn45
         ZEizJ8aV8/PYeZbxaaNu9ImKKyljLPT5FTudmNB/I53WcZxTLCR+9I55b8yQYWOSULNn
         ZAAA==
X-Gm-Message-State: APjAAAUSAvCQqpiI9hIOiYbla0G+jKghLvVb4WdiM4E9KWToqmV89BhZ
        WVyfVj5Rs8IR9ZqXQM1EbbCUR/Vyimk1bZ/8oRqKzE6p
X-Google-Smtp-Source: APXvYqzUDAremNvrqih5i7ERJR+8OFthmnxxoxj/zfjhY8sG2ShQxbTXK45Z8kixbNZmlO/x3zy0lrASeuGyOs66LxY=
X-Received: by 2002:a19:ec15:: with SMTP id b21mr12931602lfa.32.1562686586223;
 Tue, 09 Jul 2019 08:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190709115759.10451-1-chris.redpath@arm.com> <20190709135054.GF3402@hirez.programming.kicks-ass.net>
 <b0d82dbf-f23b-f858-4c60-b5a413c0e618@arm.com>
In-Reply-To: <b0d82dbf-f23b-f858-4c60-b5a413c0e618@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 9 Jul 2019 17:36:15 +0200
Message-ID: <CAKfTPtCxw8Xqz3rJPKeeDVfvWTcsByAb64_JtB-w2Bp83BGBgw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Update rq_clock, cfs_rq before migrating for
 asym cpu capacity
To:     Chris Redpath <Chris.Redpath@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Tue, 9 Jul 2019 at 17:23, Chris Redpath <Chris.Redpath@arm.com> wrote:
>
> Hi Peter,
>
> On 09/07/2019 14:50, Peter Zijlstra wrote:
> > On Tue, Jul 09, 2019 at 12:57:59PM +0100, Chris Redpath wrote:
> >> The ancient workaround to avoid the cost of updating rq clocks in the
> >> middle of a migration causes some issues on asymmetric CPU capacity
> >> systems where we use task utilization to determine which cpus fit a ta=
sk.
> >> On quiet systems we can inflate task util after a migration which
> >> causes misfit to fire and force-migrate the task.
> >>
> >> This occurs when:
> >>
> >> (a) a task has util close to the non-overutilized capacity limit of a
> >>      particular cpu (cpu0 here); and
> >> (b) the prev_cpu was quiet otherwise, such that rq clock is
> >>      sufficiently out of date (cpu1 here).
> >>
> >> e.g.
> >>                                _____
> >> cpu0: ________________________|   |______________
> >>
> >>                                    |<- misfit happens
> >>            ______                  ___         ___
> >> cpu1: ____|    |______________|___| |_________|
> >>
> >>               ->|              |<- wakeup migration time
> >> last rq clock update
> >>
> >> When the task util is in just the right range for the system, we can e=
nd
> >> up migrating an unlucky task back and forth many times until we are lu=
cky
> >> and the source rq happens to be updated close to the migration time.
> >>
> >> In order to address this, lets update both rq_clock and cfs_rq where
> >> this could be an issue.
> >
> > Can you quantify how much of a problem this really is? It is really sad=
,
> > but this is already the second place where we take rq->lock on
> > migration. We worked so hard to avoid having to acquire it :/
> >
>
> I think you're familiar with the way we test the EAS and misfit stuff,
> but some might not be, so I'll just outline them.
>
> We have performance and placement tests for a suite of simple synthetic
> scenarios selected to trigger the EAS & misfit mechanisms. The
> performance tests use rt-app's slack metric, and we try to minimise
> negative slack (i.e. missed deadlines).
>
> In the placement tests we estimate the minimum energy consumed to run a
> particular synthetic test job and we calculate the energy consumed in
> the actual execution according to a trace. We pass the test if our
> estimate of actual is less than ideal+20%.
>
> We enter this code quite often in our testing, most individual runs of a
> test which has small tasks involved have at least one hit where we make
> a change to the clock with this patch in.

Do you have a rt-app file that you can share ?

>
> That said - despite the relatively high number of hits only about 5% of
> runs see enough additional energy consumed to trigger a test failure. We
> do try to keep a quiet system as much as possible and only run for a few
> seconds so the impact we see in testing is also probably higher than in
> the real world.

Yeah, I'm curious to see the impact on a real system which have a
60fps screen update like an android phone

>
> I totally appreciate the reluctance to add this - I don't much like it
> either, but I was hoping that sticking it behind the asym_cpucapacity
> key might be a reasonable compromise.
>
> At least only those people who select a CPU using task util and capacity
> see this cost, and we have smaller systems so in theory the cost is small=
er.
>
> I'm very open to exploring alternatives :)
>
> >> Signed-off-by: Chris Redpath <chris.redpath@arm.com>
> >> ---
> >>   kernel/sched/fair.c | 15 +++++++++++++++
> >>   1 file changed, 15 insertions(+)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index b798fe7ff7cd..51791db26a2a 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6545,6 +6545,21 @@ static void migrate_task_rq_fair(struct task_st=
ruct *p, int new_cpu)
> >>               * wakee task is less decayed, but giving the wakee more =
load
> >>               * sounds not bad.
> >>               */
> >> +            if (static_branch_unlikely(&sched_asym_cpucapacity) &&
> >> +                    p->state =3D=3D TASK_WAKING) {
> >
> > nit: indent fail.
> >
>
> oops, will tweak it
>
> --Chris
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.
