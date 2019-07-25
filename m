Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF59C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC14D229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MG1GENW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390020AbfGYQLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:11:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41351 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGYQLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:11:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGAr4p1074192
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:10:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGAr4p1074192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071054;
        bh=TIQnxAZHlGeqm52QqtxDCN8XXiFa0PibdmQGR0ZHeO8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MG1GENW/wQWDbb41fU9TBSNl93c0fC9VITB/qNIOKroCz8SCNZs1gtPQr7MvXgvLB
         +IrKsI/v42rBJxmwTk3Bj81YsxutR4b3DiIQ6FNMPxjQJpKKS92+OHSZKWzN4qcgQ0
         YsbQhMWlHvwGe42nqNyrTgeCOF5YT7imZoTqtswHIcrqE+X7F4FG3b91yiSUFo6WpP
         OlSuf2oDmsH8W6d2NECrv+UZvySbI3n6l5UOKsXbtOd84C3rlfuA/qptRzqsQxQ3TL
         davRTf9ZSrwP1Oi8xvGSC8bFrTk3ehFPQgoQUPp8RX5AcpckC6KsFxkh28cxuwnZmz
         NaGQlkrANYCEg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGArNM1074189;
        Thu, 25 Jul 2019 09:10:53 -0700
Date:   Thu, 25 Jul 2019 09:10:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-8c779229d0f4fe83ead90bdcbbf08b02989aa200@git.kernel.org>
Cc:     bvanassche@acm.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        longman@redhat.com, hpa@zytor.com, mingo@kernel.org
Reply-To: torvalds@linux-foundation.org, will.deacon@arm.com,
          linux-kernel@vger.kernel.org, bvanassche@acm.org,
          tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          longman@redhat.com, peterz@infradead.org
In-Reply-To: <20190722182443.216015-5-bvanassche@acm.org>
References: <20190722182443.216015-5-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Report more stack trace
 statistics
Git-Commit-ID: 8c779229d0f4fe83ead90bdcbbf08b02989aa200
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

Commit-ID:  8c779229d0f4fe83ead90bdcbbf08b02989aa200
Gitweb:     https://git.kernel.org/tip/8c779229d0f4fe83ead90bdcbbf08b02989aa200
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Mon, 22 Jul 2019 11:24:43 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:43:28 +0200

locking/lockdep: Report more stack trace statistics

Report the number of stack traces and the number of stack trace hash
chains. These two numbers are useful because these allow to estimate
the number of stack trace hash collisions.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/20190722182443.216015-5-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c           | 29 +++++++++++++++++++++++++++++
 kernel/locking/lockdep_internals.h |  4 ++++
 kernel/locking/lockdep_proc.c      |  6 ++++++
 3 files changed, 39 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1a96869cb2f0..3c3902c40a0e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -516,6 +516,35 @@ static struct lock_trace *save_trace(void)
 
 	return trace;
 }
+
+/* Return the number of stack traces in the stack_trace[] array. */
+u64 lockdep_stack_trace_count(void)
+{
+	struct lock_trace *trace;
+	u64 c = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(stack_trace_hash); i++) {
+		hlist_for_each_entry(trace, &stack_trace_hash[i], hash_entry) {
+			c++;
+		}
+	}
+
+	return c;
+}
+
+/* Return the number of stack hash chains that have at least one stack trace. */
+u64 lockdep_stack_hash_count(void)
+{
+	u64 c = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(stack_trace_hash); i++)
+		if (!hlist_empty(&stack_trace_hash[i]))
+			c++;
+
+	return c;
+}
 #endif
 
 unsigned int nr_hardirq_chains;
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 93a008bf77db..18d85aebbb57 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -140,6 +140,10 @@ extern unsigned int max_bfs_queue_depth;
 #ifdef CONFIG_PROVE_LOCKING
 extern unsigned long lockdep_count_forward_deps(struct lock_class *);
 extern unsigned long lockdep_count_backward_deps(struct lock_class *);
+#ifdef CONFIG_TRACE_IRQFLAGS
+u64 lockdep_stack_trace_count(void);
+u64 lockdep_stack_hash_count(void);
+#endif
 #else
 static inline unsigned long
 lockdep_count_forward_deps(struct lock_class *class)
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index ed9842425cac..dadb7b7fba37 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -285,6 +285,12 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 			nr_process_chains);
 	seq_printf(m, " stack-trace entries:           %11lu [max: %lu]\n",
 			nr_stack_trace_entries, MAX_STACK_TRACE_ENTRIES);
+#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+	seq_printf(m, " number of stack traces:        %llu\n",
+		   lockdep_stack_trace_count());
+	seq_printf(m, " number of stack hash chains:   %llu\n",
+		   lockdep_stack_hash_count());
+#endif
 	seq_printf(m, " combined max dependencies:     %11u\n",
 			(nr_hardirq_chains + 1) *
 			(nr_softirq_chains + 1) *
