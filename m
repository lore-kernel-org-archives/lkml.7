Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070BFC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D642423438
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfH3OzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 10:55:09 -0400
Received: from foss.arm.com ([217.140.110.172]:33474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbfH3OzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:55:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C500F344;
        Fri, 30 Aug 2019 07:55:05 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0C2E3F703;
        Fri, 30 Aug 2019 07:55:04 -0700 (PDT)
Date:   Fri, 30 Aug 2019 15:55:02 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Jing-Ting Wu <jing-ting.wu@mediatek.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] sched/rt: avoid contend with CFS task
Message-ID: <20190830145501.zadfv2ffuu7j46ft@e107158-lin.cambridge.arm.com>
References: <1567048502-6064-1-git-send-email-jing-ting.wu@mediatek.com>
 <d5100b2d-46c4-5811-8274-8b06710d2594@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5100b2d-46c4-5811-8274-8b06710d2594@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/19 11:38, Valentin Schneider wrote:
> On 29/08/2019 04:15, Jing-Ting Wu wrote:
> > At original linux design, RT & CFS scheduler are independent.
> > Current RT task placement policy will select the first cpu in
> > lowest_mask, even if the first CPU is running a CFS task.
> > This may put RT task to a running cpu and let CFS task runnable.
> > 
> > So we select idle cpu in lowest_mask first to avoid preempting
> > CFS task.
> > 
> 
> Regarding the RT & CFS thing, that's working as intended. RT is a whole
> class above CFS, it shouldn't have to worry about CFS.
> 
> On the other side of things, CFS does worry about RT. We have the concept
> of RT-pressure in the CFS scheduler, where RT tasks will reduce a CPU's
> capacity (see fair.c::scale_rt_capacity()).
> 
> CPU capacity is looked at on CFS wakeup (see wake_cap() and
> find_idlest_cpu()), and the periodic load balancer tries to spread load
> over capacity, so it'll tend to put less things on CPUs that are also
> running RT tasks.
> 
> If RT were to start avoiding rqs with CFS tasks, we'd end up with a nasty
> situation were both are avoiding each other. It's even more striking when
> you see that RT pressure is done with a rq-wide RT util_avg, which
> *doesn't* get migrated when a RT task migrates. So if you decide to move
> a RT task to an idle CPU "B" because CPU "A" had runnable CFS tasks, the
> CFS scheduler will keep seeing CPU "B" as not significantly RT-pressured
> while that util_avg signal ramps up, whereas it would correctly see CPU
> "A" as RT-pressured if the RT task previously ran there.
> 
> So overall I think this is the wrong approach.

I like the idea, but yeah tend to agree the current approach might not be
enough.

I think the major problem here is that on generic systems where CFS is a first
class citizen, RT tasks can be hostile to them - not always necessarily for a
good reason.

To further complicate the matter, even among CFS tasks we can't tell which are
more important than the others - though hopefully latency-nice proposal will
make the situation better.

So I agree we have a problem here, but I think this patch is just a temporary
band aid and we need to do better. Though I have no concrete suggestion yet on
how to do that.

Another thing I couldn't quantify yet how common and how severe this problem is
yet. Jing-Ting, if you can share the details of your use case that'd be great.

Cheers

--
Qais Yousef
