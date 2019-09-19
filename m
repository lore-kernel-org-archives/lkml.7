Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6F2C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D43D208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390440AbfISOXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:23:23 -0400
Received: from foss.arm.com ([217.140.110.172]:59234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389303AbfISOXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:23:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D830337;
        Thu, 19 Sep 2019 07:23:20 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F4F93F575;
        Thu, 19 Sep 2019 07:23:19 -0700 (PDT)
Date:   Thu, 19 Sep 2019 15:23:16 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Jing-Ting Wu <jing-ting.wu@mediatek.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] sched/rt: avoid contend with CFS task
Message-ID: <20190919142315.vmrrpvljpspqpurp@e107158-lin.cambridge.arm.com>
References: <1567048502-6064-1-git-send-email-jing-ting.wu@mediatek.com>
 <d5100b2d-46c4-5811-8274-8b06710d2594@arm.com>
 <20190830145501.zadfv2ffuu7j46ft@e107158-lin.cambridge.arm.com>
 <1567689999.2389.5.camel@mtkswgap22>
 <CAKfTPtC3txstND=6YkWBJ16i06cQ7xueUpD5j-j-UfuSf0-z-g@mail.gmail.com>
 <1568892135.4892.10.camel@mtkswgap22>
 <CAKfTPtCuWrpW_o6r5cmGhLf_84PFHJhBk0pJ3fcbU_YgcBnTkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCuWrpW_o6r5cmGhLf_84PFHJhBk0pJ3fcbU_YgcBnTkQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19/19 14:27, Vincent Guittot wrote:
> > > > But for requirement of performance, I think it is better to differentiate between idle CPU and CPU has CFS task.
> > > >
> > > > For example, we use rt-app to evaluate runnable time on non-patched environment.
> > > > There are (NR_CPUS-1) heavy CFS tasks and 1 RT Task. When a CFS task is running, the RT task wakes up and choose the same CPU.
> > > > The CFS task will be preempted and keep runnable until it is migrated to another cpu by load balance.
> > > > But load balance is not triggered immediately, it will be triggered until timer tick hits with some condition satisfied(ex. rq->next_balance).
> > >
> > > Yes you will have to wait for the next tick that will trigger an idle
> > > load balance because you have an idle cpu and 2 runnable tack (1 RT +
> > > 1CFS) on the same CPU. But you should not wait for more than  1 tick
> > >
> > > The current load_balance doesn't handle correctly the situation of 1
> > > CFS and 1 RT task on same CPU while 1 CPU is idle. There is a rework
> > > of the load_balance that is under review on the mailing list that
> > > fixes this problem and your CFS task should migrate to the idle CPU
> > > faster than now
> > >
> >
> > Period load balance should be triggered when current jiffies is behind
> > rq->next_balance, but rq->next_balance is not often exactly the same
> > with next tick.
> > If cpu_busy, interval = sd->balance_interval * sd->busy_factor, and
> 
> But if there is an idle CPU on the system, the next idle load balance
> should apply shortly because the busy_factor is not used for this CPU
> which is  not busy.
> In this case, the next_balance interval is sd_weight which is probably
> 4ms at cluster level and 8ms at system level in your case. This means
> between 1 and 2 ticks

But if the CFS task we're preempting was latency sensitive - this 1 or 2 tick
is too late of a recovery.

So while it's good we recover, but a preventative approach would be useful too.
Just saying :-) I'm still not sure if this is the best longer term approach.

--
Qais Yousef
