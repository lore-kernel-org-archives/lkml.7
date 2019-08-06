Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A15C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329B5214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbfHFDYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 23:24:30 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:54661 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729383AbfHFDY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 23:24:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0TYnWuqk_1565061858;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TYnWuqk_1565061858)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 06 Aug 2019 11:24:24 +0800
Date:   Tue, 6 Aug 2019 11:24:18 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20190806032418.GA54717@aaronlu>
References: <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad>
 <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu>
 <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <f4778816-69e5-146c-2a30-ec42e7f1677f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4778816-69e5-146c-2a30-ec42e7f1677f@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 08:55:28AM -0700, Tim Chen wrote:
> On 8/2/19 8:37 AM, Julien Desfossez wrote:
> > We tested both Aaron's and Tim's patches and here are our results.
> > 
> > Test setup:
> > - 2 1-thread sysbench, one running the cpu benchmark, the other one the
> >   mem benchmark
> > - both started at the same time
> > - both are pinned on the same core (2 hardware threads)
> > - 10 30-seconds runs
> > - test script: https://paste.debian.net/plainh/834cf45c
> > - only showing the CPU events/sec (higher is better)
> > - tested 4 tag configurations:
> >   - no tag
> >   - sysbench mem untagged, sysbench cpu tagged
> >   - sysbench mem tagged, sysbench cpu untagged
> >   - both tagged with a different tag
> > - "Alone" is the sysbench CPU running alone on the core, no tag
> > - "nosmt" is both sysbench pinned on the same hardware thread, no tag
> > - "Tim's full patchset + sched" is an experiment with Tim's patchset
> >   combined with Aaron's "hack patch" to get rid of the remaining deep
> >   idle cases
> > - In all test cases, both tasks can run simultaneously (which was not
> >   the case without those patches), but the standard deviation is a
> >   pretty good indicator of the fairness/consistency.
> 
> Thanks for testing the patches and giving such detailed data.

Thanks Julien.

> I came to realize that for my scheme, the accumulated deficit of forced idle could be wiped
> out in one execution of a task on the forced idle cpu, with the update of the min_vruntime,
> even if the execution time could be far less than the accumulated deficit.
> That's probably one reason my scheme didn't achieve fairness.

I've been thinking if we should consider core wide tenent fairness?

Let's say there are 3 tasks on 2 threads' rq of the same core, 2 tasks
(e.g. A1, A2) belong to tenent A and the 3rd B1 belong to another tenent
B. Assume A1 and B1 are queued on the same thread and A2 on the other
thread, when we decide priority for A1 and B1, shall we also consider
A2's vruntime? i.e. shall we consider A1 and A2 as a whole since they
belong to the same tenent? I tend to think we should make fairness per
core per tenent, instead of per thread(cpu) per task(sched entity). What
do you guys think?

Implemention of the idea is a mess to me, as I feel I'm duplicating the
existing per cpu per sched_entity enqueue/update vruntime/dequeue logic
for the per core per tenent stuff.
