Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD43C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F107B20872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569447773;
	bh=AYode9PlaIC0hRrFA8rWwBDwtULCuvtmK+Py1GKxgD4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=S5gXK60dLejovcz/Bbv2dX4YsU9c2ZzaH9EYjP0VrqNOLeaA7kD180Zl0XO7gizw1
	 sZnpLPvBYBbWv7LO+acFYbHBIMY6aEur/YNntdwPlCwTmllEhJHaB91wT2lQCGRZVw
	 D2AI0EXT8TV0rE+qukZD9Rs0MVv5XW/WhWQNh5AM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfIYVmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 17:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfIYVmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:42:52 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 934A3205F4;
        Wed, 25 Sep 2019 21:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569447771;
        bh=AYode9PlaIC0hRrFA8rWwBDwtULCuvtmK+Py1GKxgD4=;
        h=From:To:Cc:Subject:Date:From;
        b=H7GatfJ063qpvrFS9alZimCNtMI9haZyoVnLX19hvI5oDk9Mi4l+gmWTtLUYaluLt
         /D7Q/A6wTAyXuMJde37ySUsE1tU+Ke9YTAcQFvVWyxuJJr1cpyPZKu2xqCc7PrKNVL
         /OQ5XIcgOmk1yXhoC3RYcZSZuSF+rr0qH09heoaM=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@redhat.com>
Subject: [PATCH] sched/vtime: Fix guest/system mis-accounting on task switch
Date:   Wed, 25 Sep 2019 23:42:42 +0200
Message-Id: <20190925214242.21873-1-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vtime_account_system() assumes that the target task to account cputime
to is always the current task. This is most often true indeed except on
task switch where we call:

	vtime_common_task_switch(prev)
		vtime_account_system(prev)

Here prev is the scheduling-out task where we account the cputime to. It
doesn't match current that is already the scheduling-in task at this
stage of the context switch.

So we end up checking the wrong task flags to determine if we are
accounting guest or system time to the previous task.

As a result the wrong task is used to check if the target is running in
guest mode. We may then spuriously account or leak either system or
guest time on task switch.

Fix this assumption and also turn vtime_guest_enter/exit() to use the
task passed in parameter as well to avoid future similar issues.

Fixes: 2a42eb9594a1 ("sched/cputime: Accumulate vtime on top of nsec clocksource")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cputime.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 2305ce89a26c..46ed4e1383e2 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -740,7 +740,7 @@ void vtime_account_system(struct task_struct *tsk)
 
 	write_seqcount_begin(&vtime->seqcount);
 	/* We might have scheduled out from guest path */
-	if (current->flags & PF_VCPU)
+	if (tsk->flags & PF_VCPU)
 		vtime_account_guest(tsk, vtime);
 	else
 		__vtime_account_system(tsk, vtime);
@@ -783,7 +783,7 @@ void vtime_guest_enter(struct task_struct *tsk)
 	 */
 	write_seqcount_begin(&vtime->seqcount);
 	__vtime_account_system(tsk, vtime);
-	current->flags |= PF_VCPU;
+	tsk->flags |= PF_VCPU;
 	write_seqcount_end(&vtime->seqcount);
 }
 EXPORT_SYMBOL_GPL(vtime_guest_enter);
@@ -794,7 +794,7 @@ void vtime_guest_exit(struct task_struct *tsk)
 
 	write_seqcount_begin(&vtime->seqcount);
 	vtime_account_guest(tsk, vtime);
-	current->flags &= ~PF_VCPU;
+	tsk->flags &= ~PF_VCPU;
 	write_seqcount_end(&vtime->seqcount);
 }
 EXPORT_SYMBOL_GPL(vtime_guest_exit);
-- 
2.21.0

