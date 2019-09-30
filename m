Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8EDC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C1B218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oFwm9wuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbfI3OIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:08:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731375AbfI3OIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nGO+/P6co1PNfbFpn0HhRpkobXLdDQLgOo3vkL3dnQU=; b=oFwm9wuVRUCMkpFfxrj3rlfM7
        ZEKCLh6YFrBA9TGoGPtQDHYApGIwbO5PvQap4FsTkpTSzJlUzXhgle2IRp1X3JilvmqNZu7/E7Owc
        BmsBAbClveVoI0SGB+RLmWkmJitP8HDDbrNNiNdAhKQWRkq2ptZUbMz+hpX56oKpqk8/80/6BvObg
        z61df8lkf9tXS44l53L/9AXHLyiOA+SHVtBy8dM8YAgDSaWnX3eaVQTEUECVkiNQEges+reDs6j8m
        9ibDKdcHBcYIGuzDOkiIY8E1Y1iN8+RDlxkF75BvcVMMeSaMeLSKVwnc+8LtRira2yDfaufgufSl1
        mZMkfC7Wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEwLF-0003xH-FO; Mon, 30 Sep 2019 14:07:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3EAAC305DE2;
        Mon, 30 Sep 2019 16:07:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E3B520FE307C; Mon, 30 Sep 2019 16:07:55 +0200 (CEST)
Date:   Mon, 30 Sep 2019 16:07:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V4 07/14] perf/x86/intel: Support hardware TopDown metrics
Message-ID: <20190930140755.GE4581@hirez.programming.kicks-ass.net>
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
 <20190916134128.18120-8-kan.liang@linux.intel.com>
 <20190930130615.GN4553@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930130615.GN4553@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 03:06:15PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 16, 2019 at 06:41:21AM -0700, kan.liang@linux.intel.com wrote:

> > +static bool is_first_topdown_event_in_group(struct perf_event *event)
> > +{
> > +	struct perf_event *first = NULL;
> > +
> > +	if (is_topdown_event(event->group_leader))
> > +		first = event->group_leader;
> > +	else {
> > +		for_each_sibling_event(first, event->group_leader)
> > +			if (is_topdown_event(first))
> > +				break;
> > +	}
> > +
> > +	if (event == first)
> > +		return true;
> > +
> > +	return false;
> > +}
> 
> > +static u64 icl_update_topdown_event(struct perf_event *event)
> > +{
> > +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > +	struct perf_event *other;
> > +	u64 slots, metrics;
> > +	int idx;
> > +
> > +	/*
> > +	 * Only need to update all events for the first
> > +	 * slots/metrics event in a group
> > +	 */
> > +	if (event && !is_first_topdown_event_in_group(event))
> > +		return 0;
> 
> This is pretty crap and approaches O(n^2); let me think if there's
> anything saner to do here.

This is also really complicated in the case where we do
perf_remove_from_context() in the 'wrong' order.

In that case we get detached events that are not up-to-date (and never
will be). It doesn't look like that matters, but it is weird.
