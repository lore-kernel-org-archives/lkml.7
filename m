Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70FEC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB1820656
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qD9mwkaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfDZR75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:59:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39038 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726386AbfDZR7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:59:53 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QHxIPR015969
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 10:59:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=+UMTNtxqzrE5Cg6Nx66l9gCl1GIuLMdJPrf2D2IS40w=;
 b=qD9mwkaVodyVgKBnuir2SAFuzqVcSGfFaaj/1HyJqtNPbxJUA2vdEtJFd4mrmo3DCpUD
 GKIV56DQWSiH6CO3mzTg/XWPu+iqo7I5h3DJNkVlth6iKpBviCJUjlk3pqaVOp+7tTxq
 Sa4sRe5ZknIc5k5hUnhHRVNbeB0rXkJm/ws= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2s416as5pg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 10:59:52 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 26 Apr 2019 10:59:51 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 604FE115F37BE; Fri, 26 Apr 2019 10:59:48 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Tejun Heo <tj@kernel.org>
CC:     Oleg Nesterov <oleg@redhat.com>, <kernel-team@fb.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 1/2] cgroup: prevent spurious transition into non-frozen state
Date:   Fri, 26 Apr 2019 10:59:44 -0700
Message-ID: <20190426175945.2559865-2-guro@fb.com>
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
 mlxlogscore=786 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260123
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If freezing of a cgroup races with waking of a task from
the frozen state (like waiting in vfork() or in do_signal_stop()),
a spurious transition of the cgroup state can happen.

The task enters cgroup_leave_frozen(true), the cgroup->nr_frozen_tasks
counter decrements, and the cgroup is switched to the unfrozen state.

To prevent it, let's reserve cgroup_leave_frozen(true) for
terminating processes and use cgroup_leave_frozen(false) otherwise.

To avoid busy-looping in the signal handling loop waiting
for JOBCTL_TRAP_FREEZE set from the cgroup freezing path,
let's do it explicitly in cgroup_leave_frozen(), if the task
is going to stay frozen.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Roman Gushchin <guro@fb.com>
---
 kernel/cgroup/freezer.c | 16 +++++-----------
 kernel/signal.c         |  2 +-
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 3bfbb3c8baf3..c321e768f8d3 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -139,19 +139,13 @@ void cgroup_leave_frozen(bool always_leave)
 		cgroup_update_frozen(cgrp);
 		WARN_ON_ONCE(!current->frozen);
 		current->frozen = false;
+	} else if (!(current->jobctl & JOBCTL_TRAP_FREEZE)) {
+		spin_lock(&current->sighand->siglock);
+		current->jobctl |= JOBCTL_TRAP_FREEZE;
+		set_thread_flag(TIF_SIGPENDING);
+		spin_unlock(&current->sighand->siglock);
 	}
 	spin_unlock_irq(&css_set_lock);
-
-	if (unlikely(current->frozen)) {
-		/*
-		 * If the task remained in the frozen state,
-		 * make sure it won't reach userspace without
-		 * entering the signal handling loop.
-		 */
-		spin_lock_irq(&current->sighand->siglock);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
 }
 
 /*
diff --git a/kernel/signal.c b/kernel/signal.c
index 095e0fc57b25..16b72f4f14df 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2514,7 +2514,7 @@ bool get_signal(struct ksignal *ksig)
 		 */
 		if (unlikely(cgroup_task_frozen(current))) {
 			spin_unlock_irq(&sighand->siglock);
-			cgroup_leave_frozen(true);
+			cgroup_leave_frozen(false);
 			goto relock;
 		}
 
-- 
2.20.1

