Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFF5C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E6C21835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbfJIM7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:59:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50940 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731356AbfJIM7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:59:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iIBYr-0002pT-4v; Wed, 09 Oct 2019 14:59:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AFAD01C028F;
        Wed,  9 Oct 2019 14:59:19 +0200 (CEST)
Date:   Wed, 09 Oct 2019 12:59:19 -0000
From:   "tip-bot2 for Song Liu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Rework memory accounting in perf_mmap()
Cc:     Hechao Li <hechaol@fb.com>, Song Liu <songliubraving@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        <kernel-team@fb.com>, Jie Meng <jmeng@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190904214618.3795672-1-songliubraving@fb.com>
References: <20190904214618.3795672-1-songliubraving@fb.com>
MIME-Version: 1.0
Message-ID: <157062595964.9978.13325399994782902718.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     d44248a41337731a111374822d7d4451b64e73e4
Gitweb:        https://git.kernel.org/tip/d44248a41337731a111374822d7d4451b64e73e4
Author:        Song Liu <songliubraving@fb.com>
AuthorDate:    Wed, 04 Sep 2019 14:46:18 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Oct 2019 12:44:12 +02:00

perf/core: Rework memory accounting in perf_mmap()

perf_mmap() always increases user->locked_vm. As a result, "extra" could
grow bigger than "user_extra", which doesn't make sense. Here is an
example case:

(Note: Assume "user_lock_limit" is very small.)

  | # of perf_mmap calls |vma->vm_mm->pinned_vm|user->locked_vm|
  | 0                    | 0                   | 0             |
  | 1                    | user_extra          | user_extra    |
  | 2                    | 3 * user_extra      | 2 * user_extra|
  | 3                    | 6 * user_extra      | 3 * user_extra|
  | 4                    | 10 * user_extra     | 4 * user_extra|

Fix this by maintaining proper user_extra and extra.

Reviewed-By: Hechao Li <hechaol@fb.com>
Reported-by: Hechao Li <hechaol@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <kernel-team@fb.com>
Cc: Jie Meng <jmeng@fb.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190904214618.3795672-1-songliubraving@fb.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f953dd1..2b8265a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5668,7 +5668,8 @@ again:
 	 * undo the VM accounting.
 	 */
 
-	atomic_long_sub((size >> PAGE_SHIFT) + 1, &mmap_user->locked_vm);
+	atomic_long_sub((size >> PAGE_SHIFT) + 1 - mmap_locked,
+			&mmap_user->locked_vm);
 	atomic64_sub(mmap_locked, &vma->vm_mm->pinned_vm);
 	free_uid(mmap_user);
 
@@ -5812,8 +5813,20 @@ accounting:
 
 	user_locked = atomic_long_read(&user->locked_vm) + user_extra;
 
-	if (user_locked > user_lock_limit)
+	if (user_locked <= user_lock_limit) {
+		/* charge all to locked_vm */
+	} else if (atomic_long_read(&user->locked_vm) >= user_lock_limit) {
+		/* charge all to pinned_vm */
+		extra = user_extra;
+		user_extra = 0;
+	} else {
+		/*
+		 * charge locked_vm until it hits user_lock_limit;
+		 * charge the rest from pinned_vm
+		 */
 		extra = user_locked - user_lock_limit;
+		user_extra -= extra;
+	}
 
 	lock_limit = rlimit(RLIMIT_MEMLOCK);
 	lock_limit >>= PAGE_SHIFT;
