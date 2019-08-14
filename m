Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A53C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6A4216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802729;
	bh=gpA5jfY7E5xa0KgP8ng14YmiMbhoXW6uBtPbe/8/lb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LMhs4mFXjiDOgJgRWJypR1p+xq04ALzDh13I7qaAxLPFle6bc2EBvFOToV88ONd4Y
	 bvWGmYqP9rAhXdIjljcsKw5vnKswv0EhXlSRUDfFiLv5axB8I+KBJDFYMU7Txj/c2F
	 SAvdCxbFIXxhLkS/1oJ1aLiUnyzZ2A68z1gJFUfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfHNRMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbfHNRMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:12:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 866962063F;
        Wed, 14 Aug 2019 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802726;
        bh=gpA5jfY7E5xa0KgP8ng14YmiMbhoXW6uBtPbe/8/lb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mAb0QH0QgSpeTcXbgTfFuHxRti0sEB5v74xLZ5bifT9/NSikAQ8J9XmjAFoasVobv
         xddAeD1EAg8+PHujBef2VXFGcCmlTP4y1Z03eDx2asl5YQr3b0/igmEIsJSF2IDAm4
         SiWwVW4WzBPsN4tLY1myPYuNpeComuued/RgWaPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 67/91] tty/ldsem, locking/rwsem: Add missing ACQUIRE to read_failed sleep loop
Date:   Wed, 14 Aug 2019 19:01:30 +0200
Message-Id: <20190814165752.450174976@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165748.991235624@linuxfoundation.org>
References: <20190814165748.991235624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



