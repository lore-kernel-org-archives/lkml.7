Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B820C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FC220815
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZTXFjHN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbfI3Oxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:53:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54934 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731190AbfI3Oxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mnC3RWrcGpJf9PV0SZrHbzybPrsZM4YAcvJLhRdeBOE=; b=ZTXFjHN2WU1sTnHb3aZxlGKhF
        axWZPHOXlMW2AEbUO87REhmZA/lfF0odFEpKSTCdM+VJepiekJQXVhFhnq14/P3xe6GbFCAl0EgkI
        aLWH1fs13cVNmPykcrk4AE18jL7V4QvR2tt/066Ao6a0Vgchm4pNZDMuNmwZkS2IKY72XQ+n/wjjj
        lpnCDSB/uUOcjlHezjarr+2dLtUL6326yCGuX+nU1ncY6csPATCt4bCLmfwZGEVufuZn3IkYeOnjF
        xH84AhN2y87o8IrHdxS5kf2b+FiCpdfaf9ncaEZMffxSuLLj2lXBWB3K8b7qRHwsFXiUwlMe56zzs
        q5PLecqNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEx3C-0004a2-Tg; Mon, 30 Sep 2019 14:53:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9727D3056B6;
        Mon, 30 Sep 2019 16:52:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 938C225D6479E; Mon, 30 Sep 2019 16:53:21 +0200 (CEST)
Date:   Mon, 30 Sep 2019 16:53:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V4 07/14] perf/x86/intel: Support hardware TopDown metrics
Message-ID: <20190930145321.GF4581@hirez.programming.kicks-ass.net>
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
 <20190916134128.18120-8-kan.liang@linux.intel.com>
 <20190930130615.GN4553@hirez.programming.kicks-ass.net>
 <20190930140755.GE4581@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930140755.GE4581@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 04:07:55PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 30, 2019 at 03:06:15PM +0200, Peter Zijlstra wrote:
> > On Mon, Sep 16, 2019 at 06:41:21AM -0700, kan.liang@linux.intel.com wrote:
> 
> > > +static bool is_first_topdown_event_in_group(struct perf_event *event)
> > > +{
> > > +	struct perf_event *first = NULL;
> > > +
> > > +	if (is_topdown_event(event->group_leader))
> > > +		first = event->group_leader;
> > > +	else {
> > > +		for_each_sibling_event(first, event->group_leader)
> > > +			if (is_topdown_event(first))
> > > +				break;
> > > +	}
> > > +
> > > +	if (event == first)
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> > 
> > > +static u64 icl_update_topdown_event(struct perf_event *event)
> > > +{
> > > +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > > +	struct perf_event *other;
> > > +	u64 slots, metrics;
> > > +	int idx;
> > > +
> > > +	/*
> > > +	 * Only need to update all events for the first
> > > +	 * slots/metrics event in a group
> > > +	 */
> > > +	if (event && !is_first_topdown_event_in_group(event))
> > > +		return 0;
> > 
> > This is pretty crap and approaches O(n^2); let me think if there's
> > anything saner to do here.
> 
> This is also really complicated in the case where we do
> perf_remove_from_context() in the 'wrong' order.
> 
> In that case we get detached events that are not up-to-date (and never
> will be). It doesn't look like that matters, but it is weird.

So we either get called from the PMI, or read(). In the PMI there is the
perf_output_read_group() path, and that too appears broken vs the above,
it assumes perf_event_count() is up-to-date after calling pmu->read(),
which isn't true.

Now, I'm thinking that is already broken vs TXN_READ, so we should fix
that a little something like the below (needs to be tested on
Power-hv-24x7).

---
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6272,10 +6272,22 @@ static void perf_output_read_group(struc
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		values[n++] = running;
 
+	if (leader->nr_siblings > 1)
+		leader->pmu->start_txn(pmu, PERF_PMU_TXN_READ);
+
 	if ((leader != event) &&
 	    (leader->state == PERF_EVENT_STATE_ACTIVE))
 		leader->pmu->read(leader);
 
+	for_each_sibling_event(sub, leader) {
+		if ((sub != event) &&
+		    (sub->state == PERF_EVENT_STATE_ACTIVE))
+			sub->pmu->read(sub);
+	}
+
+	if (leader->nr_siblings > 1)
+		leader->pmu->commit_tx(pmu, PERF_PMU_TXN_READ);
+
 	values[n++] = perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
@@ -6285,10 +6297,6 @@ static void perf_output_read_group(struc
 	for_each_sibling_event(sub, leader) {
 		n = 0;
 
-		if ((sub != event) &&
-		    (sub->state == PERF_EVENT_STATE_ACTIVE))
-			sub->pmu->read(sub);
-
 		values[n++] = perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);


After that, I think we can simply do something like:

icl_update_topdown_event(..)
{
	int idx = event->hwc.idx;

	if (is_metric_idx(idx))
		return;

	// must be FIXED_SLOTS

	/* do teh thing and update SLOTS and METRIC together */
}

Hmmm?
