Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3818C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EBA208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687918;
	bh=/Vtno4sOinuAM7o/+JZ6Nhg24Km8W9CPv1Y8NJBBeOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xAzb7/qEs6y2NueQtYIEvUqNm/sCdHlUzxB3ueAT8roddKI9Y7aD7nApUW+40vGOM
	 pwxXRdhK23bFZIGKGk84EZ0tl1PIAt3t9fdJmMXvlxErWO723eQrUu3Me84l7I+p95
	 RAzO82i2+4SMipyQ3V8QpB5OGUTcqvxw3wyAiiKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfCDIZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:25:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfCDIZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:25:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 357AA20823;
        Mon,  4 Mar 2019 08:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687913;
        bh=/Vtno4sOinuAM7o/+JZ6Nhg24Km8W9CPv1Y8NJBBeOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uuuMNFPNHXC3twT/Y2sML077fXXiXYR+kvqVSo9LaIzA4Uikkhi3x3rklfjZgbxPa
         kxk9OnsNLvVHwJkYW5E8M9l69fw8FcArek2EelkhDLeEkSFnycR1yQ3QsNVhmgOTul
         jwVhdHMdy2VbLqJm8Vg2gDAvuwT9S2Apu4+ZAf70=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xie Yongji <xieyongji@baidu.com>,
        Zhang Yu <zhangyu31@baidu.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 27/52] locking/rwsem: Fix (possible) missed wakeup
Date:   Mon,  4 Mar 2019 09:22:25 +0100
Message-Id: <20190304081618.762492385@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
References: <20190304081617.159014799@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e158488be27b157802753a59b336142dc0eb0380 ]

Because wake_q_add() can imply an immediate wakeup (cmpxchg failure
case), we must not rely on the wakeup being delayed. However, commit:

  e38513905eea ("locking/rwsem: Rework zeroing reader waiter->task")

relies on exactly that behaviour in that the wakeup must not happen
until after we clear waiter->task.

[ peterz: Added changelog. ]

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: e38513905eea ("locking/rwsem: Rework zeroing reader waiter->task")
Link: https://lkml.kernel.org/r/1543495830-2644-1-git-send-email-xieyongji@baidu.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/rwsem-xadd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index a903367793758..c75017326c37a 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -198,15 +198,22 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		woken++;
 		tsk = waiter->task;
 
-		wake_q_add(wake_q, tsk);
+		get_task_struct(tsk);
 		list_del(&waiter->list);
 		/*
-		 * Ensure that the last operation is setting the reader
+		 * Ensure calling get_task_struct() before setting the reader
 		 * waiter to nil such that rwsem_down_read_failed() cannot
 		 * race with do_exit() by always holding a reference count
 		 * to the task to wakeup.
 		 */
 		smp_store_release(&waiter->task, NULL);
+		/*
+		 * Ensure issuing the wakeup (either by us or someone else)
+		 * after setting the reader waiter to nil.
+		 */
+		wake_q_add(wake_q, tsk);
+		/* wake_q_add() already take the task ref */
+		put_task_struct(tsk);
 	}
 
 	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
-- 
2.19.1



