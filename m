Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E48C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1053C2067B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmapRWPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfKMJWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:22:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60866 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726165AbfKMJWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573636969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJBK5GqsRWRSHAzw+iX9H5BVWT6ShwZy7nPfVoFfuRA=;
        b=WmapRWPXVzQDJ69p2cW7TzEG06CRjthqgEEHwmmggB8aT7JmPa4vmuVqN6NPR3TyN9ElQu
        zmCd1iHuUk4Vu/HTI9+1qHXSnYpAC3tUXV+R9u1qBvQ36WqueavpfPJpRntGEz4cNqAffS
        9SFw/B2Hbo3uKyboIHTCkKsj3Is46Jw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-t4DzbyeEOsWotlWmJ8zF-w-1; Wed, 13 Nov 2019 04:22:46 -0500
Received: by mail-wr1-f71.google.com with SMTP id v6so1205979wrm.18
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 01:22:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8kl2Zw/SIXB3dRX/wTpFEopWJ2sWd0XDgzhtmSJ+3rU=;
        b=XhxAEBn/sOVHUjX4EerEvFMqhx4e4rc3IPusIJZGkscEeL/ePtFA0inlS5dL8GLUnI
         OQvoCKotz0zBtHYuCqjYVyqS/dVkPEcNRmVWIaHGe91YCtQ2knsRHpZQWH3LQ9PVjn6G
         4jHL8qvghddF/4bemxOguzxjTap07BWCooT53F6VLCmAaGiel+4V9uUq4qb1p7n/w8rl
         FPrYVV6x0feoOXIp3c9hkEgblFxwsl+DgscacCcxZFMKu2dw2Ub1r+fNUCafIINhgF8u
         2pxPYK0Qo3WOAvXQl2e0hnJ3NDeEdJHPuecxGHEgVqPnBz9sEcnUCUKvXPFmIbR3kHcO
         Fxwg==
X-Gm-Message-State: APjAAAW4RywS0Brgvxt65eC+0KewtZuLMGVeiv8WMeu2+GzuLNx0OMdD
        DjMNNPIrBLjQVYUoK78sjBFOYtQ2NdfjrvUysnJ7rCR8FHPsrPUp0m/Zcly93qvkiyrQIBJybyo
        9QZyi6odJ4EFxGTDes+EW12D9
X-Received: by 2002:a7b:c743:: with SMTP id w3mr1829012wmk.165.1573636965022;
        Wed, 13 Nov 2019 01:22:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqyIs6dM0VBJCx5ce4x5FLJ2C/6B3joM+AH2rBo9UHysp4KWHv7I36LAtJKdblAZnUVIsxxMsg==
X-Received: by 2002:a7b:c743:: with SMTP id w3mr1828968wmk.165.1573636964593;
        Wed, 13 Nov 2019 01:22:44 -0800 (PST)
Received: from localhost.localdomain ([151.29.177.194])
        by smtp.gmail.com with ESMTPSA id t13sm1974933wrr.88.2019.11.13.01.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Nov 2019 01:22:43 -0800 (PST)
Date:   Wed, 13 Nov 2019 10:22:41 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, glenn@aurora.tech, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, tglx@linutronix.de,
        luca.abeni@santannapisa.it, c.scordino@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com
Subject: Re: [PATCH 2/2] sched/deadline: Temporary copy static parameters to
 boosted non-DEADLINE entities
Message-ID: <20191113092241.GB29273@localhost.localdomain>
References: <20191112075056.19971-1-juri.lelli@redhat.com>
 <20191112075056.19971-3-juri.lelli@redhat.com>
 <20191112105130.GZ4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
In-Reply-To: <20191112105130.GZ4131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-MC-Unique: t4DzbyeEOsWotlWmJ8zF-w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/11/19 11:51, Peter Zijlstra wrote:
> On Tue, Nov 12, 2019 at 08:50:56AM +0100, Juri Lelli wrote:
> > Boosted entities (Priority Inheritance) use static DEADLINE parameters
> > of the top priority waiter. However, there might be cases where top
> > waiter could be a non-DEADLINE entity that is currently boosted by a
> > DEADLINE entity from a different lock chain (i.e., nested priority
> > chains involving entities of non-DEADLINE classes). In this case, top
> > waiter static DEADLINE parameters could null (initialized to 0 at
> > fork()) and replenish_dl_entity() would hit a BUG().
>=20
> Argh!
>=20
> > Fix this by temporarily copying static DEADLINE parameters of top
> > DEADLINE waiter (there must be at least one in the chain(s) for the
> > problem above to happen) into boosted entities. Parameters are reset
> > during deboost.
>=20
> Also, yuck!

Indeed. :-(

> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4441,19 +4441,21 @@ void rt_mutex_setprio(struct task_struct *p, st=
ruct task_struct *pi_task)
> >  =09=09if (!dl_prio(p->normal_prio) ||
> >  =09=09    (pi_task && dl_entity_preempt(&pi_task->dl, &p->dl))) {
> >  =09=09=09p->dl.dl_boosted =3D 1;
> > +=09=09=09if (!dl_prio(p->normal_prio))
> > +=09=09=09=09__dl_copy_static(p, pi_task);
> >  =09=09=09queue_flag |=3D ENQUEUE_REPLENISH;
> >  =09=09} else
> >  =09=09=09p->dl.dl_boosted =3D 0;
> >  =09=09p->sched_class =3D &dl_sched_class;
>=20
> So I thought our basic approach was deadline inheritance and screw
> runtime accounting.
>=20
> Given that, I don't quite understand the REPLENISH hack there. Should we
> not simply copy dl->deadline around (and restore on unboost)?
>=20
> That is, should we not do something 'simple' like this:
>=20
>=20
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 84b26d38c929..1579c571cb83 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -522,6 +522,7 @@ struct sched_dl_entity {
>  =09 */
>  =09s64=09=09=09=09runtime;=09/* Remaining runtime for this instance=09*/
>  =09u64=09=09=09=09deadline;=09/* Absolute deadline for this instance=09*=
/
> +=09u64=09=09=09=09normal_deadline;
>  =09unsigned int=09=09=09flags;=09=09/* Specifying the scheduler behaviou=
r=09*/
> =20
>  =09/*
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 26e4ffa01e7a..16164b0ba80b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4452,9 +4452,11 @@ void rt_mutex_setprio(struct task_struct *p, struc=
t task_struct *pi_task)
>  =09=09if (!dl_prio(p->normal_prio) ||
>  =09=09    (pi_task && dl_entity_preempt(&pi_task->dl, &p->dl))) {
>  =09=09=09p->dl.dl_boosted =3D 1;
> -=09=09=09queue_flag |=3D ENQUEUE_REPLENISH;
> -=09=09} else
> +=09=09=09p->dl.deadline =3D pi_task->dl.deadline;
> +=09=09} else {
>  =09=09=09p->dl.dl_boosted =3D 0;
> +=09=09=09p->dl.deadline =3D p->dl.normal_deadline;
> +=09=09}
>  =09=09p->sched_class =3D &dl_sched_class;
>  =09} else if (rt_prio(prio)) {
>  =09=09if (dl_prio(oldprio))
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 43323f875cb9..0ad7c2797f11 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -674,6 +674,7 @@ static inline void setup_new_dl_entity(struct sched_d=
l_entity *dl_se)
>  =09 * spent on hardirq context, etc.).
>  =09 */
>  =09dl_se->deadline =3D rq_clock(rq) + dl_se->dl_deadline;
> +=09dl_se->normal_deadline =3D dl_se->deadline;
>  =09dl_se->runtime =3D dl_se->dl_runtime;
>  }
> =20
> @@ -709,6 +710,7 @@ static void replenish_dl_entity(struct sched_dl_entit=
y *dl_se,
>  =09 */
>  =09if (dl_se->dl_deadline =3D=3D 0) {
>  =09=09dl_se->deadline =3D rq_clock(rq) + pi_se->dl_deadline;
> +=09=09dl_se->normal_deadline =3D dl_se->deadline;
>  =09=09dl_se->runtime =3D pi_se->dl_runtime;
>  =09}
> =20
> @@ -723,6 +725,7 @@ static void replenish_dl_entity(struct sched_dl_entit=
y *dl_se,
>  =09 */
>  =09while (dl_se->runtime <=3D 0) {
>  =09=09dl_se->deadline +=3D pi_se->dl_period;
> +=09=09dl_se->normal_deadline =3D dl_se->normal;
>  =09=09dl_se->runtime +=3D pi_se->dl_runtime;

So, the problem is more related to pi_se->dl_runtime than its deadline.
Even if we don't replenish at the instant in time when boosting happens,
the boosted task might still deplete its runtime while being boosted and
that would cause update_curr_dl() to eventually call
enqueue_task_dl(..., ENQUEUE_REPLENISH) - we don't perform runtime
enforcement on boosted tasks, but still do accounting and 'instant'
replenishment with deadline postponement ('soft CBS'). This in turn will
BUG_ON(pi_se->dl_runtime <=3D 0), as, in a case like Glenn's, N2 and N1
are non-deadline tasks and N1 would be using N2's (pi_se) dl_runtime to
replenish finding it to be 0.

Does it make any sense?

