Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44E2C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A915B2196E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqHf4OIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKMJos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:44:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34774 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725996AbfKMJos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573638286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cDdiHDcEStmY6scJoyJyHvmybCKNNpP7CuLcie0FPDo=;
        b=SqHf4OIU0BHhuYawWcQZ1thu60vzUG48PS6K3ll6LyDxPyhfxZbqr3wrSzU5WNb+S2Ty1p
        5PJLBDWo153JCRB8mjiy1bDaJiBwVAsw6PZFDYVC8dJd3E7eEzjpxbT2Hw1sNu+12QCYFF
        +uHkrEU+9ERf0jAcUqFYKYLiMTiMs20=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-m6vYQEHsN3ylelALsCzhzA-1; Wed, 13 Nov 2019 04:44:43 -0500
Received: by mail-wm1-f70.google.com with SMTP id i23so882550wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 01:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GgDjzSfpCVB8YrwAyb1RA98R17weyuG5Poe+yUVi+WE=;
        b=uVLtI0YPcyJn3gr5xjjnRCwkn9FoiuNslsfy1Dnumh5jQhg8191pa0F7+1Lbffd1uC
         XJuv4g0WZPAx5t8bhU4AKQesf62qveUBCJD+Ey3dmPQyxChWg2be/MbdTo5HidcnuBn1
         v0FxvKywWhDsgDmp1bG/TmoqjQChSiYfkgLaGAhNbVhwoZkJOgTBfYwsdrY1jIb7vUAz
         1Nj+AT7R9XZh39dyHJTCf/EZ9V441ZV2WHJtgVtNu5UId0IBkAPxiHRVy1dKxCcLm+oW
         i8INkMMvpJMVnA+YP5cyKUKu6b5uRADSH0OtlajC7SZ0Gb+sjryxfZ93b2DotNmLFhNm
         QHVA==
X-Gm-Message-State: APjAAAVtoD1nth2Ank4oBVZun+8NM7uVXOWuHSvoG46jJtNjLVWvobFb
        jyaS0JLC5tQhioL24YzZFclpqXsAzPdz28pVaYtf5b5x5zSc8mr+ecjhdB42BXf5WsRtKnAPPMP
        bmrufUjUbhOUB+zQbdbZIk47C
X-Received: by 2002:adf:e94e:: with SMTP id m14mr1923530wrn.233.1573638282305;
        Wed, 13 Nov 2019 01:44:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyliK5aW2MejgU4HFXMPTKirM9swQs+P4RXuy5qOv3Uo8Vs1HaxEKVB7gH1vbmBZomCqj9Qg==
X-Received: by 2002:adf:e94e:: with SMTP id m14mr1923515wrn.233.1573638282031;
        Wed, 13 Nov 2019 01:44:42 -0800 (PST)
Received: from localhost.localdomain ([151.29.177.194])
        by smtp.gmail.com with ESMTPSA id o10sm2175491wrq.92.2019.11.13.01.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Nov 2019 01:44:41 -0800 (PST)
Date:   Wed, 13 Nov 2019 10:44:39 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, glenn@aurora.tech, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, tglx@linutronix.de,
        luca.abeni@santannapisa.it, c.scordino@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com
Subject: Re: [PATCH 2/2] sched/deadline: Temporary copy static parameters to
 boosted non-DEADLINE entities
Message-ID: <20191113094439.GC29273@localhost.localdomain>
References: <20191112075056.19971-1-juri.lelli@redhat.com>
 <20191112075056.19971-3-juri.lelli@redhat.com>
 <20191112105130.GZ4131@hirez.programming.kicks-ass.net>
 <20191113092241.GB29273@localhost.localdomain>
 <20191113093649.GI4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
In-Reply-To: <20191113093649.GI4131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-MC-Unique: m6vYQEHsN3ylelALsCzhzA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/19 10:36, Peter Zijlstra wrote:
> On Wed, Nov 13, 2019 at 10:22:41AM +0100, Juri Lelli wrote:
>=20
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 26e4ffa01e7a..16164b0ba80b 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -4452,9 +4452,11 @@ void rt_mutex_setprio(struct task_struct *p, s=
truct task_struct *pi_task)
> > >  =09=09if (!dl_prio(p->normal_prio) ||
> > >  =09=09    (pi_task && dl_entity_preempt(&pi_task->dl, &p->dl))) {
> > >  =09=09=09p->dl.dl_boosted =3D 1;
> > > -=09=09=09queue_flag |=3D ENQUEUE_REPLENISH;
> > > -=09=09} else
> > > +=09=09=09p->dl.deadline =3D pi_task->dl.deadline;
> > > +=09=09} else {
> > >  =09=09=09p->dl.dl_boosted =3D 0;
> > > +=09=09=09p->dl.deadline =3D p->dl.normal_deadline;
> > > +=09=09}
> > >  =09=09p->sched_class =3D &dl_sched_class;
> > >  =09} else if (rt_prio(prio)) {
> > >  =09=09if (dl_prio(oldprio))
>=20
> > So, the problem is more related to pi_se->dl_runtime than its deadline.
> > Even if we don't replenish at the instant in time when boosting happens=
,
> > the boosted task might still deplete its runtime while being boosted an=
d
>=20
> I thought we ignored all runtime checks when we were boosted? Yes, that

We don't throttle and replenish instantly when runtime is depleted, but
we still account runtime. See update_curr_dl(), dl_runtime_exceeded()
and if(unlikely(dl_se->dl_boosted ...) case.

Mmm, maybe we should stop accounting as well and only postpone
deadlines, is this what you had in mind?

> is all sorts of broken, but IIRC we figured that barring something like
> proxy-execution there really wasn't anything sane we could do wrt
> bandwidth anyway.
>=20
> Seeing how proper bandwidth handling would have the boosted task consume
> the boostee's budget etc.. And blocking the entire boost chain when it
> collectively runs out.

Yep, this is how it should eventually all work.

