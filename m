Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5BFC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511C520675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JdRLHNFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbfLDSTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:19:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33140 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbfLDSTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:19:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id 21so441833ljr.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 10:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TO3M4JRDwYEQYalzC1JJGfXlWb3K9ShCnnIC37XGBvg=;
        b=JdRLHNFl/zP5IdAJrHumL9k5kT+8N/SXMgaszfW6wKBo84jtVsc8GDMDEnHdUfzsxb
         UH5/xrbFYWjsnujb1VgNV0ifwdAa6m2rUr/VbbeTKuNW4BHdAB17wKII+KD6isEytVz9
         8kEgho3g4wpnYqC27M7LDRh8voiRk1Fr197UjvGqnmez4aSHveJEcfdpWGs4ON0Kb58l
         TPd/YkqWWyCAHUvV5oZqSTPSe4c20GL8w5run9Fva+GzuNglr8j/ZmchkzY5PT9zY4le
         EKDlDTR/jCYBd92gms9jcyKKt3MPmcpzYfYz25tbx2QBYpR3qsI/DNV9BYYPR+kf4+gG
         D2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TO3M4JRDwYEQYalzC1JJGfXlWb3K9ShCnnIC37XGBvg=;
        b=eFceCEEcKDk31XPZB9pzxAfByFDxzcDbVvfwmiE79m+Gfk0jmb7cgXRemmzcn4jQGG
         PKxW3hfcQW+Wrzqz32mJzKAkG50Zd1hpx6CQbBdnewRo5d+eobdOddM/KWZwFCbs6ybZ
         TGvAa6LJ2S/5am3WWA7izWmViPrCUcLQMbu6AVTAShAWyV/DPBUhTuUTydAr7wnwxW9y
         dhrrYRVnZ7GPLVWPSoQrRMCWD4kcs1XuOShsiZCtM86RVF/+NrDiQAVfbKlNSMBzxOg7
         QQQdj0KTXZ6vrPMVhO1TLIP8Ay5NmWOGODEhwmn/zhoK787opfK4X2GiUj0tF6XSxiiq
         za0w==
X-Gm-Message-State: APjAAAXxt1cx4+7IcbaGJgDHVDChPJ4FxOaxF9pr50iA5bk01Jp31EMU
        XC2vPU89JjHeVwhX5UvFclXpiLIpMNDIuGquxxVvSA==
X-Google-Smtp-Source: APXvYqyzBiR+Ed0b5BcuFC05QaXCBuLCHt63QfZjPhGoegC3WP3wGNcc6ShbnjkYko3wnz8eotLLdLInGe+67+UCcjQ=
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr510830ljn.48.1575483580174;
 Wed, 04 Dec 2019 10:19:40 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
 <CAKfTPtAvnLY3brp9iy_aHNu0rMM8nLfgeLc3CXEkMk3bwU1weA@mail.gmail.com>
 <20191204094216.u7yld5r3zelp22lf@e107158-lin.cambridge.arm.com>
 <20191204100925.GA15727@linaro.org> <CALAqxLWCFNJzNvgrSKSs3s42O=D6EPmnvwPTWV_k-QH7v7VNtQ@mail.gmail.com>
In-Reply-To: <CALAqxLWCFNJzNvgrSKSs3s42O=D6EPmnvwPTWV_k-QH7v7VNtQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Dec 2019 19:19:26 +0100
Message-ID: <CAKfTPtC-G+avBrixS35emnqUvW_MMjRBLyy=WxRB=bvS62zg_w@mail.gmail.com>
Subject: Re: Null pointer crash at find_idlest_group on db845c w/ linus/master
To:     John Stultz <john.stultz@linaro.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019 at 19:16, John Stultz <john.stultz@linaro.org> wrote:
>
> On Wed, Dec 4, 2019 at 2:09 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Le Wednesday 04 Dec 2019 =C3=A0 09:42:17 (+0000), Qais Yousef a =C3=A9c=
rit :
> > > On 12/04/19 09:06, Vincent Guittot wrote:
> > > > Hi John,
> > > >
> > > > On Tue, 3 Dec 2019 at 20:15, John Stultz <john.stultz@linaro.org> w=
rote:
> > > > >
> > > > > With today's linus/master on db845c running android, I'm able to
> > > > > fairly easily reproduce the following crash. I've not had a chanc=
e to
> > > > > bisect it yet, but I'm suspecting its connected to Vincent's rece=
nt
> > > > > rework.
> > > >
> > > > Does the crash happen randomly or after a specific action ?
> > > > I have a db845 so I can try to reproduce it locally.
> > >
> > > Isn't there a chance we use local_sgs without initializing it in that=
 function?
> >
> > Normally not because the cpu belongs to its sched_domain
> >
> > Now, we test that a group has at least one allowed CPU for the task so =
we
> > could skip the local group with the correct/wrong p->cpus_ptr
> >
> > The path is used for fork/exec ibut also for wakeup path for b.L when t=
he task doesn't fit in the CPUs
> >
> > So we can probably imagine a scenario where we change task affinity whi=
le
> > sleeping. If the wakeup happens on a CPU that belongs to the group that=
 is not
> > allowed, we can imagine that we skip the local_group
> >
> > John,
> >
> > Could you try the fix below ?
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 08a233e..bcd216d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8417,6 +8417,10 @@ find_idlest_group(struct sched_domain *sd, struc=
t task_struct *p,
> >         if (!idlest)
> >                 return NULL;
> >
> > +       /* The local group has been skipped because of cpu affinity */
> > +       if (!local)
> > +               return idlest;
> > +
> >         /*
> >          * If the local group is idler than the selected idlest group
> >          * don't try and push the task.
>
> This patch does seem to solve the issue for me! Thanks so much!

Thanks for testing

>
> Tested-by: John Stultz <john.stultz@linaro.org>
> -john
