Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6ACC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81AA206CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfIEN0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:26:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45428 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726843AbfIEN0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:26:46 -0400
X-UUID: fa9d2b8632594392bb4a756e24b54930-20190905
X-UUID: fa9d2b8632594392bb4a756e24b54930-20190905
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jing-ting.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 424018845; Thu, 05 Sep 2019 21:26:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 5 Sep 2019 21:26:37 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 5 Sep 2019 21:26:36 +0800
Message-ID: <1567689999.2389.5.camel@mtkswgap22>
Subject: Re: [PATCH 1/1] sched/rt: avoid contend with CFS task
From:   Jing-Ting Wu <jing-ting.wu@mediatek.com>
To:     Qais Yousef <qais.yousef@arm.com>
CC:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 5 Sep 2019 21:26:39 +0800
In-Reply-To: <20190830145501.zadfv2ffuu7j46ft@e107158-lin.cambridge.arm.com>
References: <1567048502-6064-1-git-send-email-jing-ting.wu@mediatek.com>
         <d5100b2d-46c4-5811-8274-8b06710d2594@arm.com>
         <20190830145501.zadfv2ffuu7j46ft@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-30 at 15:55 +0100, Qais Yousef wrote:
> On 08/29/19 11:38, Valentin Schneider wrote:
> > On 29/08/2019 04:15, Jing-Ting Wu wrote:
> > > At original linux design, RT & CFS scheduler are independent.
> > > Current RT task placement policy will select the first cpu in
> > > lowest_mask, even if the first CPU is running a CFS task.
> > > This may put RT task to a running cpu and let CFS task runnable.
> > > 
> > > So we select idle cpu in lowest_mask first to avoid preempting
> > > CFS task.
> > > 
> > 
> > Regarding the RT & CFS thing, that's working as intended. RT is a whole
> > class above CFS, it shouldn't have to worry about CFS.
> > 
> > On the other side of things, CFS does worry about RT. We have the concept
> > of RT-pressure in the CFS scheduler, where RT tasks will reduce a CPU's
> > capacity (see fair.c::scale_rt_capacity()).
> > 
> > CPU capacity is looked at on CFS wakeup (see wake_cap() and
> > find_idlest_cpu()), and the periodic load balancer tries to spread load
> > over capacity, so it'll tend to put less things on CPUs that are also
> > running RT tasks.
> > 
> > If RT were to start avoiding rqs with CFS tasks, we'd end up with a nasty
> > situation were both are avoiding each other. It's even more striking when
> > you see that RT pressure is done with a rq-wide RT util_avg, which
> > *doesn't* get migrated when a RT task migrates. So if you decide to move
> > a RT task to an idle CPU "B" because CPU "A" had runnable CFS tasks, the
> > CFS scheduler will keep seeing CPU "B" as not significantly RT-pressured
> > while that util_avg signal ramps up, whereas it would correctly see CPU
> > "A" as RT-pressured if the RT task previously ran there.
> > 
> > So overall I think this is the wrong approach.
> 
> I like the idea, but yeah tend to agree the current approach might not be
> enough.
> 
> I think the major problem here is that on generic systems where CFS is a first
> class citizen, RT tasks can be hostile to them - not always necessarily for a
> good reason.
> 
> To further complicate the matter, even among CFS tasks we can't tell which are
> more important than the others - though hopefully latency-nice proposal will
> make the situation better.
> 
> So I agree we have a problem here, but I think this patch is just a temporary
> band aid and we need to do better. Though I have no concrete suggestion yet on
> how to do that.
> 
> Another thing I couldn't quantify yet how common and how severe this problem is
> yet. Jing-Ting, if you can share the details of your use case that'd be great.
> 
> Cheers
> 
> --
> Qais Yousef


I agree that the nasty situation will happen.The current approach and this patch might not be enough.
But for requirement of performance, I think it is better to differentiate between idle CPU and CPU has CFS task.

For example, we use rt-app to evaluate runnable time on non-patched environment.
There are (NR_CPUS-1) heavy CFS tasks and 1 RT Task. When a CFS task is running, the RT task wakes up and choose the same CPU.
The CFS task will be preempted and keep runnable until it is migrated to another cpu by load balance.
But load balance is not triggered immediately, it will be triggered until timer tick hits with some condition satisfied(ex. rq->next_balance).
CFS tasks may be runnable for a long time. In this test case, it increase 332.091 ms runnable time for CFS task.

The detailed log is shown as following, CFS task(thread1-6580) is preempted by RT task(thread0-6674) about 332ms:
thread1-6580  [003] dnh2    94.452898: sched_wakeup: comm=thread0 pid=6674 prio=89 target_cpu=003 
thread1-6580  [003] d..2    94.452916: sched_switch: prev_comm=thread1 prev_pid=6580 prev_prio=120 prev_state=R ==> next_comm=thread0 next_pid=6674 next_prio=89
.... 332.091ms
krtatm-1930  [001] d..2    94.785007: sched_migrate_task: comm=thread1 pid=6580 prio=120 orig_cpu=3 dest_cpu=1
krtatm-1930  [001] d..2    94.785020: sched_switch: prev_comm=krtatm prev_pid=1930 prev_prio=100 prev_state=S ==> next_comm=thread1 next_pid=6580 next_prio=120

So I think choose idle CPU at RT wake up flow could reduce the CFS runnable time. 


Best regards,
Jing-Ting Wu


