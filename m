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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A57C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBE62073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFc3dDYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfH2Idq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:33:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37904 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbfH2Ido (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:33:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id w11so1253728plp.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ymnwIrQm3GLsrCHL+AiS6np4V8kjEkqw3aVn58Jh3RQ=;
        b=kFc3dDYhHpPa7jbv5v3AnAM1kGZSWbfBfZqOWcsY5bzcvyeTFdrm4Z/Y+1AWkp6B5L
         BzY+f0VDZtss1bVuWghY4FQ2WCgMjFX9A8UMjfYsTvQk551ufQRT8s9CNyB6V75FbjSl
         qgQ/T/F6wQ9E2TXBYmSYGANsRWpCaqd8uqg9YTkkoBCMmztADzj9Fk/bTK7+HcxiO6GE
         zA6+K4msTe2X90JdwXiCrhP3DeC0W4YgXCHj0b3Ci1bhMFSpyHSf5T22d63fIP13xXP0
         1T5GZQkvu284OSNE/fqx+L5xHgfcOOEE/iQImbh93Wwqc0kdH2Wgmlgj1stL6JGVlbuR
         tNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ymnwIrQm3GLsrCHL+AiS6np4V8kjEkqw3aVn58Jh3RQ=;
        b=RibdT5Jj0PehdfAojEmDLRLxTdm/yteH2GS8uMvv8J7APNZGVwyX0EZ+yNEBzNuQan
         AWAwjpeB6i6nQ2Cd7Sbp2homthQP0eFll3o6dZm+woBCDqq8+tppv62v3TPrA2W/A3k3
         2yitoUzN91UTmjYVF534nkdcMyMG3b3Yi43u7Ba9KioqyeYC6azFRx757V3x/l3i820r
         DqQtKFIv+nPTU9pUUSQhiTgZGtkvOiCDOGTZpzPgMIiUyWuSWQLZiXFzdXAqe2VhLj7g
         oCcmZSzjyneulMzSz+yDdU+2rHPbZ5jmDwWpYVdlmu0u7VYb0j/6NWokgtMMUz4M+eCV
         LBUg==
X-Gm-Message-State: APjAAAUyBfh+2wYbQ7j0RK0sUuDHIOrXNgl+VObUDyohUT+dtrUkl6uj
        dmgEwzsa+N8OoNv37dYRobY=
X-Google-Smtp-Source: APXvYqzc1wCFuu+cGJEN6VYUIyHE2tqFx8Td2eYelLaXtY8TrlRKGPMjO6lv6vnihTxFlzr89ELPow==
X-Received: by 2002:a17:902:6a:: with SMTP id 97mr8671626pla.257.1567067623129;
        Thu, 29 Aug 2019 01:33:43 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:33:42 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 30/30] locking/lockdep: Add more lockdep selftest cases
Date:   Thu, 29 Aug 2019 16:31:32 +0800
Message-Id: <20190829083132.22394-31-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lets make sure our 13 cases can be correctly handled. Some cases are
missing because we currently don't have such locks or annotated
correctly to implement the cases.

----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
   read-write lock ABBA Case #1.1:             |  ok  |
   read-write lock ABBA Case #1.2:             |  ok  |
  read-write lock ABBA Case #2.1a:                                  | ok  |
  read-write lock ABBA Case #2.1b:                                  | ok  |
  read-write lock ABBA Case #2.2a:                                  | ok  |
  read-write lock ABBA Case #2.2b:                                  | ok  |
  read-write lock ABBA Case #4.1a:                                  | ok  |
  read-write lock ABBA Case #4.1b:                                  | ok  |
  read-write lock ABBA Case #4.2a:                                  | ok  |
  read-write lock ABBA Case #4.2b:                                  | ok  |
   read-write lock ABBA Case #6.1:             |  ok  |
  read-write lock ABBA Case #6.2a:             |  ok  |
  read-write lock ABBA Case #6.2b:             |  ok  |
   read-write lock ABBA Case #6.3:             |  ok  |
  read-write lock ABBA Case #7.1a:             |  ok  |
  read-write lock ABBA Case #7.1b:             |  ok  |
  read-write lock ABBA Case #7.2a:             |  ok  |
  read-write lock ABBA Case #7.2b:             |  ok  |
    read-write lock ABBA Case #8a:                                  | ok  |
    read-write lock ABBA Case #8b:                                  | ok  |
    read-write lock ABBA Case #8c:                                  | ok  |
    read-write lock ABBA Case #8d:                                  | ok  |
  read-write lock ABBA Case #9.1a:             |  ok  |
  read-write lock ABBA Case #9.1b:             |  ok  |
  read-write lock ABBA Case #9.2a:             |  ok  |
  read-write lock ABBA Case #9.2b:             |  ok  |
   read-write lock ABBA Case #10a:             |  ok  |             | ok  |
   read-write lock ABBA Case #10b:             |  ok  |             | ok  |
   read-write lock ABBA Case #10c:             |  ok  |             | ok  |
   read-write lock ABBA Case #10d:             |  ok  |             | ok  |
    read-write lock ABBA Case #11:             |  ok  |
   read-write lock ABBA Case #12a:             |  ok  |
   read-write lock ABBA Case #12b:             |  ok  |
   read-write lock ABBA Case #12c:             |  ok  |
   read-write lock ABBA Case #12d:             |  ok  |
   read-write lock ABBA Case #12e:             |  ok  |
   read-write lock ABBA Case #12f:             |  ok  |
  read-write lock ABBA Case #13.1:             |  ok  |
  read-write lock ABBA Case #13.2:             |  ok  |
  --------------------------------------------------------------------------

Now this patch marks the finish of the implementation of the read-write
lock detection algorithm. With recursive-read lock dependencies in
graph, there may be new deadlock scenarios that have never been able to
be discovered before. Admittedly, they include both true and possibly
false positives. Have fun and brace for impact!

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 lib/locking-selftest.c | 1077 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1077 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 7d14d87..4fb6ab6 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -461,6 +461,919 @@ static void rwsem_ABBA3(void)
 }
 
 /*
+ * Read-write lock ABBA cases.
+ *
+ * Notation:
+ *  W:  write lock
+ *  R:  read lock
+ *  RR: recursive-read lock
+ *  X:  either write, read, or recursive-read lock
+ */
+
+/*
+ * Lock dependencies in one chain vs. in different chains
+ * ------------------------------------------------------
+ *
+ * Case #1.1:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     W1
+ *     RR2       W3
+ *     W3        W1   [Deadlock]
+ *
+ * Case #1.2:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     W1
+ *     RR2
+ *
+ *     (W1 RR2 released
+ *      in T1)
+ *
+ *     RR2       W3
+ *     W3        W1   [No deadlock]
+ *
+ * Case #1.3:
+ *
+ *     T1a       T1b       T2
+ *     ---       ---       --
+ *
+ *     W1        RR2       W3
+ *     RR2       W3        W1   [No deadlock]
+ */
+static void rlock_ABBA_case1_1(void)
+{
+	WL(X1);
+	RL(Y1);
+	WL(Z1);
+	WU(Z1);
+	RU(Y1);
+	WU(X1);
+
+	RL(Z1);
+	RL(X1);
+	RU(X1);
+	RU(Z1);
+}
+
+static void rlock_ABBA_case1_2(void)
+{
+	WL(X1);
+	RL(Y1);
+	RU(Y1);
+	WU(X1);
+
+	RL(Y1);
+	WL(Z1);
+	WU(Z1);
+	RU(Y1);
+
+	RL(Z1);
+	RL(X1);
+	RU(X1);
+	RU(Z1);
+}
+
+/*
+ * When the final dependency is ended with read lock and read lock
+ * ---------------------------------------------------------------
+ *
+ * Case #2.1:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     X1        R2
+ *     W2        R1   [Deadlock]
+ *
+ * Case #2.2:
+ *
+ *     T1        T2
+ *
+ *     X1        R2
+ *     R2        R1   [Deadlock]
+ *
+ * Case #2.3:
+ *
+ *     T1        T2
+ *
+ *     X1        R2
+ *     RR2       R1   [No deadlock]
+ */
+
+static void rwsem_ABBA_case2_1a(void)
+{
+	WSL(X1);
+	WSL(Y1);
+	WSU(Y1);
+	WSU(X1);
+
+	RSL(Y1);
+	RSL(X1);
+	RSU(X1);
+	RSU(Y1);
+}
+
+static void rwsem_ABBA_case2_1b(void)
+{
+	RSL(X1);
+	WSL(Y1);
+	WSU(Y1);
+	RSU(X1);
+
+	RSL(Y1);
+	RSL(X1);
+	RSU(X1);
+	RSU(Y1);
+}
+
+static void rwsem_ABBA_case2_2a(void)
+{
+	WSL(X1);
+	RSL(Y1);
+	RSU(Y1);
+	WSU(X1);
+
+	RSL(Y1);
+	RSL(X1);
+	RSU(X1);
+	RSU(Y1);
+}
+
+static void rwsem_ABBA_case2_2b(void)
+{
+	RSL(X1);
+	RSL(Y1);
+	RSU(Y1);
+	RSU(X1);
+
+	RSL(Y1);
+	RSL(X1);
+	RSU(X1);
+	RSU(Y1);
+}
+
+/*
+ * When the final dependency is read lock and recursive-read lock
+ * --------------------------------------------------------------
+ *
+ * Case #3.1:
+ *
+ *     T1        T2
+ *
+ *     W1        R2
+ *     X2        RR1   [Deadlock]
+ *
+ * Case #3.2:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     R1        R2
+ *     X2        RR1   [No deadlock]
+ *
+ * Case #3.3:
+ *
+ *     T1        T2
+ *
+ *     RR1       R2
+ *     X2        RR1   [No deadlock]
+ */
+
+/*
+ * When the final dependency is read lock and write lock
+ * -----------------------------------------------------
+ *
+ * Case #4.1:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     X1        R2
+ *     R2        W1   [Deadlock]
+ *
+ * Case #4.2:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     X1        R2
+ *     W2        W1   [Deadlock]
+ *
+ * Case #4.3:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     X1        R2
+ *     RR2       W1   [No deadlock]
+ */
+
+static void rwsem_ABBA_case4_1a(void)
+{
+	WSL(X1);
+	RSL(Y1);
+	RSU(Y1);
+	WSU(X1);
+
+	RSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	RSU(Y1);
+}
+
+static void rwsem_ABBA_case4_1b(void)
+{
+	RSL(X1);
+	RSL(Y1);
+	RSU(Y1);
+	RSU(X1);
+
+	RSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	RSU(Y1);
+}
+
+static void rwsem_ABBA_case4_2a(void)
+{
+	WSL(X1);
+	WSL(Y1);
+	WSU(Y1);
+	WSU(X1);
+
+	RSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	RSU(Y1);
+}
+
+static void rwsem_ABBA_case4_2b(void)
+{
+	RSL(X1);
+	WSL(Y1);
+	WSU(Y1);
+	RSU(X1);
+
+	RSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	RSU(Y1);
+}
+
+/*
+ * When the final dependency is recursive-read lock and read lock
+ * --------------------------------------------------------------
+ *
+ * Case #5.1:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     X1        RR2
+ *     R2        R1   [Deadlock]
+ *
+ * Case #5.2:
+ *
+ *     T1        T2
+ *
+ *     X1        RR2
+ *     W2        R1   [Deadlock]
+ *
+ * Case #5.3:
+ *
+ *     T1        T2
+ *
+ *     X1        RR2
+ *     RR2       R1   [No deadlock]
+ */
+
+/*
+ * When the final dependency is recursive-read lock and recursive-read lock
+ * ------------------------------------------------------------------------
+ *
+ * Case #6.1:
+ *
+ *     T1        T2
+ *
+ *     W1        RR2
+ *     W2        RR1   [Deadlock]
+ *
+ * Case #6.2:
+ *
+ *     T1        T2
+ *
+ *     RR1       RR2
+ *     X2        RR1   [No deadlock]
+ *
+ * Case #6.3:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     X1        RR2
+ *     RR2       RR1   [No deadlock]
+ *
+ * Case #6.4:
+ *
+ *     T1        T2
+ *
+ *     W1        RR2
+ *     R2        RR1   [Deadlock]
+ *
+ * Case #6.5:
+ *
+ *     T1        T2
+ *
+ *     R1        RR2
+ *     X2        RR1   [No deadlock]
+ */
+
+static void rlock_ABBA_case6_1(void)
+{
+	WL(X1);
+	WL(Y1);
+	WU(Y1);
+	WU(X1);
+
+	RL(Y1);
+	RL(X1);
+	RU(X1);
+	RU(Y1);
+}
+
+static void rlock_ABBA_case6_2a(void)
+{
+	RL(X1);
+	WL(Y1);
+	WU(Y1);
+	RU(X1);
+
+	RL(Y1);
+	RL(X1);
+	RU(X1);
+	RU(Y1);
+}
+
+static void rlock_ABBA_case6_2b(void)
+{
+	RL(X1);
+	RL(Y1);
+	RU(Y1);
+	RU(X1);
+
+	RL(Y1);
+	RL(X1);
+	RU(X1);
+	RU(Y1);
+}
+
+static void rlock_ABBA_case6_3(void)
+{
+	WL(X1);
+	RL(Y1);
+	RU(Y1);
+	WU(X1);
+
+	RL(Y1);
+	RL(X1);
+	RU(X1);
+	RU(Y1);
+}
+
+/*
+ * When the final dependency is recursive-read lock and write lock
+ * ---------------------------------------------------------------
+ *
+ * Case #7.1:
+ *
+ *     T1        T2
+ *
+ *     X1        RR2
+ *     W2        W1   [Deadlock]
+ *
+ * Case #7.2:
+ *
+ *     T1        T2
+ *
+ *     X1        RR2
+ *     RR2       W1   [No deadlock]
+ *
+ * Case #7.3:
+ *
+ *     T1        T2
+ *
+ *     X1        RR2
+ *     R2        W1   [Deadlock]
+ */
+
+static void rlock_ABBA_case7_1a(void)
+{
+	WL(X1);
+	WL(Y1);
+	WU(Y1);
+	WU(X1);
+
+	RL(Y1);
+	WL(X1);
+	WU(X1);
+	RU(Y1);
+}
+
+static void rlock_ABBA_case7_1b(void)
+{
+	RL(X1);
+	WL(Y1);
+	WU(Y1);
+	RU(X1);
+
+	RL(Y1);
+	WL(X1);
+	WU(X1);
+	RU(Y1);
+}
+
+static void rlock_ABBA_case7_2a(void)
+{
+	WL(X1);
+	RL(Y1);
+	RU(Y1);
+	WU(X1);
+
+	RL(Y1);
+	WL(X1);
+	WU(X1);
+	RU(Y1);
+}
+
+static void rlock_ABBA_case7_2b(void)
+{
+	RL(X1);
+	RL(Y1);
+	RU(Y1);
+	RU(X1);
+
+	RL(Y1);
+	WL(X1);
+	WU(X1);
+	RU(Y1);
+}
+
+/*
+ * When the final dependency is write lock and read lock
+ * -----------------------------------------------------
+ *
+ * Case #8:
+ *
+ *     T1        T2
+ *
+ *     X1        W2
+ *     X2        R1   [Deadlock]
+ */
+
+static void rwsem_ABBA_case8a(void)
+{
+	WSL(X1);
+	WSL(Y1);
+	WSU(Y1);
+	WSU(X1);
+
+	WSL(Y1);
+	RSL(X1);
+	RSU(X1);
+	WSU(Y1);
+}
+
+static void rwsem_ABBA_case8b(void)
+{
+	WSL(X1);
+	RSL(Y1);
+	RSU(Y1);
+	WSU(X1);
+
+	WSL(Y1);
+	RSL(X1);
+	RSU(X1);
+	WSU(Y1);
+}
+
+static void rwsem_ABBA_case8c(void)
+{
+	RSL(X1);
+	RSL(Y1);
+	RSU(Y1);
+	RSU(X1);
+
+	WSL(Y1);
+	RSL(X1);
+	RSU(X1);
+	WSU(Y1);
+}
+
+static void rwsem_ABBA_case8d(void)
+{
+	RSL(X1);
+	WSL(Y1);
+	WSU(Y1);
+	RSU(X1);
+
+	WSL(Y1);
+	RSL(X1);
+	RSU(X1);
+	WSU(Y1);
+}
+
+/*
+ * When the final dependency is write lock and recursive-read lock
+ * ---------------------------------------------------------------
+ *
+ * Case #9.1:
+ *
+ *     T1        T2
+ *
+ *     W1        W2
+ *     X2        RR1   [Deadlock]
+ *
+ * Case #9.2:
+ *
+ *     T1        T2
+ *
+ *     RR1       W2
+ *     X2        RR1   [No deadlock]
+ *
+ * Case #9.3:
+ *
+ *     T1        T2
+ *
+ *     R1        W2
+ *     X2        RR1   [No deadlock]
+ */
+static void rlock_ABBA_case9_1a(void)
+{
+	WL(X1);
+	WL(Y1);
+	WU(Y1);
+	WU(X1);
+
+	WL(Y1);
+	RL(X1);
+	RU(X1);
+	RU(Y1);
+}
+
+static void rlock_ABBA_case9_1b(void)
+{
+	WL(X1);
+	RL(Y1);
+	RU(Y1);
+	WU(X1);
+
+	WL(Y1);
+	RL(X1);
+	RU(X1);
+	RU(Y1);
+}
+
+static void rlock_ABBA_case9_2a(void)
+{
+	RL(X1);
+	WL(Y1);
+	WU(Y1);
+	RU(X1);
+
+	WL(Y1);
+	RL(X1);
+	RU(X1);
+	RU(Y1);
+}
+
+static void rlock_ABBA_case9_2b(void)
+{
+	RL(X1);
+	RL(Y1);
+	RU(Y1);
+	RU(X1);
+
+	WL(Y1);
+	RL(X1);
+	RU(X1);
+	RU(Y1);
+}
+
+/*
+ * When the final dependency is write lock and write lock
+ * ------------------------------------------------------
+ *
+ * Case #10:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     X1        W2
+ *     X2        W1   [Deadlock]
+ */
+static void rlock_ABBA_case10a(void)
+{
+	WL(X1);
+	WL(Y1);
+	WU(Y1);
+	WU(X1);
+
+	WL(Y1);
+	WL(X1);
+	WU(X1);
+	WU(Y1);
+}
+
+static void rlock_ABBA_case10b(void)
+{
+	WL(X1);
+	RL(Y1);
+	RU(Y1);
+	WU(X1);
+
+	WL(Y1);
+	WL(X1);
+	WU(X1);
+	WU(Y1);
+}
+
+static void rlock_ABBA_case10c(void)
+{
+	RL(X1);
+	RL(Y1);
+	RU(Y1);
+	RU(X1);
+
+	WL(Y1);
+	WL(X1);
+	WU(X1);
+	WU(Y1);
+}
+
+static void rlock_ABBA_case10d(void)
+{
+	RL(X1);
+	WL(Y1);
+	WU(Y1);
+	RU(X1);
+
+	WL(Y1);
+	WL(X1);
+	WU(X1);
+	WU(Y1);
+}
+
+static void rwsem_ABBA_case10a(void)
+{
+	WSL(X1);
+	WSL(Y1);
+	WSU(Y1);
+	WSU(X1);
+
+	WSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	WSU(Y1);
+}
+
+static void rwsem_ABBA_case10b(void)
+{
+	WSL(X1);
+	RSL(Y1);
+	RSU(Y1);
+	WSU(X1);
+
+	WSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	WSU(Y1);
+}
+
+static void rwsem_ABBA_case10c(void)
+{
+	RSL(X1);
+	RSL(Y1);
+	RSU(Y1);
+	RSU(X1);
+
+	WSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	WSU(Y1);
+}
+
+static void rwsem_ABBA_case10d(void)
+{
+	RSL(X1);
+	WSL(Y1);
+	WSU(Y1);
+	RSU(X1);
+
+	WSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	WSU(Y1);
+}
+
+/*
+ * Case #11:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     RR1
+ *     RR2
+ *
+ *    (RR1 RR2 released)
+ *
+ *     W1        RR2
+ *     W2        RR1   [Deadlock]
+ */
+static void rlock_ABBA_case11(void)
+{
+	RL(X1);
+	RL(Y1);
+	RU(Y1);
+	RU(X1);
+
+	WL(X1);
+	WL(Y1);
+	WU(Y1);
+	WU(X1);
+
+	RL(Y1);
+	RL(X1);
+	RU(X1);
+	RU(Y1);
+}
+
+/*
+ * Case #12:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     X1        X3
+ *     RR2       RR2
+ *     X3        X1   [Deadlock]
+ */
+static void rlock_ABBA_case12a(void)
+{
+	WL(X1);
+	RL(Y1);
+	WL(Z1);
+	WU(Z1);
+	RU(Y1);
+	WU(X1);
+
+	WL(Z1);
+	RL(Y1);
+	WL(X1);
+	WU(X1);
+	RU(Y1);
+	WU(Z1);
+}
+
+static void rlock_ABBA_case12b(void)
+{
+	WL(X1);
+	RL(Y1);
+	RL(Z1);
+	RU(Z1);
+	RU(Y1);
+	WU(X1);
+
+	WL(Z1);
+	RL(Y1);
+	WL(X1);
+	WU(X1);
+	RU(Y1);
+	WU(Z1);
+}
+
+static void rlock_ABBA_case12c(void)
+{
+	RL(X1);
+	RL(Y1);
+	RL(Z1);
+	RU(Z1);
+	RU(Y1);
+	RU(X1);
+
+	WL(Z1);
+	RL(Y1);
+	WL(X1);
+	WU(X1);
+	RU(Y1);
+	WU(Z1);
+}
+
+static void rlock_ABBA_case12d(void)
+{
+	RL(X1);
+	RL(Y1);
+	WL(Z1);
+	WU(Z1);
+	RU(Y1);
+	RU(X1);
+
+	WL(Z1);
+	RL(Y1);
+	WL(X1);
+	WU(X1);
+	RU(Y1);
+	WU(Z1);
+}
+
+static void rlock_ABBA_case12e(void)
+{
+	RL(X1);
+	RL(Y1);
+	WL(Z1);
+	WU(Z1);
+	RU(Y1);
+	RU(X1);
+
+	RL(Z1);
+	RL(Y1);
+	WL(X1);
+	WU(X1);
+	RU(Y1);
+	RU(Z1);
+}
+
+static void rlock_ABBA_case12f(void)
+{
+	WL(X1);
+	RL(Y1);
+	RL(Z1);
+	RU(Z1);
+	RU(Y1);
+	WU(X1);
+
+	WL(Z1);
+	RL(Y1);
+	RL(X1);
+	RU(X1);
+	RU(Y1);
+	WU(Z1);
+}
+
+/*
+ * Case #13.1:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     X1
+ *     X3        RR2
+ *     RR2       X1   [No deadlock]
+ *
+ * Case #13.2:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     X1
+ *     RR2       RR2
+ *     X3        X1   [No deadlock]
+ */
+static void rlock_ABBA_case13_1(void)
+{
+	WL(X1);
+	WL(Z1);
+	RL(Y1);
+	RU(Y1);
+	WU(Z1);
+	WU(X1);
+
+	RL(Y1);
+	WL(X1);
+	WU(X1);
+	RU(Y1);
+}
+
+static void rlock_ABBA_case13_2(void)
+{
+	WL(X1);
+	RL(Y1);
+	WL(Z1);
+	WU(Z1);
+	RU(Y1);
+	WU(X1);
+
+	RL(Y1);
+	WL(X1);
+	WU(X1);
+	RU(Y1);
+}
+
+/*
  * ABBA deadlock:
  *
  * Should fail except for either A or B is rlock.
@@ -2060,6 +2973,170 @@ void locking_selftest(void)
 	pr_cont("             |");
 	dotest(rwsem_ABBA3, FAILURE, LOCKTYPE_RWSEM);
 
+	print_testname("read-write lock ABBA Case #1.1");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case1_1, FAILURE, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #1.2");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case1_2, SUCCESS, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #2.1a");
+	pr_cont("                                  |");
+	dotest(rwsem_ABBA_case2_1a, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #2.1b");
+	pr_cont("                                  |");
+	dotest(rwsem_ABBA_case2_1b, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #2.2a");
+	pr_cont("                                  |");
+	dotest(rwsem_ABBA_case2_2a, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #2.2b");
+	pr_cont("                                  |");
+	dotest(rwsem_ABBA_case2_2b, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #4.1a");
+	pr_cont("                                  |");
+	dotest(rwsem_ABBA_case4_1a, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #4.1b");
+	pr_cont("                                  |");
+	dotest(rwsem_ABBA_case4_1b, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #4.2a");
+	pr_cont("                                  |");
+	dotest(rwsem_ABBA_case4_2a, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #4.2b");
+	pr_cont("                                  |");
+	dotest(rwsem_ABBA_case4_2b, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #6.1");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case6_1, FAILURE, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #6.2a");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case6_2a, SUCCESS, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #6.2b");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case6_2b, SUCCESS, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #6.3");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case6_3, SUCCESS, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #7.1a");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case7_1a, FAILURE, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #7.1b");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case7_1b, FAILURE, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #7.2a");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case7_2a, SUCCESS, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #7.2b");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case7_2b, SUCCESS, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #8a");
+	pr_cont("                                  |");
+	dotest(rwsem_ABBA_case8a, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #8b");
+	pr_cont("                                  |");
+	dotest(rwsem_ABBA_case8b, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #8c");
+	pr_cont("                                  |");
+	dotest(rwsem_ABBA_case8c, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #8d");
+	pr_cont("                                  |");
+	dotest(rwsem_ABBA_case8d, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #9.1a");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case9_1a, FAILURE, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #9.1b");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case9_1b, FAILURE, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #9.2a");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case9_2a, SUCCESS, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #9.2b");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case9_2b, SUCCESS, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #10a");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case10a, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case10a, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #10b");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case10b, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case10b, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #10c");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case10c, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case10c, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #10d");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case10d, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case10d, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #11");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case11, FAILURE, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #12a");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case12a, FAILURE, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #12b");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case12b, FAILURE, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #12c");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case12c, FAILURE, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #12d");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case12d, FAILURE, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #12e");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case12e, FAILURE, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #12f");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case12f, FAILURE, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #13.1");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case13_1, SUCCESS, LOCKTYPE_RWLOCK);
+
+	print_testname("read-write lock ABBA Case #13.2");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case13_2, SUCCESS, LOCKTYPE_RWLOCK);
+
 	printk("  --------------------------------------------------------------------------\n");
 
 	/*
-- 
1.8.3.1

