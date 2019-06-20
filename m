Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBA2C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7D321670
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054008;
	bh=b+W1qEmJWmRiW+AMUH4yv3opZsDfBNdCI4DHJZt3y3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VRXkFbz7GeT5/uS5Rce9W+jXE9/uw2Ioat8kyryt+l4C84al1y3sscWG4+1soIc53
	 /E+AsfnV9pWYIR2del0vLVXjpr1PgXu3hHuq+Uqc8oObk/Xu5AWKALE+9FxpbeR12z
	 IETVmVbye8PyNA442msxSK31Nnj6SvzON2z+s3j4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfFTSGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728206AbfFTSGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:06:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AC6C21530;
        Thu, 20 Jun 2019 18:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054001;
        bh=b+W1qEmJWmRiW+AMUH4yv3opZsDfBNdCI4DHJZt3y3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YkHhwFzvVP9eOEd4tZHRZvX75gPPpFwnebxuAKJvl8AdMB8dqkZRrJsqMIe+jjreD
         LvH8Mielp7J4D7RP7HCrGZL/LKjedQp/X6Atyej1UF8HABjsTplsaIZhnm6bOdY7wZ
         6ClCf9sTF7SgXwOwyZTD/aoeL6V8D/xpt+baq1Qk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yabin Cui <yabinc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, mark.rutland@arm.com,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 101/117] perf/ring_buffer: Fix exposing a temporarily decreased data_head
Date:   Thu, 20 Jun 2019 19:57:15 +0200
Message-Id: <20190620174357.840962614@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1b038c6e05ff70a1e66e3e571c2e6106bdb75f53 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/ring_buffer.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 99becab2c1ce..524744a38d61 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -52,11 +52,18 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
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
@@ -88,9 +95,18 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
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
-- 
2.20.1



