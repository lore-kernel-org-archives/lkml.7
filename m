Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A457AC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7982175B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfEZTSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbfEZTSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:18:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 691462146E;
        Sun, 26 May 2019 19:18:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUyfO-0004Xd-KI; Sun, 26 May 2019 15:18:46 -0400
Message-Id: <20190526191846.519063200@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 May 2019 15:18:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [for-next][PATCH 01/16] ftrace: Make enable and update parameters bool when applicable
References: <20190526191828.466305460@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The code modification functions have "enable" and "update" variables that
are sometimes "int" but used as "bool". Remove the ambiguity and make them
"bool" when they are only used for true or false values.

Link: http://lkml.kernel.org/r/e1429923d9eda92a3cf5ee9e33c7eacce539781d.1558115654.git.naveen.n.rao@linux.vnet.ibm.com

Reported-by: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  4 ++--
 kernel/trace/ftrace.c  | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 25e2995d4a4c..8a8cb3c401b2 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -427,8 +427,8 @@ struct dyn_ftrace *ftrace_rec_iter_record(struct ftrace_rec_iter *iter);
 	     iter = ftrace_rec_iter_next(iter))
 
 
-int ftrace_update_record(struct dyn_ftrace *rec, int enable);
-int ftrace_test_record(struct dyn_ftrace *rec, int enable);
+int ftrace_update_record(struct dyn_ftrace *rec, bool enable);
+int ftrace_test_record(struct dyn_ftrace *rec, bool enable);
 void ftrace_run_stop_machine(int command);
 unsigned long ftrace_location(unsigned long ip);
 unsigned long ftrace_location_range(unsigned long start, unsigned long end);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a12aff849c04..4f2c26bebe2a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1768,7 +1768,7 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 		count++;
 
 		/* Must match FTRACE_UPDATE_CALLS in ftrace_modify_all_code() */
-		update |= ftrace_test_record(rec, 1) != FTRACE_UPDATE_IGNORE;
+		update |= ftrace_test_record(rec, true) != FTRACE_UPDATE_IGNORE;
 
 		/* Shortcut, if we handled all records, we are done. */
 		if (!all && count == hash->count)
@@ -2047,7 +2047,7 @@ void ftrace_bug(int failed, struct dyn_ftrace *rec)
 	}
 }
 
-static int ftrace_check_record(struct dyn_ftrace *rec, int enable, int update)
+static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
 {
 	unsigned long flag = 0UL;
 
@@ -2146,28 +2146,28 @@ static int ftrace_check_record(struct dyn_ftrace *rec, int enable, int update)
 /**
  * ftrace_update_record, set a record that now is tracing or not
  * @rec: the record to update
- * @enable: set to 1 if the record is tracing, zero to force disable
+ * @enable: set to true if the record is tracing, false to force disable
  *
  * The records that represent all functions that can be traced need
  * to be updated when tracing has been enabled.
  */
-int ftrace_update_record(struct dyn_ftrace *rec, int enable)
+int ftrace_update_record(struct dyn_ftrace *rec, bool enable)
 {
-	return ftrace_check_record(rec, enable, 1);
+	return ftrace_check_record(rec, enable, true);
 }
 
 /**
  * ftrace_test_record, check if the record has been enabled or not
  * @rec: the record to test
- * @enable: set to 1 to check if enabled, 0 if it is disabled
+ * @enable: set to true to check if enabled, false if it is disabled
  *
  * The arch code may need to test if a record is already set to
  * tracing to determine how to modify the function code that it
  * represents.
  */
-int ftrace_test_record(struct dyn_ftrace *rec, int enable)
+int ftrace_test_record(struct dyn_ftrace *rec, bool enable)
 {
-	return ftrace_check_record(rec, enable, 0);
+	return ftrace_check_record(rec, enable, false);
 }
 
 static struct ftrace_ops *
@@ -2356,7 +2356,7 @@ unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec)
 }
 
 static int
-__ftrace_replace_code(struct dyn_ftrace *rec, int enable)
+__ftrace_replace_code(struct dyn_ftrace *rec, bool enable)
 {
 	unsigned long ftrace_old_addr;
 	unsigned long ftrace_addr;
@@ -2395,7 +2395,7 @@ void __weak ftrace_replace_code(int mod_flags)
 {
 	struct dyn_ftrace *rec;
 	struct ftrace_page *pg;
-	int enable = mod_flags & FTRACE_MODIFY_ENABLE_FL;
+	bool enable = mod_flags & FTRACE_MODIFY_ENABLE_FL;
 	int schedulable = mod_flags & FTRACE_MODIFY_MAY_SLEEP_FL;
 	int failed;
 
-- 
2.20.1


