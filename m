Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454E1C28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B9A26525
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfEaHmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:42:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:41352 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726933AbfEaHmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:42:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C67C4ACC4;
        Fri, 31 May 2019 07:42:08 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/3] livepatch: Remove duplicate warning about missing reliable stacktrace support
Date:   Fri, 31 May 2019 09:41:46 +0200
Message-Id: <20190531074147.27616-3-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190531074147.27616-1-pmladek@suse.com>
References: <20190531074147.27616-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON_ONCE() could not be called safely under rq lock because
of console deadlock issues.

It can be simply removed. A better descriptive message is written
in klp_enable_patch() when klp_have_reliable_stack() fails.
The remaining debug message is good enough.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/livepatch/transition.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index abb2a4a2cbb2..1bf362df76e1 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -247,7 +247,6 @@ static int klp_check_stack(struct task_struct *task, char *err_buf)
 	int ret, nr_entries;
 
 	ret = stack_trace_save_tsk_reliable(task, entries, ARRAY_SIZE(entries));
-	WARN_ON_ONCE(ret == -ENOSYS);
 	if (ret < 0) {
 		snprintf(err_buf, STACK_ERR_BUF_SIZE,
 			 "%s: %s:%d has an unreliable stack\n",
-- 
2.16.4

