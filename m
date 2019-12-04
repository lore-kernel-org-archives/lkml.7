Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A81C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6D420675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tw69+kBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfLDKJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:09:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55567 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfLDKJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:09:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so5276652wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 02:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ps1rtOcXuYsUueLU4UdN769iYcf9YnJDnrWZOt41SLc=;
        b=Tw69+kBEOdoxubaVTPe8l5QVMQzlYHNeW45RwYRhiX7i9/RlSHgKFY19iLmrLkUYLR
         NuCegdnXKeyZLAltZLTOWCfYXlk+DnqBPBmtNb2OHPod+rLhXK+XC7IxE4O1A4mLaSoB
         fxcYrKOUZUCjaijunzjvFFu5fEf/xST7tR0Dy/Tv+EDYGfxq1EZVlqHoCSt87szm9gEo
         TsmMYhy3O0G91ecIc+pa0beBW5jdEnYQzScfLgYBdUw+vur5Rhz60ifHp22v0pQTVQ7W
         Qo+GsbDb52g8jsylLrHvBl3EtR/wIvPp/CxWwk14wsRaHYV6nE9vjvSlUgg23ys89GP/
         oqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ps1rtOcXuYsUueLU4UdN769iYcf9YnJDnrWZOt41SLc=;
        b=CZrFaxhkULGdltQP/pub0d4UWLm/Ld0rYZAeigHJiwWB5rkACa5eFE7lv3cPF6InRs
         GJfm//MC0aO3eUXjLeRnpYM3oVMHCnieEwSjRHT2qL/2b4durUkNKIPxKSY2Z/OKu/0R
         a7Xr5kCPFEAf+HLRu9NPNHJGpisbOjJujGLIfkCkmz+IH0NQHz2st3/Nqv11CDYhyhS+
         6HwgD9V+aEoL4+CZiTFp6QJmKRXQ7AKuKGDDHcXmPbmy2Hg/xFR265KLGtKmtrHPfS6u
         NZ8S7pZUPcSmR0pT7xaDD/bey/vN6FuQZMKNv7wx23JX3oFYaFpBy3lU8C+XqijwzGgX
         cB6w==
X-Gm-Message-State: APjAAAVGiQwWVkSj8cFb7RJ5mss4vSwPUCljthrIswQDApqkuhsK/4Fo
        EWUFg/lS/GwegCP6DQDcGvlkOw==
X-Google-Smtp-Source: APXvYqyLlol4OenDCW1ts9oteg2WmoFziuuhOKbgAPDlybGhIPB7rVVgNrGsYpt9YQkiKlLHC4c43A==
X-Received: by 2002:a1c:8086:: with SMTP id b128mr36485189wmd.80.1575454167940;
        Wed, 04 Dec 2019 02:09:27 -0800 (PST)
Received: from linaro.org ([2a01:e0a:f:6020:2cbb:10bf:9f58:c35f])
        by smtp.gmail.com with ESMTPSA id t8sm7447510wrp.69.2019.12.04.02.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 02:09:26 -0800 (PST)
Date:   Wed, 4 Dec 2019 11:09:25 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Null pointer crash at find_idlest_group on db845c w/ linus/master
Message-ID: <20191204100925.GA15727@linaro.org>
References: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
 <CAKfTPtAvnLY3brp9iy_aHNu0rMM8nLfgeLc3CXEkMk3bwU1weA@mail.gmail.com>
 <20191204094216.u7yld5r3zelp22lf@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191204094216.u7yld5r3zelp22lf@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wednesday 04 Dec 2019 à 09:42:17 (+0000), Qais Yousef a écrit :
> On 12/04/19 09:06, Vincent Guittot wrote:
> > Hi John,
> > 
> > On Tue, 3 Dec 2019 at 20:15, John Stultz <john.stultz@linaro.org> wrote:
> > >
> > > With today's linus/master on db845c running android, I'm able to
> > > fairly easily reproduce the following crash. I've not had a chance to
> > > bisect it yet, but I'm suspecting its connected to Vincent's recent
> > > rework.
> > 
> > Does the crash happen randomly or after a specific action ?
> > I have a db845 so I can try to reproduce it locally.
> 
> Isn't there a chance we use local_sgs without initializing it in that function?

Normally not because the cpu belongs to its sched_domain

Now, we test that a group has at least one allowed CPU for the task so we
could skip the local group with the correct/wrong p->cpus_ptr

The path is used for fork/exec ibut also for wakeup path for b.L when the task doesn't fit in the CPUs

So we can probably imagine a scenario where we change task affinity while
sleeping. If the wakeup happens on a CPU that belongs to the group that is not
allowed, we can imagine that we skip the local_group

John,

Could you try the fix below ?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e..bcd216d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8417,6 +8417,10 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
        if (!idlest)
                return NULL;
 
+       /* The local group has been skipped because of cpu affinity */
+       if (!local)
+               return idlest;
+
        /*
         * If the local group is idler than the selected idlest group
         * don't try and push the task.


>
> AFAICS we define local_sgs on the stack but not always could be populated with
> the right values. I can't see tmp_sgs being used in the function too. Could
> this cause the/a problem?
> 
>  8377         struct sg_lb_stats local_sgs, tmp_sgs;
> .
> .
> .
>  8399                 if (local_group) {
>  8400                         sgs = &local_sgs;
>  8401                         local = group;
>  8402                 } else {
>  8403                         sgs = &tmp_sgs;
>  8404                 }
>  8405
>  8406                 update_sg_wakeup_stats(sd, group, sgs, p);
> 
> Cheers
> 
> --
> Qais Youef
