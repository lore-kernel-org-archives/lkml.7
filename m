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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D895C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10D82087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0zZt+o6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfEPIAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:00:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46695 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPIAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:00:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id r18so1200113pls.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eo36gth8TiJm3De/GHnJH2AyCm98XgpRVL6ZC2cXx9I=;
        b=Y0zZt+o6mTNMdvOqAJuBc+tVbMVv/PfLYM9B2Wol5wLV9ESInsFE0rWz2BWS8CH7o5
         OP9qrBBX3nREBuWZnBWCfMJrRNgRSVhiOWGW3IdpG/PFCpJpFhIVwfdJ2NBSXZ31Pffm
         ioKE4F9FIb/NFPWnAEcmGnlD8YRmMN3Q2ryWB+SWUidtcMiw+U7SBJgc5aAp9QT3cco1
         nFqHRrDyW0GXTbhbfGtkhxSxCIUg6bTXN1e2qSf9w5apt5DJzdxbo9YZYNtFR1Jfnxdb
         mTlXIvGvmpdHx82uq20MYrA2bhzvTIiOcMuPXm8SzvOyt9Mw7tb775kNhzFNxYnff4AV
         WVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eo36gth8TiJm3De/GHnJH2AyCm98XgpRVL6ZC2cXx9I=;
        b=G2WU+ZTqKIPOoxUcbaeJGvty4JVv1nMc5QMdE/vh48uyHfyOqfrpysj4WDHCSutP7i
         60Gc7eDmVlVTUV2RzsLWKDJkgm63bFfrLFLOMh73VbMDgYS5j5QONg0PjZ3FIlwvvXES
         bqvyYxDxId/3pEsosFTQkv/QmxShGRgYXDWZ/aPkkPumSDwzQTlzlIFOVbkkLajdZAsQ
         IlxHtdGDuZuN+r2SWM2JRIJKWK7na5FOrzLWMWc0Tc6CEuarGgqN1QUZmgCqqDHLI5v4
         hW2ECTbElOfaAlCtFo8GlKBpDmrBgLMeIAf0KrJ3siRGYKlitG/Y/hLyWL8AMOJdK0FI
         zueQ==
X-Gm-Message-State: APjAAAUDcwgn4L1CPnS1HM0S6w37rJtXj1IexL229OsC3U+Rtk8a2S7f
        olUvH6y//NfHyXX+cPr/LVE=
X-Google-Smtp-Source: APXvYqyW3+tYedtleOkoP+xm1iU8NM7/nbzjy1G+hetnxIZ4j9CVQbdXterJYfpgMX1gTRDv31vVgg==
X-Received: by 2002:a17:902:9884:: with SMTP id s4mr50144312plp.179.1557993642056;
        Thu, 16 May 2019 01:00:42 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:00:41 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 05/17] locking/lockdep: Rename deadlock check functions
Date:   Thu, 16 May 2019 16:00:03 +0800
Message-Id: <20190516080015.16033-6-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190516080015.16033-1-duyuyang@gmail.com>
References: <20190516080015.16033-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deadlock checks are performed at two places:

 - Within current's held lock stack, check for lock recursion deadlock.
 - Within dependency graph, check for lock inversion deadlock.

Rename the two relevant functions for later use. Plus, with read locks,
dependency circle in graph is not a sufficient condition for lock
inversion deadlocks anymore, so check_noncircular() is not entirely
accurate.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1f1cb21..f4982ad 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1771,8 +1771,8 @@ static inline void set_lock_type2(struct lock_list *lock, int read)
  * Print an error and return 0 if it does.
  */
 static noinline int
-check_noncircular(struct held_lock *src, struct held_lock *target,
-		  struct lock_trace *trace)
+check_deadlock_graph(struct held_lock *src, struct held_lock *target,
+		     struct lock_trace *trace)
 {
 	int ret;
 	struct lock_list *uninitialized_var(target_entry);
@@ -2385,7 +2385,8 @@ static inline void inc_chains(void)
 }
 
 /*
- * Check whether we are holding such a class already.
+ * Check whether we are holding such a class already in current
+ * context's held lock stack.
  *
  * (Note that this has to be done separately, because the graph cannot
  * detect such classes of deadlocks.)
@@ -2396,7 +2397,7 @@ static inline void inc_chains(void)
  *  3: LOCK_TYPE_RECURSIVE on recursive read
  */
 static int
-check_deadlock(struct task_struct *curr, struct held_lock *next)
+check_deadlock_current(struct task_struct *curr, struct held_lock *next)
 {
 	struct held_lock *prev;
 	struct held_lock *nest = NULL;
@@ -2480,7 +2481,7 @@ static inline void inc_chains(void)
 
 	/*
 	 * Prove that the new <prev> -> <next> dependency would not
-	 * create a circular dependency in the graph. (We do this by
+	 * create a deadlock scenario in the graph. (We do this by
 	 * a breadth-first search into the graph starting at <next>,
 	 * and check whether we can reach <prev>.)
 	 *
@@ -2488,7 +2489,7 @@ static inline void inc_chains(void)
 	 * MAX_CIRCULAR_QUEUE_SIZE) which keeps track of a breadth of nodes
 	 * in the graph whose neighbours are to be checked.
 	 */
-	ret = check_noncircular(next, prev, trace);
+	ret = check_deadlock_graph(next, prev, trace);
 	if (unlikely(ret <= 0))
 		return 0;
 
@@ -2983,7 +2984,7 @@ static int validate_chain(struct task_struct *curr,
 		 * The simple case: does the current hold the same lock
 		 * already?
 		 */
-		int ret = check_deadlock(curr, hlock);
+		int ret = check_deadlock_current(curr, hlock);
 
 		if (!ret)
 			return 0;
-- 
1.8.3.1

