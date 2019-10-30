Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6DCCA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DB22087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="hQBmMXBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfJ3Sei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:34:38 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43437 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbfJ3See (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:34:34 -0400
Received: by mail-yw1-f67.google.com with SMTP id g77so1180022ywb.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sCPo7Sa7HT48HXeeD9u54Jo9TW2SXqApycTbqabqamA=;
        b=hQBmMXBtE030jLPi+b9OoEqhm+GlYLhHzFG71MvXJfq6tN7DnEaZObUxiXcvp8yJM8
         rA2lINv0taa91AQ1KQxEutyYsC/pcupxwkuTpRNSS3DwTJW0m2VqpZ7GzK79exctCUdr
         YPub1UR6ihiKWvaGOQhGsV04S0Jwhg5oGj1rQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sCPo7Sa7HT48HXeeD9u54Jo9TW2SXqApycTbqabqamA=;
        b=dvQ6I+0C+7al8XWFAbBv0O4M90W+0kDXl+fil5EaAn1oN2+bweUAFRP6RNbmbRoPn+
         D1bPZg8vKxNje/+UOxdWCh7e7iJe6hQk1qkaeVozLPhjPRw8QK1da7ThOADO+ytYa1yY
         y6kIRVij2QtMhvVDRStKTVE+RI3yJL8Gp/k/teqdih/VUTGPHlDiODHBUSMG/ehmQbNz
         9Kgt2Qhrjneq35+WatZPIFIwKc5D9B1n/m7YmdGyr1TVj8+JAZCRvSSgxGuhRzrcTE/P
         SLx0CRUDR6hY7VOZ7a0ViW9vVuVXsoxHiF32eSKHaZ0UWPtvLo9M7hocrCP17lNrDkhv
         t7Mg==
X-Gm-Message-State: APjAAAV8bomJ59vJmu8k/rK+3MqUP5k3r+hGBTudyTmi83357DcRRFij
        oYslvxCaqHnNdHxlHfzi7Uy/IQ==
X-Google-Smtp-Source: APXvYqxyRCbl173Y2AJcQqH0jMpvgTa3A4ebqWxDo3vdlfW7bs37KYq7Yd0C9KcKF0zDmNykSN4h7Q==
X-Received: by 2002:a81:6cd6:: with SMTP id h205mr841373ywc.119.1572460472652;
        Wed, 30 Oct 2019 11:34:32 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id m205sm558325ywd.82.2019.10.30.11.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:34:32 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH v4 19/19] sched/fair : Wake up forced idle siblings if needed
Date:   Wed, 30 Oct 2019 18:33:32 +0000
Message-Id: <4aaad8379b0b54eca2df9a91cbc0eda47a7a8faf.1572437285.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Lu <aaron.lu@linux.alibaba.com>

If the sibling of a forced idle cpu has only one task and if it has
used up its timeslice, then we should try to wake up the forced idle
cpu to give the starving task on it a chance.

Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
---
 kernel/sched/fair.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e8dd78a8c54d..9d4cc97d4dd8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4165,6 +4165,13 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		update_min_vruntime(cfs_rq);
 }
 
+static inline bool
+__entity_slice_used(struct sched_entity *se)
+{
+	return (se->sum_exec_runtime - se->prev_sum_exec_runtime) >
+		sched_slice(cfs_rq_of(se), se);
+}
+
 /*
  * Preempt the current task with a newly woken task if needed:
  */
@@ -10052,6 +10059,34 @@ static void rq_offline_fair(struct rq *rq)
 
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_SCHED_CORE
+/*
+ * If runqueue has only one task which used up its slice and
+ * if the sibling is forced idle, then trigger schedule
+ * to give forced idle task a chance.
+ */
+static void resched_forceidle_sibling(struct rq *rq, struct sched_entity *se)
+{
+	int cpu = cpu_of(rq), sibling_cpu;
+	if (rq->cfs.nr_running > 1 || !__entity_slice_used(se))
+		return;
+
+	for_each_cpu(sibling_cpu, cpu_smt_mask(cpu)) {
+		struct rq *sibling_rq;
+		if (sibling_cpu == cpu)
+			continue;
+		if (cpu_is_offline(sibling_cpu))
+			continue;
+
+		sibling_rq = cpu_rq(sibling_cpu);
+		if (sibling_rq->core_forceidle) {
+			resched_curr(sibling_rq);
+		}
+	}
+}
+#endif
+
+
 /*
  * scheduler tick hitting a task of our scheduling class.
  *
@@ -10075,6 +10110,11 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
+
+#ifdef CONFIG_SCHED_CORE
+	if (sched_core_enabled(rq))
+		resched_forceidle_sibling(rq, &curr->se);
+#endif
 }
 
 /*
-- 
2.17.1

