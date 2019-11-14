Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6DDC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874962072C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfKNSTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:19:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfKNSS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55C0E20855;
        Thu, 14 Nov 2019 18:18:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhK-00018H-IE; Thu, 14 Nov 2019 13:18:26 -0500
Message-Id: <20191114181826.444059437@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Divya Indi <divya.indi@oracle.com>
Subject: [for-next][PATCH 21/33] tracing: Verify if trace array exists before destroying it.
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Divya Indi <divya.indi@oracle.com>

A trace array can be destroyed from userspace or kernel. Verify if the
trace array exists before proceeding to destroy/remove it.

Link: http://lkml.kernel.org/r/1565805327-579-3-git-send-email-divya.indi@oracle.com

Reviewed-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Signed-off-by: Divya Indi <divya.indi@oracle.com>
[ Removed unneeded braces ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/module.c      |  6 +++++-
 kernel/trace/trace.c | 15 ++++++++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index ff2d7359a418..6e2fd40a6ed9 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3728,7 +3728,6 @@ static int complete_formation(struct module *mod, struct load_info *info)
 
 	module_enable_ro(mod, false);
 	module_enable_nx(mod);
-	module_enable_x(mod);
 
 	/* Mark state as coming so strong_try_module_get() ignores us,
 	 * but kallsyms etc. can see us. */
@@ -3751,6 +3750,11 @@ static int prepare_coming_module(struct module *mod)
 	if (err)
 		return err;
 
+	/* Make module executable after ftrace is enabled */
+	mutex_lock(&module_mutex);
+	module_enable_x(mod);
+	mutex_unlock(&module_mutex);
+
 	blocking_notifier_call_chain(&module_notify_list,
 				     MODULE_STATE_COMING, mod);
 	return 0;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index db7d06a26861..fa4f742fc449 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8556,17 +8556,26 @@ static int __remove_instance(struct trace_array *tr)
 	return 0;
 }
 
-int trace_array_destroy(struct trace_array *tr)
+int trace_array_destroy(struct trace_array *this_tr)
 {
+	struct trace_array *tr;
 	int ret;
 
-	if (!tr)
+	if (!this_tr)
 		return -EINVAL;
 
 	mutex_lock(&event_mutex);
 	mutex_lock(&trace_types_lock);
 
-	ret = __remove_instance(tr);
+	ret = -ENODEV;
+
+	/* Making sure trace array exists before destroying it. */
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (tr == this_tr) {
+			ret = __remove_instance(tr);
+			break;
+		}
+	}
 
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
-- 
2.23.0


