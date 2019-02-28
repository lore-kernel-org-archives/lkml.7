Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BB6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA522084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbfB1HQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:16:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43843 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbfB1HQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:16:14 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7FjL02940318
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:15:45 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7FiVw2940315;
        Wed, 27 Feb 2019 23:15:44 -0800
Date:   Wed, 27 Feb 2019 23:15:44 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-f214737b75b0ee79763b5c058b9d5e83d711348d@git.kernel.org>
Cc:     torvalds@linux-foundation.org, longman@redhat.com,
        mingo@kernel.org, johannes@sipsolutions.net, bvanassche@acm.org,
        will.deacon@arm.com, hpa@zytor.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Reply-To: akpm@linux-foundation.org, hpa@zytor.com, will.deacon@arm.com,
          johannes@sipsolutions.net, bvanassche@acm.org,
          tglx@linutronix.de, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
          longman@redhat.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20190214230058.196511-24-bvanassche@acm.org>
References: <20190214230058.196511-24-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] lockdep/lib/tests: Test dynamic key registration
Git-Commit-ID: f214737b75b0ee79763b5c058b9d5e83d711348d
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

Commit-ID:  f214737b75b0ee79763b5c058b9d5e83d711348d
Gitweb:     https://git.kernel.org/tip/f214737b75b0ee79763b5c058b9d5e83d711348d
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:58 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:48 +0100

lockdep/lib/tests: Test dynamic key registration

Make sure that the lockdep_register_key() and lockdep_unregister_key()
code is tested when running the lockdep tests.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: johannes.berg@intel.com
Cc: tj@kernel.org
Link: https://lkml.kernel.org/r/20190214230058.196511-24-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/lib/lockdep/include/liblockdep/common.h |  2 ++
 tools/lib/lockdep/include/liblockdep/mutex.h  | 11 ++++++-----
 tools/lib/lockdep/tests/ABBA.c                |  9 +++++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/lib/lockdep/include/liblockdep/common.h b/tools/lib/lockdep/include/liblockdep/common.h
index d640a9761f09..a81d91d4fc78 100644
--- a/tools/lib/lockdep/include/liblockdep/common.h
+++ b/tools/lib/lockdep/include/liblockdep/common.h
@@ -45,6 +45,8 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 void lock_release(struct lockdep_map *lock, int nested,
 			unsigned long ip);
 void lockdep_reset_lock(struct lockdep_map *lock);
+void lockdep_register_key(struct lock_class_key *key);
+void lockdep_unregister_key(struct lock_class_key *key);
 extern void debug_check_no_locks_freed(const void *from, unsigned long len);
 
 #define STATIC_LOCKDEP_MAP_INIT(_name, _key) \
diff --git a/tools/lib/lockdep/include/liblockdep/mutex.h b/tools/lib/lockdep/include/liblockdep/mutex.h
index 2073d4e1f2f0..783dd0df06f9 100644
--- a/tools/lib/lockdep/include/liblockdep/mutex.h
+++ b/tools/lib/lockdep/include/liblockdep/mutex.h
@@ -7,6 +7,7 @@
 
 struct liblockdep_pthread_mutex {
 	pthread_mutex_t mutex;
+	struct lock_class_key key;
 	struct lockdep_map dep_map;
 };
 
@@ -27,11 +28,10 @@ static inline int __mutex_init(liblockdep_pthread_mutex_t *lock,
 	return pthread_mutex_init(&lock->mutex, __mutexattr);
 }
 
-#define liblockdep_pthread_mutex_init(mutex, mutexattr)		\
-({								\
-	static struct lock_class_key __key;			\
-								\
-	__mutex_init((mutex), #mutex, &__key, (mutexattr));	\
+#define liblockdep_pthread_mutex_init(mutex, mutexattr)			\
+({									\
+	lockdep_register_key(&(mutex)->key);				\
+	__mutex_init((mutex), #mutex, &(mutex)->key, (mutexattr));	\
 })
 
 static inline int liblockdep_pthread_mutex_lock(liblockdep_pthread_mutex_t *lock)
@@ -55,6 +55,7 @@ static inline int liblockdep_pthread_mutex_trylock(liblockdep_pthread_mutex_t *l
 static inline int liblockdep_pthread_mutex_destroy(liblockdep_pthread_mutex_t *lock)
 {
 	lockdep_reset_lock(&lock->dep_map);
+	lockdep_unregister_key(&lock->key);
 	return pthread_mutex_destroy(&lock->mutex);
 }
 
diff --git a/tools/lib/lockdep/tests/ABBA.c b/tools/lib/lockdep/tests/ABBA.c
index 623313f54720..543789bc3e37 100644
--- a/tools/lib/lockdep/tests/ABBA.c
+++ b/tools/lib/lockdep/tests/ABBA.c
@@ -14,4 +14,13 @@ void main(void)
 
 	pthread_mutex_destroy(&b);
 	pthread_mutex_destroy(&a);
+
+	pthread_mutex_init(&a, NULL);
+	pthread_mutex_init(&b, NULL);
+
+	LOCK_UNLOCK_2(a, b);
+	LOCK_UNLOCK_2(b, a);
+
+	pthread_mutex_destroy(&b);
+	pthread_mutex_destroy(&a);
 }
