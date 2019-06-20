Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E05C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 05:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB2020B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 05:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCVaRrbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbfFTFzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 01:55:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38839 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfFTFzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 01:55:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id v11so977088pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 22:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K9pZXmjEarEwCyykMezDXwpehpmv4umtwvd9btCXgKc=;
        b=XCVaRrbpse0CSGD70QnaHV3nIfsX43qaQFSxrfnJW/VmR080ALVpX8dSSZASxz2lzr
         R100yUGLnMUR69TxsxEuO/YdkK1EoNyWdMbIA1NyYz/XZsCfcBs6Skb5n2cMnE8JqY4f
         /4FWSMQ1niGhs+4sXX5B++cu0bQoqURFh5bctYtIIDQCl68u0pFC5wNpqDjU5KH7UNIU
         YsEnNOIrZDaeCz/vLS0/wSj53HhulsyCiFljCWI4xgvqTRa17HnK+oyaPzOckmuwojEU
         Xm2lUMHgFK9vjYwO2QyJ0L04c4ePZe/bF8/mFVgfFaos8RtBC1HHk19D5le0FS3bLlon
         utIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K9pZXmjEarEwCyykMezDXwpehpmv4umtwvd9btCXgKc=;
        b=jfXdy9GlaV2Fl/TLGsbHbH2jrk3CjBGRY8coX833kMDga+svu65X35yCfc6VKs2LNy
         Tpf4MmtcPjya67j+G8340Tz/wK/K0Lc8W5lX4V8+CtZsrxt/xAvbZsG1+krf+8FGl5rv
         UIwOuP0pyUnBSLGTrY+tP2e9OySCzYj4UCOz2SIxh/s3bwPE2w6pAnqistiX5Es25sgF
         VCNmlELiP4kh1Ide32VJrn+pycI51HHuAPss2zJ8oP+FeXZ0/amE0JVotaScdGyY28f2
         H3Wza8crStRYZixdC7+9w6jkWS1pjcPVtvwNLO7rjqlyg6FZpKJ5IVCF3O03qkKsTifI
         lr3A==
X-Gm-Message-State: APjAAAUjo+ZMgGqChd2aPjfPOhii7pNaPS/Gfb6Qv7VmmpKxHc7t12MK
        xC3Lb0cluAHd6qA/yVu2N0ls/mgWcpc=
X-Google-Smtp-Source: APXvYqx5er+qQrHL1j38LKHAX4s8XXfOE8iKYN4Ky6U1iGragatOQN6CtKyu178J66sxlxjJS5eY1Q==
X-Received: by 2002:a65:63c6:: with SMTP id n6mr11208778pgv.370.1561010135545;
        Wed, 19 Jun 2019 22:55:35 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id n17sm37308044pfq.182.2019.06.19.22.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 22:55:34 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org, penguin-kernel@I-love.SAKURA.ne.jp,
        dvyukov@google.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] hung_task: recover hung task warnings in next check interval
Date:   Thu, 20 Jun 2019 13:55:00 +0800
Message-Id: <1561010100-14080-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sys_hung_task_warnings reaches 0, the hang task messages will not
be reported any more.

If the user want to get more hung task messages, he must reset
kernel.hung_task_warnings to a postive integer or -1 with sysctl.
This is not a good way for the user.
We'd better reset hung task warnings in the kernel, and then the user
don't need to pay attention to this value.

With this patch, hung task warnings will be reset with
sys_hung_task_warnings setting in evenry check interval.

Another difference is if the user set kernel.hung_task_warnings with a
new value, the new value will take effect in next check interval.
For example, when the kernel is printing the hung task messages, the
user can't set it to 0 to stop the printing, but I don't think this will
happen in the real world. (If that happens, then sys_hung_task_warnings
must be protected by a lock)

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 Documentation/sysctl/kernel.txt |  5 ++++-
 kernel/hung_task.c              | 19 ++++++++++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index f0c86fb..350df41 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -377,6 +377,8 @@ This file shows up if CONFIG_DETECT_HUNG_TASK is enabled.
 
 0 (default): means use hung_task_timeout_secs as checking interval.
 Possible values to set are in range {0..LONG_MAX/HZ}.
+hung_task_check_interval_secs must not be set greater than
+hung_task_timeout_secs.
 
 ==============================================================
 
@@ -384,7 +386,8 @@ hung_task_warnings:
 
 The maximum number of warnings to report. During a check interval
 if a hung task is detected, this value is decreased by 1.
-When this value reaches 0, no more warnings will be reported.
+When this value reaches 0, no more warnings will be reported until
+next check interval begins.
 This file shows up if CONFIG_DETECT_HUNG_TASK is enabled.
 
 -1: report an infinite number of warnings.
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 14a625c..01e6c94 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -85,7 +85,8 @@ static int __init hung_task_panic_setup(char *str)
 	.notifier_call = hung_task_panic,
 };
 
-static void check_hung_task(struct task_struct *t, unsigned long timeout)
+static void check_hung_task(struct task_struct *t, unsigned long timeout,
+			    int *warnings)
 {
 	unsigned long switch_count = t->nvcsw + t->nivcsw;
 
@@ -124,9 +125,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	 * Ok, the task did not get scheduled for more than 2 minutes,
 	 * complain:
 	 */
-	if (sysctl_hung_task_warnings) {
-		if (sysctl_hung_task_warnings > 0)
-			sysctl_hung_task_warnings--;
+	if (*warnings) {
+		if (*warnings > 0)
+			(*warnings)--;
 		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
 		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
 		pr_err("      %s %s %.*s\n",
@@ -170,7 +171,8 @@ static bool rcu_lock_break(struct task_struct *g, struct task_struct *t)
  * a really long time (120 seconds). If that happens, print out
  * a warning.
  */
-static void check_hung_uninterruptible_tasks(unsigned long timeout)
+static void check_hung_uninterruptible_tasks(unsigned long timeout,
+					     int *warnings)
 {
 	int max_count = sysctl_hung_task_check_count;
 	unsigned long last_break = jiffies;
@@ -195,7 +197,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 		}
 		/* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
 		if (t->state == TASK_UNINTERRUPTIBLE)
-			check_hung_task(t, timeout);
+			check_hung_task(t, timeout, warnings);
 	}
  unlock:
 	rcu_read_unlock();
@@ -271,6 +273,7 @@ static int hungtask_pm_notify(struct notifier_block *self,
 static int watchdog(void *dummy)
 {
 	unsigned long hung_last_checked = jiffies;
+	int warnings;
 
 	set_user_nice(current, 0);
 
@@ -284,9 +287,11 @@ static int watchdog(void *dummy)
 		interval = min_t(unsigned long, interval, timeout);
 		t = hung_timeout_jiffies(hung_last_checked, interval);
 		if (t <= 0) {
+			warnings = sysctl_hung_task_warnings;
 			if (!atomic_xchg(&reset_hung_task, 0) &&
 			    !hung_detector_suspended)
-				check_hung_uninterruptible_tasks(timeout);
+				check_hung_uninterruptible_tasks(timeout,
+								 &warnings);
 			hung_last_checked = jiffies;
 			continue;
 		}
-- 
1.8.3.1

