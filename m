Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C419C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B2D214AE
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994737;
	bh=ugUySFmSmxgk0l+L3c6rCvDBw8Ve0Z51DyJfgMwjbVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TjpVBzckOQGD94kvIxRfALUeACJTiiZ+GpLPq6m+ZOfKWs5PbU/RI65tbw0JMH4hG
	 vnCJbmZyfGRj7Qtdawgh87TQcWEXG0SC9K2UVWbUgGYbdJ+ZqIXqO8Eun4X94RYRqx
	 5HErBXM4mHTNRAekaw8yH7v8Dhu60iRk9k/3wGog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfFHLwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728913AbfFHLrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:47:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCADA21537;
        Sat,  8 Jun 2019 11:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994437;
        bh=ugUySFmSmxgk0l+L3c6rCvDBw8Ve0Z51DyJfgMwjbVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V72MzVUcJt+MLUHcO4R3pOwtXy3igbGsQ/ewe7yiV5G2vnBkH+YjEX53bDoqcR12G
         DSKCFE/NoVLWGFVZ3MfDOSE1TywHZaklT8jQ1vFP9dW7hqhE96dYp2LLgn11EWFL7Y
         ZIQ/muxVhJw+BOeKGa4nzgzyGKUqiwgUOoAP+ccA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Yabin Cui <yabinc@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        mark.rutland@arm.com, namhyung@kernel.org,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 11/31] perf/ring_buffer: Add ordering to rb->nest increment
Date:   Sat,  8 Jun 2019 07:46:22 -0400
Message-Id: <20190608114646.9415-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608114646.9415-1-sashal@kernel.org>
References: <20190608114646.9415-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 3f9fbe9bd86c534eba2faf5d840fd44c6049f50e ]

Similar to how decrementing rb->next too early can cause data_head to
(temporarily) be observed to go backward, so too can this happen when
we increment too late.

This barrier() ensures the rb->head load happens after the increment,
both the one in the 'goto again' path, as the one from
perf_output_get_handle() -- albeit very unlikely to matter for the
latter.

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
Fixes: ef60777c9abd ("perf: Optimize the perf_output() path by removing IRQ-disables")
Link: http://lkml.kernel.org/r/20190517115418.309516009@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/ring_buffer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index fde853270c09..aef2af80a927 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -49,6 +49,15 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
 	unsigned long head;
 
 again:
+	/*
+	 * In order to avoid publishing a head value that goes backwards,
+	 * we must ensure the load of @rb->head happens after we've
+	 * incremented @rb->nest.
+	 *
+	 * Otherwise we can observe a @rb->head value before one published
+	 * by an IRQ/NMI happening between the load and the increment.
+	 */
+	barrier();
 	head = local_read(&rb->head);
 
 	/*
-- 
2.20.1

