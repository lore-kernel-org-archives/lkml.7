Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A79C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C2B23404
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfH1TEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 15:04:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:21441 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfH1TEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:04:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 12:04:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="171645852"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga007.jf.intel.com with ESMTP; 28 Aug 2019 12:04:46 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0A3CD300FC7; Wed, 28 Aug 2019 12:04:46 -0700 (PDT)
Date:   Wed, 28 Aug 2019 12:04:45 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown
 metrics
Message-ID: <20190828190445.GQ5447@tassilo.jf.intel.com>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com>
 <20190828150238.GC17205@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828150238.GC17205@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 05:02:38PM +0200, Peter Zijlstra wrote:
> > 
> > To avoid reading the METRICS register multiple times, the metrics and
> > slots value can only be updated by the first slots/metrics event in a
> > group. All active slots and metrics events will be updated one time.
> 
> Can't we require SLOTS to be the group leader for any Metric group?

Metrics are really useful to collect with any other sampling event
to give you more context in the program behavior.

> Is there ever a case where we want to add other events to a metric
> group?

Yes. Any normal leader sampling case. You just collect metrics too.

> it also musn't be too cold. But that leaves it unspecified what exactly
> is the right range.
> 
> IOW, you want a Goldilocks number of SLOTS.

That's too strong. You probably don't want minutes, but seconds
worth of measurement should be ok.

> > NMI
> > ======
> > 
> > The METRICS register may be overflow. The bit 48 of STATUS register
> > will be set. If so, update all active slots and metrics events.
> 
> that happen? It would be useful to get that METRIC_OVF (can we please

This happens when the internal counters that feed the metrics
overflow.

> If this is so; then we can use this to update/reset PERF_METRICS and
> nothing else.

It has to be handled in the PMI.

> Then there is no mucking about with that odd counter/metrics msr pair
> reset nonsense. Becuase that really stinks.

You have to write them to reset the internal counters.

-Andi

