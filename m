Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84970C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC712089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfFUOgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:36:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55105 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfFUOgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:36:50 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1heKel-0004et-Bn; Fri, 21 Jun 2019 16:36:47 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] posix-timers: Remove "it_signal = NULL" assignment in itimer_delete()
Date:   Fri, 21 Jun 2019 16:36:42 +0200
Message-Id: <20190621143643.25649-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621143643.25649-1-bigeasy@linutronix.de>
References: <20190621143643.25649-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

itimer_delete() is invoked during do_exit(). At this point it is the
last thread in the group dying and doing the clean up.
Since it is the last thread in the group, there can not be any other
task attempting to lock the itimer which means the NULL assignment (which
avoids lookups in __lock_timer()) is not required.

The assignment and comment was copied in commit 0e568881178ff ("[PATCH]
fix posix-timers to have proper per-process scope") from
sys_timer_delete() which was/is the syscall interface and requires the
assignment.

Remove the superfluous ->it_signal = NULL assignment.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/posix-timers.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 29176635991f0..caa63e58e3d88 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -990,11 +990,6 @@ static void itimer_delete(struct k_itimer *timer)
 		goto retry_delete;
 	}
 	list_del(&timer->list);
-	/*
-	 * This keeps any tasks waiting on the spin lock from thinking
-	 * they got something (see the lock code above).
-	 */
-	timer->it_signal = NULL;
 
 	unlock_timer(timer, flags);
 	release_posix_timer(timer, IT_ID_SET);
-- 
2.20.1

