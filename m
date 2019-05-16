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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F39EC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB812205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTzLk80z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfEPIBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:01:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36741 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfEPIBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:01:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id v80so1426508pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZHzlqjHUpBcWDeEJ3Xlm22kRNhQiFjrERpI1mkPi/eY=;
        b=DTzLk80zG35jL5eAJ1GNkQ7fn32H16sfzG9eUkiK+cxTZoCPpWNWILcN6nkgVWEjvK
         EeHYsoxsZzOg4SkIlIsFvhYQkyZolLm2hjdv4ugj4cEr2kgzDYcZaEuSXxHwHFi45yIu
         kv0d0sb/FYRCeD9Pw8bmqzsUn6uBB4L2Iny5VeJoYESAkEQLj6KzDEpy8zDyeqaH/zH4
         /qTPgXKR/PtFGnQ0o/jeaGJpk/EK20IWcSaXiOYZdOE5REPUjfmTf868KFxO+FOMoR6c
         B9IxpJ/HcKZekMkm1maxWV8hc82fPgIXb5yLzjBgtUNqZcZyvmmWbu5VbpnOEzwoSxgp
         JtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZHzlqjHUpBcWDeEJ3Xlm22kRNhQiFjrERpI1mkPi/eY=;
        b=nJ7olaTjUuoVdeH0pPGv2K3z97n9XEyoEcR0ReR3XHcJdtPCwpXkpJ9HYoWbvHNsMB
         guem1+/2JHpsEheS0fbqWu5FGwNczAXh4A/zwppbjjpo0JHfUa76xJ7ewnvWwgnabuXa
         RVDTCHFDsjXLE5AqloKe7sS8qKIVySCm73aWcAo2uZZgFgRUEv++3O/FH9O35s6LF+rN
         6EHBIZpFAvddP7FTWDu84QhQqUs9GrJpxTy0gDN3QaOxoq3UOpNhrxEFkforjL9lqyPM
         NMldYnH+ir/Fq0deN3KBMJqfm/Chj5jZyD8PUoQ7U+vIwQU7OH4vRJw4x1lcyhI8QjxI
         bZ+Q==
X-Gm-Message-State: APjAAAWnKpfzdbhblp1cunu8p5VaHw2KQiHJtE6RdtvRiB2jbKdwiTjC
        Kubx69mlYCvZSZ3lyEXYTBo=
X-Google-Smtp-Source: APXvYqyyLGOssyZkls/8bDxWZ9s/TGYsTs10X0bSQwAtZfcfAPiNarDF9KkH6vay4zy0gjRsfoMf5Q==
X-Received: by 2002:a63:4a66:: with SMTP id j38mr29842320pgl.199.1557993669949;
        Thu, 16 May 2019 01:01:09 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:01:09 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 13/17] locking/lockdep: Add nest lock type
Date:   Thu, 16 May 2019 16:00:11 +0800
Message-Id: <20190516080015.16033-14-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190516080015.16033-1-duyuyang@gmail.com>
References: <20190516080015.16033-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a macro LOCK_TYPE_NEST for nest lock type and mark the nested lock in
check_deadlock_current(). Unlike the other LOCK_TYPE_* enums, this lock type
is used only in lockdep.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c           | 7 +++++--
 kernel/locking/lockdep_internals.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ce79b5a..d8e484d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2527,6 +2527,7 @@ static inline void inc_chains(void)
  *  0: on deadlock detected;
  *  1: on OK;
  *  3: LOCK_TYPE_RECURSIVE on recursive read
+ *  4: LOCK_TYPE_NEST on nest lock
  */
 static int
 check_deadlock_current(struct task_struct *curr, struct held_lock *next)
@@ -2556,7 +2557,7 @@ static inline void inc_chains(void)
 		 * nesting behaviour.
 		 */
 		if (nest)
-			return LOCK_TYPE_RECURSIVE;
+			return LOCK_TYPE_NEST;
 
 		print_deadlock_bug(curr, prev, next);
 		return 0;
@@ -3131,11 +3132,13 @@ static int validate_chain(struct task_struct *curr,
 
 		if (!ret)
 			return 0;
+
 		/*
 		 * Add dependency only if this lock is not the head
 		 * of the chain, and if it's not a secondary read-lock:
 		 */
-		if (!chain_head && ret != LOCK_TYPE_RECURSIVE) {
+		if (!chain_head && ret != LOCK_TYPE_RECURSIVE &&
+		    ret != LOCK_TYPE_NEST) {
 			if (!check_prevs_add(curr, hlock))
 				return 0;
 		}
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index c287bcb..759e740 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -28,6 +28,7 @@ enum lock_usage_bit {
 
 #define LOCK_TYPE_BITS	16
 #define LOCK_TYPE_MASK	0xFFFF
+#define LOCK_TYPE_NEST	(LOCK_TYPE_RECURSIVE + 1)
 
 /*
  * Usage-state bitmasks:
-- 
1.8.3.1

