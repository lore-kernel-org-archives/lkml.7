Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3D4C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA2720873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfGSOAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 10:00:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50350 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbfGSOAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:00:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so28946724wml.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 07:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1v9Wyn7iwUdwNAPe/wicZ1s65Wur1rKRI0dtWQllWvE=;
        b=rdhVfRWtEfyS4/6AvuV7vDP6spgkLu83gjz3lLSmzR2robQfEeHoVeoya1JYdf2I7/
         1BkwdfSVJeGcMtxG8Bxx1VTQqqL1C47Cr4ZENuHWvhMromFZaMEr3KKJGGwuayLSmm+z
         /FzuaiOpyBHHOuGMJHFr8K9/3sYJSimy8vHYu5Ew+74vQkJ+BI1ML8dS1BGNUUqWTYUW
         1Tvm9qOIA52pfdn0Pjwt1okim5dIo7iqqDa3maQmbAQBamyIlWKy7a2QWN8dvfmypjxP
         hPEvXyaSVPC2FrQE5n+9Ifufnd30k5gRSyiSi9B2mBbDKnwZwW8JKIiwHXR5aEKUTM90
         j13g==
X-Gm-Message-State: APjAAAV+xarXj+nDNVX0+er6AiGCrMu4Qyt9ciNbTzSPAHFkVFcW6LfQ
        OQ7NY59MQo5eIQ7JKt9VA4Gh3Q==
X-Google-Smtp-Source: APXvYqxlDiOmAaFd2Cg1EI75A3NKa/pF6D06AuO71ssB6z21VU9mUEXZkL345zWuGf9AnGKZqdVG1w==
X-Received: by 2002:a1c:dc07:: with SMTP id t7mr50358433wmg.164.1563544828940;
        Fri, 19 Jul 2019 07:00:28 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id f10sm21276926wrs.22.2019.07.19.07.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 07:00:28 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        longman@redhat.com, dietmar.eggemann@arm.com,
        cgroups@vger.kernel.org
Subject: [PATCH v9 2/8] sched/core: Streamlining calls to task_rq_unlock()
Date:   Fri, 19 Jul 2019 15:59:54 +0200
Message-Id: <20190719140000.31694-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190719140000.31694-1-juri.lelli@redhat.com>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Calls to task_rq_unlock() are done several times in function
__sched_setscheduler().  This is fine when only the rq lock needs to be
handled but not so much when other locks come into play.

This patch streamlines the release of the rq lock so that only one
location need to be modified when dealing with more than one lock.

No change of functionality is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427742a9..acd6a9fe85bc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4222,8 +4222,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	 * Changing the policy of the stop threads its a very bad idea:
 	 */
 	if (p == rq->stop) {
-		task_rq_unlock(rq, p, &rf);
-		return -EINVAL;
+		retval = -EINVAL;
+		goto unlock;
 	}
 
 	/*
@@ -4239,8 +4239,8 @@ static int __sched_setscheduler(struct task_struct *p,
 			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
-		task_rq_unlock(rq, p, &rf);
-		return 0;
+		retval = 0;
+		goto unlock;
 	}
 change:
 
@@ -4253,8 +4253,8 @@ static int __sched_setscheduler(struct task_struct *p,
 		if (rt_bandwidth_enabled() && rt_policy(policy) &&
 				task_group(p)->rt_bandwidth.rt_runtime == 0 &&
 				!task_group_is_autogroup(task_group(p))) {
-			task_rq_unlock(rq, p, &rf);
-			return -EPERM;
+			retval = -EPERM;
+			goto unlock;
 		}
 #endif
 #ifdef CONFIG_SMP
@@ -4269,8 +4269,8 @@ static int __sched_setscheduler(struct task_struct *p,
 			 */
 			if (!cpumask_subset(span, &p->cpus_allowed) ||
 			    rq->rd->dl_bw.bw == 0) {
-				task_rq_unlock(rq, p, &rf);
-				return -EPERM;
+				retval = -EPERM;
+				goto unlock;
 			}
 		}
 #endif
@@ -4289,8 +4289,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	 * is available.
 	 */
 	if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
-		task_rq_unlock(rq, p, &rf);
-		return -EBUSY;
+		retval = -EBUSY;
+		goto unlock;
 	}
 
 	p->sched_reset_on_fork = reset_on_fork;
@@ -4346,6 +4346,10 @@ static int __sched_setscheduler(struct task_struct *p,
 	preempt_enable();
 
 	return 0;
+
+unlock:
+	task_rq_unlock(rq, p, &rf);
+	return retval;
 }
 
 static int _sched_setscheduler(struct task_struct *p, int policy,
-- 
2.17.2

