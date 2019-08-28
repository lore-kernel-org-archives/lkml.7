Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20816C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DB12077B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ur+Y+HO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfH1Pbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:31:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfH1Pbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+4RbtbadPeHDqkWHNeTqtGn6hIPGJnVJdxnnaB9xmZY=; b=Ur+Y+HO3NeJVf0WUmN6alVkTx
        awzvqkfhHx5NAj5o8PhCN5egCiVC8tGf1oKNzZllH2zKiEblJfdcLnzIb8Gq1vp3W7YwhHXCLdoS7
        t9Bi0ixv2Wt7HqOHvsyth5hW4a5caGSJEMu7PZu2uz+yW2NzHJKutwUYlBw645CYxKOLlLMmgz9tx
        cO90OCokv2HuW8FkcbyWcD9tukBL4IoFwCwXzdJje1hePXpM2iTpos2Jv52GuvBus7A1HCGb2IaUp
        48Ib0wN32leS3ObbNfrAg+l8FfaYttqVwHFDbgIJEe/W9dIB3XSgwNVypUCFo41JMzxxQJJBDqhvy
        XvuOsPMxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2zv2-0007RL-HW; Wed, 28 Aug 2019 15:31:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9BA7C98040A; Wed, 28 Aug 2019 17:02:38 +0200 (CEST)
Date:   Wed, 28 Aug 2019 17:02:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown
 metrics
Message-ID: <20190828150238.GC17205@worktop.programming.kicks-ass.net>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826144740.10163-4-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 07:47:35AM -0700, kan.liang@linux.intel.com wrote:

> Groups
> ======
> 
> To avoid reading the METRICS register multiple times, the metrics and
> slots value can only be updated by the first slots/metrics event in a
> group. All active slots and metrics events will be updated one time.

Can't we require SLOTS to be the group leader for any Metric group?

Is there ever a case where we want to add other events to a metric
group?

> Reset
> ======
> 
> The PERF_METRICS and Fixed counter 3 have to be reset for each read,
> because:
> - The 8bit metrics ratio values lose precision when the measurement
>   period gets longer.

So it musn't be too hot,

> - The PERF_METRICS may report wrong value if its delta was less than
>   1/255 of SLOTS (Fixed counter 3).

it also musn't be too cold. But that leaves it unspecified what exactly
is the right range.

IOW, you want a Goldilocks number of SLOTS.

> Also, for counting, the -max_period is the initial value of the SLOTS.
> The huge initial value will definitely trigger the issue mentioned
> above. Force initial value as 0 for topdown and slots event counting.

But you just told us that 0 is wrong too (too cold).

I'm still confused by all this; when exactly does:

> NMI
> ======
> 
> The METRICS register may be overflow. The bit 48 of STATUS register
> will be set. If so, update all active slots and metrics events.

that happen? It would be useful to get that METRIC_OVF (can we please
start naming them; 62,55,48 is past silly) at the exact point
where PERF_METRICS is saturated.

If this is so; then we can use this to update/reset PERF_METRICS and
nothing else.

That is; leave the SLOTS programming alone; use -max_period as usual.

Then on METRIC_OVF, read PERF_METRICS and clear it, and update all the
metric events by adding slots_delta * frac / 256 -- where slots_delta is
the SLOTS count since the last METRIC_OVF.

On read; read PERF_METRICS -- BUT DO NOT RESET -- and compute an
intermediate delta and add that to whatever stable count we had.

Maybe something like:

	do {
		count1 = local64_read(&event->count);
		barrier();
		metrics = read_perf_metrics();
		barrier();
		count2 = local64_read(event->count);
	} while (count1 != count2);

	/* no METRIC_OVF happened and {count,metrics} is consistent */

	return count1 + (slots_delta * frac / 256);

> The update_topdown_event() has to read two registers separately. The
> values may be modify by a NMI. PMU has to be disabled before calling the
> function.

Then there is no mucking about with that odd counter/metrics msr pair
reset nonsense. Becuase that really stinks.
