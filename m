Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64591C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39639208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENTf0wur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfF1JRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:17:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35531 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfF1JRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:17:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id d126so2670289pfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnO/okTbKLvMF4T13IhMzFxc2qOpndxWZV5ih139KE8=;
        b=ENTf0wurSaZ4G3TOw3syZCTeJtx5VAl7W1KsKGHWrZAtzJU6FmyMPcHW1YFNRAKMF4
         P7WU5NUQiUzUC+cpdOTXZscbN7ORFsZYE+Qp6vDEJ3TzIiZA8HA6jsVbvcsrWjBD3FFC
         jlfD/gVQambNKQlVP8B1X8xhiTyRxCZaO8xz2GQlF1qztFBtvOOhAnVUgZRw9zppP2BR
         2tRN1foZBiNNid4Ce4a5k3dJRZLcdiFGixDSHC5kDAnx91Ociz8GSat8KJHw/WMgiB1F
         Vdu+lk3K9I+G+zAVjU1vyq0bVEB6GnXlJU4L5msJlOQfSblH49Mf6nWEJVMyqBcx+hWk
         hHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LnO/okTbKLvMF4T13IhMzFxc2qOpndxWZV5ih139KE8=;
        b=LpNb3inHTMg9BpwW5oD7hH36PRA/ilePYYweYaiK9n0Ojb9aFJvizdnhnODu860EiB
         ztS17/RdR8WNvSUE6K5aC8Xnwt1bHEfBIydnnHW/pnJJQcz51pFLQr06/47ijpnJhzmJ
         BFvBiuS6jQMDVQU9e0i8FybW0aYq8QdDc3yqY30qM5GLwQ6pzkv2NOduG1XCf7oQRftn
         /6wXMoZl8GceqICnuZ9uvyEGz38BI1cUP83ZhI2ePKSBHyF4JfIlLGTnIBfeEX5GBGNa
         F/MtwhuIvCrhRN4Ps09KfT+F+avnTK/woBjkI/J1c4xpd8qAAhoQfQGGVpFIr4f5aE9T
         oQAA==
X-Gm-Message-State: APjAAAXAees4lT4PCsT9N+VwAtK1AVC4z7HyZ++Y7aaZ6SPAuIMTfwcq
        VCw/y7mRc++7FRzeup5mvos=
X-Google-Smtp-Source: APXvYqwMvoKFF8zxW6yKAs4Paz4JkkDSOjfnsT8A5XDc1KrnK3aC3d45O112psbvrJTq3IESABXePw==
X-Received: by 2002:a17:90a:a489:: with SMTP id z9mr1653222pjp.24.1561713467642;
        Fri, 28 Jun 2019 02:17:47 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:17:47 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 28/30] locking/lockdep: Adjust selftest case for recursive read lock
Date:   Fri, 28 Jun 2019 17:15:26 +0800
Message-Id: <20190628091528.17059-29-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we support recursive read locks, a previously failed case:

 ----------------------------------------------------------------------------
                                  | spin |wlock |rlock |mutex | wsem | rsem |
   --------------------------------------------------------------------------
   mixed read-lock/lock-write ABBA:             |FAILED|             |  ok  |

can be added back. Now we have:

	Good, all 262 testcases passed!

See the case in: e91498589746065e3a ("Add mixed read-write ABBA tests")

It is worth noting that previously for the lock inversion deadlock checks,
the SUCCESS's of _rlock cases are only because the dependencies having
recursive-read locks (rlock) are not included in the graph.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 lib/locking-selftest.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index a170554..7d14d87 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -462,12 +462,13 @@ static void rwsem_ABBA3(void)
 
 /*
  * ABBA deadlock:
+ *
+ * Should fail except for either A or B is rlock.
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
+ * Should fail except for rlock.
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
+ * Should fail except for rlock.
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
+ * Should fail except for rlock.
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
+ * Should fail except for rlock.
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
+ * Should fail except for rlock.
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
@@ -2033,13 +2044,6 @@ void locking_selftest(void)
 	print_testname("mixed read-lock/lock-write ABBA");
 	pr_cont("             |");
 	dotest(rlock_ABBA1, FAILURE, LOCKTYPE_RWLOCK);
-#ifdef CONFIG_PROVE_LOCKING
-	/*
-	 * Lockdep does indeed fail here, but there's nothing we can do about
-	 * that now.  Don't kill lockdep for it.
-	 */
-	unexpected_testcase_failures--;
-#endif
 
 	pr_cont("             |");
 	dotest(rwsem_ABBA1, FAILURE, LOCKTYPE_RWSEM);
-- 
1.8.3.1

