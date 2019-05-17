Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28616C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F2720815
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OTigpAmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfEQLzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 07:55:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfEQLzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 07:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BB+a1yAjmGBaCcsmFlZZE8gT8m2E1PyHUTm3q9L2zV8=; b=OTigpAmAdL7mg9vDisVbcjE4G0
        pPbA5jd9aZKd4FP0X7whbf/A2shmtw7IA0uCf+L2FWO0/nmbgSs2feGC9D+ipz+w9aO/tW5tpKgHC
        z6rHkCo6wJd7SlT2W1unKAYDuGH9f9k5Ww6uYCh+18/RBOAvo5yiB6iWsBivOQAbPxPgo40mhTWyd
        h2iUWYwhHBFnBWcaQCTag4f9nq711zbvzXSxiscmxL2r9XbMwKZRkNvgpvAmp74f4wxWsMmteQPlw
        3HAAZ/aMVpi2REoHtNgRgoRRxRzWVM+j+xGYzz9DUFmtbUfHLM4wV171SrcAyOvBAqdYXfmzi6vyo
        vODmVk1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRbRy-00022T-W1; Fri, 17 May 2019 11:54:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C1EF62027B748; Fri, 17 May 2019 13:54:56 +0200 (CEST)
Message-Id: <20190517115418.481392777@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 17 May 2019 13:52:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org, mingo@kernel.org
Cc:     yabinc@google.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] perf/ring-buffer: Use regular variables for nesting
References: <20190517115230.437269790@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the IRQ/NMI will nest, the nest-count will be invariant over the
actual exception, since it will decrement equal to increment.

This means we can -- carefully -- use a regular variable since the
typical LOAD-STORE race doesn't exist (similar to preempt_count).

This optimizes the ring-buffer for all LOAD-STORE architectures, since
they need to use atomic ops to implement local_t.

Suggested-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/internal.h    |    4 ++--
 kernel/events/ring_buffer.c |   41 ++++++++++++++++++++++++++---------------
 2 files changed, 28 insertions(+), 17 deletions(-)

--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -24,7 +24,7 @@ struct ring_buffer {
 	atomic_t			poll;		/* POLL_ for wakeups */
 
 	local_t				head;		/* write position    */
-	local_t				nest;		/* nested writers    */
+	unsigned int			nest;		/* nested writers    */
 	local_t				events;		/* event limit       */
 	local_t				wakeup;		/* wakeup stamp      */
 	local_t				lost;		/* nr records lost   */
@@ -41,7 +41,7 @@ struct ring_buffer {
 
 	/* AUX area */
 	long				aux_head;
-	local_t				aux_nest;
+	unsigned int			aux_nest;
 	long				aux_wakeup;	/* last aux_watermark boundary crossed by aux_head */
 	unsigned long			aux_pgoff;
 	int				aux_nr_pages;
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -38,7 +38,12 @@ static void perf_output_get_handle(struc
 	struct ring_buffer *rb = handle->rb;
 
 	preempt_disable();
-	local_inc(&rb->nest);
+
+	/*
+	 * Avoid an explicit LOAD/STORE such that architectures with memops
+	 * can use them.
+	 */
+	(*(volatile unsigned int *)&rb->nest)++;
 	handle->wakeup = local_read(&rb->wakeup);
 }
 
@@ -46,6 +51,17 @@ static void perf_output_put_handle(struc
 {
 	struct ring_buffer *rb = handle->rb;
 	unsigned long head;
+	unsigned int nest;
+
+	/*
+	 * If this isn't the outermost nesting, we don't have to update
+	 * @rb->user_page->data_head.
+	 */
+	nest = READ_ONCE(rb->nest);
+	if (nest > 1) {
+		WRITE_ONCE(rb->nest, nest - 1);
+		goto out;
+	}
 
 again:
 	/*
@@ -65,15 +81,6 @@ static void perf_output_put_handle(struc
 	 */
 
 	/*
-	 * If this isn't the outermost nesting, we don't have to update
-	 * @rb->user_page->data_head.
-	 */
-	if (local_read(&rb->nest) > 1) {
-		local_dec(&rb->nest);
-		goto out;
-	}
-
-	/*
 	 * Since the mmap() consumer (userspace) can run on a different CPU:
 	 *
 	 *   kernel				user
@@ -108,7 +115,7 @@ static void perf_output_put_handle(struc
 	 * write will (temporarily) publish a stale value.
 	 */
 	barrier();
-	local_set(&rb->nest, 0);
+	WRITE_ONCE(rb->nest, 0);
 
 	/*
 	 * Ensure we decrement @rb->nest before we validate the @rb->head.
@@ -116,7 +123,7 @@ static void perf_output_put_handle(struc
 	 */
 	barrier();
 	if (unlikely(head != local_read(&rb->head))) {
-		local_inc(&rb->nest);
+		WRITE_ONCE(rb->nest, 1);
 		goto again;
 	}
 
@@ -355,6 +362,7 @@ void *perf_aux_output_begin(struct perf_
 	struct perf_event *output_event = event;
 	unsigned long aux_head, aux_tail;
 	struct ring_buffer *rb;
+	unsigned int nest;
 
 	if (output_event->parent)
 		output_event = output_event->parent;
@@ -385,13 +393,16 @@ void *perf_aux_output_begin(struct perf_
 	if (!refcount_inc_not_zero(&rb->aux_refcount))
 		goto err;
 
+	nest = READ_ONCE(rb->aux_nest);
 	/*
 	 * Nesting is not supported for AUX area, make sure nested
 	 * writers are caught early
 	 */
-	if (WARN_ON_ONCE(local_xchg(&rb->aux_nest, 1)))
+	if (WARN_ON_ONCE(nest))
 		goto err_put;
 
+	WRITE_ONCE(rb->aux_nest, nest + 1);
+
 	aux_head = rb->aux_head;
 
 	handle->rb = rb;
@@ -419,7 +430,7 @@ void *perf_aux_output_begin(struct perf_
 		if (!handle->size) { /* A, matches D */
 			event->pending_disable = smp_processor_id();
 			perf_output_wakeup(handle);
-			local_set(&rb->aux_nest, 0);
+			WRITE_ONCE(rb->aux_nest, 0);
 			goto err_put;
 		}
 	}
@@ -508,7 +519,7 @@ void perf_aux_output_end(struct perf_out
 
 	handle->event = NULL;
 
-	local_set(&rb->aux_nest, 0);
+	WRITE_ONCE(rb->aux_nest, 0);
 	/* can't be last */
 	rb_free_aux(rb);
 	ring_buffer_put(rb);


