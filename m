Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24496C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6C121A49
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lk+J5omQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388719AbfISHeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:34:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41723 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388657AbfISHeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:34:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so1905342wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E0Lgz25SpUetPrpayHmg7zZdcUkNn2aH/KnWe2aleok=;
        b=Lk+J5omQRVbDf3S2TzthQ2TDCGVfOORMYRykG6caePHrKT4UJLOqzRiVomJwl0v6Si
         Zh5ON9sbhJ3nB4SATF5E6spIrYRy8+8bz2gvvd3eEajirzSv9l/jYn4+YCiLanGOZJ35
         EpdhzEhoSF5cMu0ARjJSK84l14QiFALGNWSAFpLF4vIQWtWC86co/Bs+WpB0RJJZ3M4k
         SURkqGWEDAhRG0csovcm51s9ACqc0d09JHgtg3SWiN6HbXPJQdcNvKa6e1UORvVRXGsr
         bQsDRMz6SxErS/ZnVS1aw3rLhFF7KIdAi11uZaFZU3FpnW9vP97JToCaCnWADiFYI899
         cQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E0Lgz25SpUetPrpayHmg7zZdcUkNn2aH/KnWe2aleok=;
        b=X+Yy4f2QpthjB8UAnpPiv2iP7sr0MQGjdT/7UDzQGwM3RmSO9vhVpjkDl/S5MZDfhN
         B6seS9RFczJefpahLJ2K6El2KV3NTm4s5n/rKLYWyWYfW+yK8y/pQ4fVT0ztlf/O/i6Y
         nH2JrP2SdAX1IjaZwpNV/WeP4tSAbTqMRFs7AF/wQ6ZMr5HR+KeNVXA3x2yiE0r2rS3F
         DCL/QH+uqN+L0Om2GhXcEmONpy0ycaUvs+oCy1UhteJkt2ONaRpSrsH5oUF2H35A15kL
         ZDRveVwT/53IO6gZl2YpzbS7SErq3lVYN2ULhXBRmoXKJDU7q3h7hG7kG7uJ7xG0wlTL
         Y2yg==
X-Gm-Message-State: APjAAAV8VTT4u7VlS49ZOIgwwZhNEOh2kwmdYPKftDyGLac3E0Wqdl3H
        3iPrASnjirra2cH1YG63EFurJHuK7Aw=
X-Google-Smtp-Source: APXvYqwyH0ReRA+hACHu1N8L5JDB+XX6bhNeHhHxkFsFk/LoCqsOeHrc1ozMrVhwY73vgXh/+lY/3A==
X-Received: by 2002:adf:dbc6:: with SMTP id e6mr1492515wrj.149.1568878453024;
        Thu, 19 Sep 2019 00:34:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d555:8fca:a19c:222c])
        by smtp.gmail.com with ESMTPSA id s12sm13300250wra.82.2019.09.19.00.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 00:34:11 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 09/10] sched/fair: use load instead of runnable load in wakeup path
Date:   Thu, 19 Sep 2019 09:33:40 +0200
Message-Id: <1568878421-12301-10-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

runnable load has been introduced to take into account the case where
blocked load biases the wake up path which may end to select an overloaded
CPU with a large number of runnable tasks instead of an underutilized
CPU with a huge blocked load.

Tha wake up path now starts to looks for idle CPUs before comparing
runnable load and it's worth aligning the wake up path with the
load_balance.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index acca869..39a37ae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5485,7 +5485,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	s64 this_eff_load, prev_eff_load;
 	unsigned long task_load;
 
-	this_eff_load = cpu_runnable_load(cpu_rq(this_cpu));
+	this_eff_load = cpu_load(cpu_rq(this_cpu));
 
 	if (sync) {
 		unsigned long current_load = task_h_load(current);
@@ -5503,7 +5503,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 		this_eff_load *= 100;
 	this_eff_load *= capacity_of(prev_cpu);
 
-	prev_eff_load = cpu_runnable_load(cpu_rq(prev_cpu));
+	prev_eff_load = cpu_load(cpu_rq(prev_cpu));
 	prev_eff_load -= task_load;
 	if (sched_feat(WA_BIAS))
 		prev_eff_load *= 100 + (sd->imbalance_pct - 100) / 2;
@@ -5591,7 +5591,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 		max_spare_cap = 0;
 
 		for_each_cpu(i, sched_group_span(group)) {
-			load = cpu_runnable_load(cpu_rq(i));
+			load = cpu_load(cpu_rq(i));
 			runnable_load += load;
 
 			avg_load += cfs_rq_load_avg(&cpu_rq(i)->cfs);
@@ -5732,7 +5732,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 				continue;
 			}
 
-			load = cpu_runnable_load(cpu_rq(i));
+			load = cpu_load(cpu_rq(i));
 			if (load < min_load) {
 				min_load = load;
 				least_loaded_cpu = i;
-- 
2.7.4

