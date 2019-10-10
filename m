Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7AAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981002067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfJJNyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:54:47 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:50842 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbfJJNyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:54:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Teee2Gx_1570715676;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0Teee2Gx_1570715676)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Oct 2019 21:54:42 +0800
Date:   Thu, 10 Oct 2019 21:54:36 +0800
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
Message-ID: <20191010135436.GA67897@aaronlu>
References: <20190802153715.GA18075@sinkpad>
 <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
 <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
 <20190911140204.GA52872@aaronlu>
 <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
 <CANaguZCH-jjHrWwycU3vz6RfNkW9xN+DoRkHnL3n8-DneNV3FQ@mail.gmail.com>
 <20190912123532.GB16200@aaronlu>
 <CANaguZBTiLQiRQU9MJR2Qys8S2S=-PTe66_ZPi5DVzpPbJ93zw@mail.gmail.com>
 <CANaguZDOb+rVcDPMS+SR1DKc73fnctkBK0EbfBrf90dztr8t=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZDOb+rVcDPMS+SR1DKc73fnctkBK0EbfBrf90dztr8t=Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 04:48:14PM -0400, Vineeth Remanan Pillai wrote:
> On Mon, Sep 30, 2019 at 7:53 AM Vineeth Remanan Pillai
> <vpillai@digitalocean.com> wrote:
> >
> > >
> > Sorry, I misunderstood the fix and I did not initially see the core wide
> > min_vruntime that you tried to maintain in the rq->core. This approach
> > seems reasonable. I think we can fix the potential starvation that you
> > mentioned in the comment by adjusting for the difference in all the children
> > cfs_rq when we set the minvruntime in rq->core. Since we take the lock for
> > both the queues, it should be doable and I am trying to see how we can best
> > do that.
> >
> Attaching here with, the 2 patches I was working on in preparation of v4.
> 
> Patch 1 is an improvement of patch 2 of Aaron where I am propagating the
> vruntime changes to the whole tree.

I didn't see why we need do this.

We only need to have the root level sched entities' vruntime become core
wide since we will compare vruntime for them across hyperthreads. For
sched entities on sub cfs_rqs, we never(at least, not now) compare their
vruntime outside their cfs_rqs.

Thanks,
Aaron

> Patch 2 is an improvement for patch 3 of Aaron where we do resched_curr
> only when the sibling is forced idle.
