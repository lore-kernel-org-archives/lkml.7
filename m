Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31F8C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AAF2073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvAU73YF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfH2Idm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:33:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33814 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbfH2Idj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:33:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id d3so1254809plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnO/okTbKLvMF4T13IhMzFxc2qOpndxWZV5ih139KE8=;
        b=dvAU73YFeJpzLajMJncBIvCNf+DA10aWeXA5+/gTQdxrveD/OVYI3C/QYloSptIMq7
         JTN6DU6tHKwRchR3PMo0eAyTbA1BPTt/Kz04S8FpFm5sHkoWszUKPvmKv5asbp2coo3o
         lLormpJ1OgCZqVYSMgKgIrrrQFKzGZl6En5rwSRzfQFZkfbQ6G1KkxfwhTUQHAGXHgqw
         Nc5DThxHwWjnGe33PDpjmhskXL4ZUM5Wk6/tbddEQzS8iGywNDKg70k3c9b5qNV9CTmj
         h7q6dESuIP8+KE7sLTeLiDD/2PTYXRIHKMo/UnyJPyxQS93NU2DwdSHzlj2zlbiGDAWc
         k4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LnO/okTbKLvMF4T13IhMzFxc2qOpndxWZV5ih139KE8=;
        b=SJyuqvj3z71UapTV1JvSFYWiTG/hFqkj01rQEN50S61jwKsZe9+5T53yQ5EprPygRf
         VN3YkOKLY87kjoFdmWGt0wmx96zf3ui1ffsvvevhu6m6K0fuyMdes0tfmCuEgUbImu+a
         vUV1ZUDzmcB4O3AIUJUWuhS3MILGsd5l6BBdyDMHhBJPNQuoueqigT8EmHA6d1VXUhKu
         Koce4u21SuBXSb0kwLdwRog8gQEigabaR0OsI/pzDQIMTsoJXduVn2ggOqd7kgtkydZ1
         PytFXkZa8ntO27RVjn86WPDVWCwJWpV47a3bEwcXAOHd7z7gxOWJ6tROykX+jB3zmQGd
         allg==
X-Gm-Message-State: APjAAAU8i+VL9fG0ZKdlQD4eLU0IjRsQQ+4a7cgBfLU2WoVtgXCLNYd7
        iRKrOeP/enbl5YbhNpBvxxc=
X-Google-Smtp-Source: APXvYqwtcYyJaN/JNvMFvwr3062BpdTwDBYXjJMfn1Uv/hfpCIXbImOLj9UwqEl6haes3qhjW3nBbQ==
X-Received: by 2002:a17:902:aa08:: with SMTP id be8mr8801354plb.144.1567067618869;
        Thu, 29 Aug 2019 01:33:38 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:33:38 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 29/30] locking/lockdep: Adjust selftest case for recursive read lock
Date:   Thu, 29 Aug 2019 16:31:31 +0800
Message-Id: <20190829083132.22394-30-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
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

