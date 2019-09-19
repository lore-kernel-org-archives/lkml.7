Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D15C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0042067B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LL11A7S9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbfISOdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:33:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45760 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfISOdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:33:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so3791973ljb.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 07:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+iAm9PNcP/MqvjLYI90Q8a9MlSIBggvtRha4/yfxSjo=;
        b=LL11A7S9PPhZPUMJHeB72Hs8rvCUbc4npJmhdqAx0R3688k13FcJsaavtQI4Gie6D6
         5bE4wdOBlMEb3cNjI70eyY8TMxrSzSMhJMYt5DWDOgVxOmeId8uLKGhhSHFUOpCIs5ck
         TDT9zKzbnrwe1RQ3sKU570sKKD0UsSAlBaCUdQJp6r4gXSlnb5zoKVuiUp6AfLfMh15H
         JTSLVS/JwRuWUptwlfWXp7fFLim+S0v6IPlk9b9mNLKBUvjezs/MfOxUwU6v5XDmbI6C
         atjg8zRfPFuPa5Yk9ReJYTu3uLIMxbs+VYktJfNtBQNhMTtIZGNJXVwhJr31fRuJVkhl
         +sVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+iAm9PNcP/MqvjLYI90Q8a9MlSIBggvtRha4/yfxSjo=;
        b=VBJq9rY+LWlYTFN+AqQYN1+5xRvMq5KzgUbqO06ku2/6B0S0hpfwAofon6NU6IIPKQ
         /RCx01xS3d9VasZgzbrHCp5R+bvbjdFoqJVjgM9LRfEyekQWYqVymXhyibGOQHdCerYM
         +vC8AOqLI/UIV5ZLh4kyAVPTWkKCLod8cR4pmwY0kXywle334AFJyhw9ALnozIgE7bK1
         5A2msxlOVEmM2+qi61ioVsKhOhrAnDgoSIBYkxJSZgnVoG2FmifClExMyjogpRGSLOn8
         qCxSItwtMdjxF2Bk3cLiFMDOx+b8t46ybYZ8uoOQbE40E4uxFsOiJuXgR98NXmbGpasW
         Awig==
X-Gm-Message-State: APjAAAVqoqOEx1Vqj4Rmc5AIP/OF2BRfGySaRkwjhvykDxRixsbPaPOt
        lY7u25dK8MGt7lXQ2NN6Y/t+gbxFIqYEzZAi8AdrDQ==
X-Google-Smtp-Source: APXvYqyfccvz9I3VLff61MNvieg7GcINgTmqho338fZr4EkAQ0b8VLL9XABOtj1AY6IXkT0A6Bp+jQVUf9txqZahj8Y=
X-Received: by 2002:a2e:1b56:: with SMTP id b83mr5621468ljb.107.1568903586009;
 Thu, 19 Sep 2019 07:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <1567048502-6064-1-git-send-email-jing-ting.wu@mediatek.com>
 <d5100b2d-46c4-5811-8274-8b06710d2594@arm.com> <20190830145501.zadfv2ffuu7j46ft@e107158-lin.cambridge.arm.com>
 <1567689999.2389.5.camel@mtkswgap22> <CAKfTPtC3txstND=6YkWBJ16i06cQ7xueUpD5j-j-UfuSf0-z-g@mail.gmail.com>
 <1568892135.4892.10.camel@mtkswgap22> <CAKfTPtCuWrpW_o6r5cmGhLf_84PFHJhBk0pJ3fcbU_YgcBnTkQ@mail.gmail.com>
 <20190919142315.vmrrpvljpspqpurp@e107158-lin.cambridge.arm.com>
In-Reply-To: <20190919142315.vmrrpvljpspqpurp@e107158-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 19 Sep 2019 16:32:53 +0200
Message-ID: <CAKfTPtA9-JLxs+DdLYjBQ6VfVGNxm++QYYi1wy-xS6o==EAPNw@mail.gmail.com>
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

On Thu, 19 Sep 2019 at 16:23, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 09/19/19 14:27, Vincent Guittot wrote:
> > > > > But for requirement of performance, I think it is better to differentiate between idle CPU and CPU has CFS task.
> > > > >
> > > > > For example, we use rt-app to evaluate runnable time on non-patched environment.
> > > > > There are (NR_CPUS-1) heavy CFS tasks and 1 RT Task. When a CFS task is running, the RT task wakes up and choose the same CPU.
> > > > > The CFS task will be preempted and keep runnable until it is migrated to another cpu by load balance.
> > > > > But load balance is not triggered immediately, it will be triggered until timer tick hits with some condition satisfied(ex. rq->next_balance).
> > > >
> > > > Yes you will have to wait for the next tick that will trigger an idle
> > > > load balance because you have an idle cpu and 2 runnable tack (1 RT +
> > > > 1CFS) on the same CPU. But you should not wait for more than  1 tick
> > > >
> > > > The current load_balance doesn't handle correctly the situation of 1
> > > > CFS and 1 RT task on same CPU while 1 CPU is idle. There is a rework
> > > > of the load_balance that is under review on the mailing list that
> > > > fixes this problem and your CFS task should migrate to the idle CPU
> > > > faster than now
> > > >
> > >
> > > Period load balance should be triggered when current jiffies is behind
> > > rq->next_balance, but rq->next_balance is not often exactly the same
> > > with next tick.
> > > If cpu_busy, interval = sd->balance_interval * sd->busy_factor, and
> >
> > But if there is an idle CPU on the system, the next idle load balance
> > should apply shortly because the busy_factor is not used for this CPU
> > which is  not busy.
> > In this case, the next_balance interval is sd_weight which is probably
> > 4ms at cluster level and 8ms at system level in your case. This means
> > between 1 and 2 ticks
>
> But if the CFS task we're preempting was latency sensitive - this 1 or 2 tick
> is too late of a recovery.
>
> So while it's good we recover, but a preventative approach would be useful too.
> Just saying :-) I'm still not sure if this is the best longer term approach.

like using a rt task ?

>
> --
> Qais Yousef
