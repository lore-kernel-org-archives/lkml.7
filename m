Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CC5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE212070B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfH2DLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 23:11:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:1407 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfH2DLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 23:11:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 20:11:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="182212723"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga007.fm.intel.com with ESMTP; 28 Aug 2019 20:11:52 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id DE41C301004; Wed, 28 Aug 2019 20:11:51 -0700 (PDT)
Date:   Wed, 28 Aug 2019 20:11:51 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown
 metrics
Message-ID: <20190829031151.GR5447@tassilo.jf.intel.com>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com>
 <20190828151921.GD17205@worktop.programming.kicks-ass.net>
 <20190828161754.GP5447@tassilo.jf.intel.com>
 <20190828162857.GO2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828162857.GO2332@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 06:28:57PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 28, 2019 at 09:17:54AM -0700, Andi Kleen wrote:
> > > This really doesn't make sense to me; if you set FIXED_CTR3 := 0, you'll
> > > never trigger the overflow there; this then seems to suggest the actual
> > 
> > The 48bit counter might overflow in a few hours.
> 
> Sure; the point is? Kan said it should not be too big; a full 48bit wrap
> around must be too big or nothing is.

We expect users to avoid making it too big, but we cannot rule it out.

Actually for the common perf stat for a long time case you can make it fairly
big because the percentages still work out over the complete run time.

The problem with letting it accumulate too much is mainly if you
want to use a continuously running metrics counter to time smaller
regions by taking deltas, for example using RDPMC. 

In this case the small regions would be too inaccurate after some time.

But to make the first case work absolutely need to handle the overflow
case. Otherwise the metrics would just randomly stop at some
point.


-Andi



