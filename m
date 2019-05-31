Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83996C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628A02652C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfEaHmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:42:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:41322 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbfEaHmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:42:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 822B4AE15;
        Fri, 31 May 2019 07:42:07 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/3] stacktrace: Remove superfluous WARN_ONCE() from save_stack_trace_tsk_reliable()
Date:   Fri, 31 May 2019 09:41:45 +0200
Message-Id: <20190531074147.27616-2-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190531074147.27616-1-pmladek@suse.com>
References: <20190531074147.27616-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ONCE() in the generic save_stack_trace_tsk_reliable() is superfluous.

The information is passed also via the return value. The only current
user klp_check_stack() writes its own warning when the reliable stack
traces are not supported. Other eventual users might want its own error
handling as well.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 kernel/stacktrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 5667f1da3ede..8d088408928d 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -259,7 +259,6 @@ __weak int
 save_stack_trace_tsk_reliable(struct task_struct *tsk,
 			      struct stack_trace *trace)
 {
-	WARN_ONCE(1, KERN_INFO "save_stack_tsk_reliable() not implemented yet.\n");
 	return -ENOSYS;
 }
 
-- 
2.16.4

