Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A60C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EA920449
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfDXI4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:56:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:40114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728717AbfDXI4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:56:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2EF0AAED4;
        Wed, 24 Apr 2019 08:56:04 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/3] stacktrace: Remove superfluous WARN_ONCE() from save_stack_trace_tsk_reliable()
Date:   Wed, 24 Apr 2019 10:55:49 +0200
Message-Id: <20190424085550.29612-3-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190424085550.29612-1-pmladek@suse.com>
References: <20190424085550.29612-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ONCE() in the generic save_stack_trace_tsk_reliable() is superfluous.
The only current user klp_check_stack() writes its own warning when
-ENOSYS is returned.

Signed-off-by: Petr Mladek <pmladek@suse.com>
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

