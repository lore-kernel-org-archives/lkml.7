Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64E5C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6049214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Sq2zHTqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388847AbfDRL1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:27:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRL1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:27:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3IBQpFC166760
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Apr 2019 04:26:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3IBQpFC166760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555586812;
        bh=NOozGcXbv3+/MTZGIu3Q9LNrVJvcgJefLyFJ6P5g8DI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Sq2zHTqpWCKxWZ1hYhGHPXQXAXBN9dMzaAJeazMw8Mi5hAcZ0lJ8q5oK5q7zpkho1
         izggRJCh6XC+8NhIAtJ7akHL8BncFI/rbMoWLzD4O45X73BhosFCd1m+E10Nwu30VK
         hUJDwwGAdK4oTo3qB5GxfbYBBCF4KcnEzLpxIYWIw3j+KEC1308VAEsxyQ9LDEj2DF
         mnJV4W9iLGn3P+kOjH5J2r2Q/WFAFCaqzUmZA8RuO6qm2YJi8BxUg58qhtl23ytYam
         fHUl3kzg8quUrPNjTwsW9zqKJErGPettLOdTKnK29TQ1KGzVNrEXziVq+DcLsQVaN3
         0z/w5GmURi/2A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3IBQpeR166756;
        Thu, 18 Apr 2019 04:26:51 -0700
Date:   Thu, 18 Apr 2019 04:26:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-c902a1e8d9c9b47cd8faa16892710247cdda9b02@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, frederic@kernel.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, will.deacon@arm.com,
        akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          peterz@infradead.org, frederic@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, will.deacon@arm.com,
          torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
          akpm@linux-foundation.org
In-Reply-To: <20190402160244.32434-3-frederic@kernel.org>
References: <20190402160244.32434-3-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Map remaining magic numbers to
 lock usage mask names
Git-Commit-ID: c902a1e8d9c9b47cd8faa16892710247cdda9b02
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c902a1e8d9c9b47cd8faa16892710247cdda9b02
Gitweb:     https://git.kernel.org/tip/c902a1e8d9c9b47cd8faa16892710247cdda9b02
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 2 Apr 2019 18:02:42 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 18 Apr 2019 12:50:17 +0200

locking/lockdep: Map remaining magic numbers to lock usage mask names

Clarify the code with mapping some more constant numbers that haven't
been named after their corresponding LOCK_USAGE_* symbol.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/20190402160244.32434-3-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 9c5819ef4a28..2288aa2fa4c6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -516,11 +516,11 @@ static char get_usage_char(struct lock_class *class, enum lock_usage_bit bit)
 {
 	char c = '.';
 
-	if (class->usage_mask & lock_flag(bit + 2))
+	if (class->usage_mask & lock_flag(bit + LOCK_USAGE_DIR_MASK))
 		c = '+';
 	if (class->usage_mask & lock_flag(bit)) {
 		c = '-';
-		if (class->usage_mask & lock_flag(bit + 2))
+		if (class->usage_mask & lock_flag(bit + LOCK_USAGE_DIR_MASK))
 			c = '?';
 	}
 
@@ -1971,7 +1971,10 @@ static const char *state_rnames[] = {
 
 static inline const char *state_name(enum lock_usage_bit bit)
 {
-	return (bit & LOCK_USAGE_READ_MASK) ? state_rnames[bit >> 2] : state_names[bit >> 2];
+	if (bit & LOCK_USAGE_READ_MASK)
+		return state_rnames[bit >> LOCK_USAGE_DIR_MASK];
+	else
+		return state_names[bit >> LOCK_USAGE_DIR_MASK];
 }
 
 static int exclusive_bit(int new_bit)
@@ -3017,7 +3020,7 @@ static int (*state_verbose_f[])(struct lock_class *class) = {
 static inline int state_verbose(enum lock_usage_bit bit,
 				struct lock_class *class)
 {
-	return state_verbose_f[bit >> 2](class);
+	return state_verbose_f[bit >> LOCK_USAGE_DIR_MASK](class);
 }
 
 typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
