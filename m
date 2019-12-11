Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7677BC00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E7F22B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbfLKOe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729701AbfLKOe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:34:58 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 353D121556;
        Wed, 11 Dec 2019 14:34:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1if34q-0010cK-VV; Wed, 11 Dec 2019 09:34:56 -0500
Message-Id: <20191211143456.855201282@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 09:34:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hulk Robot <hulkci@huawei.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [for-linus][PATCH 2/3] tracing: remove set but not used variable buffer
References: <20191211143422.570348522@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

kernel/trace/trace_events_inject.c: In function trace_inject_entry:
kernel/trace/trace_events_inject.c:20:22: warning: variable buffer set but not used [-Wunused-but-set-variable]

It is never used, so remove it.

Link: http://lkml.kernel.org/r/20191207034409.25668-1-yuehaibing@huawei.com

Reported-by: Hulk Robot <hulkci@huawei.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_inject.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index d43710718ee5..d45079ee62f8 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -17,12 +17,10 @@ static int
 trace_inject_entry(struct trace_event_file *file, void *rec, int len)
 {
 	struct trace_event_buffer fbuffer;
-	struct ring_buffer *buffer;
 	int written = 0;
 	void *entry;
 
 	rcu_read_lock_sched();
-	buffer = file->tr->trace_buffer.buffer;
 	entry = trace_event_buffer_reserve(&fbuffer, file, len);
 	if (entry) {
 		memcpy(entry, rec, len);
-- 
2.24.0


