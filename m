Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320B8C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071A02238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="zQpxCGRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389184AbfGYQEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:04:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48051 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388481AbfGYQEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:04:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PG3RIM1071304
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:03:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PG3RIM1071304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564070608;
        bh=A2BsfU+o5G861v52udO74SU0jEv17wo3QrmMOENtt5c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=zQpxCGRUVOg8hAlv+h5QNII9ja+fUS1rUoHFeUc7ceQRGtK/nTT6XEIJ+CsFroIyj
         yF0OrcsxXGRGRzdKBisbEPLqjTnP+7U+SjFXMEsph/IWrxmB0ZeWqbfgzv+eHI19pC
         OH/tsnhEwz+Z+T7WToymS7vxn9STHQuEJP7myscbVei0t8rOeK7Q6g6i+hMn5dKjEE
         pSkt/1UhzXJkP4Yx75V8SUKi4hvN28kJhLz/WpMosyQawqIiWjzZjhu/1uj2vGFLcx
         1lUgN+cgcCLuHI7GKLmA26i4f9Tlhjb9urkLnS1F1u7FnQmHiOq0vtNRSRJslJGnPC
         GtUqgI1JVXn2Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PG3QZP1071300;
        Thu, 25 Jul 2019 09:03:26 -0700
Date:   Thu, 25 Jul 2019 09:03:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-68037aa78208f34bda4e5cd76c357f718b838cbb@git.kernel.org>
Cc:     cai@lca.pw, akpm@linux-foundation.org, will@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        bvanassche@acm.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, hpa@zytor.com, longman@redhat.com,
        duyuyang@gmail.com
Reply-To: will@kernel.org, paulmck@linux.vnet.ibm.com, mingo@kernel.org,
          tglx@linutronix.de, akpm@linux-foundation.org, cai@lca.pw,
          hpa@zytor.com, torvalds@linux-foundation.org, duyuyang@gmail.com,
          longman@redhat.com, arnd@arndb.de, bvanassche@acm.org,
          will.deacon@arm.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190715092809.736834-1-arnd@arndb.de>
References: <20190715092809.736834-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Hide unused 'class' variable
Git-Commit-ID: 68037aa78208f34bda4e5cd76c357f718b838cbb
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

Commit-ID:  68037aa78208f34bda4e5cd76c357f718b838cbb
Gitweb:     https://git.kernel.org/tip/68037aa78208f34bda4e5cd76c357f718b838cbb
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Mon, 15 Jul 2019 11:27:49 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:39:25 +0200

locking/lockdep: Hide unused 'class' variable

The usage is now hidden in an #ifdef, so we need to move
the variable itself in there as well to avoid this warning:

  kernel/locking/lockdep_proc.c:203:21: error: unused variable 'class' [-Werror,-Wunused-variable]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Yuyang Du <duyuyang@gmail.com>
Cc: frederic@kernel.org
Fixes: 68d41d8c94a3 ("locking/lockdep: Fix lock used or unused stats error")
Link: https://lkml.kernel.org/r/20190715092809.736834-1-arnd@arndb.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep_proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 65b6a1600c8f..bda006f8a88b 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -200,7 +200,6 @@ static void lockdep_stats_debug_show(struct seq_file *m)
 
 static int lockdep_stats_show(struct seq_file *m, void *v)
 {
-	struct lock_class *class;
 	unsigned long nr_unused = 0, nr_uncategorized = 0,
 		      nr_irq_safe = 0, nr_irq_unsafe = 0,
 		      nr_softirq_safe = 0, nr_softirq_unsafe = 0,
@@ -211,6 +210,8 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 		      sum_forward_deps = 0;
 
 #ifdef CONFIG_PROVE_LOCKING
+	struct lock_class *class;
+
 	list_for_each_entry(class, &all_lock_classes, lock_entry) {
 
 		if (class->usage_mask == 0)
