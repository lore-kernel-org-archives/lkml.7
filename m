Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A1AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F16214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VtmWPyO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388825AbfDRL0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:26:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40525 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRL0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:26:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3IBQ5iO166649
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Apr 2019 04:26:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3IBQ5iO166649
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555586766;
        bh=aG75LDi+S/MLkFq6ZRzL6s1NCKZSoTNA0rV7fYcp8s4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=VtmWPyO8YodinRU+8RfkGCbmwFFUFbJK0CsC1LgeuG9vPApneyYBErgk+FeN/iopb
         ZnvQzJiuxBxpRCQcqve2Y8+eWwCalNv5cN8qIMa9tdtuYwdtGJ9gJmyEwXqCpByVZ0
         zxrntZ24+1gl2IN5EdkZXSSX2tyeR478AeLr5+4DZJ9HTRapXFu4zkTu/UpcM9BLSz
         zub9p5mc/3X/fZfju21UXawPzckkjqrptRR2km1FcuI0mGntccmKaDaOr842Gjze+H
         yRXfuUUF4ktqJorbc+lfduqdzYiyiEL3TLOuDTwIR0Vqhr/lS9io1CAefAKpVW3znQ
         xzR+FP4pVSbnA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3IBQ419166645;
        Thu, 18 Apr 2019 04:26:04 -0700
Date:   Thu, 18 Apr 2019 04:26:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-0d2cc3b3453254f1c56f9456ba03e092ed4cfb72@git.kernel.org>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        frederic@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, paulmck@linux.vnet.ibm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          paulmck@linux.vnet.ibm.com, will.deacon@arm.com,
          akpm@linux-foundation.org, torvalds@linux-foundation.org,
          frederic@kernel.org, tglx@linutronix.de, mingo@kernel.org,
          peterz@infradead.org
In-Reply-To: <20190402160244.32434-2-frederic@kernel.org>
References: <20190402160244.32434-2-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Move valid_state() inside
 CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING
Git-Commit-ID: 0d2cc3b3453254f1c56f9456ba03e092ed4cfb72
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

Commit-ID:  0d2cc3b3453254f1c56f9456ba03e092ed4cfb72
Gitweb:     https://git.kernel.org/tip/0d2cc3b3453254f1c56f9456ba03e092ed4cfb72
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 2 Apr 2019 18:02:41 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 18 Apr 2019 12:50:17 +0200

locking/lockdep: Move valid_state() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING

valid_state() and print_usage_bug*() functions are not used beyond
irq locking correctness checks under CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING.

Sadly the "unused function" warning wouldn't fire because valid_state()
is inline so the unused case has remained unseen until now.

So move them inside the appropriate CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING
section.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/20190402160244.32434-2-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 34cdcbedda49..9c5819ef4a28 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2784,6 +2784,12 @@ static void check_chain_key(struct task_struct *curr)
 #endif
 }
 
+static int mark_lock(struct task_struct *curr, struct held_lock *this,
+		     enum lock_usage_bit new_bit);
+
+#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+
+
 static void
 print_usage_bug_scenario(struct held_lock *lock)
 {
@@ -2853,10 +2859,6 @@ valid_state(struct task_struct *curr, struct held_lock *this,
 	return 1;
 }
 
-static int mark_lock(struct task_struct *curr, struct held_lock *this,
-		     enum lock_usage_bit new_bit);
-
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
 
 /*
  * print irq inversion bug:
