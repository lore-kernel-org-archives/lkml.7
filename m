Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4992DC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D74205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oC+gktir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfEPIBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:01:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40304 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfEPIBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:01:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so1416171pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XBmUcIl+foqYKZfIDdCGj+DfSZ0ABmx1DPRCcaGIe1c=;
        b=oC+gktirmERJIw0WcL/J3jjn0VHuD81jy1QoHgDnvi0gOBlddXyzxp0FLKrQsAjCPB
         S+BRERYJE4BZWru7oZ+lkcAH7Xv0is7ODVjuUM+lGNNGC+s7xxdaSCovHXFxK/wDBBId
         KkqrLlT8DydhBSDpQ0Fc0HipTXzw6xTPmEJ3cYAc3dGfc/UbbLqJl29cO2dBSv/wylhO
         1UaLB4ibWFAZkDqRE/s4ya4o5bb+Y6rb89E/8nq8vlWa+Di6jdwi4qs3JIVpf2rxQQD/
         cWgXiZNAtqlR6LbJ++p8kbAEoEZyMXCrB1bLM107dUyWpUQM37iKNFl77UKCAyjy39b+
         6YFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XBmUcIl+foqYKZfIDdCGj+DfSZ0ABmx1DPRCcaGIe1c=;
        b=B6WmwaGJhLwqZzcA7Tkbx0LO8p10UzP/a8aSFA06gwHAa9tFU6b0siWnrbxEYEXFh6
         hWOg95Dxrx8Go/seWHLPkoDB2cACNqIGHQ1CZ95xh+PsoADLSRPzGxib+FTGG1hkhdRl
         MoUnzTxk6wq1J/2py4B4SUB8DJ+OcUMclU4EX/HzTRkK5IcJKCEZUf94PhGyHQwc3JS5
         nBwSiJVMiybrC5E/4tzboQQCDuxgKj2Vh6AFI05S3BvGsE8TFAO93zgrLgOjC3ahij60
         4j0NN1GbKXD5Heddr+mpc7/dXPcoviwjNkrgAaUeQulNHmUvwbaF7xLPEhH7STL55CJ7
         8vJQ==
X-Gm-Message-State: APjAAAUX7jkllSd9kgDVrQBfuoKME9Oz42OQQUc4i32+ETxi/+olGYKz
        7J37Hf308Ui818LJwYzXoLc=
X-Google-Smtp-Source: APXvYqxQPXrRgFB80T+AzSw5pJ0o8gVL/c/m2xJ22D2kJZYk9zVSldK4k3qhq59vhXkPSqVYIXd90A==
X-Received: by 2002:a62:7689:: with SMTP id r131mr54166032pfc.181.1557993680286;
        Thu, 16 May 2019 01:01:20 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:01:19 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 16/17] locking/lockdep: Add more lockdep selftest cases
Date:   Thu, 16 May 2019 16:00:14 +0800
Message-Id: <20190516080015.16033-17-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190516080015.16033-1-duyuyang@gmail.com>
References: <20190516080015.16033-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lets make sure our 8 cases can be correctly handled. In contrast, before
this patchset, these 8 cases have 24 failures:

 ----------------------------------------------------------------------------
                                  | spin |wlock |rlock |mutex | wsem | rsem |
   --------------------------------------------------------------------------
      read-write lock ABBA Case #1:             |FAILED|             |  ok  |
     read-write lock ABBA Case #2a:             |  ok  |             |FAILED|
     read-write lock ABBA Case #2b:             |  ok  |             |FAILED|
     read-write lock ABBA Case #3a:             |FAILED|             |  ok  |
     read-write lock ABBA Case #3b:             |FAILED|             |  ok  |
     read-write lock ABBA Case #3c:             |FAILED|             |  ok  |
     read-write lock ABBA Case #3d:             |  ok  |             |  ok  |
     read-write lock ABBA Case #4a:             |FAILED|             |  ok  |
     read-write lock ABBA Case #4b:             |FAILED|             |  ok  |
     read-write lock ABBA Case #5a:             |  ok  |             |FAILED|
     read-write lock ABBA Case #5b:             |  ok  |             |FAILED|
     read-write lock ABBA Case #6a:             |FAILED|             |  ok  |
     read-write lock ABBA Case #6b:             |FAILED|             |  ok  |
     read-write lock ABBA Case #6c:             |FAILED|             |  ok  |
     read-write lock ABBA Case #7a:             |  ok  |             |  ok  |
     read-write lock ABBA Case #7b:             |FAILED|             |  ok  |
     read-write lock ABBA Case #7c:             |FAILED|             |  ok  |
     read-write lock ABBA Case #7d:             |FAILED|             |  ok  |
   read-write lock ABBA Case #8.1a:             |  ok  |             |FAILED|
   read-write lock ABBA Case #8.1b:             |  ok  |             |FAILED|
   read-write lock ABBA Case #8.1c:             |  ok  |             |FAILED|
   read-write lock ABBA Case #8.1d:             |  ok  |             |FAILED|
   read-write lock ABBA Case #8.2a:             |  ok  |             |FAILED|
   read-write lock ABBA Case #8.2b:             |  ok  |             |FAILED|
   read-write lock ABBA Case #8.2c:             |  ok  |             |FAILED|
   read-write lock ABBA Case #8.2d:             |  ok  |             |FAILED|
   --------------------------------------------------------------------------

Note that even many of the cases passed, it is simply because the
recursive-read locks are *not* considered.

Now this patch marks the finish of the implementation of the read-write lock
detection algorithm. Looking forward, we may have some ramifications:

(1) Some previous false positive read-lock involved deadlocks should not be
    a false positive anymore (hopefully), so however a such false positive
    was resolved, it has a chance to have a second look at it.

(2) With recursive-read lock dependencies in graph, there may be new
    deadlock scenarios that have never been able to be discovered before.
    Admittedly, they include both true and possibly false positives.

Have fun and brace for impact!

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 lib/locking-selftest.c | 1022 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1022 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 4c6dd8a..52d5494 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -461,6 +461,872 @@ static void rwsem_ABBA3(void)
 }
 
 /*
+ * Read-write lock ABBA cases.
+ *
+ * Notation:
+ *  R: read lock
+ *  W: write lock
+ *  X: either read or write lock
+ *
+ * Case #1:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     W1        R2
+ *     W2        R1   [Deadlock]
+ */
+static void rlock_ABBA_case1(void)
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
+static void rwsem_ABBA_case1(void)
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
+/*
+ * Case #2:
+ *
+ *     T1        T2
+ *
+ *     X1        R2
+ *     R2        R1   [No deadlock]
+ */
+static void rlock_ABBA_case2a(void)
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
+static void rwsem_ABBA_case2a(void)
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
+static void rlock_ABBA_case2b(void)
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
+static void rwsem_ABBA_case2b(void)
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
+ * Case #3:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     X1        W2
+ *     X2        W1   [Deadlock]
+ */
+static void rlock_ABBA_case3a(void)
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
+static void rwsem_ABBA_case3a(void)
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
+static void rlock_ABBA_case3b(void)
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
+static void rwsem_ABBA_case3b(void)
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
+static void rlock_ABBA_case3c(void)
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
+static void rwsem_ABBA_case3c(void)
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
+static void rlock_ABBA_case3d(void)
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
+static void rwsem_ABBA_case3d(void)
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
+/*
+ * Case #4:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     X1        R2
+ *     W2        W1   [Deadlock]
+ */
+static void rlock_ABBA_case4a(void)
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
+static void rwsem_ABBA_case4a(void)
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
+static void rlock_ABBA_case4b(void)
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
+static void rwsem_ABBA_case4b(void)
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
+ * Case #5:
+
+ *     T1        T2
+ *     --        --
+ *
+ *     X1        R2
+ *     R2        W1   [No deadlock]
+ */
+static void rlock_ABBA_case5a(void)
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
+static void rwsem_ABBA_case5a(void)
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
+static void rlock_ABBA_case5b(void)
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
+static void rwsem_ABBA_case5b(void)
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
+/*
+ * Case #6:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     R1
+ *     R2
+ *
+ *    (R1 R2 released)
+ *
+ *     W1        R2
+ *     W2        R1   [Deadlock]
+ */
+static void rlock_ABBA_case6a(void)
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
+static void rwsem_ABBA_case6a(void)
+{
+	RSL(X1);
+	RSL(Y1);
+	RSU(Y1);
+	RSU(X1);
+
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
+static void rlock_ABBA_case6b(void)
+{
+	WL(X1);
+	RL(Y1);
+	RU(Y1);
+	WU(X1);
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
+static void rwsem_ABBA_case6b(void)
+{
+	WSL(X1);
+	RSL(Y1);
+	RSU(Y1);
+	WSU(X1);
+
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
+static void rlock_ABBA_case6c(void)
+{
+	RL(X1);
+	WL(Y1);
+	WU(Y1);
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
+static void rwsem_ABBA_case6c(void)
+{
+	RSL(X1);
+	WSL(Y1);
+	WSU(Y1);
+	RSU(X1);
+
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
+/*
+ * Case #7:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     X1        X3
+ *     R2        R2
+ *     X3        X1   [Deadlock]
+ */
+static void rlock_ABBA_case7a(void)
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
+static void rwsem_ABBA_case7a(void)
+{
+	WSL(X1);
+	RSL(Y1);
+	WSL(Z1);
+	WSU(Z1);
+	RSU(Y1);
+	WSU(X1);
+
+	WSL(Z1);
+	RSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	RSU(Y1);
+	WSU(Z1);
+}
+
+static void rlock_ABBA_case7b(void)
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
+static void rwsem_ABBA_case7b(void)
+{
+	RSL(X1);
+	RSL(Y1);
+	WSL(Z1);
+	WSU(Z1);
+	RSU(Y1);
+	RSU(X1);
+
+	WSL(Z1);
+	RSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	RSU(Y1);
+	WSU(Z1);
+}
+
+static void rlock_ABBA_case7c(void)
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
+static void rwsem_ABBA_case7c(void)
+{
+	WSL(X1);
+	RSL(Y1);
+	RSL(Z1);
+	RSU(Z1);
+	RSU(Y1);
+	WSU(X1);
+
+	WSL(Z1);
+	RSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	RSU(Y1);
+	WSU(Z1);
+}
+
+static void rlock_ABBA_case7d(void)
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
+static void rwsem_ABBA_case7d(void)
+{
+	RSL(X1);
+	RSL(Y1);
+	RSL(Z1);
+	RSU(Z1);
+	RSU(Y1);
+	RSU(X1);
+
+	WSL(Z1);
+	RSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	RSU(Y1);
+	WSU(Z1);
+}
+
+/*
+ * Case #8.1:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     X1
+ *     X3        R2
+ *     R2        X1   [No deadlock]
+ */
+static void rlock_ABBA_case81a(void)
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
+static void rwsem_ABBA_case81a(void)
+{
+	WSL(X1);
+	WSL(Z1);
+	RSL(Y1);
+	RSU(Y1);
+	WSU(Z1);
+	WSU(X1);
+
+	RSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	RSU(Y1);
+}
+
+static void rlock_ABBA_case81b(void)
+{
+	RL(X1);
+	WL(Z1);
+	RL(Y1);
+	RU(Y1);
+	WU(Z1);
+	RU(X1);
+
+	RL(Y1);
+	WL(X1);
+	WU(X1);
+	RU(Y1);
+}
+
+static void rwsem_ABBA_case81b(void)
+{
+	RSL(X1);
+	WSL(Z1);
+	RSL(Y1);
+	RSU(Y1);
+	WSU(Z1);
+	RSU(X1);
+
+	RSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	RSU(Y1);
+}
+
+static void rlock_ABBA_case81c(void)
+{
+	WL(X1);
+	RL(Z1);
+	RL(Y1);
+	RU(Y1);
+	RU(Z1);
+	WU(X1);
+
+	RL(Y1);
+	WL(X1);
+	WU(X1);
+	RU(Y1);
+}
+
+static void rwsem_ABBA_case81c(void)
+{
+	WSL(X1);
+	RSL(Z1);
+	RSL(Y1);
+	RSU(Y1);
+	RSU(Z1);
+	WSU(X1);
+
+	RSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	RSU(Y1);
+}
+
+static void rlock_ABBA_case81d(void)
+{
+	RL(X1);
+	RL(Z1);
+	RL(Y1);
+	RU(Y1);
+	RU(Z1);
+	RU(X1);
+
+	RL(Y1);
+	WL(X1);
+	WU(X1);
+	RU(Y1);
+}
+
+static void rwsem_ABBA_case81d(void)
+{
+	RSL(X1);
+	RSL(Z1);
+	RSL(Y1);
+	RSU(Y1);
+	RSU(Z1);
+	RSU(X1);
+
+	RSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	RSU(Y1);
+}
+
+
+/*
+ * Case #8.2:
+ *
+ *     T1        T2
+ *     --        --
+ *
+ *     X1
+ *     R2        R2
+ *     X3        X1   [No deadlock]
+ */
+static void rlock_ABBA_case82a(void)
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
+static void rwsem_ABBA_case82a(void)
+{
+	WSL(X1);
+	RSL(Y1);
+	WSL(Z1);
+	WSU(Z1);
+	RSU(Y1);
+	WSU(X1);
+
+	RSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	RSU(Y1);
+}
+
+static void rlock_ABBA_case82b(void)
+{
+	RL(X1);
+	RL(Y1);
+	WL(Z1);
+	WU(Z1);
+	RU(Y1);
+	RU(X1);
+
+	RL(Y1);
+	WL(X1);
+	WU(X1);
+	RU(Y1);
+}
+
+static void rwsem_ABBA_case82b(void)
+{
+	RSL(X1);
+	RSL(Y1);
+	WSL(Z1);
+	WSU(Z1);
+	RSU(Y1);
+	RSU(X1);
+
+	RSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	RSU(Y1);
+}
+
+static void rlock_ABBA_case82c(void)
+{
+	WL(X1);
+	RL(Y1);
+	RL(Z1);
+	RU(Z1);
+	RU(Y1);
+	WU(X1);
+
+	RL(Y1);
+	WL(X1);
+	WU(X1);
+	RU(Y1);
+}
+
+static void rwsem_ABBA_case82c(void)
+{
+	WSL(X1);
+	RSL(Y1);
+	RSL(Z1);
+	RSU(Z1);
+	RSU(Y1);
+	WSU(X1);
+
+	RSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	RSU(Y1);
+}
+
+static void rlock_ABBA_case82d(void)
+{
+	RL(X1);
+	RL(Y1);
+	RL(Z1);
+	RU(Z1);
+	RU(Y1);
+	RU(X1);
+
+	RL(Y1);
+	WL(X1);
+	WU(X1);
+	RU(Y1);
+}
+
+static void rwsem_ABBA_case82d(void)
+{
+	RSL(X1);
+	RSL(Y1);
+	RSL(Z1);
+	RSU(Z1);
+	RSU(Y1);
+	RSU(X1);
+
+	RSL(Y1);
+	WSL(X1);
+	WSU(X1);
+	RSU(Y1);
+}
+
+/*
  * ABBA deadlock:
  *
  * Should fail except for either A or B is read lock.
@@ -2071,6 +2937,162 @@ void locking_selftest(void)
 	pr_cont("             |");
 	dotest(rwsem_ABBA3, FAILURE, LOCKTYPE_RWSEM);
 
+	print_testname("read-write lock ABBA Case #1");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case1, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case1, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #2a");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case2a, SUCCESS, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case2a, SUCCESS, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #2b");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case2b, SUCCESS, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case2b, SUCCESS, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #3a");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case3a, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case3a, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #3b");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case3b, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case3b, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #3c");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case3c, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case3c, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #3d");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case3d, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case3d, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #4a");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case4a, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case4a, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #4b");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case4b, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case4b, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #5a");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case5a, SUCCESS, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case5a, SUCCESS, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #5b");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case5b, SUCCESS, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case5b, SUCCESS, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #6a");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case6a, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case6a, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #6b");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case6b, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case6b, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #6c");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case6c, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case6c, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #7a");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case7a, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case7a, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #7b");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case7b, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case7b, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #7c");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case7c, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case7c, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #7d");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case7d, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case7d, FAILURE, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #8.1a");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case81a, SUCCESS, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case81a, SUCCESS, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #8.1b");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case81b, SUCCESS, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case81b, SUCCESS, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #8.1c");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case81c, SUCCESS, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case81c, SUCCESS, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #8.1d");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case81d, SUCCESS, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case81d, SUCCESS, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #8.2a");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case82a, SUCCESS, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case82a, SUCCESS, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #8.2b");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case82b, SUCCESS, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case82b, SUCCESS, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #8.2c");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case82c, SUCCESS, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case82c, SUCCESS, LOCKTYPE_RWSEM);
+
+	print_testname("read-write lock ABBA Case #8.2d");
+	pr_cont("             |");
+	dotest(rlock_ABBA_case82d, SUCCESS, LOCKTYPE_RWLOCK);
+	pr_cont("             |");
+	dotest(rwsem_ABBA_case82d, SUCCESS, LOCKTYPE_RWSEM);
+
 	printk("  --------------------------------------------------------------------------\n");
 
 	/*
-- 
1.8.3.1

