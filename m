Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CE7C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121DE2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfDZKTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:19:51 -0400
Received: from outbound-smtp24.blacknight.com ([81.17.249.192]:53301 "EHLO
        outbound-smtp24.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbfDZKTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:19:51 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id EE94FB8918
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 11:19:48 +0100 (IST)
Received: (qmail 10966 invoked from network); 26 Apr 2019 10:19:48 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Apr 2019 10:19:48 -0000
Date:   Fri, 26 Apr 2019 11:19:47 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Fr?d?ric Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190426101947.GZ18914@techsingularity.net>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
 <20190425144619.GX18914@techsingularity.net>
 <20190425185343.GA122353@gmail.com>
 <20190425213145.GY18914@techsingularity.net>
 <20190426094545.GD126896@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190426094545.GD126896@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:45:45AM +0200, Ingo Molnar wrote:
> 
> * Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > > > I can show a comparison with equal levels of parallelisation but with 
> > > > HT off, it is a completely broken configuration and I do not think a 
> > > > comparison like that makes any sense.
> > > 
> > > I would still be interested in that comparison, because I'd like
> > > to learn whether there's any true *inherent* performance advantage to 
> > > HyperThreading for that particular workload, for exactly tuned 
> > > parallelism.
> > > 
> > 
> > It really isn't a fair comparison. MPI seems to behave very differently
> > when a machine is saturated. It's documented as changing its behaviour
> > as it tries to avoid the worst consequences of saturation.
> > 
> > Curiously, the results on the 2-socket machine were not as bad as I
> > feared when the HT configuration is running with twice the number of
> > threads as there are CPUs
> > 
> > Amean     bt      771.15 (   0.00%)     1086.74 * -40.93%*
> > Amean     cg      445.92 (   0.00%)      543.41 * -21.86%*
> > Amean     ep       70.01 (   0.00%)       96.29 * -37.53%*
> > Amean     is       16.75 (   0.00%)       21.19 * -26.51%*
> > Amean     lu      882.84 (   0.00%)      595.14 *  32.59%*
> > Amean     mg       84.10 (   0.00%)       80.02 *   4.84%*
> > Amean     sp     1353.88 (   0.00%)     1384.10 *  -2.23%*
> 
> Yeah, so what I wanted to suggest is a parallel numeric throughput test 
> with few inter-process data dependencies, and see whether HT actually 
> improves total throughput versus the no-HT case.
> 
> No over-saturation - but exactly as many threads as logical CPUs.
> 
> I.e. with 20 physical cores and 40 logical CPUs the numbers to compare 
> would be a 'nosmt' benchmark running 20 threads, versus a SMT test 
> running 40 threads.
> 
> I.e. how much does SMT improve total throughput when the workload's 
> parallelism is tuned to utilize 100% of the available CPUs?
> 
> Does this make sense?
> 

Yes. Here is the comparison.

Amean     bt      678.75 (   0.00%)      789.13 * -16.26%*
Amean     cg      261.22 (   0.00%)      428.82 * -64.16%*
Amean     ep       55.36 (   0.00%)       84.41 * -52.48%*
Amean     is       13.25 (   0.00%)       17.82 * -34.47%*
Amean     lu     1065.08 (   0.00%)     1090.44 (  -2.38%)
Amean     mg       89.96 (   0.00%)       84.28 *   6.31%*
Amean     sp     1579.52 (   0.00%)     1506.16 *   4.64%*
Amean     ua      611.87 (   0.00%)      663.26 *  -8.40%*

This is the socket machine and with HT On, there are 80 logical CPUs
versus HT Off with 40 logical CPUs.

-- 
Mel Gorman
SUSE Labs
