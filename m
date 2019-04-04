Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA24AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47F620820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfDDRoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:44:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15073 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729325AbfDDRnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:43:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02D663164989;
        Thu,  4 Apr 2019 17:43:45 +0000 (UTC)
Received: from llong.com (dhcp-17-19.bos.redhat.com [10.18.17.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A294B1749B;
        Thu,  4 Apr 2019 17:43:43 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v4 04/11] locking/rwsem: Micro-optimize rwsem_try_read_lock_unqueued()
Date:   Thu,  4 Apr 2019 13:43:13 -0400
Message-Id: <20190404174320.22416-5-longman@redhat.com>
In-Reply-To: <20190404174320.22416-1-longman@redhat.com>
References: <20190404174320.22416-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 04 Apr 2019 17:43:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atomic_long_cmpxchg_acquire() in rwsem_try_read_lock_unqueued() is
replaced by atomic_long_try_cmpxchg_acquire() to simpify the code and
generate slightly better assembly code. There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/locking/rwsem-xadd.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index c213869e1aa7..f6198e1a58f6 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -259,21 +259,16 @@ static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem)
  */
 static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 {
-	long old, count = atomic_long_read(&sem->count);
+	long count = atomic_long_read(&sem->count);
 
-	while (true) {
-		if (!(count == 0 || count == RWSEM_WAITING_BIAS))
-			return false;
-
-		old = atomic_long_cmpxchg_acquire(&sem->count, count,
-				      count + RWSEM_ACTIVE_WRITE_BIAS);
-		if (old == count) {
+	while (!count || count == RWSEM_WAITING_BIAS) {
+		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
+					count + RWSEM_ACTIVE_WRITE_BIAS)) {
 			rwsem_set_owner(sem);
 			return true;
 		}
-
-		count = old;
 	}
+	return false;
 }
 
 static inline bool owner_on_cpu(struct task_struct *owner)
-- 
2.18.1

