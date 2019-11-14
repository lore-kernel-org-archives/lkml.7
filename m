Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33381C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198AD20727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfKNSUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:20:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727538AbfKNSSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:25 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B6852084B;
        Thu, 14 Nov 2019 18:18:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhI-00010J-8c; Thu, 14 Nov 2019 13:18:24 -0500
Message-Id: <20191114181824.153629115@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 05/33] ftrace: Separate out functionality from ftrace_location_range()
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Create a new function called lookup_rec() from the functionality of
ftrace_location_range(). The difference between lookup_rec() is that it
returns the record that it finds, where as ftrace_location_range() returns
only if it found a match or not.

The lookup_rec() is static, and can be used for new functionality where
ftrace needs to find a record of a specific address.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 76e5de8c7822..b0e7f03919de 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1541,6 +1541,26 @@ static int ftrace_cmp_recs(const void *a, const void *b)
 	return 0;
 }
 
+static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
+{
+	struct ftrace_page *pg;
+	struct dyn_ftrace *rec = NULL;
+	struct dyn_ftrace key;
+
+	key.ip = start;
+	key.flags = end;	/* overload flags, as it is unsigned long */
+
+	for (pg = ftrace_pages_start; pg; pg = pg->next) {
+		if (end < pg->records[0].ip ||
+		    start >= (pg->records[pg->index - 1].ip + MCOUNT_INSN_SIZE))
+			continue;
+		rec = bsearch(&key, pg->records, pg->index,
+			      sizeof(struct dyn_ftrace),
+			      ftrace_cmp_recs);
+	}
+	return rec;
+}
+
 /**
  * ftrace_location_range - return the first address of a traced location
  *	if it touches the given ip range
@@ -1555,23 +1575,11 @@ static int ftrace_cmp_recs(const void *a, const void *b)
  */
 unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 {
-	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
-	struct dyn_ftrace key;
 
-	key.ip = start;
-	key.flags = end;	/* overload flags, as it is unsigned long */
-
-	for (pg = ftrace_pages_start; pg; pg = pg->next) {
-		if (end < pg->records[0].ip ||
-		    start >= (pg->records[pg->index - 1].ip + MCOUNT_INSN_SIZE))
-			continue;
-		rec = bsearch(&key, pg->records, pg->index,
-			      sizeof(struct dyn_ftrace),
-			      ftrace_cmp_recs);
-		if (rec)
-			return rec->ip;
-	}
+	rec = lookup_rec(start, end);
+	if (rec)
+		return rec->ip;
 
 	return 0;
 }
-- 
2.23.0


