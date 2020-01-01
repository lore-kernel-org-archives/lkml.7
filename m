Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05535C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 09:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C909E2072C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 09:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgAAJmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 04:42:49 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:44732 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgAAJmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 04:42:49 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TmUDZF-_1577871758;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TmUDZF-_1577871758)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Jan 2020 17:42:46 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     xlpang@linux.alibaba.com, Wen Yang <wenyang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] ftrace: avoid potential division by zero
Date:   Wed,  1 Jan 2020 17:42:33 +0800
Message-Id: <20200101094233.3804-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ftrace_profile->counter is unsigned long and
do_div truncates it to 32 bits, which means it can test
non-zero and be truncated to zero for division.
Fix this issue by using div64_ul() instead.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 kernel/trace/ftrace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ac99a35..342e286 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -527,7 +527,7 @@ static int function_stat_show(struct seq_file *m, void *v)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	avg = rec->time;
-	do_div(avg, rec->counter);
+	avg = div64_ul(avg, rec->counter);
 	if (tracing_thresh && (avg < tracing_thresh))
 		goto out;
 #endif
@@ -553,7 +553,8 @@ static int function_stat_show(struct seq_file *m, void *v)
 		 * Divide only 1000 for ns^2 -> us^2 conversion.
 		 * trace_print_graph_duration will divide 1000 again.
 		 */
-		do_div(stddev, rec->counter * (rec->counter - 1) * 1000);
+		stddev = div64_ul(stddev,
+				  rec->counter * (rec->counter - 1) * 1000);
 	}
 
 	trace_seq_init(&s);
-- 
1.8.3.1

