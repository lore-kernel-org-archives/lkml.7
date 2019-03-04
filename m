Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA7C20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687970;
	bh=kei/RYslGCkvFTKNSf+CjLF76CVZynwBhC//EZut/lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uyDqf2rO1Ohhf7e/ORvQkSlhA0yo+I3iTR945++Xe5u5PnLnhLHee4cIV6MwlgpnF
	 vPpb/FND5RNaa/wVkfVoHeG9duZLD4wRVGXMFgeRn2NKHwwSwHVHdd1OgV5lv7NNJN
	 YX7+V2je34wjHB4wo9+l2FzVnK+hdoLwbXUpn4Uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfCDI0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:26:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfCDIZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:25:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C750208E4;
        Mon,  4 Mar 2019 08:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687909;
        bh=kei/RYslGCkvFTKNSf+CjLF76CVZynwBhC//EZut/lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4dWTe9DAH1XJ3dJrISsF7iO/McSiYnkF40SiVuve8jR7LUTEzGQ7eDx4cuhtAX/g
         0UweDLtYSsDD5Il2ofSZBasoNc/fMf4qZobUQTmkhsLj29VOd8F6U6gX1H5GlvTBws
         wcpkVtfZFIAIX36T2Uts7WZpZvqZZgpplvb/hqIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 26/52] futex: Fix (possible) missed wakeup
Date:   Mon,  4 Mar 2019 09:22:24 +0100
Message-Id: <20190304081618.710941797@linuxfoundation.org>
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

[ Upstream commit b061c38bef43406df8e73c5be06cbfacad5ee6ad ]

We must not rely on wake_q_add() to delay the wakeup; in particular
commit:

  1d0dcb3ad9d3 ("futex: Implement lockless wakeups")

moved wake_q_add() before smp_store_release(&q->lock_ptr, NULL), which
could result in futex_wait() waking before observing ->lock_ptr ==
NULL and going back to sleep again.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 1d0dcb3ad9d3 ("futex: Implement lockless wakeups")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 29d708d0b3d19..22f83064abb35 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1462,11 +1462,7 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 	if (WARN(q->pi_state || q->rt_waiter, "refusing to wake PI futex\n"))
 		return;
 
-	/*
-	 * Queue the task for later wakeup for after we've released
-	 * the hb->lock. wake_q_add() grabs reference to p.
-	 */
-	wake_q_add(wake_q, p);
+	get_task_struct(p);
 	__unqueue_futex(q);
 	/*
 	 * The waiting task can free the futex_q as soon as q->lock_ptr = NULL
@@ -1476,6 +1472,13 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 	 * plist_del in __unqueue_futex().
 	 */
 	smp_store_release(&q->lock_ptr, NULL);
+
+	/*
+	 * Queue the task for later wakeup for after we've released
+	 * the hb->lock. wake_q_add() grabs reference to p.
+	 */
+	wake_q_add(wake_q, p);
+	put_task_struct(p);
 }
 
 /*
-- 
2.19.1



