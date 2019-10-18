Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEA0CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED999222CC
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0oDhG1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442845AbfJRN1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:27:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55007 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438919AbfJRN1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:27:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so6193216wmp.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 06:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rF17NfzVuoPQDjrV4B8MSfUDRkdA/P46N9yA+eCB77U=;
        b=G0oDhG1tp21hqgoc0Wftnssc9hxoXtNaWmw+rX4yhbE0TfCUsLCUi2lUibmsO/dO+R
         ZAeKslXiKdUvQNF5+/tWf8z9YDwDNh6iP0kqNAH1W7mjk3OIIDkR25vTWoJeiXryGQz6
         CiTA0HSae02uTYsH1CtxaxiWGKU6dikwaGiWNLbOlebv82W4MPTw/9aOJKRbnidMVfeA
         Edeo7C2SnFT5Q3TH25FB1bmiIn4sAIFVK0vMDtEm3krbAKip3CQ9qFFs0X7/Il3cQIrx
         65F2uNoLKYHNl6GoBI/NfYUfqLUT+Mb/g1cOXMKKY6xumD9nWHZhvz1+B80kCITNjZRm
         ysYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rF17NfzVuoPQDjrV4B8MSfUDRkdA/P46N9yA+eCB77U=;
        b=WhrzCnH9Uzd9PTCSlpWmeaRs+6XZCBCzoW4qm1a6nAnaMWYEnQB59BC4PPMFPXTT0M
         VlEM/2ZW570TEfRGRbZfzrIJ06Lk1SX6HFXHaX4QQv83xC2KtBgDh1UW1bMdnns6WNRd
         Phpq6zMvGb7eqWWJ691lMuYZJb8JUT/PeSIFX6Ir7daPci0PBjrHesSRzV1QsLVITYQC
         s3NH114Y/PtJwFtpBfn5ePzuda1pZcWp72etLjbtatC49sqURXuSSSEv4f16a0X0Z4FY
         oslzxadSRrLBfaQEF6ojeDhOzB7JW9UBNqREaDSY0I6KaAs07zEuzLti6c0lJPc3+Mwv
         u3/A==
X-Gm-Message-State: APjAAAVW5ilrALn/gTZsmZREvgOWYTe9vS3UMNcNMy/tmqKXRRC8DwIo
        QFlFsQQUNS9a53AUvZThx9MJvYLO2KY=
X-Google-Smtp-Source: APXvYqyEZEMxnWUCkzubwAXrgo1WeACT1rmIKkzmasKqr0n+u4Gc4VfVshY6pSNgGQ1RQeQfjm/LiQ==
X-Received: by 2002:a1c:9c0c:: with SMTP id f12mr1836748wme.133.1571405222144;
        Fri, 18 Oct 2019 06:27:02 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id p15sm5870123wrs.94.2019.10.18.06.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 06:27:00 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 10/11] sched/fair: optimize find_idlest_group
Date:   Fri, 18 Oct 2019 15:26:37 +0200
Message-Id: <1571405198-27570-11-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_idlest_group() now reads CPU's load_avg in 2 different ways.
Consolidate the function to read and use load_avg only once and simplify
the algorithm to only look for the group with lowest load_avg.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 50 ++++++++++++++------------------------------------
 1 file changed, 14 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6203e71..ed1800d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5560,16 +5560,14 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 {
 	struct sched_group *idlest = NULL, *group = sd->groups;
 	struct sched_group *most_spare_sg = NULL;
-	unsigned long min_runnable_load = ULONG_MAX;
-	unsigned long this_runnable_load = ULONG_MAX;
-	unsigned long min_avg_load = ULONG_MAX, this_avg_load = ULONG_MAX;
+	unsigned long min_load = ULONG_MAX, this_load = ULONG_MAX;
 	unsigned long most_spare = 0, this_spare = 0;
 	int imbalance_scale = 100 + (sd->imbalance_pct-100)/2;
 	unsigned long imbalance = scale_load_down(NICE_0_LOAD) *
 				(sd->imbalance_pct-100) / 100;
 
 	do {
-		unsigned long load, avg_load, runnable_load;
+		unsigned long load;
 		unsigned long spare_cap, max_spare_cap;
 		int local_group;
 		int i;
@@ -5586,15 +5584,11 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 		 * Tally up the load of all CPUs in the group and find
 		 * the group containing the CPU with most spare capacity.
 		 */
-		avg_load = 0;
-		runnable_load = 0;
+		load = 0;
 		max_spare_cap = 0;
 
 		for_each_cpu(i, sched_group_span(group)) {
-			load = cpu_load(cpu_rq(i));
-			runnable_load += load;
-
-			avg_load += cfs_rq_load_avg(&cpu_rq(i)->cfs);
+			load += cpu_load(cpu_rq(i));
 
 			spare_cap = capacity_spare_without(i, p);
 
@@ -5603,31 +5597,15 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 		}
 
 		/* Adjust by relative CPU capacity of the group */
-		avg_load = (avg_load * SCHED_CAPACITY_SCALE) /
-					group->sgc->capacity;
-		runnable_load = (runnable_load * SCHED_CAPACITY_SCALE) /
+		load = (load * SCHED_CAPACITY_SCALE) /
 					group->sgc->capacity;
 
 		if (local_group) {
-			this_runnable_load = runnable_load;
-			this_avg_load = avg_load;
+			this_load = load;
 			this_spare = max_spare_cap;
 		} else {
-			if (min_runnable_load > (runnable_load + imbalance)) {
-				/*
-				 * The runnable load is significantly smaller
-				 * so we can pick this new CPU:
-				 */
-				min_runnable_load = runnable_load;
-				min_avg_load = avg_load;
-				idlest = group;
-			} else if ((runnable_load < (min_runnable_load + imbalance)) &&
-				   (100*min_avg_load > imbalance_scale*avg_load)) {
-				/*
-				 * The runnable loads are close so take the
-				 * blocked load into account through avg_load:
-				 */
-				min_avg_load = avg_load;
+			if (load < min_load) {
+				min_load = load;
 				idlest = group;
 			}
 
@@ -5668,18 +5646,18 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 	 * local domain to be very lightly loaded relative to the remote
 	 * domains but "imbalance" skews the comparison making remote CPUs
 	 * look much more favourable. When considering cross-domain, add
-	 * imbalance to the runnable load on the remote node and consider
-	 * staying local.
+	 * imbalance to the load on the remote node and consider staying
+	 * local.
 	 */
 	if ((sd->flags & SD_NUMA) &&
-	    min_runnable_load + imbalance >= this_runnable_load)
+	     min_load + imbalance >= this_load)
 		return NULL;
 
-	if (min_runnable_load > (this_runnable_load + imbalance))
+	if (min_load >= this_load + imbalance)
 		return NULL;
 
-	if ((this_runnable_load < (min_runnable_load + imbalance)) &&
-	     (100*this_avg_load < imbalance_scale*min_avg_load))
+	if ((this_load < (min_load + imbalance)) &&
+	    (100*this_load < imbalance_scale*min_load))
 		return NULL;
 
 	return idlest;
-- 
2.7.4

