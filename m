Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57802C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E202084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GNHw49ef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfDHVqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:46:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52322 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727445AbfDHVqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:46:04 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38LWlie004870
        for <linux-kernel@vger.kernel.org>; Mon, 8 Apr 2019 14:46:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=gwcpzJCNH9zTKl6c0+rR3lwfn5Cb+QEquraGGM3w8eg=;
 b=GNHw49efVqUrBpQIsK1cfbNcOF4clyurX8JZsvNaLB2dCP1YHHNTax2kCkaSge50lhbD
 aF6Zqcupfeis+vKQF9Q+tDlcRQEZ0Z52yykMXmIotCxxN+cPUoStO8840UDq0+7SAk9s
 JexNMq9HGVvM/db59wem8ckF4c0/dVzQ2xM= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2rra0ph822-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 14:46:03 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 8 Apr 2019 14:46:00 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 7C0E562E1F66; Mon,  8 Apr 2019 14:46:00 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <tglx@linutronix.de>,
        <morten.rasmussen@arm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 2/7] cgroup: introduce hook css_has_tasks_changed
Date:   Mon, 8 Apr 2019 14:45:34 -0700
Message-ID: <20190408214539.2705660-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408214539.2705660-1-songliubraving@fb.com>
References: <20190408214539.2705660-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new hook css_has_tasks_changed:

   void (*css_has_tasks_changed)(struct cgroup_subsys_state *css,
                                 bool has_tasks);

The hook is called when the cgroup gets its first task and when the cgroup
loses its last task. It is called under css_set_lock.

Note: has_task is different to populated. It only considers directly
attached tasks.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/cgroup-defs.h |  2 ++
 kernel/cgroup/cgroup.c      | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1c70803e9f77..ba499ed5309c 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -594,6 +594,8 @@ struct cgroup_subsys {
 	void (*css_released)(struct cgroup_subsys_state *css);
 	void (*css_free)(struct cgroup_subsys_state *css);
 	void (*css_reset)(struct cgroup_subsys_state *css);
+	void (*css_has_tasks_changed)(struct cgroup_subsys_state *css,
+				      bool has_tasks);
 	void (*css_rstat_flush)(struct cgroup_subsys_state *css, int cpu);
 	int (*css_extra_stat_show)(struct seq_file *seq,
 				   struct cgroup_subsys_state *css);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3f2b4bde0f9c..b0df96132476 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -200,6 +200,7 @@ static u16 have_fork_callback __read_mostly;
 static u16 have_exit_callback __read_mostly;
 static u16 have_release_callback __read_mostly;
 static u16 have_canfork_callback __read_mostly;
+static u16 have_has_tasks_changed_callback __read_mostly;
 
 /* cgroup namespace for init task */
 struct cgroup_namespace init_cgroup_ns = {
@@ -762,8 +763,11 @@ static bool css_set_populated(struct css_set *cset)
  */
 static void cgroup_update_populated(struct cgroup *cgrp, bool populated)
 {
+	struct cgroup *orig_cgrp = cgrp;
 	struct cgroup *child = NULL;
 	int adj = populated ? 1 : -1;
+	struct cgroup_subsys *ss;
+	int ssid;
 
 	lockdep_assert_held(&css_set_lock);
 
@@ -788,6 +792,14 @@ static void cgroup_update_populated(struct cgroup *cgrp, bool populated)
 		child = cgrp;
 		cgrp = cgroup_parent(cgrp);
 	} while (cgrp);
+
+	do_each_subsys_mask(ss, ssid, have_has_tasks_changed_callback) {
+		struct cgroup_subsys_state *css;
+
+		css = cgroup_css(orig_cgrp, ss);
+		if (css)
+			ss->css_has_tasks_changed(css, populated);
+	} while_each_subsys_mask();
 }
 
 /**
@@ -5370,6 +5382,8 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 	have_exit_callback |= (bool)ss->exit << ss->id;
 	have_release_callback |= (bool)ss->release << ss->id;
 	have_canfork_callback |= (bool)ss->can_fork << ss->id;
+	have_has_tasks_changed_callback |=
+		(bool)ss->css_has_tasks_changed << ss->id;
 
 	/* At system boot, before all subsystems have been
 	 * registered, no tasks have been forked, so we don't
-- 
2.17.1

