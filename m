Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D7AC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FC7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="LyEFbdwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfDWQS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:18:57 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51124 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbfDWQSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:18:53 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so1166606itk.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=EtZk3SeeXKQqkXCHRONf08T07XQMFClawAltZ/fWtIE=;
        b=LyEFbdwUCN5y5Ma4NDSi1pXikJqvX6wSnD3zS+PmORAbo5Qpf+5mixZHhsuHt93w5I
         Z79S9H9aqMQHGoisIff9QbcAIAHLdsZHjozPg7GZYbM8SjFr1/P/lA9ZlE/cD6+2HS6i
         UtaZOiylH/6QUdqvj6Tr7RnKNn2mbgNPT+bPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EtZk3SeeXKQqkXCHRONf08T07XQMFClawAltZ/fWtIE=;
        b=e0Ue96ldg0BT6QS3SUAwabxwnHAfgvBBghu4I3dlRT8Pm2+5fii3mrSq4FsAQP4W5a
         p/9KwEyx4+kNJ0xbmvOvND59XPF3+uEmvAoUsK+72Yw532T+rWKM+aJJHojkD+tLdzIN
         WCk40lXAcu0H0JamkkppBc4p6rGK1D8n5g541dJgbVqbkxS1U4oWfcU0u2YV4MTYpa2G
         Q8x1XXRYbNNxLwRxbPixlM208ygikk23DqVQYRTYUqO3a/BQrllV6LE7M7OtBh/5Utqg
         Xk6Y29XfzWV+/sOH8Rq86zrMzYujJqGzimlcNbIUKJ4PtsIWk+Q00RINjo2FVvSwBXGN
         DwrA==
X-Gm-Message-State: APjAAAWMb7cu702whgbOKBppCaQU+2T9v7liy7SRBowFhfFx9CzfoSq1
        qWFjzJfehZpXI1KJvl8lg0b9XQ==
X-Google-Smtp-Source: APXvYqw45HeoiufjegnttMnzJfx9H+US98cBcHyGXzS1ahocvhKh40MF/b7Vg3se4R64vEIAfOPt+A==
X-Received: by 2002:a24:e48d:: with SMTP id o135mr2609305ith.132.1556036332936;
        Tue, 23 Apr 2019 09:18:52 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id q12sm2603362iog.85.2019.04.23.09.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 09:18:52 -0700 (PDT)
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
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v2 12/17] sched: A quick and dirty cgroup tagging interface
Date:   Tue, 23 Apr 2019 16:18:17 +0000
Message-Id: <b058b74f303fe40e5822925c90a5b0161c4a0a2d.1556025155.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra (Intel) <peterz@infradead.org>

Marks all tasks in a cgroup as matching for core-scheduling.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  4 +++
 2 files changed, 66 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5066a1493acf..e5bdc1c4d8d7 100644
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
@@ -7117,6 +7126,43 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
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
@@ -7152,6 +7198,14 @@ static struct cftype cpu_legacy_files[] = {
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
@@ -7319,6 +7373,14 @@ static struct cftype cpu_files[] = {
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
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 42dd620797d7..16fb236eab7b 100644
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

