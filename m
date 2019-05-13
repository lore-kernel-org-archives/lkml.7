Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E725C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3534A21479
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSgEFRDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfEMJOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:14:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43973 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbfEMJNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:13:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id c6so6853958pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yHYDQ9IZ8H2C7mCEc1bmyCJDNMEW+3FaB3NaC6RhOPw=;
        b=TSgEFRDqbV4yo6asweU3jpq4qSl+BFyMCnpaYp+XeS3pR/qyVr3FFRzFAQYj1SXM5b
         9jA97+jRmAfnIJ6CWhOGaB+ZvgnCj1Q3vwB4CVM6H/YY2yuDlKFgn8jcBteuiZkrGD8t
         7pVNyinf+Rtb5gzMP/mjGrrHWXw5szdiDx8kEkSw6uSjCAYiAczQRSatbMvtYYtdSQXz
         4pr0QtY7MzpdDBm0znZBhVXx2McpbHXCrENuJGO515PF3EBbxCU6hrtw1eiRrM59KIhp
         +YuqIBF1bd6BHIKAotiPRIo42Qvm0lYdm+HtZXI5ZGinvcWXUFF9nre5F71dL5D59499
         NHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHYDQ9IZ8H2C7mCEc1bmyCJDNMEW+3FaB3NaC6RhOPw=;
        b=RiHODayc2goQX89ngsrQ9OT72zJb/ULOYdVAb+JPCWgyAbetVGSfT6747HbszNjVHb
         TqMWwodHPmJ0Oxd1xrPLh/UauvQWDnG/XwJC64B051JqMqEHqD6LgHk1VimP7/uTKaZb
         3V3kKHGYM+C97tLF1EOETrWuSFAURji6q4ZXsiDQWbgwoo4i+Ep2m34xHY14WPpCaW0M
         5K6VYPK22oK7idTB820R4Vvv9PaEg6kIPGJnbfDVQydVWV3z9+J8HZ6Vthak6mVVxpY0
         sTLP/bhLHi0PfoKFqqOO7jmnlpYl6EtMbxj0sQtfc6DuODDkYuP+8+8Izj5QiNqiRS/y
         8mQw==
X-Gm-Message-State: APjAAAUnPM15iQ4lpMNwTB3OBCdHQiHn0NalERYGRPnPk+85RvCsHjUf
        3FfFqfRwtr/TKKO+VALfhVM=
X-Google-Smtp-Source: APXvYqwInDUY/fZ06Dgs3rrZMqrYL4Qv4n8mkxJkKYy0XaZ5RLnE2uo0KuT9DgvJMkMiYwj/KndGQQ==
X-Received: by 2002:a62:56d9:: with SMTP id h86mr32688613pfj.195.1557738833987;
        Mon, 13 May 2019 02:13:53 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id n18sm35500837pfi.48.2019.05.13.02.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:13:53 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 11/17] locking/lockdep: Adjust lockdep selftest cases
Date:   Mon, 13 May 2019 17:11:57 +0800
Message-Id: <20190513091203.7299-12-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190513091203.7299-1-duyuyang@gmail.com>
References: <20190513091203.7299-1-duyuyang@gmail.com>
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

