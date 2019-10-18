Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC30CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE10222CC
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YexuFZ4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410335AbfJRN1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:27:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56134 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410292AbfJRN1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:27:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so6169546wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 06:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U+L99VOS6caLFt+CoaTBRiqHtekpuXrbr4pGYmwWDiE=;
        b=YexuFZ4fjlY6AevXkLYwKDu06ECkTRx8vSIFlXx6hDq+1v+NVL84yLK2F9YZbhhFxG
         FXfR5Ko8czlD+FeLKLYoY9Ve/rxWNtsqruSpX0mZBJMXp9pe1oiSc8KPR6wy2SJCuJCH
         wQxXCJh4t7J5njM9BWDMVuGFItJGfZd7xOiUmzwaRnnw9UqkPPJJw8lqPBXbLmzoAlZw
         AQvBqx+pW3YfnOkARBIxpcZCNQfSq6co36YadtT5BFN09zMaMkqojXMIQRX+Lboka8Fw
         mfBRYyX6DfVIUqkxTx/bmo/08rM/gz1lGdpa9xv2YPg0j1ANnF0zUAWThZIhrYkXklhH
         UIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U+L99VOS6caLFt+CoaTBRiqHtekpuXrbr4pGYmwWDiE=;
        b=JDt6yMQ0j4UONOwZqL384Ghcm3lD+Pqk80jn315ymPy5ZyWBo1laG2IEhJ5f7BqL73
         I9oXSNlrujML96/dJEZxBOOU3DmvnWY9vWOdpF5e3heMeSYXSZw7hcwTGYP6cDMjdNBs
         AP3OEyRCD5b7MpyxVoXHHFEaYZsA4quzSVHClNKe4d4B//uktrKAwJ8AWVhW08Pxkimz
         yIIvdo996axB0ljEtl1R8fVGQ6W0zwZmhA4YuRCYDumOTSaAn203lDcCsnPWWZUr1/M/
         7h9Oz49wFEb4DgO2qoPu0NrXz0LrcxmPRWTkCks+Mb5PkFIZ1w3hHCo5BWTnlKrPhUqR
         M6fQ==
X-Gm-Message-State: APjAAAWwHni/5VdNRGm07BZPxZd6fCrHrTvHNfzT8bTIws4eDKD3S3QG
        18vrHSyePVD1r0wmEu6MmrI30j9W+Dk=
X-Google-Smtp-Source: APXvYqzPtB3AW8f2LEc+55f4M+WMCvGt7WbJ/ZZAOK7l7n15Yxj8EdUjmEDMBE4vjb/D2/fLlINlOQ==
X-Received: by 2002:a05:600c:23cc:: with SMTP id p12mr3592277wmb.163.1571405216635;
        Fri, 18 Oct 2019 06:26:56 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id p15sm5870123wrs.94.2019.10.18.06.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 06:26:55 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 07/11] sched/fair: evenly spread tasks when not overloaded
Date:   Fri, 18 Oct 2019 15:26:34 +0200
Message-Id: <1571405198-27570-8-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is only 1 cpu per group, using the idle cpus to evenly spread
tasks doesn't make sense and nr_running is a better metrics.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9ac2264..9b8e20d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8601,18 +8601,34 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	    busiest->sum_nr_running > local->sum_nr_running + 1)
 		goto force_balance;
 
-	if (busiest->group_type != group_overloaded &&
-	     (env->idle == CPU_NOT_IDLE ||
-	      local->idle_cpus <= (busiest->idle_cpus + 1)))
-		/*
-		 * If the busiest group is not overloaded
-		 * and there is no imbalance between this and busiest group
-		 * wrt idle CPUs, it is balanced. The imbalance
-		 * becomes significant if the diff is greater than 1 otherwise
-		 * we might end up to just move the imbalance on another
-		 * group.
-		 */
-		goto out_balanced;
+	if (busiest->group_type != group_overloaded) {
+		if (env->idle == CPU_NOT_IDLE)
+			/*
+			 * If the busiest group is not overloaded (and as a
+			 * result the local one too) but this cpu is already
+			 * busy, let another idle cpu try to pull task.
+			 */
+			goto out_balanced;
+
+		if (busiest->group_weight > 1 &&
+		    local->idle_cpus <= (busiest->idle_cpus + 1))
+			/*
+			 * If the busiest group is not overloaded
+			 * and there is no imbalance between this and busiest
+			 * group wrt idle CPUs, it is balanced. The imbalance
+			 * becomes significant if the diff is greater than 1
+			 * otherwise we might end up to just move the imbalance
+			 * on another group. Of course this applies only if
+			 * there is more than 1 CPU per group.
+			 */
+			goto out_balanced;
+
+		if (busiest->sum_h_nr_running == 1)
+			/*
+			 * busiest doesn't have any tasks waiting to run
+			 */
+			goto out_balanced;
+	}
 
 force_balance:
 	/* Looks like there is an imbalance. Compute it */
-- 
2.7.4

