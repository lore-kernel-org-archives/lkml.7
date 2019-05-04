Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A95C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 11:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE2B206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 11:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfEDLfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 07:35:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7723 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726529AbfEDLfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 07:35:18 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0D63F9FA47EA2DAE5D7A;
        Sat,  4 May 2019 19:35:17 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Sat, 4 May 2019
 19:35:09 +0800
From:   Cheng Jian <cj.chengjian@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <rostedt@goodmis.org>, <mingo@redhat.com>
Subject: [PATCH] ftrace: enable trampoline when rec count decrement to one
Date:   Sat, 4 May 2019 19:39:39 +0800
Message-ID: <1556969979-111047-1-git-send-email-cj.chengjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trampoline can only be enabled if there is only a single ops
attached to it. If there's only a single callback registered
to a function, and the ops has a trampoline registered for it,
then we can call the trampoline directly. This is very useful
for improving the performance of ftrace and livepatch.

But we always disable trampoline when unregister ftrace. So if
you have registered multiple ftrace_ops at the same location,
even if the other ones have been unregistered, you will no longer
be able to use trampoline.

To fix it, set FTRACE_FL_TRAMP flag if rec count is decremented
to one, and the ops that left has a trampoline.

Testing After this patch :

insmod livepatch_unshare_files.ko
cat /sys/kernel/debug/tracing/enabled_functions

	unshare_files (1) R I	tramp: 0xffffffffc0000000(klp_ftrace_handler+0x0/0xa0) ->ftrace_ops_assist_func+0x0/0xf0

echo unshare_files > /sys/kernel/debug/tracing/set_ftrace_filter
echo function > /sys/kernel/debug/tracing/current_tracer
cat /sys/kernel/debug/tracing/enabled_functions

	unshare_files (2) R I ->ftrace_ops_list_func+0x0/0x150

echo nop > /sys/kernel/debug/tracing/current_tracer
cat /sys/kernel/debug/tracing/enabled_functions

	unshare_files (1) R I	tramp: 0xffffffffc0000000(klp_ftrace_handler+0x0/0xa0) ->ftrace_ops_assist_func+0x0/0xf0

Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
---
 kernel/trace/ftrace.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b920358..bdc29c2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1626,6 +1626,11 @@ static bool test_rec_ops_needs_regs(struct dyn_ftrace *rec)
 	return  keep_regs;
 }
 
+static struct ftrace_ops *
+ftrace_find_tramp_ops_any(struct dyn_ftrace *rec);
+static struct ftrace_ops *
+ftrace_find_tramp_ops_next(struct dyn_ftrace *rec, struct ftrace_ops *ops);
+
 static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 				     int filter_hash,
 				     bool inc)
@@ -1754,15 +1759,17 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 			}
 
 			/*
-			 * If the rec had TRAMP enabled, then it needs to
-			 * be cleared. As TRAMP can only be enabled iff
-			 * there is only a single ops attached to it.
-			 * In otherwords, always disable it on decrementing.
-			 * In the future, we may set it if rec count is
-			 * decremented to one, and the ops that is left
-			 * has a trampoline.
+			 * The TRAMP needs to be set only if rec count
+			 * is decremented to one, and the ops that is
+			 * left has a trampoline. As TRAMP can only be
+			 * enabled if there is only a single ops attached
+			 * to it.
 			 */
-			rec->flags &= ~FTRACE_FL_TRAMP;
+			if (ftrace_rec_count(rec) == 1 &&
+			    ftrace_find_tramp_ops_any(rec))
+				rec->flags |= FTRACE_FL_TRAMP;
+			else
+				rec->flags &= ~FTRACE_FL_TRAMP;
 
 			/*
 			 * flags will be cleared in ftrace_check_record()
@@ -1955,11 +1962,6 @@ static void print_ip_ins(const char *fmt, const unsigned char *p)
 		printk(KERN_CONT "%s%02x", i ? ":" : "", p[i]);
 }
 
-static struct ftrace_ops *
-ftrace_find_tramp_ops_any(struct dyn_ftrace *rec);
-static struct ftrace_ops *
-ftrace_find_tramp_ops_next(struct dyn_ftrace *rec, struct ftrace_ops *ops);
-
 enum ftrace_bug_type ftrace_bug_type;
 const void *ftrace_expected;
 
-- 
2.7.4

