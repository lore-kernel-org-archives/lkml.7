Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFE9CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE05A2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfJUHmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:42:32 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:16466 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfJUHmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:42:32 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id B356A5866CCA1754A0D9;
        Mon, 21 Oct 2019 15:42:12 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x9L7fnOk005313;
        Mon, 21 Oct 2019 15:41:49 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019102115415257-53030 ;
          Mon, 21 Oct 2019 15:41:52 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, up2wing@gmail.com, wang.liang82@zte.com.cn
Subject: [PATCH] posix-cpu-timers: fix two trivial comments
Date:   Mon, 21 Oct 2019 15:44:12 +0800
Message-Id: <1571643852-21848-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-10-21 15:41:52,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-10-21 15:41:49,
        Serialize complete at 2019-10-21 15:41:49
X-MAIL: mse-fl2.zte.com.cn x9L7fnOk005313
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b7be4ef1365d ("posix-cpu-timers: Switch thread group sampling to
array") and commit 001f7971433a ("posix-cpu-timers: Make expiry checks
array based") made some modification on parameters of function
thread_group_sample_cputime() and task_cputimers_expired(), but forgot
to modify the comment.

This patch can fix this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 kernel/time/posix-cpu-timers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 92a4319..617b919 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -266,7 +266,7 @@ static void update_gt_cputime(struct task_cputime_atomic *cputime_atomic,
 /**
  * thread_group_sample_cputime - Sample cputime for a given task
  * @tsk:	Task for which cputime needs to be started
- * @iimes:	Storage for time samples
+ * @samples:	Storage for time samples
  *
  * Called from sys_getitimer() to calculate the expiry time of an active
  * timer. That means group cputime accounting is already active. Called
@@ -1031,7 +1031,7 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 /**
  * task_cputimers_expired - Check whether posix CPU timers are expired
  *
- * @samples:	Array of current samples for the CPUCLOCK clocks
+ * @sample:	Array of current samples for the CPUCLOCK clocks
  * @pct:	Pointer to a posix_cputimers container
  *
  * Returns true if any member of @samples is greater than the corresponding
-- 
1.8.3.1

