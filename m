Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF76FC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E792087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387991AbfG3WGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:06:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44498 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387733AbfG3WGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:06:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 9633028B646
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 1/2] futex: Split key setup from key queue locking and read
Date:   Tue, 30 Jul 2019 18:06:01 -0400
Message-Id: <20190730220602.28781-1-krisman@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

split the futex key setup from the queue locking and key reading.  This
is useful to support the setup of multiple keys at the same time, like
what is done in futex_requeue() and what will be done for the
FUTEX_WAIT_MULTIPLE command.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 kernel/futex.c | 71 +++++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 6d50728ef2e7..91f3db335c57 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2631,6 +2631,39 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 	__set_current_state(TASK_RUNNING);
 }
 
+static int __futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
+			      struct futex_q *q, struct futex_hash_bucket **hb)
+{
+
+	u32 uval;
+	int ret;
+
+retry_private:
+	*hb = queue_lock(q);
+
+	ret = get_futex_value_locked(&uval, uaddr);
+
+	if (ret) {
+		queue_unlock(*hb);
+
+		ret = get_user(uval, uaddr);
+		if (ret)
+			return ret;
+
+		if (!(flags & FLAGS_SHARED))
+			goto retry_private;
+
+		return 1;
+	}
+
+	if (uval != val) {
+		queue_unlock(*hb);
+		ret = -EWOULDBLOCK;
+	}
+
+	return ret;
+}
+
 /**
  * futex_wait_setup() - Prepare to wait on a futex
  * @uaddr:	the futex userspace address
@@ -2651,7 +2684,6 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 			   struct futex_q *q, struct futex_hash_bucket **hb)
 {
-	u32 uval;
 	int ret;
 
 	/*
@@ -2672,38 +2704,19 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 	 * absorb a wakeup if *uaddr does not match the desired values
 	 * while the syscall executes.
 	 */
-retry:
-	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q->key, FUTEX_READ);
-	if (unlikely(ret != 0))
-		return ret;
-
-retry_private:
-	*hb = queue_lock(q);
+	do {
+		ret = get_futex_key(uaddr, flags & FLAGS_SHARED,
+				    &q->key, FUTEX_READ);
+		if (unlikely(ret != 0))
+			return ret;
 
-	ret = get_futex_value_locked(&uval, uaddr);
+		ret = __futex_wait_setup(uaddr, val, flags, q, hb);
 
-	if (ret) {
-		queue_unlock(*hb);
-
-		ret = get_user(uval, uaddr);
+		/* Drop key reference if retry or error. */
 		if (ret)
-			goto out;
+			put_futex_key(&q->key);
+	} while (ret > 0);
 
-		if (!(flags & FLAGS_SHARED))
-			goto retry_private;
-
-		put_futex_key(&q->key);
-		goto retry;
-	}
-
-	if (uval != val) {
-		queue_unlock(*hb);
-		ret = -EWOULDBLOCK;
-	}
-
-out:
-	if (ret)
-		put_futex_key(&q->key);
 	return ret;
 }
 
-- 
2.20.1

