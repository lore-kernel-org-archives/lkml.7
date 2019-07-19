Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351AAC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 05:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121612085A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 05:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfGSFxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 01:53:20 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:40643 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726600AbfGSFxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 01:53:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0TXG4jGq_1563515558;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TXG4jGq_1563515558)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Jul 2019 13:53:16 +0800
Date:   Fri, 19 Jul 2019 13:52:38 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
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
Message-ID: <20190719055238.GA536@aaronlu>
References: <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
 <20190531210816.GA24027@sinkpad>
 <20190606152637.GA5703@sinkpad>
 <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
 <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad>
 <20190718100714.GA469@aaronlu>
 <5f869512-3336-d9f0-6fff-e1150673a924@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f869512-3336-d9f0-6fff-e1150673a924@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 04:27:19PM -0700, Tim Chen wrote:
> 
> 
> On 7/18/19 3:07 AM, Aaron Lu wrote:
> > On Wed, Jun 19, 2019 at 02:33:02PM -0400, Julien Desfossez wrote:
> 
> > 
> > With the below patch on top of v3 that makes use of util_avg to decide
> > which task win, I can do all 8 steps and the final scores of the 2
> > workloads are: 1796191 and 2199586. The score number are not close,
> > suggesting some unfairness, but I can finish the test now...
> 
> Aaron,
> 
> Do you still see high variance in terms of workload throughput that
> was a problem with the previous version?

Any suggestion how to measure this?
It's not clear how Aubrey did his test, will need to take a look at
sysbench.

> >
> >  
> >  }
> > +
> > +bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
> > +{
> > +	struct sched_entity *sea = &a->se;
> > +	struct sched_entity *seb = &b->se;
> > +	bool samecore = task_cpu(a) == task_cpu(b);
> 
> 
> Probably "samecpu" instead of "samecore" will be more accurate.
> I think task_cpu(a) and task_cpu(b)
> can be different, but still belong to the same cpu core.

Right, definitely, guess I'm brain damaged.

> 
> > +	struct task_struct *p;
> > +	s64 delta;
> > +
> > +	if (samecore) {
> > +		/* vruntime is per cfs_rq */
> > +		while (!is_same_group(sea, seb)) {
> > +			int sea_depth = sea->depth;
> > +			int seb_depth = seb->depth;
> > +
> > +			if (sea_depth >= seb_depth)
> 
> Should this be strictly ">" instead of ">=" ?

Same depth doesn't necessarily mean same group while the purpose here is
to make sure they are in the same cfs_rq. When they are of the same
depth but in different cfs_rqs, we will continue to go up till we reach
rq->cfs.

> 
> > +				sea = parent_entity(sea);
> > +			if (sea_depth <= seb_depth)
> 
> Should use "<" ?

Ditto here.
When they are of the same depth but no in the same cfs_rq, both se will
move up.

> > +				seb = parent_entity(seb);
> > +		}
> > +
> > +		delta = (s64)(sea->vruntime - seb->vruntime);
> > +	}
> > +

Thanks.
