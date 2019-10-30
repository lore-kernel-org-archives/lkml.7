Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5067CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74856208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="CN436F3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfJ3Se3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:34:29 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35159 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbfJ3SeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:34:23 -0400
Received: by mail-yb1-f193.google.com with SMTP id i6so1320521ybe.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=jZ39za85ScGJv4ktAQLofwed/22Q20d0MWd8WvHXZOw=;
        b=CN436F3hzQc8pX6mbeecf9db+BuDJXmhmeuQOVitfwOeZVAwChfV/AeJlIyXlEjNN2
         HxjBa06v8PH/rMfddPK3tgLjennIVQ+nK1wI+r9tgXKOZ9VBSJnz8EeSYHSyxYVRhKY1
         Zf+888qzMpR+4UYwWdjQZnlaZZSRvQqx2Rmj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jZ39za85ScGJv4ktAQLofwed/22Q20d0MWd8WvHXZOw=;
        b=OH40Qi11cISvanvjNwFzgKD0foEdH059FncNleP/dJ+BH167tlcVta0UPK5VD9AhQx
         6R+/uCphrRBcF16P0SUEPxpiiSLWBeCJpjd/PxL8kXl03HbrJQ7c5Zm6Ums1Kk48iqAn
         qUKS9YPz4ErUYBtqDCPR5Ned5e4nAflFzR4/aWrG9o798Q/mT1zy8/BCTRtDmCcL02Ag
         rIrKkLtFiezt05fLL8lZd0jvYurrTaN3MRGbVLjNUavD1YWl0cbj60DFnWHfNKJY6iUs
         ZW9HQOGX+WshS/4v+heLJMFah6zep2WcEsU2UK1MOoLVabQcrcLNmE5GlO7Aa25iUW1f
         rt3g==
X-Gm-Message-State: APjAAAW7Hj3vIpycDk8OqycCJm2stHSX/ZeAykUz+MqSqMwx6gnQ075g
        YLoV4Xrtv8UqWNoiv8Nq/rZ4iQ==
X-Google-Smtp-Source: APXvYqwF4jqBrKem03NItjKdmDKGLY2J7lTKrmATFpvAN/mqu97TVhgGbsHUNc4HBZV+h55g0jeUJA==
X-Received: by 2002:a25:ce07:: with SMTP id x7mr80244ybe.415.1572460461649;
        Wed, 30 Oct 2019 11:34:21 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id 23sm872668ywf.91.2019.10.30.11.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:34:21 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH v4 12/19] sched: A quick and dirty cgroup tagging interface
Date:   Wed, 30 Oct 2019 18:33:25 +0000
Message-Id: <655b4d9fc5494df291d8e4b961ddd93eafd9d0d6.1572437285.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
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
 kernel/sched/core.c  | 78 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  4 +++
 2 files changed, 82 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 44dadbe9a2d0..27af86aa9a8b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7076,6 +7076,15 @@ static void sched_change_group(struct task_struct *tsk, int type)
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
@@ -7155,6 +7164,18 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
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
@@ -7542,6 +7563,46 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
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
@@ -7577,6 +7638,14 @@ static struct cftype cpu_legacy_files[] = {
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
@@ -7744,6 +7813,14 @@ static struct cftype cpu_files[] = {
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
@@ -7751,6 +7828,7 @@ static struct cftype cpu_files[] = {
 struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_alloc	= cpu_cgroup_css_alloc,
 	.css_online	= cpu_cgroup_css_online,
+	.css_offline	= cpu_cgroup_css_offline,
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 666b3bc2cfc2..0442a5abec01 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -357,6 +357,10 @@ struct cfs_bandwidth {
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

