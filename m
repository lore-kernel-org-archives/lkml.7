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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074A0C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0273208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA1/GZGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfF1JQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:16:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36288 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfF1JQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:16:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so2912310plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KzQscIlOqbSR5X8vlQQcdhDhIvVQjC/TlNpKJdDihTo=;
        b=VA1/GZGC2lFQKUb6UwkuaLhqscyMT/ICb6iqxIBr0inuYzIPGNJdW8KK88iMY1heeZ
         ewV6BvMQApVRI2XWOTZerVVVPMQ0eKjjJ0gGsTo7opqCVc/CqYymKPi6ZG7xBqF85f9R
         UCU5vc6jPJben0VEV0How97m0DT4oLAXIyBdbZPrh57euBamWGZkyKHPwO79qiuvvemj
         roOkO8metksahsnXJgYDWpBIECN1KZwhs+NOKz9ToSKGcni02PHQIoqRomQAWU0ejWTn
         0XAOSy4OGQiGSQoYbvpUFXvZpJyJyDr7eeyh0YGkMJV6I3HyFKduZLXHcQ91MKgChRwr
         ra8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KzQscIlOqbSR5X8vlQQcdhDhIvVQjC/TlNpKJdDihTo=;
        b=r8qmZ2/HFOr8bAgm3G6YCHPcszBYYUqRocs0fIf9WUZHyLZqorMu/8GCF7TTXm8aFb
         SHFsCLtupKjo2kXaCSqAkJgSelzXXxWOOEFFI43IdBtcDRcqpA8u10dfxzNfaOek8qLR
         HD1y5VXDgVWJ14YlD4cIzDV2BKGvWb1Iq+pj6lWY2EdikcrGsVVCxb2lFNKnNSpzzB7x
         xoS33DUjzmUMqLE2bcM9dy2irR9qMSMX/3AySyIGz08GoIZSvWTsJOIIEoP3KCvAEmjP
         GcARC0lN/0EIRxMlMYm61i+PtOyipk/vHHSAk/DqzT1rWGri9gRNeipeYGTJ+n+vbpkl
         I6HA==
X-Gm-Message-State: APjAAAVCr0pfQrVRnhWJL4nL5z63MzCaYElfKzyA8FombRoBUsIIo9cn
        lax4xOA/aQhq8oJJFw4325k=
X-Google-Smtp-Source: APXvYqxI1f2yhjpmncPs1VDjOpvKzG4+xPkPaU+jYCXkrYjeH4HjCB2uUVIUCjYKZszll5sGoM+fQw==
X-Received: by 2002:a17:902:b70f:: with SMTP id d15mr9826919pls.318.1561713361638;
        Fri, 28 Jun 2019 02:16:01 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:16:01 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 04/30] locking/lockdep: Pass lock chain from validate_chain() to check_prev_add()
Date:   Fri, 28 Jun 2019 17:15:02 +0800
Message-Id: <20190628091528.17059-5-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer of lock chains is passed all the way from validate_chain()
to check_prev_add(). This is aimed for a later effort to associate lock
chains to lock dependencies.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d545b6c..f171c6e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2370,7 +2370,8 @@ static inline void inc_chains(void)
  */
 static int
 check_prev_add(struct task_struct *curr, struct held_lock *prev,
-	       struct held_lock *next, int distance, struct lock_trace *trace)
+	       struct held_lock *next, int distance, struct lock_trace *trace,
+	       struct lock_chain *chain)
 {
 	struct lock_list *entry;
 	int ret;
@@ -2475,7 +2476,8 @@ static inline void inc_chains(void)
  * the end of this context's lock-chain - whichever comes first.
  */
 static int
-check_prevs_add(struct task_struct *curr, struct held_lock *next)
+check_prevs_add(struct task_struct *curr, struct held_lock *next,
+		struct lock_chain *chain)
 {
 	struct lock_trace trace = { .nr_entries = 0 };
 	int depth = curr->lockdep_depth;
@@ -2506,7 +2508,7 @@ static inline void inc_chains(void)
 		 */
 		if (hlock->read != 2 && hlock->check) {
 			int ret = check_prev_add(curr, hlock, next, distance,
-						 &trace);
+						 &trace, chain);
 			if (!ret)
 				return 0;
 
@@ -2846,6 +2848,7 @@ static int validate_chain(struct task_struct *curr,
 			  struct held_lock *hlock,
 			  int chain_head, u64 chain_key)
 {
+	struct lock_chain *chain;
 	/*
 	 * Trylock needs to maintain the stack of held locks, but it
 	 * does not add new dependencies, because trylock can be done
@@ -2857,7 +2860,7 @@ static int validate_chain(struct task_struct *curr,
 	 * graph_lock for us)
 	 */
 	if (!hlock->trylock && hlock->check &&
-	    lookup_chain_cache_add(curr, hlock, chain_key)) {
+	    (chain = lookup_chain_cache_add(curr, hlock, chain_key))) {
 		/*
 		 * Check whether last held lock:
 		 *
@@ -2892,7 +2895,7 @@ static int validate_chain(struct task_struct *curr,
 		 * of the chain, and if it's not a secondary read-lock:
 		 */
 		if (!chain_head && ret != 2) {
-			if (!check_prevs_add(curr, hlock))
+			if (!check_prevs_add(curr, hlock, chain))
 				return 0;
 		}
 
-- 
1.8.3.1

