Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D93C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211DD21985
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbfGVSY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:24:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45673 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731715AbfGVSY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:24:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so18043056pgp.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uk+4XtkOOEybIk+H0HjUDGStzTJm5yLDzlE/r6X1gHU=;
        b=H7vAswfmjbNIp10/Qjdr82Twf9GVzUkIj1Rpa10i0rAr69zAbm9T0yhZS6dvaFIQNr
         Pg5dq+LFa5aP8BAYmnQzjwA4aUh+HCqKPXMw1QocJFvowUP2uf0dzI6UIqV/wzzVPLGo
         h5W6ZUuRkkixyAK7kOP43bmPaw/HdiZiPfc4rpUFJq+yUqxNzyuOql0W+rbfARsA2WR+
         zGOYSMMTOfPh02Yuh/subchPJbISia+5lvY3kBWY53z9zSZLPGvfhH9kA5JIOkd2OlCs
         Bhe32fHuoIzTG+Nbd0KWE9zHz7041q5YMQeR/XxoSL5utY4crQwciXePfDo/EpeNevYG
         wRZQ==
X-Gm-Message-State: APjAAAVQIKNxgKW+eo8lQTO7usykF01lfZY6fvjLIWNpM+7fPZoAHOHf
        emOmxPQeecR4uXOAj8ZcE7U=
X-Google-Smtp-Source: APXvYqy+adPT8p44KMGPwUA6SNK0rOwrBo7t0HUDsrQprMo+4WIVdB0y++tL1HD5i0wfLyuQdvDHGg==
X-Received: by 2002:a65:62c4:: with SMTP id m4mr71171165pgv.243.1563819895639;
        Mon, 22 Jul 2019 11:24:55 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id p23sm44556008pfn.10.2019.07.22.11.24.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:24:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 4/4] locking/lockdep: Report more stack trace statistics
Date:   Mon, 22 Jul 2019 11:24:43 -0700
Message-Id: <20190722182443.216015-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722182443.216015-1-bvanassche@acm.org>
References: <20190722182443.216015-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Report the number of stack traces and the number of stack trace hash
chains. These two numbers are useful because these allow to estimate
the number of stack trace hash collisions.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c           | 29 +++++++++++++++++++++++++++++
 kernel/locking/lockdep_internals.h |  4 ++++
 kernel/locking/lockdep_proc.c      |  6 ++++++
 3 files changed, 39 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 19eace34b5fa..320346b3bdbb 100644
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
index 1ba5780182e7..64b5b47ab117 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -284,6 +284,12 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
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
-- 
2.22.0.657.g960e92d24f-goog

