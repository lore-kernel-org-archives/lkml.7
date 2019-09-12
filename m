Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258F0C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024EF20830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbfILMgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 08:36:36 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:53382 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731283AbfILMgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 08:36:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Tc9p5so_1568291732;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0Tc9p5so_1568291732)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Sep 2019 20:35:34 +0800
Date:   Thu, 12 Sep 2019 20:35:32 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
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
Message-ID: <20190912123532.GB16200@aaronlu>
References: <20190725143003.GA992@aaronlu>
 <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
 <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
 <20190911140204.GA52872@aaronlu>
 <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
 <CANaguZCH-jjHrWwycU3vz6RfNkW9xN+DoRkHnL3n8-DneNV3FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZCH-jjHrWwycU3vz6RfNkW9xN+DoRkHnL3n8-DneNV3FQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 12:47:34PM -0400, Vineeth Remanan Pillai wrote:
> > > So both of you are working on top of my 2 patches that deal with the
> > > fairness issue, but I had the feeling Tim's alternative patches[1] are
> > > simpler than mine and achieves the same result(after the force idle tag
> >
> > I think Julien's result show that my patches did not do as well as
> > your patches for fairness. Aubrey did some other testing with the same
> > conclusion.  So I think keeping the forced idle time balanced is not
> > enough for maintaining fairness.
> >
> There are two main issues - vruntime comparison issue and the
> forced idle issue.  coresched_idle thread patch is addressing
> the forced idle issue as scheduler is no longer overloading idle
> thread for forcing idle. If I understand correctly, Tim's patch
> also tries to fix the forced idle issue. On top of fixing forced

Er...I don't think so. Tim's patch is meant to solve fairness issue as
mine, it doesn't attempt to address the forced idle issue.

> idle issue, we also need to fix that vruntime comparison issue
> and I think thats where Aaron's patch helps.
> 
> I think comparing parent's runtime also will have issues once
> the task group has a lot more threads with different running
> patterns. One example is a task group with lot of active threads
> and a thread with fairly less activity. So when this less active
> thread is competing with a thread in another group, there is a
> chance that it loses continuously for a while until the other
> group catches up on its vruntime.

I actually think this is expected behaviour.

Without core scheduling, when deciding which task to run, we will first
decide which "se" to run from the CPU's root level cfs runqueue and then
go downwards. Let's call the chosen se on the root level cfs runqueue
the winner se. Then with core scheduling, we will also need compare the
two winner "se"s of each hyperthread and choose the core wide winner "se".

> 
> As discussed during LPC, probably start thinking along the lines
> of global vruntime or core wide vruntime to fix the vruntime
> comparison issue?

core wide vruntime makes sense when there are multiple tasks of
different cgroups queued on the same core. e.g. when there are two
tasks of cgroupA and one task of cgroupB are queued on the same core,
assume cgroupA's one task is on one hyperthread and its other task is on
the other hyperthread with cgroupB's task. With my current
implementation or Tim's, cgroupA will get more time than cgroupB. If we
maintain core wide vruntime for cgroupA and cgroupB, we should be able
to maintain fairness between cgroups on this core. Tim propose to solve
this problem by doing some kind of load balancing if I'm not mistaken, I
haven't taken a look at this yet.
