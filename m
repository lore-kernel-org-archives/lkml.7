Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ED2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 23:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C494021741
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 23:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfCWXPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 19:15:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:40643 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbfCWXPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 19:15:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Mar 2019 16:15:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="309864568"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2019 16:15:43 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 672693015F7; Sat, 23 Mar 2019 16:15:43 -0700 (PDT)
Date:   Sat, 23 Mar 2019 16:15:43 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Like Xu <like.xu@linux.intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, like.xu@intel.com, wei.w.wang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] [PATCH v2 0/5] Intel Virtual PMU Optimization
Message-ID: <20190323231543.GE18020@tassilo.jf.intel.com>
References: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com>
 <20190323172800.GD6058@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323172800.GD6058@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > We optimize the current vPMU to work in this manner:
> > 
> > (1) rely on the existing host perf (perf_event_create_kernel_counter)
> >     to allocate counters for in-use vPMC and always try to reuse events;
> > (2) vPMU captures guest accesses to the eventsel and fixctrl msr directly
> >     to the hardware msr that the corresponding host event is scheduled on
> >     and avoid pollution from host is also needed in its partial runtime;
> 
> If you do pass-through; how do you deal with event constraints?

The guest has to deal with them. It already needs to know
the model number to program the right events, can as well know
the constraints too.

For architectural events that don't need the model number it's
not a problem because they don't have constraints.

-Andi
