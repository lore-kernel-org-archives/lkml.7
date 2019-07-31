Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201B8C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F311F20693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfGaJFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:05:13 -0400
Received: from mail.windriver.com ([147.11.1.11]:41075 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfGaJFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:05:13 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x6V94fug020339
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 31 Jul 2019 02:04:41 -0700 (PDT)
Received: from pek-lpggp2 (128.224.153.75) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.468.0; Wed, 31 Jul 2019
 02:04:40 -0700
Received: by pek-lpggp2 (Postfix, from userid 20544)    id 34FA0720F9C; Wed, 31
 Jul 2019 17:04:37 +0800 (CST)
From:   Jiping Ma <jiping.ma2@windriver.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <jiping.ma2@windriver.com>
Subject: [PATCH] Function stack size and its name mismatch in arm64
Date:   Wed, 31 Jul 2019 17:04:37 +0800
Message-ID: <20190731090437.19867-1-jiping.ma2@windriver.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PC of one the frame is matched to the next frame function, rather
than the function of his frame.

Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
---
 kernel/trace/trace_stack.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 5d16f73898db..ed80b95abf06 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -40,16 +40,28 @@ static void print_max_stack(void)
 
 	pr_emerg("        Depth    Size   Location    (%d entries)\n"
 			   "        -----    ----   --------\n",
+#ifdef CONFIG_ARM64
+			   stack_trace_nr_entries - 1);
+#else
 			   stack_trace_nr_entries);
-
+#endif
+#ifdef CONFIG_ARM64
+	for (i = 1; i < stack_trace_nr_entries; i++) {
+#else
 	for (i = 0; i < stack_trace_nr_entries; i++) {
+#endif
 		if (i + 1 == stack_trace_nr_entries)
 			size = stack_trace_index[i];
 		else
 			size = stack_trace_index[i] - stack_trace_index[i+1];
 
+#ifdef CONFIG_ARM64
+		pr_emerg("%3ld) %8d   %5d   %pS\n", i-1, stack_trace_index[i],
+				size, (void *)stack_dump_trace[i-1]);
+#else
 		pr_emerg("%3ld) %8d   %5d   %pS\n", i, stack_trace_index[i],
 				size, (void *)stack_dump_trace[i]);
+#endif
 	}
 }
 
@@ -324,8 +336,11 @@ static int t_show(struct seq_file *m, void *v)
 		seq_printf(m, "        Depth    Size   Location"
 			   "    (%d entries)\n"
 			   "        -----    ----   --------\n",
+#ifdef CONFIG_ARM64
+			   stack_trace_nr_entries - 1);
+#else
 			   stack_trace_nr_entries);
-
+#endif
 		if (!stack_tracer_enabled && !stack_trace_max_size)
 			print_disabled(m);
 
@@ -334,6 +349,10 @@ static int t_show(struct seq_file *m, void *v)
 
 	i = *(long *)v;
 
+#ifdef CONFIG_ARM64
+	if (i == 0)
+		return 0;
+#endif
 	if (i >= stack_trace_nr_entries)
 		return 0;
 
@@ -342,9 +361,14 @@ static int t_show(struct seq_file *m, void *v)
 	else
 		size = stack_trace_index[i] - stack_trace_index[i+1];
 
+#ifdef CONFIG_ARM64
+	seq_printf(m, "%3ld) %8d   %5d   ", i-1, stack_trace_index[i], size);
+	trace_lookup_stack(m, i-1);
+#else
 	seq_printf(m, "%3ld) %8d   %5d   ", i, stack_trace_index[i], size);
 
 	trace_lookup_stack(m, i);
+#endif
 
 	return 0;
 }
-- 
2.18.1

