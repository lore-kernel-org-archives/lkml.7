Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0DEC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC6E20640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbfIMN6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:58:14 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:47291 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388084AbfIMN6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:58:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0TcEdU0d_1568383072;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TcEdU0d_1568383072)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Sep 2019 21:57:58 +0800
Date:   Fri, 13 Sep 2019 21:57:52 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Dario Faggioli <dfaggioli@suse.com>,
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
Message-ID: <20190913135752.GA81644@aaronlu>
References: <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
 <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
 <20190911140204.GA52872@aaronlu>
 <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
 <20190912120400.GA16200@aaronlu>
 <474e818e-0bae-a715-99e0-7fbaf40590dc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474e818e-0bae-a715-99e0-7fbaf40590dc@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 10:05:43AM -0700, Tim Chen wrote:
> On 9/12/19 5:04 AM, Aaron Lu wrote:
> 
> > Well, I have done following tests:
> > 1 Julien's test script: https://paste.debian.net/plainh/834cf45c
> > 2 start two tagged will-it-scale/page_fault1, see how each performs;
> > 3 Aubrey's mysql test: https://github.com/aubreyli/coresched_bench.git
> > 
> > They all show your patchset performs equally well...And consider what
> > the patch does, I think they are really doing the same thing in
> > different ways.
> > 
> 
> Aaron,
> 
> The new feature of my new patches attempt to load balance between cores,
> and remove imbalance of cgroup load on a core that causes forced idle.
> Whereas previous patches attempt for fairness of cgroup between sibling threads,
> so I think the goals are kind of orthogonal and complementary.
> 
> The premise is this, say cgroup1 is occupying 50% of cpu on cpu thread 1
> and 25% of cpu on cpu thread 2, that means we have a 25% cpu imbalance
> and cpu is force idled 25% of the time.  So ideally we need to remove
> 12.5% of cgroup 1 load from cpu thread 1 to sibling thread 2, so they
> both run at 37.5% on both thread for cgroup1 load without causing
> any force idled time.  Otherwise we will try to remove 25% of cgroup1
> load from cpu thread 1 to another core that has cgroup1 load to match.
> 
> This load balance is done in the regular load balance paths.
> 
> Previously for v3, only sched_core_balance made an attempt to pull a cookie task, and only
> in the idle balance path. So if the cpu is kept busy, the cgroup load imbalance
> between sibling threads could last a long time.  And the thread fairness
> patches for v3 don't help to balance load for such cases.
> 
> The new patches take into actual consideration of the amount of load imbalance
> of the same group between sibling threads when selecting task to pull, 
> and it also prevent task migration that creates
> more load imbalance. So hopefully this feature will help when we have
> more cores and need load balance across the cores.  This tries to help
> even cgroup workload between threads to minimize forced idle time, and also
> even out load across cores.

Will take a look at your new patches, thanks for the explanation.

> In your test, how many cores are on your machine and how many threads did
> each page_fault1 spawn off?

The test VM has 16 cores and 32 threads.
I created 2 tagged cgroups to run page_fault1 and each page_fault1 has
16 processes, like this:
$ ./src/will-it-scale/page_fault1_processes -t 16 -s 60
