Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676C1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F89221850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbfB1HCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:02:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56553 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731161AbfB1HCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:02:36 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S722Xu2936042
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:02:02 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S721fC2936039;
        Wed, 27 Feb 2019 23:02:01 -0800
Date:   Wed, 27 Feb 2019 23:02:01 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-733000c7ffd9d9c8c4fdfd82f0d41956c8cf0537@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        paulmck@linux.vnet.ibm.com, hpa@zytor.com, mingo@kernel.org,
        longman@redhat.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, will.deacon@arm.com,
        peterz@infradead.org
Reply-To: paulmck@linux.vnet.ibm.com, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, will.deacon@arm.com,
          torvalds@linux-foundation.org, peterz@infradead.org,
          mingo@kernel.org, akpm@linux-foundation.org, longman@redhat.com
In-Reply-To: <1551057253-3231-1-git-send-email-longman@redhat.com>
References: <1551057253-3231-1-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/qspinlock: Remove unnecessary BUG_ON()
 call
Git-Commit-ID: 733000c7ffd9d9c8c4fdfd82f0d41956c8cf0537
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  733000c7ffd9d9c8c4fdfd82f0d41956c8cf0537
Gitweb:     https://git.kernel.org/tip/733000c7ffd9d9c8c4fdfd82f0d41956c8cf0537
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Sun, 24 Feb 2019 20:14:13 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:38 +0100

locking/qspinlock: Remove unnecessary BUG_ON() call

With the > 4 nesting levels case handled by the commit:

  d682b596d993 ("locking/qspinlock: Handle > 4 slowpath nesting levels")

the BUG_ON() call in encode_tail() will never actually be triggered.

Remove it.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1551057253-3231-1-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/qspinlock.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 21ee51b47961..5e9247dc2515 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -124,9 +124,6 @@ static inline __pure u32 encode_tail(int cpu, int idx)
 {
 	u32 tail;
 
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(idx > 3);
-#endif
 	tail  = (cpu + 1) << _Q_TAIL_CPU_OFFSET;
 	tail |= idx << _Q_TAIL_IDX_OFFSET; /* assume < 4 */
 
