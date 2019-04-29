Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F38BC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D9320675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfD2O4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:56:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:59478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728339AbfD2O4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:56:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63F54AB6D;
        Mon, 29 Apr 2019 14:56:29 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH] stacktrace: Remove superfluous WARN_ONCE() from save_stack_trace_tsk_reliable()
Date:   Mon, 29 Apr 2019 16:56:24 +0200
Message-Id: <20190429145624.27746-1-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ONCE() in the generic save_stack_trace_tsk_reliable() is superfluous.
The only current user klp_check_stack() writes its own warning when
-ENOSYS is returned.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 kernel/stacktrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index f8edee9c792d..83ac0ac5ffd9 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -74,6 +74,5 @@ __weak int
 save_stack_trace_tsk_reliable(struct task_struct *tsk,
 			      struct stack_trace *trace)
 {
-	WARN_ONCE(1, KERN_INFO "save_stack_tsk_reliable() not implemented yet.\n");
 	return -ENOSYS;
 }
-- 
2.16.4

