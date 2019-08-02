Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD950C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DE321773
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752268;
	bh=HvD/qzUhWbepe+2VChrWLdghe6Gyg9J8+kUejSTpJhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QMbrZ1zN8hfsoN0B16OmhgGnAg2MiUuYJ0EWGqjG5EYO7zqqk9kqKa5NQLxbnlb7/
	 n9nrC9IGUN/bmfWo3Jy4HgT26A0cNftD0FX0MpspMQ9Zjzan9iFsBqNTJ/J66mnVLv
	 tVv1Q5TB0p35nEYUaC5q3Ubx7ddm5ZbMRqevSQFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391105AbfHBNY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394082AbfHBNYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:24:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52774217D4;
        Fri,  2 Aug 2019 13:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752257;
        bh=HvD/qzUhWbepe+2VChrWLdghe6Gyg9J8+kUejSTpJhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1e2lRk0IvBapLZYS4KXroLCVZrrqPhM2PKX/Er1aQwvuKw2Pr8fv8ovpx02DAmJ05
         b2LtjVFwT2rLFk/6DaEHRbBSrbJ16KGtM389aCYVmHUTvKkahiLax6tSGF9Umft5DO
         +YKNX9tCDqRuN7hRwgYAleEHRi9iQch1y3npnf5I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 40/42] tty/ldsem, locking/rwsem: Add missing ACQUIRE to read_failed sleep loop
Date:   Fri,  2 Aug 2019 09:23:00 -0400
Message-Id: <20190802132302.13537-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802132302.13537-1-sashal@kernel.org>
References: <20190802132302.13537-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 952041a8639a7a3a73a2b6573cb8aa8518bc39f8 ]

While reviewing rwsem down_slowpath, Will noticed ldsem had a copy of
a bug we just found for rwsem.

  X = 0;

  CPU0			CPU1

  rwsem_down_read()
    for (;;) {
      set_current_state(TASK_UNINTERRUPTIBLE);

                        X = 1;
                        rwsem_up_write();
                          rwsem_mark_wake()
                            atomic_long_add(adjustment, &sem->count);
                            smp_store_release(&waiter->task, NULL);

      if (!waiter.task)
        break;

      ...
    }

  r = X;

Allows 'r == 0'.

Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 4898e640caf0 ("tty: Add timed, writer-prioritized rw semaphore")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_ldsem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
index b989ca26fc788..2f0372976459e 100644
--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -116,8 +116,7 @@ static void __ldsem_wake_readers(struct ld_semaphore *sem)
 
 	list_for_each_entry_safe(waiter, next, &sem->read_wait, list) {
 		tsk = waiter->task;
-		smp_mb();
-		waiter->task = NULL;
+		smp_store_release(&waiter->task, NULL);
 		wake_up_process(tsk);
 		put_task_struct(tsk);
 	}
@@ -217,7 +216,7 @@ down_read_failed(struct ld_semaphore *sem, long count, long timeout)
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 
-		if (!waiter.task)
+		if (!smp_load_acquire(&waiter.task))
 			break;
 		if (!timeout)
 			break;
-- 
2.20.1

