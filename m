Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28292CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 11:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F399420862
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 11:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkOXBmNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfJ3LSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 07:18:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37390 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfJ3LSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 07:18:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id q130so1702515wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 04:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RuPxJiOhy1TksXQbxGnEdNQWiW6DMirlb9h1UddzLpQ=;
        b=xkOXBmNXF87UzY6oVz2q5LDZcXjFl3ddOGdr5h+J2C5hvXM1HeC7N+BnyxfdS9Fh5N
         phzeuI+opX4XzEaD6zh8gHvU4uKaRLr6z/KDoukjJ2woYRNHeQDgVQcBsoHUxvDq8mjU
         nWeJ8FdXTlhaTbGPF2wrEwjByMNTq83GTwogjtbbTOFcwhnwx4BIc5ziIV08rvZzfCrW
         AmaXtqmbStD2DhONOUQXfwFxzVqar4OtLrW4AagcHPIBqAjWkYrbC6NdR2O+KwAtAdTQ
         ycfORqHr0dQhGKku1YoV0xpGDPDW4/44/031NUknc6nusSqo/ZP/0Q7NBXF6mJqzVuPO
         Dakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RuPxJiOhy1TksXQbxGnEdNQWiW6DMirlb9h1UddzLpQ=;
        b=DZc4/8tqauCeNlpGZnmc3LsJVWwgebRC4c7xijZWpWeoHMuAUsmdKHfMg2VrnMb4V/
         pu9Pp7lIyQ7l8Ht8U+zgdtEloY5LZWO9bfUrAj4hiDaRH77tz7m2fkVEqRF+QKKZDC+O
         M0mRFO3tEiLQrt8m4V8Pj99j4v6r7M/0H/qUf433Mcp7jdpKGPSXEdMsB0s0GkkY6RKG
         uu/zig7/NhgEP/bxKpUUISoQr9v5AHtstRDATYZc+bJlKXfqIbfcJdDLQ7OxPTGIVw+E
         xOfMjeTOPDlKq/EYQF9jojseRcP2eUbTqu3LXbNQAxfvqZj6UD5J+RFne7TT0koKcW/s
         OKbA==
X-Gm-Message-State: APjAAAW/pu6lt9kpC6fSwXJU+rDnaM+Hjehp7lRyQ9mb9rgudEjcM1V1
        ibSAxM+KMEYgeKLAST3WEfft09dduy0=
X-Google-Smtp-Source: APXvYqw9DwDro23o1BUt/xP+wff1i5Gq9Nmepy0P7/CLSoltTHv/s72GysgCgxVzBOnSpTxCOhURTw==
X-Received: by 2002:a7b:cf33:: with SMTP id m19mr315030wmg.146.1572434320564;
        Wed, 30 Oct 2019 04:18:40 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ac53:afe6:58b0:b88d])
        by smtp.gmail.com with ESMTPSA id t24sm3024613wra.55.2019.10.30.04.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Oct 2019 04:18:39 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, mgorman@suse.de
Cc:     dsmythies@telus.net, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/pelt: fix update of blocked pelt ordering
Date:   Wed, 30 Oct 2019 12:18:29 +0100
Message-Id: <1572434309-32512-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_cfs_rq_load_avg() can call cpufreq_update_util() to trigger an
update of the frequency. Make sure that RT, DL and IRQ pelt signals have
been updated before calling cpufreq

Fixes: 371bf4273269 ("sched/rt: Add rt_rq utilization tracking")
Fixes: 3727e0e16340 ("sched/dl: Add dl_rq utilization tracking")
Fixes: 91c27493e78d ("sched/irq: Add IRQ utilization tracking")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a144874..adc923f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7446,6 +7446,19 @@ static void update_blocked_averages(int cpu)
 	update_rq_clock(rq);
 
 	/*
+	 * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
+	 * that RT, DL and IRQ signals have been updated before updating CFS.
+	 */
+	curr_class = rq->curr->sched_class;
+	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
+	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
+	update_irq_load_avg(rq, 0);
+
+	/* Don't need periodic decay once load/util_avg are null */
+	if (others_have_blocked(rq))
+		done = false;
+
+	/*
 	 * Iterates the task_group tree in a bottom up fashion, see
 	 * list_add_leaf_cfs_rq() for details.
 	 */
@@ -7472,14 +7485,6 @@ static void update_blocked_averages(int cpu)
 			done = false;
 	}
 
-	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
-	update_irq_load_avg(rq, 0);
-	/* Don't need periodic decay once load/util_avg are null */
-	if (others_have_blocked(rq))
-		done = false;
-
 	update_blocked_load_status(rq, !done);
 	rq_unlock_irqrestore(rq, &rf);
 }
@@ -7540,12 +7545,18 @@ static inline void update_blocked_averages(int cpu)
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
-	update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
 
+	/*
+	 * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
+	 * that RT, DL and IRQ signals have been updated before updating CFS.
+	 */
 	curr_class = rq->curr->sched_class;
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
+
+	update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
+
 	update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
 	rq_unlock_irqrestore(rq, &rf);
 }
-- 
2.7.4

