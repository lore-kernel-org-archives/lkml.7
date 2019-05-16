Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDFEC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DAD206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+EvfSN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfEPSke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:40:34 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:44477 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfEPSkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:40:33 -0400
Received: by mail-vs1-f73.google.com with SMTP id q6so879342vsn.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 11:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/qqK7u0fKXYsLjbSznfrVkJ/CBF1xYfCxZF/p/3OEu8=;
        b=I+EvfSN7hUmC8OZCk8zQfdpm93VNhwHOYngRTuW0QgaSoGdv/2SoAYSRu1+CfCodWT
         k7k6JMcoWieV2SS8Q9BFdD5nzc4dW9iq9803/G+d31l0yVcwGyEkZkkjXkC3F87+ybQp
         H8sCEaG3EDT1r69WG3PTmCePtViNeVmoBgJ8caSmJbRrqO6RkIJdo3jlTevMcteGw9e5
         I/R28Zqrtb7Sy4fZ7k/DoQuSuSPDsIyl98bYqq63qI54rZgYjQs2Vzx4g08FYZb0H+3z
         gjvHGhyqUaiycSqxDXVCoPkg1fDTQ7lF/0yp8RSfvNb3/i8vUgURXw44wGPR7M6GDqTP
         SY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/qqK7u0fKXYsLjbSznfrVkJ/CBF1xYfCxZF/p/3OEu8=;
        b=rt79ics5QYi1DYbidfGdKpXpDfdvHL4jq3RiWf+A+oiY1tK9X08tzIgiJVLUljXfw4
         z6NWYSrAKS2/bxBWJKKgsl2DvzLqmJX/nFcAxS+0ZF1kdLZUl+eKr1pfHa1sUntFfgoE
         F7LhRhNVZ5UXDPdJJ2L/aNQA9S6LVgPQK9n2LX+EpgIaR+uYknKPR89nTStkoe0gEYUk
         tn9II5pJiMwaUdWV2wtIDNwD34XckDVyJs0JO1dPzZVjMfdwGZO+z+YQu8ggSM5IYP58
         vHwqrofjkrY7swCrU5bLNTzNKEpkqs1x8jlK4L9n2SwJQJDik3wHmOllplbAU1AlGCW3
         Ej4Q==
X-Gm-Message-State: APjAAAX/xUXJQUHG/E/bfRbBLkM3I1k3ncPOj9PAFesd9EDoQ25vPS9e
        bJL/SsKA7XxuTSrukISJ0Dp2UzSViQ==
X-Google-Smtp-Source: APXvYqwOp6tcJFYlA6tTqa+sO8spVWiUjCyNRBW7ZsM2KWGBIT9ujHfP1MRRy4mKH91gCYbB0cYBeOuqI1Q=
X-Received: by 2002:a67:ef85:: with SMTP id r5mr13582159vsp.237.1558032032672;
 Thu, 16 May 2019 11:40:32 -0700 (PDT)
Date:   Thu, 16 May 2019 11:40:10 -0700
In-Reply-To: <20190515003059.23920-1-yabinc@google.com>
Message-Id: <20190516184010.167903-1-yabinc@google.com>
Mime-Version: 1.0
References: <20190515003059.23920-1-yabinc@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v2] perf/ring_buffer: Fix exposing a temporarily decreased data_head.
From:   Yabin Cui <yabinc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In perf_output_put_handle(), an IRQ/NMI can happen in below location and
write records to the same ring buffer:
	...
	local_dec_and_test(&rb->nest)
	...                          <-- an IRQ/NMI can happen here
	rb->user_page->data_head = head;
	...

In this case, a value A is written to data_head in the IRQ, then a value
B is written to data_head after the IRQ. And A > B. As a result,
data_head is temporarily decreased from A to B. And a reader may see
data_head < data_tail if it read the buffer frequently enough, which
creates unexpected behaviors.

This can be fixed by moving dec(&rb->nest) to after updating data_head,
which prevents the IRQ/NMI above from updating data_head.

Signed-off-by: Yabin Cui <yabinc@google.com>
---

v1 -> v2: change rb->nest from local_t to unsigned int, and add barriers.

---
 kernel/events/internal.h    |  2 +-
 kernel/events/ring_buffer.c | 24 ++++++++++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 79c47076700a..0a8c003b9bcf 100644
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
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 674b35383491..c677beb01fb1 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -38,7 +38,8 @@ static void perf_output_get_handle(struct perf_output_handle *handle)
 	struct ring_buffer *rb = handle->rb;
 
 	preempt_disable();
-	local_inc(&rb->nest);
+	rb->nest++;
+	barrier();
 	handle->wakeup = local_read(&rb->wakeup);
 }
 
@@ -54,8 +55,10 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
 	 * IRQ/NMI can happen here, which means we can miss a head update.
 	 */
 
-	if (!local_dec_and_test(&rb->nest))
+	if (rb->nest > 1) {
+		rb->nest--;
 		goto out;
+	}
 
 	/*
 	 * Since the mmap() consumer (userspace) can run on a different CPU:
@@ -84,14 +87,23 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
 	 * See perf_output_begin().
 	 */
 	smp_wmb(); /* B, matches C */
-	rb->user_page->data_head = head;
+	WRITE_ONCE(rb->user_page->data_head, head);
+
+	/*
+	 * Clear rb->nest after updating data_head. This prevents IRQ/NMI from
+	 * updating data_head before us. If that happens, we will expose a
+	 * temporarily decreased data_head.
+	 */
+	WRITE_ONCE(rb->nest, 0);
 
 	/*
-	 * Now check if we missed an update -- rely on previous implied
-	 * compiler barriers to force a re-read.
+	 * Now check if we missed an update -- use barrier() to force a
+	 * re-read.
 	 */
+	barrier();
 	if (unlikely(head != local_read(&rb->head))) {
-		local_inc(&rb->nest);
+		rb->nest++;
+		barrier();
 		goto again;
 	}
 
-- 
2.21.0.1020.gf2820cf01a-goog

