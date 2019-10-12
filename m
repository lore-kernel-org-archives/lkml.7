Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9448C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 03:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990962089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 03:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfJLDzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 23:55:15 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:49751 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbfJLDzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 23:55:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0TenDtwe_1570852503;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TenDtwe_1570852503)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 12 Oct 2019 11:55:09 +0800
Date:   Sat, 12 Oct 2019 11:55:03 +0800
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
Message-ID: <20191012035503.GA113034@aaronlu>
References: <CANaguZCH-jjHrWwycU3vz6RfNkW9xN+DoRkHnL3n8-DneNV3FQ@mail.gmail.com>
 <20190912123532.GB16200@aaronlu>
 <CANaguZBTiLQiRQU9MJR2Qys8S2S=-PTe66_ZPi5DVzpPbJ93zw@mail.gmail.com>
 <CANaguZDOb+rVcDPMS+SR1DKc73fnctkBK0EbfBrf90dztr8t=Q@mail.gmail.com>
 <20191010135436.GA67897@aaronlu>
 <CANaguZDCtmXpm_rpTkjsfPPBscHCwz4u1OHwUt3XztzgLJa_jA@mail.gmail.com>
 <20191011073338.GA125778@aaronlu>
 <CANaguZCkKQTmgye+9nQhzQqYBrsnCmcjA46TPmLwN60vvMQ_7w@mail.gmail.com>
 <20191011114851.GA8750@aaronlu>
 <CANaguZBgv5N2Spv-Ldio5Umn6qU7dC0Px66sL9s11W7SK3f4Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZBgv5N2Spv-Ldio5Umn6qU7dC0Px66sL9s11W7SK3f4Hg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 08:10:30AM -0400, Vineeth Remanan Pillai wrote:
> > Thanks for the clarification.
> >
> > Yes, this is the initialization issue I mentioned before when core
> > scheduling is initially enabled. rq1's vruntime is bumped the first time
> > update_core_cfs_rq_min_vruntime() is called and if there are already
> > some tasks queued, new tasks queued on rq1 will be starved to some extent.
> >
> > Agree that this needs fix. But we shouldn't need do this afterwards.
> >
> > So do I understand correctly that patch1 is meant to solve the
> > initialization issue?
> 
> I think we need this update logic even after initialization. I mean, core
> runqueue's min_vruntime can get updated every time when the core
> runqueue's min_vruntime changes with respect to the sibling's min_vruntime.
> So, whenever this update happens, we would need to propagate the changes
> down the tree right? Please let me know if I am visualizing it wrong.

I don't think we need do the normalization afterwrads and it appears
we are on the same page regarding core wide vruntime.

The intent of my patch is to treat all the root level sched entities of
the two siblings as if they are in a single cfs_rq of the core. With a
core wide min_vruntime, the core scheduler can decide which sched entity
to run next. And the individual sched entity's vruntime shouldn't be
changed based on the change of core wide min_vruntime, or faireness can
hurt(if we add or reduce vruntime of a sched entity, its credit will
change).

The weird thing about my patch is, the min_vruntime is often increased,
it doesn't point to the smallest value as in a traditional cfs_rq. This
probabaly can be changed to follow the tradition, I don't quite remember
why I did this, will need to check this some time later.

All those sub cfs_rq's sched entities are not interesting. Because once
we decided which sched entity in the root level cfs_rq should run next,
we can then pick the final next task from there(using the usual way). In
other words, to make scheduler choose the correct candidate for the core,
we only need worry about sched entities on both CPU's root level cfs_rqs.

Does this make sense?
