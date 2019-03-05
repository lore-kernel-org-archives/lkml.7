Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C53BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF202133F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfCENxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:53:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbfCENws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:52:48 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 241782146E;
        Tue,  5 Mar 2019 13:52:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1h1AUw-00030G-9D; Tue, 05 Mar 2019 08:52:46 -0500
Message-Id: <20190305135246.180038284@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 05 Mar 2019 08:52:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>
Subject: [for-next][PATCH 3/6] tracing/perf: Use strndup_user() instead of buggy open-coded version
References: <20190305135223.360347148@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

The first version of this method was missing the check for
`ret == PATH_MAX`; then such a check was added, but it didn't call kfree()
on error, so there was still a small memory leak in the error case.
Fix it by using strndup_user() instead of open-coding it.

Link: http://lkml.kernel.org/r/20190220165443.152385-1-jannh@google.com

Cc: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 0eadcc7a7bc0 ("perf/core: Fix perf_uprobe_init()")
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_event_perf.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 76217bbef815..4629a6104474 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -299,15 +299,13 @@ int perf_uprobe_init(struct perf_event *p_event,
 
 	if (!p_event->attr.uprobe_path)
 		return -EINVAL;
-	path = kzalloc(PATH_MAX, GFP_KERNEL);
-	if (!path)
-		return -ENOMEM;
-	ret = strncpy_from_user(
-		path, u64_to_user_ptr(p_event->attr.uprobe_path), PATH_MAX);
-	if (ret == PATH_MAX)
-		return -E2BIG;
-	if (ret < 0)
-		goto out;
+
+	path = strndup_user(u64_to_user_ptr(p_event->attr.uprobe_path),
+			    PATH_MAX);
+	if (IS_ERR(path)) {
+		ret = PTR_ERR(path);
+		return (ret == -EINVAL) ? -E2BIG : ret;
+	}
 	if (path[0] == '\0') {
 		ret = -EINVAL;
 		goto out;
-- 
2.20.1


