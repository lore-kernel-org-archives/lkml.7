Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A74C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D412077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfDZTt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:49:27 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:34307 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726458AbfDZTt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:49:26 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id C008E98B05
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 19:49:23 +0000 (UTC)
Received: (qmail 13679 invoked from network); 26 Apr 2019 19:49:23 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Apr 2019 19:49:23 -0000
Date:   Fri, 26 Apr 2019 20:49:22 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Fr?d?ric Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190426194921.GB18914@techsingularity.net>
References: <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
 <20190425144619.GX18914@techsingularity.net>
 <20190425185343.GA122353@gmail.com>
 <20190425213145.GY18914@techsingularity.net>
 <20190426084222.GC126896@gmail.com>
 <20190426104328.GA18914@techsingularity.net>
 <fbed0636-8e1f-ff3c-ef45-079497c844bb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <fbed0636-8e1f-ff3c-ef45-079497c844bb@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:37:11AM -0700, Subhra Mazumdar wrote:
> > > So we avoid a maybe 0.1% scheduler placement overhead but inflict 5-10%
> > > harm on the workload, and also blow up stddev by randomly co-scheduling
> > > two tasks on the same physical core? Not a good trade-off.
> > > 
> > > I really think we should implement a relatively strict physical core
> > > placement policy in the under-utilized case, and resist any attempts to
> > > weaken this for special workloads that ping-pong quickly and benefit from
> > > sharing the same physical core.
> > > 
> > It's worth a shot at least. Changes should mostly be in the wake_affine
> > path for most loads of interest.
>
> Doesn't select_idle_sibling already try to do that by calling
> select_idle_core? For our OLTP workload we infact found the cost of
> select_idle_core was actually hurting more than it helped to find a fully
> idle core, so a net negative.
> 

select_idle_sibling is not guarnateed to call select_idle_core or avoid
selecting HT sibling whose other sibling is !idle but yes, in that path,
the search cost is a general concern which is why any change there is
tricky at best.

-- 
Mel Gorman
SUSE Labs
