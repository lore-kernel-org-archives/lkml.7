Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0D7C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15A022CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qtB5oJYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfIDGow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:44:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40103 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfIDGow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:44:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so8951841ljw.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 23:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PV59x0jONCn6oZH/Jt37mkqxwJDrEsrzpgLl+0g6yY=;
        b=qtB5oJYMCrvZltHTV+MM+PBEQ+p+R0XM5ahn+0OUrNvTXlST91Cn+Stqm4/EExX0Zk
         u+0eyh0ncZDZLUSB3JL6zwE4I/0y6APYbgOaFjvw1z/tKVmSFVO1gjdUJcOfNrzfg7c/
         KWLmUlCsEI5lSqNgl37KlIWKlRMeprOBhyDjSg5OADtA9LsRa8J7CL99Q+u9dbTI7bRl
         rm4tvEmQDRB8k4vzyid3kmj/eDctx9juHwtwRrCaGzHzoJFDHDCfo7yCTtEMcaws9OuS
         DKk58CO69SNf17Co8m/gpxSy4f3P9TC7eaqIClCSW9sxCaHzRdoSo0BTKSQQ8IjE2FnY
         uU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PV59x0jONCn6oZH/Jt37mkqxwJDrEsrzpgLl+0g6yY=;
        b=KRagJjoXxG6w88DJsosTHXHL6Ve5Qw+FxO/y2lyJyrU/fC9dmVcfXAJbZ2oVwzC5yG
         z3ici/3yO6Bmu4w0aHCUmvImcHmFf58ZgajnRNV+++Vc4mGg9U67qySYS9U64bIuawr1
         I5ibe552Fk5rweqrKe1bZ/KgKIU9Nn1zQg2uiyaCp3AaV3HGWAk8W7jAvp6AfGkFY0G0
         bYhC9uVnCU6kEzn2fCmbXB62mPx20oPq5Cu2D/vBjlQ80wTZB5ZZlU5qcgiw5b3NmNfE
         4hb9u1Opwq44dW7t+DRFIt1u16KYoAZLMi8VNUB7PXTxrv152iUd9qYLfWXq7psi3bIe
         3t0w==
X-Gm-Message-State: APjAAAX/MijO9jayvDOcd1a7/4dspTHFC2E5Ol4aeKbsYBe3g63+xOEb
        7n2B2yQxzWhzoGCfsfBlhX3kPJSA+43ffPb27x6SAw==
X-Google-Smtp-Source: APXvYqwKz8Cx4FBN7z4mOn4CvKemj1SoODI9SWAUoCW2WdW9oF/tMHmShuBFA5/zXOSv7GYcUc6yauljLoPNYNchYZE=
X-Received: by 2002:a2e:94cd:: with SMTP id r13mr13090247ljh.24.1567579490798;
 Tue, 03 Sep 2019 23:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190822021740.15554-1-riel@surriel.com> <20190822021740.15554-10-riel@surriel.com>
 <CAKfTPtAw1f89d4Sv+vSfytP8pJy-fy1hvpcz-=hoz4nrZXQV6A@mail.gmail.com> <6d07046810f4a490960d0124e99fe9cf546e9d10.camel@surriel.com>
In-Reply-To: <6d07046810f4a490960d0124e99fe9cf546e9d10.camel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Sep 2019 08:44:39 +0200
Message-ID: <CAKfTPtDbpd_FgPX21QDLSm=S7FL9z2HbS2b96aGOTAUw_bcxmg@mail.gmail.com>
Subject: Re: [PATCH 09/15] sched,fair: refactor enqueue/dequeue_entity
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

On Tue, 3 Sep 2019 at 22:27, Rik van Riel <riel@surriel.com> wrote:
>
> On Tue, 2019-09-03 at 17:38 +0200, Vincent Guittot wrote:
> > Hi Rik,
> >
> > On Thu, 22 Aug 2019 at 04:18, Rik van Riel <riel@surriel.com> wrote:
> > > Refactor enqueue_entity, dequeue_entity, and update_load_avg, in
> > > order
> > > to split out the things we still want to happen at every level in
> > > the
> > > cgroup hierarchy with a flat runqueue from the things we only need
> > > to
> > > happen once.
> > >
> > > No functional changes.
> > >
> > > Signed-off-by: Rik van Riel <riel@surriel.com>
> > > ---
> > >  kernel/sched/fair.c | 64 +++++++++++++++++++++++++++++----------
> > > ------
> > >  1 file changed, 42 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 74ee22c59d13..7b0d95f2e3a8 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -3502,7 +3502,7 @@ static void detach_entity_load_avg(struct
> > > cfs_rq *cfs_rq, struct sched_entity *s
> > >  #define DO_ATTACH      0x4
> > >
> > >  /* Update task and its cfs_rq load average */
> > > -static inline void update_load_avg(struct cfs_rq *cfs_rq, struct
> > > sched_entity *se, int flags)
> > > +static inline bool update_load_avg(struct cfs_rq *cfs_rq, struct
> > > sched_entity *se, int flags)
> > >  {
> > >         u64 now = cfs_rq_clock_pelt(cfs_rq);
> > >         int decayed;
> > > @@ -3531,6 +3531,8 @@ static inline void update_load_avg(struct
> > > cfs_rq *cfs_rq, struct sched_entity *s
> > >
> > >         } else if (decayed && (flags & UPDATE_TG))
> > >                 update_tg_load_avg(cfs_rq, 0);
> > > +
> > > +       return decayed;
> >
> > This is a functional change, isn't it ?
> > update_cfs_group is now called only if decayed but we can we attach a
> > task during the enqueue and there is no decay
>
> Yes, it is, and patch 11 changes the way this functional
> change is done.
>
> If you want, I can change this patch to not have the
> functional change, though in the end it should not make
> any difference.

It's mainly that the code is not aligned with the commit message

I will continue to review other patch and will come back to this one
after reviewing patch 11

Thanks
Vincent
>
> --
> All Rights Reversed.
