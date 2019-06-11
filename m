Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E177C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6D6205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389804AbfFKONa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:13:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:44176 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388728AbfFKON1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:13:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32FF0AF8C;
        Tue, 11 Jun 2019 14:13:26 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com
Cc:     joe.lawrence@redhat.com, kamalesh@linux.vnet.ibm.com,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v4 3/3] livepatch: Remove duplicate warning about missing reliable stacktrace support
Date:   Tue, 11 Jun 2019 16:13:20 +0200
Message-Id: <20190611141320.25359-4-mbenes@suse.cz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611141320.25359-1-mbenes@suse.cz>
References: <20190611141320.25359-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Mladek <pmladek@suse.com>

WARN_ON_ONCE() could not be called safely under rq lock because
of console deadlock issues. Moreover WARN_ON_ONCE() is superfluous in
klp_check_stack(), because stack_trace_save_tsk_reliable() cannot return
-ENOSYS thanks to klp_have_reliable_stack() check in
klp_try_switch_task().

Signed-off-by: Petr Mladek <pmladek@suse.com>
[ mbenes: changelog edited ]
Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 kernel/livepatch/transition.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 7e7ef04689d1..cdf318d86dd6 100644
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
2.21.0

