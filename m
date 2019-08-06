Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B173C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC622086D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UjWbpIYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbfHFRMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 13:12:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbfHFRMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 13:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/PLCpfMIiXDbrZKcO+CegpzUS+nShcw+EtHGygpPYFc=; b=UjWbpIYdko4jsnDq93k7NNuYq
        Uro7dX7Ud/DysTy8YAezq7snHwGe9RRLLHmJb3KNTOxWDwefXyI4zaExd/uZuQZyTC/j2wjoU0bAc
        mK1G8XAQZ/IdvVRBNBS3KLVvw875FSg3WBMf6lG1ThG1x3ObOp1RxBdykeNJ1zozLz2sjuplq+9vM
        1RXjtPF2CXZxkTl2leJDVtlLmMTGSdd1m3mfV2X2zJmYzYsQIFC0cBu6z3zYd+Ht2zzM1pvgIY6cx
        NEwKjfxPL3/BtB9IbLECEWF0kSh/WTOov0Tp6XmcQV8G/Np9N9tpAB2lt/AmHyz3rZj7Gb3NkCWe+
        0Qyy9pY5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv30u-0007Ai-BB; Tue, 06 Aug 2019 17:12:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB7743077A6;
        Tue,  6 Aug 2019 19:12:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2AACF201B3683; Tue,  6 Aug 2019 19:12:41 +0200 (CEST)
Date:   Tue, 6 Aug 2019 19:12:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190806171241.GQ2349@hirez.programming.kicks-ass.net>
References: <20190619183302.GA6775@sinkpad>
 <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu>
 <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <f4778816-69e5-146c-2a30-ec42e7f1677f@linux.intel.com>
 <20190806032418.GA54717@aaronlu>
 <e1c4a7ed-822e-93cb-ff1d-6a0842db115f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c4a7ed-822e-93cb-ff1d-6a0842db115f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 10:03:29AM -0700, Tim Chen wrote:
> On 8/5/19 8:24 PM, Aaron Lu wrote:
> 
> > I've been thinking if we should consider core wide tenent fairness?
> > 
> > Let's say there are 3 tasks on 2 threads' rq of the same core, 2 tasks
> > (e.g. A1, A2) belong to tenent A and the 3rd B1 belong to another tenent
> > B. Assume A1 and B1 are queued on the same thread and A2 on the other
> > thread, when we decide priority for A1 and B1, shall we also consider
> > A2's vruntime? i.e. shall we consider A1 and A2 as a whole since they
> > belong to the same tenent? I tend to think we should make fairness per
> > core per tenent, instead of per thread(cpu) per task(sched entity). What
> > do you guys think?
> > 
> > Implemention of the idea is a mess to me, as I feel I'm duplicating the
> > existing per cpu per sched_entity enqueue/update vruntime/dequeue logic
> > for the per core per tenent stuff.
> 
> I'm wondering if something simpler will work.  It is easier to maintain fairness
> between the CPU threads.  A simple scheme may be if the force idle deficit
> on a CPU thread exceeds a threshold compared to its sibling, we will
> bias in choosing the task on the suppressed CPU thread.  
> The fairness among the tenents per run queue is balanced out by cfq fairness,
> so things should be fair if we maintain fairness in CPU utilization between
> the two CPU threads.

IIRC pjt once did a simle 5ms flip flop between siblings.
