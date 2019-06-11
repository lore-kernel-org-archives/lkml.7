Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E257C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80D420896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbfFKONh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:13:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:44152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728309AbfFKON1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:13:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62D89AEEE;
        Tue, 11 Jun 2019 14:13:25 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com
Cc:     joe.lawrence@redhat.com, kamalesh@linux.vnet.ibm.com,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 1/3] stacktrace: Remove weak version of save_stack_trace_tsk_reliable()
Date:   Tue, 11 Jun 2019 16:13:18 +0200
Message-Id: <20190611141320.25359-2-mbenes@suse.cz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611141320.25359-1-mbenes@suse.cz>
References: <20190611141320.25359-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent rework of stack trace infrastructure introduced a new set of
helpers for common stack trace operations (commit e9b98e162aa5
("stacktrace: Provide helpers for common stack trace operations") and
related). As a result, save_stack_trace_tsk_reliable() is not directly
called anywhere. Livepatch, currently the only user of the reliable
stack trace feature, now calls stack_trace_save_tsk_reliable().

When CONFIG_HAVE_RELIABLE_STACKTRACE is set and depending on
CONFIG_ARCH_STACKWALK, stack_trace_save_tsk_reliable() calls either
arch_stack_walk_reliable() or mentioned save_stack_trace_tsk_reliable().
x86_64 defines the former, ppc64le the latter. All other architectures
do not have HAVE_RELIABLE_STACKTRACE and include/linux/stacktrace.h
defines -ENOSYS returning version for them.

In short, stack_trace_save_tsk_reliable() returning -ENOSYS defined in
include/linux/stacktrace.h serves the same purpose as the old weak
version of save_stack_trace_tsk_reliable() which is therefore no longer
needed.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 kernel/stacktrace.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 36139de0a3c4..0c3f00db9069 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -255,14 +255,6 @@ save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 	WARN_ONCE(1, KERN_INFO "save_stack_trace_regs() not implemented yet.\n");
 }
 
-__weak int
-save_stack_trace_tsk_reliable(struct task_struct *tsk,
-			      struct stack_trace *trace)
-{
-	WARN_ONCE(1, KERN_INFO "save_stack_tsk_reliable() not implemented yet.\n");
-	return -ENOSYS;
-}
-
 /**
  * stack_trace_save - Save a stack trace into a storage array
  * @store:	Pointer to storage array
-- 
2.21.0

