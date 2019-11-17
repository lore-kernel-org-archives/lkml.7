Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F26C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 22:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DD22075C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 22:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfKQWNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 17:13:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfKQWNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 17:13:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87D720740;
        Sun, 17 Nov 2019 22:13:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iWSn9-0002so-5b; Sun, 17 Nov 2019 17:13:11 -0500
Message-Id: <20191117221311.056891660@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 17 Nov 2019 17:13:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 7/7] ftrace: Add helper find_direct_entry() to consolidate code
References: <20191117221256.228674565@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Both unregister_ftrace_direct() and modify_ftrace_direct() needs to
normalize the ip passed in to match the rec->ip, as it is acceptable to have
the ip on the ftrace call site but not the start. There are also common
validity checks with the record found by the ip, these should be done for
both unregister_ftrace_direct() and modify_ftrace_direct().

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 59 +++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9fe33ebaf914..ef79c8393f53 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5112,30 +5112,40 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 }
 EXPORT_SYMBOL_GPL(register_ftrace_direct);
 
-int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
+static struct ftrace_func_entry *find_direct_entry(unsigned long *ip)
 {
 	struct ftrace_func_entry *entry;
-	struct ftrace_direct_func *direct;
 	struct dyn_ftrace *rec;
-	int ret = -ENODEV;
 
-	mutex_lock(&direct_mutex);
+	rec = lookup_rec(*ip, *ip);
+	if (!rec)
+		return NULL;
 
-	entry = __ftrace_lookup_ip(direct_functions, ip);
+	entry = __ftrace_lookup_ip(direct_functions, rec->ip);
 	if (!entry) {
-		/* OK if it is off by a little */
-		rec = lookup_rec(ip, ip);
-		if (!rec || rec->ip == ip)
-			goto out_unlock;
+		WARN_ON(rec->flags & FTRACE_FL_DIRECT);
+		return NULL;
+	}
 
-		entry = __ftrace_lookup_ip(direct_functions, rec->ip);
-		if (!entry) {
-			WARN_ON(rec->flags & FTRACE_FL_DIRECT);
-			goto out_unlock;
-		}
+	WARN_ON(!(rec->flags & FTRACE_FL_DIRECT));
 
-		WARN_ON(!(rec->flags & FTRACE_FL_DIRECT));
-	}
+	/* Passed in ip just needs to be on the call site */
+	*ip = rec->ip;
+
+	return entry;
+}
+
+int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
+{
+	struct ftrace_direct_func *direct;
+	struct ftrace_func_entry *entry;
+	int ret = -ENODEV;
+
+	mutex_lock(&direct_mutex);
+
+	entry = find_direct_entry(&ip);
+	if (!entry)
+		goto out_unlock;
 
 	if (direct_functions->count == 1)
 		unregister_ftrace_function(&direct_ops);
@@ -5187,24 +5197,13 @@ int modify_ftrace_direct(unsigned long ip,
 			 unsigned long old_addr, unsigned long new_addr)
 {
 	struct ftrace_func_entry *entry;
-	struct dyn_ftrace *rec;
 	int ret = -ENODEV;
 
 	mutex_lock(&direct_mutex);
-	entry = __ftrace_lookup_ip(direct_functions, ip);
-	if (!entry) {
-		/* OK if it is off by a little */
-		rec = lookup_rec(ip, ip);
-		if (!rec || rec->ip == ip)
-			goto out_unlock;
-
-		entry = __ftrace_lookup_ip(direct_functions, rec->ip);
-		if (!entry)
-			goto out_unlock;
 
-		ip = rec->ip;
-		WARN_ON(!(rec->flags & FTRACE_FL_DIRECT));
-	}
+	entry = find_direct_entry(&ip);
+	if (!entry)
+		goto out_unlock;
 
 	ret = -EINVAL;
 	if (entry->direct != old_addr)
-- 
2.24.0


