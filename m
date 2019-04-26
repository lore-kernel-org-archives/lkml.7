Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7E9C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F6720656
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="M2N/Q29Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfDZR7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:59:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48200 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726315AbfDZR7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:59:52 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QHlMG2030033
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 10:59:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=GwFOGfYx+Z1jgC8YSP6xVOVt+bV6jEaQATYAcfMEIUM=;
 b=M2N/Q29YPQUd6z1Dn0McgNiECLg7kMpcU6SG41IjD0GImjjsNydzQWjR0ouWcd3O8EGQ
 j6g8ACOKL7w0VdwMKFGCIvsIy81RRlEaSikgaWSNVql2hJtyQ4lfT+eJ3TrSkINc540d
 Rg4qE8XuewG+GHqpK6iMjWanSGoNsO1tDl8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0b-00082601.pphosted.com with ESMTP id 2s3mmak88p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 10:59:51 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 26 Apr 2019 10:59:49 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 62ADF115F37C0; Fri, 26 Apr 2019 10:59:48 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Tejun Heo <tj@kernel.org>
CC:     Oleg Nesterov <oleg@redhat.com>, <kernel-team@fb.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 2/2] cgroup: get rid of cgroup_freezer_frozen_exit()
Date:   Fri, 26 Apr 2019 10:59:45 -0700
Message-ID: <20190426175945.2559865-3-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426175945.2559865-1-guro@fb.com>
References: <20190426175945.2559865-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=344 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260122
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A task should never enter the exit path with the task->frozen bit set.
Any frozen task must enter the signal handling loop and the only
way to escape is through cgroup_leave_frozen(true), which
unconditionally drops the task->frozen bit. So it means that
cgroyp_freezer_frozen_exit() has zero chances to be called and
has to be removed.

Let's put a WARN_ON_ONCE() instead of the cgroup_freezer_frozen_exit()
call to catch any potential leak of the task's frozen bit.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/cgroup.h  |  2 +-
 kernel/cgroup/cgroup.c  |  5 ++---
 kernel/cgroup/freezer.c | 10 ----------
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 3e2efd412dfa..c0077adeea83 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -889,7 +889,7 @@ void cgroup_update_frozen(struct cgroup *cgrp);
 void cgroup_freeze(struct cgroup *cgrp, bool freeze);
 void cgroup_freezer_migrate_task(struct task_struct *task, struct cgroup *src,
 				 struct cgroup *dst);
-void cgroup_freezer_frozen_exit(struct task_struct *task);
+
 static inline bool cgroup_task_freeze(struct task_struct *task)
 {
 	bool ret;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 57edcf398d71..622ae7452969 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5929,9 +5929,8 @@ void cgroup_exit(struct task_struct *tsk)
 		css_set_move_task(tsk, cset, NULL, false);
 		cset->nr_tasks--;
 
-		if (unlikely(cgroup_task_frozen(tsk)))
-			cgroup_freezer_frozen_exit(tsk);
-		else if (unlikely(cgroup_task_freeze(tsk)))
+		WARN_ON_ONCE(cgroup_task_frozen(tsk));
+		if (unlikely(cgroup_task_freeze(tsk)))
 			cgroup_update_frozen(task_dfl_cgroup(tsk));
 
 		spin_unlock_irq(&css_set_lock);
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index c321e768f8d3..8cf010680678 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -248,16 +248,6 @@ void cgroup_freezer_migrate_task(struct task_struct *task,
 	cgroup_freeze_task(task, test_bit(CGRP_FREEZE, &dst->flags));
 }
 
-void cgroup_freezer_frozen_exit(struct task_struct *task)
-{
-	struct cgroup *cgrp = task_dfl_cgroup(task);
-
-	lockdep_assert_held(&css_set_lock);
-
-	cgroup_dec_frozen_cnt(cgrp);
-	cgroup_update_frozen(cgrp);
-}
-
 void cgroup_freeze(struct cgroup *cgrp, bool freeze)
 {
 	struct cgroup_subsys_state *css;
-- 
2.20.1

