Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D71C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB9C205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtMmW3un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfEPIBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:01:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34145 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfEPIBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:01:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id w7so1231143plz.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yHYDQ9IZ8H2C7mCEc1bmyCJDNMEW+3FaB3NaC6RhOPw=;
        b=gtMmW3unBXvsGDmrq04i3eHhgxRQ9i5y7V0oHA8nsHolUL5hgxRvhM3H3+foLq4b9D
         yOaZUT1ValRn7s4v0v+Jik/7j8Rg2Z3mZ3u6CZeMekmutIwzNsl+W4CFm9xz2xnPu1hF
         cuOZOGRsAoNbYyJVGZ4HVEoDXrcYDUL6eCOa8Mw1oIH1CsyMMRRcPUXEw/xM/VwhVEpL
         /x4HkrIaQJivAguNhV1xWSJUxqgDbh2QWn/RUePhzVWp6uWaktLRWqsYvhFsEt4TOSGs
         p04OPrwLEcj0rGSn5nLrEuXEKdOVpyZwz3OIchRzw+vkFXjo/rMdQS9a6SVcwcRKWzZe
         qrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHYDQ9IZ8H2C7mCEc1bmyCJDNMEW+3FaB3NaC6RhOPw=;
        b=JCcq6SiDibbFO9F3a45tDs6B34iy4Ha4yofV6EqyHomPXq2vTeRP23v1tlUfGf8s2z
         l78t2G0o4wSmk7LzmXZuynTr/zJCsUBuYz+MWuPdJkAFnjdrLK6DDdyrOSW05Un66yhc
         WLitaOeWTJw9vGDqfPPlk0kq0lTJYi2PIVYe+VnaD5jwwW0Kc8XxG2g2llmcyEAt8pSJ
         xW7aabPjDxq9+9WB3hdxUNcVguJJvhbl3rBp1h2DwzZN399WHomGo57cLEizq/YKEjUW
         UlCWj2KBpWRm7My3w4OQvISmkbrTFvbtY4FJ8u+d7LpyexN6nhYyk+dVP5twxD4t8Ct0
         5M1Q==
X-Gm-Message-State: APjAAAWQZgA95R6bxRP/HEkcue61BgAdmt3tmCi7rMqFEvHpwDN/8XQU
        bxk+PD5K2qDICUh+Z23frz4=
X-Google-Smtp-Source: APXvYqy9tqPr+DUdZiDSHMASjHB9LUa7AdfEAtKUNj2RV/5sxOrq3mYHjPtMaSSni3XtZqZjyC0sqQ==
X-Received: by 2002:a17:902:6a83:: with SMTP id n3mr49306197plk.109.1557993663098;
        Thu, 16 May 2019 01:01:03 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:01:02 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 11/17] locking/lockdep: Adjust lockdep selftest cases
Date:   Thu, 16 May 2019 16:00:09 +0800
Message-Id: <20190516080015.16033-12-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190516080015.16033-1-duyuyang@gmail.com>
References: <20190516080015.16033-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With read-write lock support, some read-write lock cases need to be updated,
specifically, some read-lock involved deadlocks are actually not deadlocks.
Hope I am not wildly wrong.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 lib/locking-selftest.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index a170554..f83f047 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -424,7 +424,7 @@ static void rwsem_ABBA2(void)
 	ML(Y1);
 	RSL(X1);
 	RSU(X1);
-	MU(Y1); // should fail
+	MU(Y1); // should NOT fail
 }
 
 
@@ -462,12 +462,13 @@ static void rwsem_ABBA3(void)
 
 /*
  * ABBA deadlock:
+ *
+ * Should fail except for either A or B is read lock.
  */
-
 #define E()					\
 						\
 	LOCK_UNLOCK_2(A, B);			\
-	LOCK_UNLOCK_2(B, A); /* fail */
+	LOCK_UNLOCK_2(B, A);
 
 /*
  * 6 testcases:
@@ -494,13 +495,15 @@ static void rwsem_ABBA3(void)
 
 /*
  * AB BC CA deadlock:
+ *
+ * Should fail except for read or recursive-read locks.
  */
 
 #define E()					\
 						\
 	LOCK_UNLOCK_2(A, B);			\
 	LOCK_UNLOCK_2(B, C);			\
-	LOCK_UNLOCK_2(C, A); /* fail */
+	LOCK_UNLOCK_2(C, A);
 
 /*
  * 6 testcases:
@@ -527,13 +530,15 @@ static void rwsem_ABBA3(void)
 
 /*
  * AB CA BC deadlock:
+ *
+ * Should fail except for read or recursive-read locks.
  */
 
 #define E()					\
 						\
 	LOCK_UNLOCK_2(A, B);			\
 	LOCK_UNLOCK_2(C, A);			\
-	LOCK_UNLOCK_2(B, C); /* fail */
+	LOCK_UNLOCK_2(B, C);
 
 /*
  * 6 testcases:
@@ -560,6 +565,8 @@ static void rwsem_ABBA3(void)
 
 /*
  * AB BC CD DA deadlock:
+ *
+ * Should fail except for read or recursive-read locks.
  */
 
 #define E()					\
@@ -567,7 +574,7 @@ static void rwsem_ABBA3(void)
 	LOCK_UNLOCK_2(A, B);			\
 	LOCK_UNLOCK_2(B, C);			\
 	LOCK_UNLOCK_2(C, D);			\
-	LOCK_UNLOCK_2(D, A); /* fail */
+	LOCK_UNLOCK_2(D, A);
 
 /*
  * 6 testcases:
@@ -594,13 +601,15 @@ static void rwsem_ABBA3(void)
 
 /*
  * AB CD BD DA deadlock:
+ *
+ * Should fail except for read or recursive-read locks.
  */
 #define E()					\
 						\
 	LOCK_UNLOCK_2(A, B);			\
 	LOCK_UNLOCK_2(C, D);			\
 	LOCK_UNLOCK_2(B, D);			\
-	LOCK_UNLOCK_2(D, A); /* fail */
+	LOCK_UNLOCK_2(D, A);
 
 /*
  * 6 testcases:
@@ -627,13 +636,15 @@ static void rwsem_ABBA3(void)
 
 /*
  * AB CD BC DA deadlock:
+ *
+ * Should fail except for read or recursive-read locks.
  */
 #define E()					\
 						\
 	LOCK_UNLOCK_2(A, B);			\
 	LOCK_UNLOCK_2(C, D);			\
 	LOCK_UNLOCK_2(B, C);			\
-	LOCK_UNLOCK_2(D, A); /* fail */
+	LOCK_UNLOCK_2(D, A);
 
 /*
  * 6 testcases:
@@ -1238,7 +1249,7 @@ static inline void print_testname(const char *testname)
 /*
  * 'read' variant: rlocks must not trigger.
  */
-#define DO_TESTCASE_6R(desc, name)				\
+#define DO_TESTCASE_6AA(desc, name)				\
 	print_testname(desc);					\
 	dotest(name##_spin, FAILURE, LOCKTYPE_SPIN);		\
 	dotest(name##_wlock, FAILURE, LOCKTYPE_RWLOCK);		\
@@ -1249,6 +1260,17 @@ static inline void print_testname(const char *testname)
 	dotest_rt(name##_rtmutex, FAILURE, LOCKTYPE_RTMUTEX);	\
 	pr_cont("\n");
 
+#define DO_TESTCASE_6R(desc, name)				\
+	print_testname(desc);					\
+	dotest(name##_spin, FAILURE, LOCKTYPE_SPIN);		\
+	dotest(name##_wlock, FAILURE, LOCKTYPE_RWLOCK);		\
+	dotest(name##_rlock, SUCCESS, LOCKTYPE_RWLOCK);		\
+	dotest(name##_mutex, FAILURE, LOCKTYPE_MUTEX);		\
+	dotest(name##_wsem, FAILURE, LOCKTYPE_RWSEM);		\
+	dotest(name##_rsem, SUCCESS, LOCKTYPE_RWSEM);		\
+	dotest_rt(name##_rtmutex, FAILURE, LOCKTYPE_RTMUTEX);	\
+	pr_cont("\n");
+
 #define DO_TESTCASE_2I(desc, name, nr)				\
 	DO_TESTCASE_1("hard-"desc, name##_hard, nr);		\
 	DO_TESTCASE_1("soft-"desc, name##_soft, nr);
@@ -1991,7 +2013,7 @@ void locking_selftest(void)
 	debug_locks_silent = !debug_locks_verbose;
 	lockdep_set_selftest_task(current);
 
-	DO_TESTCASE_6R("A-A deadlock", AA);
+	DO_TESTCASE_6AA("A-A deadlock", AA);
 	DO_TESTCASE_6R("A-B-B-A deadlock", ABBA);
 	DO_TESTCASE_6R("A-B-B-C-C-A deadlock", ABBCCA);
 	DO_TESTCASE_6R("A-B-C-A-B-C deadlock", ABCABC);
@@ -2048,7 +2070,7 @@ void locking_selftest(void)
 	pr_cont("             |");
 	dotest(rlock_ABBA2, SUCCESS, LOCKTYPE_RWLOCK);
 	pr_cont("             |");
-	dotest(rwsem_ABBA2, FAILURE, LOCKTYPE_RWSEM);
+	dotest(rwsem_ABBA2, SUCCESS, LOCKTYPE_RWSEM);
 
 	print_testname("mixed write-lock/lock-write ABBA");
 	pr_cont("             |");
-- 
1.8.3.1

