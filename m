Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D1DC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E2E2652B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfEaHpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:45:09 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:48847 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726331AbfEaHpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:45:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0TT3sHiW_1559288697;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TT3sHiW_1559288697)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 31 May 2019 15:45:04 +0800
Date:   Fri, 31 May 2019 15:44:57 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190531074456.GA314@aaronlu>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
 <CAERHkruVthrTgGqiH=yhCspZWpMDAu0G4rNcrDTKQzgPq9eqQQ@mail.gmail.com>
 <21fda627-1d3c-12cc-6389-8c226218e2ce@linux.alibaba.com>
 <CAERHkrsjTNUssmECksdJnLdDjVJ_9UpvYiHyBDJ3S1toURCbrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkrsjTNUssmECksdJnLdDjVJ_9UpvYiHyBDJ3S1toURCbrw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 02:53:21PM +0800, Aubrey Li wrote:
> On Fri, May 31, 2019 at 2:09 PM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
> >
> > On 2019/5/31 13:12, Aubrey Li wrote:
> > > On Fri, May 31, 2019 at 11:01 AM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
> > >>
> > >> This feels like "date" failed to schedule on some CPU
> > >> on time.
> > >>
> > >> My first reaction is: when shell wakes up from sleep, it will
> > >> fork date. If the script is untagged and those workloads are
> > >> tagged and all available cores are already running workload
> > >> threads, the forked date can lose to the running workload
> > >> threads due to __prio_less() can't properly do vruntime comparison
> > >> for tasks on different CPUs. So those idle siblings can't run
> > >> date and are idled instead. See my previous post on this:
> > >> https://lore.kernel.org/lkml/20190429033620.GA128241@aaronlu/
> > >> (Now that I re-read my post, I see that I didn't make it clear
> > >> that se_bash and se_hog are assigned different tags(e.g. hog is
> > >> tagged and bash is untagged).
> > >
> > > Yes, script is untagged. This looks like exactly the problem in you
> > > previous post. I didn't follow that, does that discussion lead to a solution?
> >
> > No immediate solution yet.
> >
> > >>
> > >> Siblings being forced idle is expected due to the nature of core
> > >> scheduling, but when two tasks belonging to two siblings are
> > >> fighting for schedule, we should let the higher priority one win.
> > >>
> > >> It used to work on v2 is probably due to we mistakenly
> > >> allow different tagged tasks to schedule on the same core at
> > >> the same time, but that is fixed in v3.
> > >
> > > I have 64 threads running on a 104-CPU server, that is, when the
> >
> > 104-CPU means 52 cores I guess.
> > 64 threads may(should?) spread on all the 52 cores and that is enough
> > to make 'date' suffer.
> 
> 64 threads should spread onto all the 52 cores, but why they can get
> scheduled while untagged "date" can not? Is it because in the current

If 'date' didn't get scheduled, there will be no output at all unless
all those workload threads finished :-)

I guess the workload you used is not entirely CPU intensive, or 'date'
can be totally blocked due to START_DEBIT. But note that START_DEBIT
isn't the problem here, cross CPU vruntime comparison is.

> implementation the task with cookie always has higher priority than the
> task without a cookie?

No.
