Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F52C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B282067B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3UQB2Rr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732622AbfISOhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:37:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35644 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731857AbfISOhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:37:23 -0400
Received: by mail-lf1-f65.google.com with SMTP id w6so2564198lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 07:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/YKIIlDS8lZho9e4vPUeHyogrERU8xcKbZimBkWeCQ=;
        b=W3UQB2RrUJ6vv2M8HVuZVtFpnWXhc3dHhXFwnUsp6CeKd30GsXdyZZw2GFh1mxC8km
         vK8dfFCRgbYvp6PeqcgtD7al/L9UpnvwUFuj5EeKyCb0WOfA7CScYIPAbsF4N2ksXz+0
         X4t+cFR8bz6VRAnE7V77kNi4ZdoCg+MnmI+sUsyRi/1LTugIZgMwa2ClGlOWdvcHoaH8
         +ciin3FlYbQS3Fy5VogrE4bthJuZjKAoBoA6slyjZ0Dw8KKNftfxZzE7oEjyQLr1T74z
         CqgGfFvOg0nHEtuAYtO/wcP+KA/k+Vxl4lkpGrA4E9ZKdgyxFQShtZE6p9OLLMFcHNy7
         09og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/YKIIlDS8lZho9e4vPUeHyogrERU8xcKbZimBkWeCQ=;
        b=hQB5ih9appRsmBpY/m70ChMTnvDtUwqAiznPCy0pIRIqwrR6Kv38jbaDgMjqEonWFH
         DTMxU56BxO+2LVf7E4wO8LGajsUBj4wmPAHGpRLsWFFRzetD/VV4cMWdygL/0wUa1mby
         npGp0AeEsugmU946cz3r4dwx/zsAK+/LQqvJqz052FtDZm0h1Egh5azsY6L8jALCiZDa
         lgWMzhrWplg/o7yD4uPn5W/OeGGE+ojM3GEo9+wFuicS9d/zPhYrw02qn7i3w7OAKUcK
         /z3GvuGNeMAnjmcyTGZCah6XbSn3qr8v2nxVKowOgyxiQV31DdLdQ+vbws+cOrHWRwPy
         07NQ==
X-Gm-Message-State: APjAAAXasIptrgnKfsDdpEYmAgir7hoD2bfBByt/AFmhd99n9XMFHiQy
        g5V7xFO9P5ixeZlxZGFjiROohRKAEpIDtHO+DhQU0A==
X-Google-Smtp-Source: APXvYqxsqDiic3hvUIIWYsTzTncSZd01uGcFQSbFPvhTKDCRIprfIO3eszoVG4u+PbsHXQ8Xikg9MTyxZG/mKHhzbIs=
X-Received: by 2002:ac2:568c:: with SMTP id 12mr5126705lfr.133.1568903841835;
 Thu, 19 Sep 2019 07:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <1567048502-6064-1-git-send-email-jing-ting.wu@mediatek.com>
 <d5100b2d-46c4-5811-8274-8b06710d2594@arm.com> <20190830145501.zadfv2ffuu7j46ft@e107158-lin.cambridge.arm.com>
 <1567689999.2389.5.camel@mtkswgap22> <CAKfTPtC3txstND=6YkWBJ16i06cQ7xueUpD5j-j-UfuSf0-z-g@mail.gmail.com>
 <1568892135.4892.10.camel@mtkswgap22> <CAKfTPtCuWrpW_o6r5cmGhLf_84PFHJhBk0pJ3fcbU_YgcBnTkQ@mail.gmail.com>
 <20190919142315.vmrrpvljpspqpurp@e107158-lin.cambridge.arm.com> <CAKfTPtA9-JLxs+DdLYjBQ6VfVGNxm++QYYi1wy-xS6o==EAPNw@mail.gmail.com>
In-Reply-To: <CAKfTPtA9-JLxs+DdLYjBQ6VfVGNxm++QYYi1wy-xS6o==EAPNw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 19 Sep 2019 16:37:10 +0200
Message-ID: <CAKfTPtAy1JSh725GAVXmg_x3fby1UfYn504tq4n2rQs1-JMy6Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/rt: avoid contend with CFS task
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Jing-Ting Wu <jing-ting.wu@mediatek.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2019 at 16:32, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 19 Sep 2019 at 16:23, Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 09/19/19 14:27, Vincent Guittot wrote:
> > > > > > But for requirement of performance, I think it is better to differentiate between idle CPU and CPU has CFS task.
> > > > > >
> > > > > > For example, we use rt-app to evaluate runnable time on non-patched environment.
> > > > > > There are (NR_CPUS-1) heavy CFS tasks and 1 RT Task. When a CFS task is running, the RT task wakes up and choose the same CPU.
> > > > > > The CFS task will be preempted and keep runnable until it is migrated to another cpu by load balance.
> > > > > > But load balance is not triggered immediately, it will be triggered until timer tick hits with some condition satisfied(ex. rq->next_balance).
> > > > >
> > > > > Yes you will have to wait for the next tick that will trigger an idle
> > > > > load balance because you have an idle cpu and 2 runnable tack (1 RT +
> > > > > 1CFS) on the same CPU. But you should not wait for more than  1 tick
> > > > >
> > > > > The current load_balance doesn't handle correctly the situation of 1
> > > > > CFS and 1 RT task on same CPU while 1 CPU is idle. There is a rework
> > > > > of the load_balance that is under review on the mailing list that
> > > > > fixes this problem and your CFS task should migrate to the idle CPU
> > > > > faster than now
> > > > >
> > > >
> > > > Period load balance should be triggered when current jiffies is behind
> > > > rq->next_balance, but rq->next_balance is not often exactly the same
> > > > with next tick.
> > > > If cpu_busy, interval = sd->balance_interval * sd->busy_factor, and
> > >
> > > But if there is an idle CPU on the system, the next idle load balance
> > > should apply shortly because the busy_factor is not used for this CPU
> > > which is  not busy.
> > > In this case, the next_balance interval is sd_weight which is probably
> > > 4ms at cluster level and 8ms at system level in your case. This means
> > > between 1 and 2 ticks
> >
> > But if the CFS task we're preempting was latency sensitive - this 1 or 2 tick
> > is too late of a recovery.
> >
> > So while it's good we recover, but a preventative approach would be useful too.
> > Just saying :-) I'm still not sure if this is the best longer term approach.
>
> like using a rt task ?

I mean, RT task should select a sub optimal CPU because of CFS
If you want to favor CFS compared to RT it's probably because your
task should be RT too

>
> >
> > --
> > Qais Yousef
