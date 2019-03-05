Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DF9C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E042082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfCELOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:14:40 -0500
Received: from mx57.baidu.com ([61.135.168.57]:40931 "EHLO
        tc-sys-mailedm04.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727348AbfCELOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:14:40 -0500
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm04.tc.baidu.com (Postfix) with ESMTP id B62E1236C03A;
        Tue,  5 Mar 2019 19:14:26 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     paul@paul-moore.com, eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] audit: fix a memleak caused by auditing load module
Date:   Tue,  5 Mar 2019 19:14:26 +0800
Message-Id: <1551784466-15610-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we should always free context->module.name, since it will be
allocated unconditionally and audit_log_start() can fail with
other reasons, and audit_log_exit maybe not called

unreferenced object 0xffff88af90837d20 (size 8):
  comm "modprobe", pid 1036, jiffies 4294704867 (age 3069.138s)
  hex dump (first 8 bytes):
    69 78 67 62 65 00 ff ff                          ixgbe...
  backtrace:
    [<0000000008da28fe>] __audit_log_kern_module+0x33/0x80
    [<00000000c1491e61>] load_module+0x64f/0x3850
    [<000000007fc9ae3f>] __do_sys_init_module+0x218/0x250
    [<0000000000d4a478>] do_syscall_64+0x117/0x400
    [<000000004924ded8>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<000000007dc331dd>] 0xffffffffffffffff

Fixes: ca86cad7380e3 ("audit: log module name on init_module")
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 kernel/auditsc.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b2d1f043f..2bd80375f 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1186,8 +1186,13 @@ static void show_special(struct audit_context *context, int *call_panic)
 	int i;
 
 	ab = audit_log_start(context, GFP_KERNEL, context->type);
-	if (!ab)
+	if (!ab) {
+		if (context->type == AUDIT_KERN_MODULE) {
+			kfree(context->module.name);
+			context->module.name = NULL;
+		}
 		return;
+	}
 
 	switch (context->type) {
 	case AUDIT_SOCKETCALL: {
@@ -1354,8 +1359,15 @@ static void audit_log_exit(struct audit_context *context, struct task_struct *ts
 	context->personality = tsk->personality;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_SYSCALL);
-	if (!ab)
+
+	if (!ab) {
+		if (context->type == AUDIT_KERN_MODULE) {
+			kfree(context->module.name);
+			context->module.name = NULL;
+		}
 		return;		/* audit_panic has been called */
+	}
+
 	audit_log_format(ab, "arch=%x syscall=%d",
 			 context->arch, context->major);
 	if (context->personality != PER_LINUX)
@@ -1576,6 +1588,12 @@ void __audit_syscall_exit(int success, long return_code)
 
 	if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
 		audit_log_exit(context, current);
+	else {
+		if (context->type == AUDIT_KERN_MODULE) {
+			kfree(context->module.name);
+			context->module.name = NULL;
+		}
+	}
 
 	context->in_syscall = 0;
 	context->prio = context->state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
-- 
2.16.2

