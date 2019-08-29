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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAD9C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5C72341B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Te6dIM32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfH2IcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:32:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39433 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2IcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so1209690pgi.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iStq7ogyYRbk+qwLA4GKKU5BvJtxVB3HPWsw2YA81jg=;
        b=Te6dIM32RQo4ztkQNJrTH+5YJ3Ce298hBuKO/1YVJ1HYbj04/e4M0aXHr5LDAsYUip
         BD1LorIdtPQ4AXlwvdioun/CebYaofvBLJbLNh6aTDqORjCdm7VD/5D95t9573b9jBU2
         VQz4tbVPR8LA+gzTQzfoOwB555rqdjb8h8J4abaArCVnLH/ThctJUTv0JPDC5I7tmncR
         OpD6tKeqvoPlfcCjJ8hdOoqJ6HFF+MpQHIBIKlalg409EyhEFGpr+KDrtxQnmR3VQ5yu
         vU+1RoSHNuzKu9y62uju406Qj3mUQBA0RlReAFLlGk94MZmvJPwi+9YqUfS/8uWK4w0F
         f70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iStq7ogyYRbk+qwLA4GKKU5BvJtxVB3HPWsw2YA81jg=;
        b=pW1TSj8oe8rVtgt0FuLayKXEC9+vbziCciSPLPqHZOuv0AtN05/GVXnPb+DukG1y6u
         RHvj2A/jCYRIDX+1VO/ZxjsOGwq13X5hLWpQYkjtYlPxW8QbG0CLqAW1aIAIJBMPh3Wp
         Ozr8sWvlS5fBeTjka8KDRwcFFYty3VqTPAPx6TOVfJLLSqQYD1qcm217JSl/NfJsMwwV
         FvE1Qj30GZi3l1nfc2GPZR4J46sPcgufDW8UEK+1arAQLLVcVA21Q+EF9/m6xbjCbtlF
         4jTSgx0IlNIt/Pt8ylOp7bxAnjciviIx8xwO0lEbz6RQtTVfxfkI00kMEcbiiCD3f2mF
         6j2Q==
X-Gm-Message-State: APjAAAVNpoAtosCRWk5F5PsWTh9G1nICMd+Mw0Km2KRptmHBH+pYq31y
        yoOIF8N7izvfdeYZO7yYpIM=
X-Google-Smtp-Source: APXvYqwR+t7cEBrvEoTEZkSoRWerblV0GC6u5SmkIfv/HYM8EYrpLSsmpwpHs0yz2oVA08J6XkWVfA==
X-Received: by 2002:aa7:9a5a:: with SMTP id x26mr9557090pfj.47.1567067521369;
        Thu, 29 Aug 2019 01:32:01 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:32:00 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 04/30] locking/lockdep: Pass lock chain from validate_chain() to check_prev_add()
Date:   Thu, 29 Aug 2019 16:31:06 +0800
Message-Id: <20190829083132.22394-5-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer of lock chains is passed all the way from validate_chain()
to check_prev_add(). This is aimed for the later effort to associate lock
chains to lock dependencies.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 51918d2..a0e62e5 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2441,7 +2441,7 @@ static inline void inc_chains(void)
 static int
 check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	       struct held_lock *next, int distance,
-	       struct lock_trace **const trace)
+	       struct lock_trace **const trace, struct lock_chain *chain)
 {
 	struct lock_list *entry;
 	int ret;
@@ -2549,7 +2549,8 @@ static inline void inc_chains(void)
  * the end of this context's lock-chain - whichever comes first.
  */
 static int
-check_prevs_add(struct task_struct *curr, struct held_lock *next)
+check_prevs_add(struct task_struct *curr, struct held_lock *next,
+		struct lock_chain *chain)
 {
 	struct lock_trace *trace = NULL;
 	int depth = curr->lockdep_depth;
@@ -2580,7 +2581,7 @@ static inline void inc_chains(void)
 		 */
 		if (hlock->read != 2 && hlock->check) {
 			int ret = check_prev_add(curr, hlock, next, distance,
-						 &trace);
+						 &trace, chain);
 			if (!ret)
 				return 0;
 
@@ -2920,6 +2921,7 @@ static int validate_chain(struct task_struct *curr,
 			  struct held_lock *hlock,
 			  int chain_head, u64 chain_key)
 {
+	struct lock_chain *chain;
 	/*
 	 * Trylock needs to maintain the stack of held locks, but it
 	 * does not add new dependencies, because trylock can be done
@@ -2931,7 +2933,7 @@ static int validate_chain(struct task_struct *curr,
 	 * graph_lock for us)
 	 */
 	if (!hlock->trylock && hlock->check &&
-	    lookup_chain_cache_add(curr, hlock, chain_key)) {
+	    (chain = lookup_chain_cache_add(curr, hlock, chain_key))) {
 		/*
 		 * Check whether last held lock:
 		 *
@@ -2966,7 +2968,7 @@ static int validate_chain(struct task_struct *curr,
 		 * of the chain, and if it's not a secondary read-lock:
 		 */
 		if (!chain_head && ret != 2) {
-			if (!check_prevs_add(curr, hlock))
+			if (!check_prevs_add(curr, hlock, chain))
 				return 0;
 		}
 
-- 
1.8.3.1

