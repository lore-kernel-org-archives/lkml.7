Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5079CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064A320863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbfCZMmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731464AbfCZMmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:42:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E76220896;
        Tue, 26 Mar 2019 12:42:08 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1h8lP5-0005aE-Jv; Tue, 26 Mar 2019 08:42:07 -0400
Message-Id: <20190326124207.499149620@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 26 Mar 2019 08:41:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH 3/3] ftrace: Fix warning using plain integer as NULL & spelling
 corrections
References: <20190326124143.521905652@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hariprasad Kelam <hariprasad.kelam@gmail.com>

Changed  0 --> NULL to avoid sparse warning
Corrected spelling mistakes reported by checkpatch.pl
Sparse warning below:

sudo make C=2 CF=-D__CHECK_ENDIAN__ M=kernel/trace

CHECK   kernel/trace/ftrace.c
kernel/trace/ftrace.c:3007:24: warning: Using plain integer as NULL pointer
kernel/trace/ftrace.c:4758:37: warning: Using plain integer as NULL pointer

Link: http://lkml.kernel.org/r/20190323183523.GA2244@hari-Inspiron-1545

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fa79323331b2..26c8ca9bd06b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1992,7 +1992,7 @@ static void print_bug_type(void)
  * modifying the code. @failed should be one of either:
  * EFAULT - if the problem happens on reading the @ip address
  * EINVAL - if what is read at @ip is not what was expected
- * EPERM - if the problem happens on writting to the @ip address
+ * EPERM - if the problem happens on writing to the @ip address
  */
 void ftrace_bug(int failed, struct dyn_ftrace *rec)
 {
@@ -2391,7 +2391,7 @@ __ftrace_replace_code(struct dyn_ftrace *rec, int enable)
 		return ftrace_modify_call(rec, ftrace_old_addr, ftrace_addr);
 	}
 
-	return -1; /* unknow ftrace bug */
+	return -1; /* unknown ftrace bug */
 }
 
 void __weak ftrace_replace_code(int mod_flags)
@@ -3004,7 +3004,7 @@ ftrace_allocate_pages(unsigned long num_to_init)
 	int cnt;
 
 	if (!num_to_init)
-		return 0;
+		return NULL;
 
 	start_pg = pg = kzalloc(sizeof(*pg), GFP_KERNEL);
 	if (!pg)
@@ -4755,7 +4755,7 @@ static int
 ftrace_set_addr(struct ftrace_ops *ops, unsigned long ip, int remove,
 		int reset, int enable)
 {
-	return ftrace_set_hash(ops, 0, 0, ip, remove, reset, enable);
+	return ftrace_set_hash(ops, NULL, 0, ip, remove, reset, enable);
 }
 
 /**
@@ -5463,7 +5463,7 @@ void ftrace_create_filter_files(struct ftrace_ops *ops,
 
 /*
  * The name "destroy_filter_files" is really a misnomer. Although
- * in the future, it may actualy delete the files, but this is
+ * in the future, it may actually delete the files, but this is
  * really intended to make sure the ops passed in are disabled
  * and that when this function returns, the caller is free to
  * free the ops.
@@ -5786,7 +5786,7 @@ void ftrace_module_enable(struct module *mod)
 	/*
 	 * If the tracing is enabled, go ahead and enable the record.
 	 *
-	 * The reason not to enable the record immediatelly is the
+	 * The reason not to enable the record immediately is the
 	 * inherent check of ftrace_make_nop/ftrace_make_call for
 	 * correct previous instructions.  Making first the NOP
 	 * conversion puts the module to the correct state, thus
-- 
2.20.1


