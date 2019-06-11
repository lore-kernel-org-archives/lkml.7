Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3874AC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3B520896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbfFKON2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:13:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:44164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387447AbfFKON1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:13:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3F52AF1F;
        Tue, 11 Jun 2019 14:13:25 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com
Cc:     joe.lawrence@redhat.com, kamalesh@linux.vnet.ibm.com,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v4 2/3] Revert "livepatch: Remove reliable stacktrace check in klp_try_switch_task()"
Date:   Tue, 11 Jun 2019 16:13:19 +0200
Message-Id: <20190611141320.25359-3-mbenes@suse.cz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611141320.25359-1-mbenes@suse.cz>
References: <20190611141320.25359-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1d98a69e5cef3aeb68bcefab0e67e342d6bb4dad. Commit
31adf2308f33 ("livepatch: Convert error about unsupported reliable
stacktrace into a warning") weakened the enforcement for architectures
to have reliable stack traces support. The system only warns now about
it.

It only makes sense to reintroduce the compile time checking in
klp_try_switch_task() again and bail out early.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 kernel/livepatch/transition.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 8e8c79d4b204..7e7ef04689d1 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -293,6 +293,13 @@ static bool klp_try_switch_task(struct task_struct *task)
 	if (task->patch_state == klp_target_state)
 		return true;
 
+	/*
+	 * For arches which don't have reliable stack traces, we have to rely
+	 * on other methods (e.g., switching tasks at kernel exit).
+	 */
+	if (!klp_have_reliable_stack())
+		return false;
+
 	/*
 	 * Now try to check the stack for any to-be-patched or to-be-unpatched
 	 * functions.  If all goes well, switch the task to the target patch
-- 
2.21.0

