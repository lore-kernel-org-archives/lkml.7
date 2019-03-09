Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5980EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F689207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfCIOmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 09:42:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48087 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCIOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 09:42:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29EfeCY3109570
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 06:41:41 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29Efep23109566;
        Sat, 9 Mar 2019 06:41:40 -0800
Date:   Sat, 9 Mar 2019 06:41:40 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-0126574fca2ce0f0d5beb9dade6efb823ff7407b@git.kernel.org>
Cc:     mingo@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, will.deacon@arm.com, hpa@zytor.com,
        peterz@infradead.org, akpm@linux-foundation.org, luto@kernel.org,
        paulmck@linux.vnet.ibm.com, tglx@linutronix.de, bp@alien8.de,
        torvalds@linux-foundation.org, bvanassche@acm.org, riel@surriel.com
Reply-To: mingo@kernel.org, dave.hansen@linux.intel.com,
          linux-kernel@vger.kernel.org, will.deacon@arm.com, hpa@zytor.com,
          luto@kernel.org, akpm@linux-foundation.org, peterz@infradead.org,
          paulmck@linux.vnet.ibm.com, tglx@linutronix.de, bp@alien8.de,
          torvalds@linux-foundation.org, bvanassche@acm.org,
          riel@surriel.com
In-Reply-To: <c20aa0f0-42ab-a884-d931-7d4ec2bf0cdc@acm.org>
References: <c20aa0f0-42ab-a884-d931-7d4ec2bf0cdc@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/lockdep: Only call init_rcu_head()
 after RCU has been initialized
Git-Commit-ID: 0126574fca2ce0f0d5beb9dade6efb823ff7407b
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

Commit-ID:  0126574fca2ce0f0d5beb9dade6efb823ff7407b
Gitweb:     https://git.kernel.org/tip/0126574fca2ce0f0d5beb9dade6efb823ff7407b
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Sun, 3 Mar 2019 10:19:01 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 9 Mar 2019 14:15:51 +0100

locking/lockdep: Only call init_rcu_head() after RCU has been initialized

init_data_structures_once() is called for the first time before RCU has
been initialized. Make sure that init_rcu_head() is called before the
RCU head is used and after RCU has been initialized.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: longman@redhat.com
Link: https://lkml.kernel.org/r/c20aa0f0-42ab-a884-d931-7d4ec2bf0cdc@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 35a144dfddf5..34cdcbedda49 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -982,15 +982,22 @@ static inline void check_data_structures(void) { }
  */
 static void init_data_structures_once(void)
 {
-	static bool initialization_happened;
+	static bool ds_initialized, rcu_head_initialized;
 	int i;
 
-	if (likely(initialization_happened))
+	if (likely(rcu_head_initialized))
 		return;
 
-	initialization_happened = true;
+	if (system_state >= SYSTEM_SCHEDULING) {
+		init_rcu_head(&delayed_free.rcu_head);
+		rcu_head_initialized = true;
+	}
+
+	if (ds_initialized)
+		return;
+
+	ds_initialized = true;
 
-	init_rcu_head(&delayed_free.rcu_head);
 	INIT_LIST_HEAD(&delayed_free.pf[0].zapped);
 	INIT_LIST_HEAD(&delayed_free.pf[1].zapped);
 
