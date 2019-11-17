Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9ADC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 22:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0182075C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 22:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfKQWNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 17:13:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfKQWNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 17:13:11 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 842012084D;
        Sun, 17 Nov 2019 22:13:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iWSn8-0002rM-OJ; Sun, 17 Nov 2019 17:13:10 -0500
Message-Id: <20191117221310.627810791@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 17 Nov 2019 17:13:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>
Subject: [for-next][PATCH 4/7] ftrace/selftests: Fix spelling mistake "wakeing" -> "waking"
References: <20191117221256.228674565@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a trace_printk message. As well as in
the selftests that search for this string.

Link: http://lkml.kernel.org/r/20191115085938.38947-1-colin.king@canonical.com
Link: http://lkml.kernel.org/r/20191115090356.39572-1-colin.king@canonical.com

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 samples/ftrace/ftrace-direct.c                                | 2 +-
 tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc | 2 +-
 tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 1483f067b000..a2e3063bd306 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -6,7 +6,7 @@
 
 void my_direct_func(struct task_struct *p)
 {
-	trace_printk("wakeing up %s-%d\n", p->comm, p->pid);
+	trace_printk("waking up %s-%d\n", p->comm, p->pid);
 }
 
 extern void my_tramp(void *);
diff --git a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
index cbc7a30c2e0f..d75a8695bc21 100644
--- a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
+++ b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
@@ -11,7 +11,7 @@ fi
 echo "Let the module run a little"
 sleep 1
 
-grep -q "my_direct_func: wakeing up" trace
+grep -q "my_direct_func: waking up" trace
 
 rmmod ftrace-direct
 
diff --git a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
index 017a7409b103..801ecb63e84c 100644
--- a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
+++ b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
@@ -16,7 +16,7 @@ fi
 echo "Let the module run a little"
 sleep 1
 
-grep -q "my_direct_func: wakeing up" trace
+grep -q "my_direct_func: waking up" trace
 
 rmmod ftrace-direct
 
@@ -26,7 +26,7 @@ start_direct() {
 	echo > trace
 	modprobe ftrace-direct
 	sleep 1
-	grep -q "my_direct_func: wakeing up" trace
+	grep -q "my_direct_func: waking up" trace
 }
 
 stop_direct() {
-- 
2.24.0


