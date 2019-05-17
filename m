Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52F8C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A234920881
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wh1daIxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfEQLzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 07:55:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43856 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfEQLzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 07:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XtwpOsw8p9+FZmwUToKYmAOI1E+3MdSkpZSo8fhVjl4=; b=Wh1daIxV0KCNScNaK2q8Q4r+w8
        rI+f6jHPPDYUdGrjhpJ9ZU4I1buuVyD1CCkxBRMYK8hVw5BPJsv+o/6T2DqntVNw6xi+EVzBYN6QR
        /H4LQV4/Iu/P3O6dsDB7jdw4pYMrPBUbTBGXEWTIX9BM7+pBgxPoBOdpKWUNeHkgDGRoFIkE7sbFh
        knwLcK6B+LdluIC83f8W1R8TQDcphsVFyW8HzKCrOUfM+7bHsQfGxaoZKY++1+Te9AaCOZKKfutA1
        DFRPMSlrqBTo8FKS0Rw/LLkNotIGr3M6yml/jb2AdlMZzz2VVKJTLLUgHN7BwEaNOA32ncX4dG6l2
        QKP6HpYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRbRz-00022S-0V; Fri, 17 May 2019 11:54:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BC3EF2027B747; Fri, 17 May 2019 13:54:56 +0200 (CEST)
Message-Id: <20190517115418.394192145@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 17 May 2019 13:52:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org, mingo@kernel.org
Cc:     yabinc@google.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] perf/ring-buffer: Always use {READ,WRITE}_ONCE() for rb->user_page data
References: <20190517115230.437269790@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must use {READ,WRITE}_ONCE() on rb->user_page data such that
concurrent usage will see whole values. A few key sites were missing
this.

Fixes:7b732a750477 ("perf_counter: new output ABI - part 1")
Suggested-by: Yabin Cui <yabinc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/ring_buffer.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -100,7 +100,7 @@ static void perf_output_put_handle(struc
 	 * See perf_output_begin().
 	 */
 	smp_wmb(); /* B, matches C */
-	rb->user_page->data_head = head;
+	WRITE_ONCE(rb->user_page->data_head, head);
 
 	/*
 	 * We must publish the head before decrementing the nest count,
@@ -496,7 +496,7 @@ void perf_aux_output_end(struct perf_out
 		perf_event_aux_event(handle->event, aux_head, size,
 				     handle->aux_flags);
 
-	rb->user_page->aux_head = rb->aux_head;
+	WRITE_ONCE(rb->user_page->aux_head, rb->aux_head);
 	if (rb_need_aux_wakeup(rb))
 		wakeup = true;
 
@@ -528,7 +528,7 @@ int perf_aux_output_skip(struct perf_out
 
 	rb->aux_head += size;
 
-	rb->user_page->aux_head = rb->aux_head;
+	WRITE_ONCE(rb->user_page->aux_head, rb->aux_head);
 	if (rb_need_aux_wakeup(rb)) {
 		perf_output_wakeup(handle);
 		handle->wakeup = rb->aux_wakeup + rb->aux_watermark;


