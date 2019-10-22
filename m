Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEC0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8502084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gK9l9daf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbfJVJZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:25:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731338AbfJVJZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oljRXGXjGPbNChUqNXgPojMiOXcqHr9P0brP8VW8uCg=; b=gK9l9dafKTgj56+Kio/59vuKpC
        tQB5QUR9X6yu97N6etoyCxG1YC8+Rpc5jEafgBb/jXYW5TI7oYD2pXM+Yne22HU3zs48mBM3I9SrG
        G84LcALYSWXdmDfqAiwUhad+jll5blSvLlh9NniBjXa7YqZ4+70EsKHuSGMyRpW5TIq+nvrXPVuCU
        k+3WkuwzQ4P8cBimJq7kdMbSQNnO/en/HbcsSxHYpA2OkSTKcZOMZfTUHJV6aWXQnWPkd7LF/xUV0
        kCmWNfSGrlC26qqMEH7jrIbTqVGAJJ959EJo4C/jqvW83aKlw7bbbaU2yfUIgk/ww5jueEkEdYKNU
        cFYwbgiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMqPf-0005Lb-Dx; Tue, 22 Oct 2019 09:25:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C8DFA30314F;
        Tue, 22 Oct 2019 11:24:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1877A2022BA0A; Tue, 22 Oct 2019 11:25:09 +0200 (CEST)
Message-Id: <20191022092307.368892814@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 22 Oct 2019 11:20:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, andi@firstfloor.org, kan.liang@linux.intel.com
Subject: [PATCH 1/3] perf: Optimize perf_install_in_event()
References: <20191022092017.740591163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi reported that when creating a lot of events, a lot of time is
spend in IPIs and asked if it would be possible to elide some of that.

Now when, as for example the perf-tool always does, events are created
disabled, then these events will not need to be scheduled when added
to the context (they're still disable) and therefore the IPI is not
required -- except for the very first event, that will need to set
ctx->is_active.

( it might be possible to set ctx->is_active remotely for cpu_ctx, but
  we really need the IPI for task_ctx, so lets not make that
  distinction )

Also use __perf_effective_state() since group events depend on the
state of the leader, if the leader is OFF, the whole group is OFF.

So when sibling events are created enabled (XXX check tool) then we
only need a single IPI to create and enable the whole group (+ that
initial IPI to initialize the context).

Reported-by: Andi Kleen <andi@firstfloor.org>
Suggested-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: kan.liang@linux.intel.com
Cc: jolsa@redhat.com
Cc: acme@kernel.org
---
 kernel/events/core.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2666,6 +2666,25 @@ perf_install_in_context(struct perf_even
 	 */
 	smp_store_release(&event->ctx, ctx);
 
+	/*
+	 * perf_event_attr::disabled events will not run and can be initialized
+	 * without IPI. Except when this is the first event for the context, in
+	 * that case we need the magic of the IPI to set ctx->is_active.
+	 *
+	 * The IOC_ENABLE that is sure to follow the creation of a disabled
+	 * event will issue the IPI and reprogram the hardware.
+	 */
+	if (__perf_effective_state(event) == PERF_EVENT_STATE_OFF && ctx->nr_events) {
+		raw_spin_lock_irq(&ctx->lock);
+		if (task && ctx->task == TASK_TOMBSTONE) {
+			raw_spin_unlock_irq(&ctx->lock);
+			return;
+		}
+		add_event_to_ctx(event, ctx);
+		raw_spin_unlock_irq(&ctx->lock);
+		return;
+	}
+
 	if (!task) {
 		cpu_function_call(cpu, __perf_install_in_context, event);
 		return;


