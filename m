Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3704CC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1215C206CD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfIKOCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 10:02:22 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:46094 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726626AbfIKOCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 10:02:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Tc4oLSS_1568210525;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0Tc4oLSS_1568210525)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 Sep 2019 22:02:12 +0800
Date:   Wed, 11 Sep 2019 22:02:05 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Dario Faggioli <dfaggioli@suse.com>,
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
Message-ID: <20190911140204.GA52872@aaronlu>
References: <20190619183302.GA6775@sinkpad>
 <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu>
 <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
 <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim & Julien,

On Fri, Sep 06, 2019 at 11:30:20AM -0700, Tim Chen wrote:
> On 8/7/19 10:10 AM, Tim Chen wrote:
> 
> > 3) Load balancing between CPU cores
> > -----------------------------------
> > Say if one CPU core's sibling threads get forced idled
> > a lot as it has mostly incompatible tasks between the siblings,
> > moving the incompatible load to other cores and pulling
> > compatible load to the core could help CPU utilization.
> > 
> > So just considering the load of a task is not enough during
> > load balancing, task compatibility also needs to be considered.
> > Peter has put in mechanisms to balance compatible tasks between
> > CPU thread siblings, but not across cores.
> > 
> > Status:
> > I have not seen patches on this issue.  This issue could lead to
> > large variance in workload performance based on your luck
> > in placing the workload among the cores.
> > 
> 
> I've made an attempt in the following two patches to address
> the load balancing of mismatched load between the siblings.
> 
> It is applied on top of Aaron's patches:
> - sched: Fix incorrect rq tagged as forced idle
> - wrapper for cfs_rq->min_vruntime
>   https://lore.kernel.org/lkml/20190725143127.GB992@aaronlu/
> - core vruntime comparison
>   https://lore.kernel.org/lkml/20190725143248.GC992@aaronlu/

So both of you are working on top of my 2 patches that deal with the
fairness issue, but I had the feeling Tim's alternative patches[1] are
simpler than mine and achieves the same result(after the force idle tag
fix), so unless there is something I missed, I think we should go with
the simpler one?

[1]: https://lore.kernel.org/lkml/b7a83fcb-5c34-9794-5688-55c52697fd84@linux.intel.com/
