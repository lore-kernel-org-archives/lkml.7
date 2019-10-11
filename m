Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E41FC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58368214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfJKMCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:02:10 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:58957 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727198AbfJKMCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:02:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0TejlPIB_1570795316;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TejlPIB_1570795316)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Oct 2019 20:02:02 +0800
Date:   Fri, 11 Oct 2019 20:01:56 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
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
Message-ID: <20191011114851.GA8750@aaronlu>
References: <20190911140204.GA52872@aaronlu>
 <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
 <CANaguZCH-jjHrWwycU3vz6RfNkW9xN+DoRkHnL3n8-DneNV3FQ@mail.gmail.com>
 <20190912123532.GB16200@aaronlu>
 <CANaguZBTiLQiRQU9MJR2Qys8S2S=-PTe66_ZPi5DVzpPbJ93zw@mail.gmail.com>
 <CANaguZDOb+rVcDPMS+SR1DKc73fnctkBK0EbfBrf90dztr8t=Q@mail.gmail.com>
 <20191010135436.GA67897@aaronlu>
 <CANaguZDCtmXpm_rpTkjsfPPBscHCwz4u1OHwUt3XztzgLJa_jA@mail.gmail.com>
 <20191011073338.GA125778@aaronlu>
 <CANaguZCkKQTmgye+9nQhzQqYBrsnCmcjA46TPmLwN60vvMQ_7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZCkKQTmgye+9nQhzQqYBrsnCmcjA46TPmLwN60vvMQ_7w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 07:32:48AM -0400, Vineeth Remanan Pillai wrote:
> > > The reason we need to do this is because, new tasks that gets created will
> > > have a vruntime based on the new min_vruntime and old tasks will have it
> > > based on the old min_vruntime
> >
> > I think this is expected behaviour.
> >
> I don't think this is the expected behavior. If we hadn't changed the root
> cfs->min_vruntime for the core rq, then it would have been the expected
> behaviour. But now, we are updating the core rq's root cfs, min_vruntime
> without changing the the vruntime down to the tree. To explain, consider
> this example based on your patch. Let cpu 1 and 2 be siblings. And let rq(cpu1)
> be the core rq. Let rq1->cfs->min_vruntime=1000 and rq2->cfs->min_vruntime=2000.
> So in update_core_cfs_rq_min_vruntime, you update rq1->cfs->min_vruntime
> to 2000 because that is the max. So new tasks enqueued on rq1 starts with
> vruntime of 2000 while the tasks in that runqueue are still based on the old
> min_vruntime(1000). So the new tasks gets enqueued some where to the right
> of the tree and has to wait until already existing tasks catch up the
> vruntime to
> 2000. This is what I meant by starvation. This happens always when we update
> the core rq's cfs->min_vruntime. Hope this clarifies.

Thanks for the clarification.

Yes, this is the initialization issue I mentioned before when core
scheduling is initially enabled. rq1's vruntime is bumped the first time
update_core_cfs_rq_min_vruntime() is called and if there are already
some tasks queued, new tasks queued on rq1 will be starved to some extent.

Agree that this needs fix. But we shouldn't need do this afterwards.

So do I understand correctly that patch1 is meant to solve the
initialization issue?
