Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51626C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0125D2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VoX6Edss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389408AbfEXIKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:10:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54625 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389215AbfEXIKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:10:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4O8AHKP118987
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 01:10:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4O8AHKP118987
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558685418;
        bh=cm+vfstlWBm818h4MnTUWz669BtIOSpf5fxFEA7JKN4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=VoX6EdssvFTxTVNpyCu62DwHw6tAhun4z1BUsiAAUgkwTHDYvepj4SpyR3/vj7IlL
         U0bhH/6ukHv+fm/oJm5gDd992C3o/1ehWpjPdAMMIkWKy/NRmflynLbEktNOgPs2dg
         3UNeXShD4GwPtflMKQgP1XKPu1xqnXL79hPvw2MLHdUkvwsif70fKxvbKMXJgvN+Ep
         Vo+ThVr4BbI1XUORc7tNrZA+YrWz634LZiQMIc8WxxEkHewcAuQaJwgENzNHIcPTKR
         To0TBmPK4pupmXpGFvXoScUmg9g/1FuVaUmj1hR4bH9ChKpKflHQC1rHwu2T74zsnF
         IexwTFXST5pcA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4O8AHTr118984;
        Fri, 24 May 2019 01:10:17 -0700
Date:   Fri, 24 May 2019 01:10:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-5322ea58a06da2e69c5ef36a9b4d4b9255edd423@git.kernel.org>
Cc:     hpa@zytor.com, vincent.weaver@maine.edu,
        alexander.shishkin@linux.intel.com, eranian@google.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        jolsa@redhat.com, tglx@linutronix.de, acme@redhat.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          vincent.weaver@maine.edu, alexander.shishkin@linux.intel.com,
          eranian@google.com, tglx@linutronix.de, acme@redhat.com,
          jolsa@redhat.com, peterz@infradead.org,
          torvalds@linux-foundation.org
In-Reply-To: <20190517115418.481392777@infradead.org>
References: <20190517115418.481392777@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/ring-buffer: Use regular variables for
 nesting
Git-Commit-ID: 5322ea58a06da2e69c5ef36a9b4d4b9255edd423
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5322ea58a06da2e69c5ef36a9b4d4b9255edd423
Gitweb:     https://git.kernel.org/tip/5322ea58a06da2e69c5ef36a9b4d4b9255edd423
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Fri, 17 May 2019 13:52:34 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 24 May 2019 09:00:11 +0200

perf/ring-buffer: Use regular variables for nesting

While the IRQ/NMI will nest, the nest-count will be invariant over the
actual exception, since it will decrement equal to increment.

This means we can -- carefully -- use a regular variable since the
typical LOAD-STORE race doesn't exist (similar to preempt_count).

This optimizes the ring-buffer for all LOAD-STORE architectures, since
they need to use atomic ops to implement local_t.

Suggested-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Cc: mark.rutland@arm.com
Cc: namhyung@kernel.org
Cc: yabinc@google.com
Link: http://lkml.kernel.org/r/20190517115418.481392777@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/internal.h    |  4 ++--
 kernel/events/ring_buffer.c | 41 ++++++++++++++++++++++++++---------------
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 79c47076700a..3aef4191798c 100644
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
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 7a0c73e4b3eb..ffb59a4ef4ff 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -38,7 +38,12 @@ static void perf_output_get_handle(struct perf_output_handle *handle)
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
 
@@ -46,6 +51,17 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
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
@@ -64,15 +80,6 @@ again:
 	 * load above to be stale.
 	 */
 
-	/*
-	 * If this isn't the outermost nesting, we don't have to update
-	 * @rb->user_page->data_head.
-	 */
-	if (local_read(&rb->nest) > 1) {
-		local_dec(&rb->nest);
-		goto out;
-	}
-
 	/*
 	 * Since the mmap() consumer (userspace) can run on a different CPU:
 	 *
@@ -108,7 +115,7 @@ again:
 	 * write will (temporarily) publish a stale value.
 	 */
 	barrier();
-	local_set(&rb->nest, 0);
+	WRITE_ONCE(rb->nest, 0);
 
 	/*
 	 * Ensure we decrement @rb->nest before we validate the @rb->head.
@@ -116,7 +123,7 @@ again:
 	 */
 	barrier();
 	if (unlikely(head != local_read(&rb->head))) {
-		local_inc(&rb->nest);
+		WRITE_ONCE(rb->nest, 1);
 		goto again;
 	}
 
@@ -355,6 +362,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 	struct perf_event *output_event = event;
 	unsigned long aux_head, aux_tail;
 	struct ring_buffer *rb;
+	unsigned int nest;
 
 	if (output_event->parent)
 		output_event = output_event->parent;
@@ -385,13 +393,16 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
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
@@ -419,7 +430,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 		if (!handle->size) { /* A, matches D */
 			event->pending_disable = smp_processor_id();
 			perf_output_wakeup(handle);
-			local_set(&rb->aux_nest, 0);
+			WRITE_ONCE(rb->aux_nest, 0);
 			goto err_put;
 		}
 	}
@@ -508,7 +519,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 
 	handle->event = NULL;
 
-	local_set(&rb->aux_nest, 0);
+	WRITE_ONCE(rb->aux_nest, 0);
 	/* can't be last */
 	rb_free_aux(rb);
 	ring_buffer_put(rb);
