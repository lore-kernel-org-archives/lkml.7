Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2194320989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfCYP62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:58:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:14030 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfCYP62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:58:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 08:58:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="125713860"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga007.jf.intel.com with ESMTP; 25 Mar 2019 08:58:27 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 81404301C16; Mon, 25 Mar 2019 08:58:27 -0700 (PDT)
Date:   Mon, 25 Mar 2019 08:58:27 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Like Xu <like.xu@linux.intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, like.xu@intel.com, wei.w.wang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] [PATCH v2 0/5] Intel Virtual PMU Optimization
Message-ID: <20190325155827.GI18020@tassilo.jf.intel.com>
References: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com>
 <20190323172800.GD6058@hirez.programming.kicks-ass.net>
 <28851e9d-5ed4-8ce1-8ff4-9d6c04180388@linux.intel.com>
 <20190325071924.GE6058@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325071924.GE6058@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It isn't going anywhere anyway, its insane. You let perf do all its
> normal things and then discard the results by avoiding the wrmsr.
> 
> Then you fudge a second wrmsr path somewhere.
> 
> Please, just make the existing event dtrt.

I still think the right way is to force an event to a counter
from an internal field. And then set that field from KVM.
This is quite straight forward to do in the event scheduler.

I did it for some experimential PEBS virtualization patches
which require the same because they have to expose the
counter indexes inside the PEBS record to the guest.

-Andi
