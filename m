Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F4BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4430214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfLBTPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:15:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:37189 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbfLBTPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 14:15:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 11:15:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="218430125"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga001.fm.intel.com with ESMTP; 02 Dec 2019 11:15:19 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id BF957300B57; Mon,  2 Dec 2019 11:15:19 -0800 (PST)
Date:   Mon, 2 Dec 2019 11:15:19 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org,
        eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com
Subject: Re: [RFC PATCH 3/8] perf: Init/fini PMU specific data
Message-ID: <20191202191519.GN84886@tassilo.jf.intel.com>
References: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
 <1574954071-6321-3-git-send-email-kan.liang@linux.intel.com>
 <20191202124055.GC2827@hirez.programming.kicks-ass.net>
 <20191202145957.GM84886@tassilo.jf.intel.com>
 <20191202162152.GG2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202162152.GG2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 05:21:52PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 02, 2019 at 06:59:57AM -0800, Andi Kleen wrote:
> > > 
> > > This is atricous crap. Also it is completely broken for -RT.
> > 
> > Well can you please suggest how you would implement it instead?
> 
> I don't think that is on me; at best I get to explain why it is

Normally code review is expected to be constructive.

> completely unacceptible to have O(nr_tasks) and allocations under a
> raw_spinlock_t, but I was thinking you'd already know that.

Ok if that's the only problem then a lock breaker + retry 
if rescheduling is needed + some limit against live lock 
should be sufficient.

-Andi

