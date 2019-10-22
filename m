Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2972ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF57B214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sMk3GnpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbfJVKEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 06:04:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37576 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfJVKEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kV/nLiFmUNm6OH0Bd9x6U4JZyYHsMO+jxibkjxu3pa8=; b=sMk3GnpMr0ciIPen7KoChofUj
        ZtT277y+/fyxmsstKPSdsW2SwlSv/ik1QdAt6Xf6/JFAkRjX7PcTkvr/jz9TfxzNZmjMO9MYE3R5i
        pSAmkKgVAWkWahL9al2RgbUXZjn6MZDjrNHZzKZ2ULV96zTLUQXQ144oXTqAEB+kDtg0Kg+nPPnkb
        9cNmy7c6mVjfOV/ALZ9sLIOX7471ZyBFB580OgWxVNwEJIu8eNNxtWNr2vs5ET4r3xNdBvIYRKqGh
        mU9fL62eUKFfCrAFGh2DLZ+S5RZI+/ldKl2h4+qEyOqbo3qyCu8/uYmn9gGs5Y0nUuYlCnNt4yd7X
        /kt5Rzouw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMr1B-0002gq-HU; Tue, 22 Oct 2019 10:03:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4842D300EBF;
        Tue, 22 Oct 2019 12:02:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1D4F29AB92A3; Tue, 22 Oct 2019 12:03:55 +0200 (CEST)
Date:   Tue, 22 Oct 2019 12:03:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, andi@firstfloor.org, kan.liang@linux.intel.com
Subject: Re: [PATCH 1/3] perf: Optimize perf_install_in_event()
Message-ID: <20191022100355.GM1817@hirez.programming.kicks-ass.net>
References: <20191022092017.740591163@infradead.org>
 <20191022092307.368892814@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022092307.368892814@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 11:20:18AM +0200, Peter Zijlstra wrote:
> Andi reported that when creating a lot of events, a lot of time is
> spend in IPIs and asked if it would be possible to elide some of that.
> 
> Now when, as for example the perf-tool always does, events are created
> disabled, then these events will not need to be scheduled when added
> to the context (they're still disable) and therefore the IPI is not
> required -- except for the very first event, that will need to set
> ctx->is_active.
> 
> ( it might be possible to set ctx->is_active remotely for cpu_ctx, but
>   we really need the IPI for task_ctx, so lets not make that
>   distinction )
> 
> Also use __perf_effective_state() since group events depend on the
> state of the leader, if the leader is OFF, the whole group is OFF.
> 
> So when sibling events are created enabled (XXX check tool) then we
> only need a single IPI to create and enable the whole group (+ that
> initial IPI to initialize the context).

Arguably, we could possible do something like so as well, but I'm not
sure it makes sense as it will not help if IOC_ENABLE is called in
creation order. Because in that case we'll enable the group leader
before the siblings and we'll schedule them one at a time, instead of
the whole group at once.

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f9a5d4356562..2a5e6d9654e1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2791,6 +2791,7 @@ static void __perf_event_enable(struct perf_event *event,
 static void _perf_event_enable(struct perf_event *event)
 {
 	struct perf_event_context *ctx = event->ctx;
+	struct perf_event *leader;
 
 	raw_spin_lock_irq(&ctx->lock);
 	if (event->state >= PERF_EVENT_STATE_INACTIVE ||
@@ -2808,6 +2809,17 @@ static void _perf_event_enable(struct perf_event *event)
 	 */
 	if (event->state == PERF_EVENT_STATE_ERROR)
 		event->state = PERF_EVENT_STATE_OFF;
+
+	/*
+	 * If this is a sibling event and the group leader is still OFF
+	 * then there is no point in trying to schedule this event.
+	 */
+	leader = event->group_leader;
+	if (leader != event && leader->state == PERF_EVENT_STATE_OFF) {
+		event->state = PERF_EVENT_STATE_INACTIVE;
+		raw_spin_unlock_irq(&ctx->lock);
+		return;
+	}
 	raw_spin_unlock_irq(&ctx->lock);
 
 	event_function_call(event, __perf_event_enable, NULL);
