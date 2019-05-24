Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F21C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DB221841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CVxFnRIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389295AbfEXIIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:08:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37169 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388959AbfEXIIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:08:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4O88EkV118439
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 01:08:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4O88EkV118439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558685295;
        bh=SwMpO8MEB+Y8QLnlfgnGBVMC/j9d1mGCQWrUxsdytHc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=CVxFnRIerqb4f0HyywT+8N3VI9hViK0+CSmdIrrIrOvmnHVzuqQiKUwHTh7PrjwQ1
         eXnVL70RkLDsghZSMUqAx8yTTBUmWr5rrv/tF4PTLLEsNMVnlPGE14uB9IZrFKFADy
         JkmwahZgIMgjbFdcOHNrfGGZ4+RyuI7OjInUplwnPqMUW7pjcU9/q3iyduf3YKwkyP
         s8Oq0TlS3sNzJrHRcHtvUtAy6yC0trUpwmCg2jSUv5Qh9PzI+OXVgZge3V3DHMtegU
         PswI5PrjizHwP4fxF1QKDocc1vZcaNGRvJ9WLb0TpVivKRWn6i0iaFYUXk5YlhbH7a
         BjPE3iWZt4wlg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4O88DMm118436;
        Fri, 24 May 2019 01:08:13 -0700
Date:   Fri, 24 May 2019 01:08:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yabin Cui <tipbot@zytor.com>
Message-ID: <tip-1b038c6e05ff70a1e66e3e571c2e6106bdb75f53@git.kernel.org>
Cc:     jolsa@redhat.com, hpa@zytor.com, torvalds@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, acme@kernel.org,
        eranian@google.com, mingo@kernel.org, yabinc@google.com,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        vincent.weaver@maine.edu
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, torvalds@linux-foundation.org,
          peterz@infradead.org, hpa@zytor.com, jolsa@redhat.com,
          vincent.weaver@maine.edu, acme@redhat.com,
          alexander.shishkin@linux.intel.com, yabinc@google.com,
          mingo@kernel.org, acme@kernel.org, eranian@google.com
In-Reply-To: <20190517115418.224478157@infradead.org>
References: <20190517115418.224478157@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/ring_buffer: Fix exposing a temporarily
 decreased data_head
Git-Commit-ID: 1b038c6e05ff70a1e66e3e571c2e6106bdb75f53
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

Commit-ID:  1b038c6e05ff70a1e66e3e571c2e6106bdb75f53
Gitweb:     https://git.kernel.org/tip/1b038c6e05ff70a1e66e3e571c2e6106bdb75f53
Author:     Yabin Cui <yabinc@google.com>
AuthorDate: Fri, 17 May 2019 13:52:31 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 24 May 2019 09:00:10 +0200

perf/ring_buffer: Fix exposing a temporarily decreased data_head

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

[ Split up by peterz. ]

Signed-off-by: Yabin Cui <yabinc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: mark.rutland@arm.com
Fixes: ef60777c9abd ("perf: Optimize the perf_output() path by removing IRQ-disables")
Link: http://lkml.kernel.org/r/20190517115418.224478157@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/ring_buffer.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 674b35383491..009467a60578 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -51,11 +51,18 @@ again:
 	head = local_read(&rb->head);
 
 	/*
-	 * IRQ/NMI can happen here, which means we can miss a head update.
+	 * IRQ/NMI can happen here and advance @rb->head, causing our
+	 * load above to be stale.
 	 */
 
-	if (!local_dec_and_test(&rb->nest))
+	/*
+	 * If this isn't the outermost nesting, we don't have to update
+	 * @rb->user_page->data_head.
+	 */
+	if (local_read(&rb->nest) > 1) {
+		local_dec(&rb->nest);
 		goto out;
+	}
 
 	/*
 	 * Since the mmap() consumer (userspace) can run on a different CPU:
@@ -87,9 +94,18 @@ again:
 	rb->user_page->data_head = head;
 
 	/*
-	 * Now check if we missed an update -- rely on previous implied
-	 * compiler barriers to force a re-read.
+	 * We must publish the head before decrementing the nest count,
+	 * otherwise an IRQ/NMI can publish a more recent head value and our
+	 * write will (temporarily) publish a stale value.
+	 */
+	barrier();
+	local_set(&rb->nest, 0);
+
+	/*
+	 * Ensure we decrement @rb->nest before we validate the @rb->head.
+	 * Otherwise we cannot be sure we caught the 'last' nested update.
 	 */
+	barrier();
 	if (unlikely(head != local_read(&rb->head))) {
 		local_inc(&rb->nest);
 		goto again;
