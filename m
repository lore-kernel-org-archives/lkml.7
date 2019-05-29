Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3340CC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F140722389
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="ToRXdgJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfE2UhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:37:12 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44617 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfE2UhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:37:10 -0400
Received: by mail-io1-f67.google.com with SMTP id f22so3039974iol.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xfxHFSc3o9z+LQIKmJo1/zP59vV7YWM0BcBPn1ilyLc=;
        b=ToRXdgJ23QBUCOlh6F80e8xh4wOCibdt3Uc+QVi1K1uoUULh/+7jq/HjN0eKFZU43K
         qldnwMFMEdj/agn8ii1ip2quJE/9T8pSHOB62r+s2+24+ZisxfdQXZcoE0yyGn1cyksC
         StEuqe3YzTjAQUKY/WJuamXDehZ9aBB+NftGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xfxHFSc3o9z+LQIKmJo1/zP59vV7YWM0BcBPn1ilyLc=;
        b=uZQpb9FJZsP2Yc4FHT9HKGi37GPTRn4VKOLchpxmJDPoY/pJhUM9Cm23v98j+RO8tE
         B5TePHvwmYZtaEULUERy5FNV7G4MC/SB7KYf1ayQIOzxWevZCDekK0sqXOQOQpBUqpv1
         kFKG3L1sFPD4TRF+ezjRmG5ZUiRBehwqtEnhYNmlJCWtY4J2UE6Rv8eLsg0OpDW+FHDC
         1CheM3JZUImV1EGwTKCSm9xi5Y0YS1rjEHGdby57t2stns9FN6KcEKoTWguMhG/VX0nK
         TK4jrX4k4zCI71EyhzfkrMvDQMXTggSbKK7xbdODAyijMJP69zW9ICy5BKUuOmh8y2sR
         TGnw==
X-Gm-Message-State: APjAAAXPFocAJxM/ECxbYByuLQsgohJZT3LP4Rbl3odsZUKlluD4+SmH
        prxBNAf3MGSa6LxQdBBC2JRTmA==
X-Google-Smtp-Source: APXvYqx8Aq5H/O/9l/fT0E6doY6BAvce51/B/K2AVnm25fkrmV0qWXSHyhurYTWNrA7THTzVIKG/IA==
X-Received: by 2002:a5d:9a11:: with SMTP id s17mr20266664iol.267.1559162229065;
        Wed, 29 May 2019 13:37:09 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id z77sm182361itb.35.2019.05.29.13.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:37:08 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH v3 12/16] sched: A quick and dirty cgroup tagging interface
Date:   Wed, 29 May 2019 20:36:48 +0000
Message-Id: <3ce2cbb14593473f5c20bb44fd817fa5fde31a37.1559129225.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Marks all tasks in a cgroup as matching for core-scheduling.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
---

Changes in v3
-------------
- Fixes the refcount management when deleting a tagged cgroup.
  - Julien Desfossez

---
 kernel/sched/core.c  | 78 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  4 +++
 2 files changed, 82 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 112d70f2b1e5..3164c6b33553 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6658,6 +6658,15 @@ static void sched_change_group(struct task_struct *tsk, int type)
 	tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
 			  struct task_group, css);
 	tg = autogroup_task_group(tsk, tg);
+
+#ifdef CONFIG_SCHED_CORE
+	if ((unsigned long)tsk->sched_task_group == tsk->core_cookie)
+		tsk->core_cookie = 0UL;
+
+	if (tg->tagged /* && !tsk->core_cookie ? */)
+		tsk->core_cookie = (unsigned long)tg;
+#endif
+
 	tsk->sched_task_group = tg;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -6737,6 +6746,18 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
 	return 0;
 }
 
+static void cpu_cgroup_css_offline(struct cgroup_subsys_state *css)
+{
+#ifdef CONFIG_SCHED_CORE
+	struct task_group *tg = css_tg(css);
+
+	if (tg->tagged) {
+		sched_core_put();
+		tg->tagged = 0;
+	}
+#endif
+}
+
 static void cpu_cgroup_css_released(struct cgroup_subsys_state *css)
 {
 	struct task_group *tg = css_tg(css);
@@ -7117,6 +7138,46 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 }
 #endif /* CONFIG_RT_GROUP_SCHED */
 
+#ifdef CONFIG_SCHED_CORE
+static u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct task_group *tg = css_tg(css);
+
+	return !!tg->tagged;
+}
+
+static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
+{
+	struct task_group *tg = css_tg(css);
+	struct css_task_iter it;
+	struct task_struct *p;
+
+	if (val > 1)
+		return -ERANGE;
+
+	if (!static_branch_likely(&sched_smt_present))
+		return -EINVAL;
+
+	if (tg->tagged == !!val)
+		return 0;
+
+	tg->tagged = !!val;
+
+	if (!!val)
+		sched_core_get();
+
+	css_task_iter_start(css, 0, &it);
+	while ((p = css_task_iter_next(&it)))
+		p->core_cookie = !!val ? (unsigned long)tg : 0UL;
+	css_task_iter_end(&it);
+
+	if (!val)
+		sched_core_put();
+
+	return 0;
+}
+#endif
+
 static struct cftype cpu_legacy_files[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
@@ -7152,6 +7213,14 @@ static struct cftype cpu_legacy_files[] = {
 		.read_u64 = cpu_rt_period_read_uint,
 		.write_u64 = cpu_rt_period_write_uint,
 	},
+#endif
+#ifdef CONFIG_SCHED_CORE
+	{
+		.name = "tag",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_tag_read_u64,
+		.write_u64 = cpu_core_tag_write_u64,
+	},
 #endif
 	{ }	/* Terminate */
 };
@@ -7319,6 +7388,14 @@ static struct cftype cpu_files[] = {
 		.seq_show = cpu_max_show,
 		.write = cpu_max_write,
 	},
+#endif
+#ifdef CONFIG_SCHED_CORE
+	{
+		.name = "tag",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_tag_read_u64,
+		.write_u64 = cpu_core_tag_write_u64,
+	},
 #endif
 	{ }	/* terminate */
 };
@@ -7326,6 +7403,7 @@ static struct cftype cpu_files[] = {
 struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_alloc	= cpu_cgroup_css_alloc,
 	.css_online	= cpu_cgroup_css_online,
+	.css_offline	= cpu_cgroup_css_offline,
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0cbcfb6c8ee4..bd9b473ebde2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -363,6 +363,10 @@ struct cfs_bandwidth {
 struct task_group {
 	struct cgroup_subsys_state css;
 
+#ifdef CONFIG_SCHED_CORE
+	int			tagged;
+#endif
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* schedulable entities of this group on each CPU */
 	struct sched_entity	**se;
-- 
2.17.1

