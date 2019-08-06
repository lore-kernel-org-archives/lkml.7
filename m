Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28E0C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C97208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbfHFNuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:50:16 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:47657 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbfHFNuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:50:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0TYpJ7Gd_1565099397;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TYpJ7Gd_1565099397)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 06 Aug 2019 21:50:02 +0800
Date:   Tue, 6 Aug 2019 21:49:57 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
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
Message-ID: <20190806134949.GA46757@aaronlu>
References: <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu>
 <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <f4778816-69e5-146c-2a30-ec42e7f1677f@linux.intel.com>
 <20190806032418.GA54717@aaronlu>
 <CAERHkrtJ3f1ggfG7Qo-KnznGo66p0Y3E0sAfb3ki6U=ADT6__g@mail.gmail.com>
 <54fa27ff-69a7-b2ac-6152-6915f78a57f9@linux.alibaba.com>
 <CANaguZDPdUp3Nb7hYjEiTpJTMVrKJyw2JDKP5EEphMjV-PAYpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZDPdUp3Nb7hYjEiTpJTMVrKJyw2JDKP5EEphMjV-PAYpA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 08:24:17AM -0400, Vineeth Remanan Pillai wrote:
> > >
> > > I also think a way to make fairness per cookie per core, is this what you
> > > want to propose?
> >
> > Yes, that's what I meant.
> 
> I think that would hurt some kind of workloads badly, especially if
> one tenant is
> having way more tasks than the other. Tenant with more task on the same core
> might have immediate requirements from some threads than the other and we
> would fail to take that into account. With some hierarchical management, we can
> alleviate this, but as Aaron said, it would be a bit messy.

I think tenant will have per core weight, similar to sched entity's per
cpu weight. The tenant's per core weight could derive from its
corresponding taskgroup's per cpu sched entities' weight(sum them up
perhaps). Tenant with higher weight will have its core wide vruntime
advance slower than tenant with lower weight. Does this address the
issue here?

> Peter's rebalance logic actually takes care of most of the runq
> imbalance caused
> due to cookie tagging. What we have found from our testing is, fairness issue is
> caused mostly due to a Hyperthread going idle and not waking up. Aaron's 3rd
> patch works around that. As Julien mentioned, we are working on a per thread
> coresched idle thread concept. The problem that we found was, idle thread causes
> accounting issues and wakeup issues as it was not designed to be used in this
> context. So if we can have a low priority thread which looks like any other task
> to the scheduler, things becomes easy for the scheduler and we achieve security
> as well. Please share your thoughts on this idea.

Care to elaborate the idea of coresched idle thread concept?
How it solved the hyperthread going idle problem and what the accounting
issues and wakeup issues are, etc.

Thanks,
Aaron

> The results are encouraging, but we do not yet have the coresched idle
> to not spin
> 100%. We will soon post the patch once it is a bit more stable for
> running the tests
> that we all have done so far.
> 
> Thanks,
> Vineeth
