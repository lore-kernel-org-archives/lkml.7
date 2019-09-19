Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D89C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5DF21924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ytdXnKLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388705AbfISHeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:34:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44502 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388685AbfISHeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:34:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id i18so1883807wru.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G38Beoqh46tSkk9feTTalhF9YSEcEpI24Anrd1Kl34E=;
        b=ytdXnKLOw7tyOpXbn4f94AyPbvdEkIJ7jwf1d/tJKiU5sjIzlgVtIZL2lgmxoNqKYk
         T4lGkWHf6yrp/1AtWR2IIlqKJ+lexzWecwblAecG+xVH4SDYZD4XsYbuc8469OLtdeNf
         kmLkqQR2twsWELCby55o28FgPGbRNSia6dCNeKWEeQnWzrk5qn6+fy62+mX2zQph18Sy
         J+xle92Rxh+kidq8JSP/FTxdyD458kWYcAxcZrdM6JGGm3eURpLIDjjX85isS4TPCfcv
         IPFDoMS/yzf0810SpaRTShFS2jzigstH6B66XkP7XGQZ/XbFB3uPgUITFJkfc0n7TYab
         D3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G38Beoqh46tSkk9feTTalhF9YSEcEpI24Anrd1Kl34E=;
        b=B8KHXY0Skz/2I750pORRd+gWAVKbwM/4cWrSsv4aC2F0x42PM+nCL/qd7WWNB1dfAw
         MFxD6xHvCv7E65bjhK4KuaV6TsvM1wwJakVZ09Q9ONVkEE572AcE8ojuhCCf/xJp2ND3
         3d+sNHMCa3njIy2O5WEDu4SaMq0ff3DJZdOHr6oBUecUvI3tOqWBNDwtD967SwZBOfgy
         PCddi0Ojow+7qX7WGAWmf4Tphzz0r2SP2yuePd7FZX9KTwmtr4K8xm7ztks57dTO7H+r
         eTMRrHNTIWI3z2VDR0O5Oh80lDAUeIhVNEOQG5QGK93cFPwcQyLdxQtvAhNZRhorwxZD
         kWAA==
X-Gm-Message-State: APjAAAWxzIzPyD9WLBrj5laXrluduTFneDb6tymIqCot1wJ3zkeums1b
        NDoc01ePWxNwKwzfHhhATRHnxYyOLWs=
X-Google-Smtp-Source: APXvYqwsoy3CDWPV0gmgWOyNo+VQl3JFNwXEvvfO6ywGpjfRAwZgPSq3IM6Flzqm0ceG+zd1h3IaDw==
X-Received: by 2002:adf:904f:: with SMTP id h73mr6287470wrh.128.1568878454611;
        Thu, 19 Sep 2019 00:34:14 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d555:8fca:a19c:222c])
        by smtp.gmail.com with ESMTPSA id s12sm13300250wra.82.2019.09.19.00.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 00:34:13 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 10/10] sched/fair: optimize find_idlest_group
Date:   Thu, 19 Sep 2019 09:33:41 +0200
Message-Id: <1568878421-12301-11-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_idlest_group() now loads CPU's load_avg in 2 different ways.
Consolidate the function to read and use load_avg only once and simplify
the algorithm to only look for the group with lowest load_avg.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 52 +++++++++++-----------------------------------------
 1 file changed, 11 insertions(+), 41 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 39a37ae..1fac444 100644
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
 
@@ -5668,18 +5646,10 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 	 * local domain to be very lightly loaded relative to the remote
 	 * domains but "imbalance" skews the comparison making remote CPUs
 	 * look much more favourable. When considering cross-domain, add
-	 * imbalance to the runnable load on the remote node and consider
-	 * staying local.
+	 * imbalance to the load on the remote node and consider staying
+	 * local.
 	 */
-	if ((sd->flags & SD_NUMA) &&
-	    min_runnable_load + imbalance >= this_runnable_load)
-		return NULL;
-
-	if (min_runnable_load > (this_runnable_load + imbalance))
-		return NULL;
-
-	if ((this_runnable_load < (min_runnable_load + imbalance)) &&
-	     (100*this_avg_load < imbalance_scale*min_avg_load))
+	if (min_load + imbalance >= this_load)
 		return NULL;
 
 	return idlest;
-- 
2.7.4

