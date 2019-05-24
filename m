Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CFAC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B972187F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wt+UymhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389351AbfEXIKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:10:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50649 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389147AbfEXIKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:10:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4O89bmI118837
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 01:09:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4O89bmI118837
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558685377;
        bh=d/8hKtZlstscXYM/zKOZAVIdL8IUOlFeZ9Y4WH+xX4Y=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=wt+UymhRcuWHaJRzHiAShQnPfi0lr2lQ/7XonbzYdOyJ8Rc+Z61jvwTAgced3JhIz
         fXXPxuIg5mXrTUAWO6VBhIngr2ruXlARuCjDck6mpGE7kKWDDINMtQtL8TkbgU6J87
         T5BzTHLl+9NQoBVfaxDmVB7eGIMrt5fK5TVs9cGsG4tOGZBxlpMxEp4k3DoS/EMCTu
         jXQ4rJQty4I1+CnVU+rSlexYOs45QSDz7TTbERUkWmEvgHiE+bAWtK4xKlqTthuKA1
         tPQH3mAYWMZ0izZdC1YwROF8Q6zjmwBha0c5cPyBWIAEYrw2j3iPqZXJ0V1uMxIyEr
         DOY34K+Hmgd9g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4O89aYD118834;
        Fri, 24 May 2019 01:09:36 -0700
Date:   Fri, 24 May 2019 01:09:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-4d839dd9e4356bbacf3eb0ab13a549b83b008c21@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, eranian@google.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        vincent.weaver@maine.edu, yabinc@google.com, acme@redhat.com,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, jolsa@redhat.com,
          vincent.weaver@maine.edu, alexander.shishkin@linux.intel.com,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          eranian@google.com, hpa@zytor.com, peterz@infradead.org,
          mingo@kernel.org, acme@redhat.com, yabinc@google.com
In-Reply-To: <20190517115418.394192145@infradead.org>
References: <20190517115418.394192145@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/ring-buffer: Always use {READ,WRITE}_ONCE()
 for rb->user_page data
Git-Commit-ID: 4d839dd9e4356bbacf3eb0ab13a549b83b008c21
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

Commit-ID:  4d839dd9e4356bbacf3eb0ab13a549b83b008c21
Gitweb:     https://git.kernel.org/tip/4d839dd9e4356bbacf3eb0ab13a549b83b008c21
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Fri, 17 May 2019 13:52:33 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 24 May 2019 09:00:11 +0200

perf/ring-buffer: Always use {READ,WRITE}_ONCE() for rb->user_page data

We must use {READ,WRITE}_ONCE() on rb->user_page data such that
concurrent usage will see whole values. A few key sites were missing
this.

Suggested-by: Yabin Cui <yabinc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
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
Fixes: 7b732a750477 ("perf_counter: new output ABI - part 1")
Link: http://lkml.kernel.org/r/20190517115418.394192145@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/ring_buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4b5f8d932400..7a0c73e4b3eb 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -100,7 +100,7 @@ again:
 	 * See perf_output_begin().
 	 */
 	smp_wmb(); /* B, matches C */
-	rb->user_page->data_head = head;
+	WRITE_ONCE(rb->user_page->data_head, head);
 
 	/*
 	 * We must publish the head before decrementing the nest count,
@@ -496,7 +496,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 		perf_event_aux_event(handle->event, aux_head, size,
 				     handle->aux_flags);
 
-	rb->user_page->aux_head = rb->aux_head;
+	WRITE_ONCE(rb->user_page->aux_head, rb->aux_head);
 	if (rb_need_aux_wakeup(rb))
 		wakeup = true;
 
@@ -528,7 +528,7 @@ int perf_aux_output_skip(struct perf_output_handle *handle, unsigned long size)
 
 	rb->aux_head += size;
 
-	rb->user_page->aux_head = rb->aux_head;
+	WRITE_ONCE(rb->user_page->aux_head, rb->aux_head);
 	if (rb_need_aux_wakeup(rb)) {
 		perf_output_wakeup(handle);
 		handle->wakeup = rb->aux_wakeup + rb->aux_watermark;
