Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3813EC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF9A206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfDZKnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:43:33 -0400
Received: from outbound-smtp06.blacknight.com ([81.17.249.39]:51417 "EHLO
        outbound-smtp06.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725966AbfDZKnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:43:33 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp06.blacknight.com (Postfix) with ESMTPS id 545FB98BA5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 10:43:30 +0000 (UTC)
Received: (qmail 20738 invoked from network); 26 Apr 2019 10:43:30 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Apr 2019 10:43:30 -0000
Date:   Fri, 26 Apr 2019 11:43:28 +0100
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
Message-ID: <20190426104328.GA18914@techsingularity.net>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
 <20190425144619.GX18914@techsingularity.net>
 <20190425185343.GA122353@gmail.com>
 <20190425213145.GY18914@techsingularity.net>
 <20190426084222.GC126896@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190426084222.GC126896@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 10:42:22AM +0200, Ingo Molnar wrote:
> > It should, but it's not perfect. For example, wake_affine_idle does not
> > take sibling activity into account even though select_idle_sibling *may*
> > take it into account. Even select_idle_sibling in its fast path may use
> > an SMT sibling instead of searching.
> > 
> > There are also potential side-effects with cpuidle. Some workloads
> > migration around the socket as they are communicating because of how the
> > search for an idle CPU works. With SMT on, there is potentially a longer
> > opportunity for a core to reach a deep c-state and incur a bigger wakeup
> > latency. This is a very weak theory but I've seen cases where latency
> > sensitive workloads with only two communicating tasks are affected by
> > CPUs reaching low c-states due to migrations.
> > 
> > > Clearly it doesn't.
> > > 
> > 
> > It's more that it's best effort to wakeup quickly instead of being perfect
> > by using an expensive search every time.
> 
> Yeah, but your numbers suggest that for *most* not heavily interacting 
> under-utilized CPU bound workloads we hurt in the 5-10% range compared to 
> no-SMT - more in some cases.
> 

Indeed, it was higher than expected and we can't even use the excuse that
more resources are available to a single logical CPU as the scheduler is
meant to keep them apart.

> So we avoid a maybe 0.1% scheduler placement overhead but inflict 5-10% 
> harm on the workload, and also blow up stddev by randomly co-scheduling 
> two tasks on the same physical core? Not a good trade-off.
> 
> I really think we should implement a relatively strict physical core 
> placement policy in the under-utilized case, and resist any attempts to 
> weaken this for special workloads that ping-pong quickly and benefit from 
> sharing the same physical core.
> 

It's worth a shot at least. Changes should mostly be in the wake_affine
path for most loads of interest.

> I.e. as long as load is kept below ~50% the SMT and !SMT benchmark 
> results and stddev numbers should match up. (With a bit of a leewy if the 
> workload gets near to 50% or occasionally goes above it.)
> 
> There's absolutely no excluse for these numbers at 30-40% load levels I 
> think.
> 

Agreed. I'll put it on the todo list but there is no way I'll get to it
in the short term due to LSF/MM. Minimally I'll put some thought into
tooling to track how often siblings are used with some reporting on when a
sibling was used when there was an idle core available. That'll at least
quantify the problem and verify the hypothesis.

-- 
Mel Gorman
SUSE Labs
