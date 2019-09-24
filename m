Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED41C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01FF217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569344123;
	bh=/J1o5rPQg1YYMn3xya9OoaaLq4oaynFEnqT78U6lrjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LoiVydKmgKk56dE3TILkFqTy3svD793PlHQXU1BbMMI/1Jon1n52pW6NgvB7uvutQ
	 OjuP3YEGoxxwjCvNzbv+Z8eSkP9Qwamo5RzVPZYQETKEpZNWCBaXvjiwK/IDghjH/U
	 6qW3MmrgpvX3Nakz7jIBQbJPXpxukEhBfqu1ymh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410998AbfIXQzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441483AbfIXQup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:50:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1584621D82;
        Tue, 24 Sep 2019 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343844;
        bh=/J1o5rPQg1YYMn3xya9OoaaLq4oaynFEnqT78U6lrjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tKV7jj19yfxk3JYRB+qthy1imGuB7/5ToCcxhMhzLLk7W1BV+O1SSG7Vm+dTKI4NK
         cirUGFjEWJe9mQYllhTwdLtrdE8dhQfivVOBN4GuQunkBliFt0Gfu0jOU8bpy5YJNo
         l3USa1hTX5guS4Nl5YicIIu6swed7VsxrvwtUODI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 08/28] ipmi_si: Only schedule continuously in the thread in maintenance mode
Date:   Tue, 24 Sep 2019 12:50:11 -0400
Message-Id: <20190924165031.28292-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924165031.28292-1-sashal@kernel.org>
References: <20190924165031.28292-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

[ Upstream commit 340ff31ab00bca5c15915e70ad9ada3030c98cf8 ]

ipmi_thread() uses back-to-back schedule() to poll for command
completion which, on some machines, can push up CPU consumption and
heavily tax the scheduler locks leading to noticeable overall
performance degradation.

This was originally added so firmware updates through IPMI would
complete in a timely manner.  But we can't kill the scheduler
locks for that one use case.

Instead, only run schedule() continuously in maintenance mode,
where firmware updates should run.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_si_intf.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index a106cf7b5ee02..f6ba90b90503f 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -284,6 +284,9 @@ struct smi_info {
 	 */
 	bool irq_enable_broken;
 
+	/* Is the driver in maintenance mode? */
+	bool in_maintenance_mode;
+
 	/*
 	 * Did we get an attention that we did not handle?
 	 */
@@ -1094,11 +1097,20 @@ static int ipmi_thread(void *data)
 		spin_unlock_irqrestore(&(smi_info->si_lock), flags);
 		busy_wait = ipmi_thread_busy_wait(smi_result, smi_info,
 						  &busy_until);
-		if (smi_result == SI_SM_CALL_WITHOUT_DELAY)
+		if (smi_result == SI_SM_CALL_WITHOUT_DELAY) {
 			; /* do nothing */
-		else if (smi_result == SI_SM_CALL_WITH_DELAY && busy_wait)
-			schedule();
-		else if (smi_result == SI_SM_IDLE) {
+		} else if (smi_result == SI_SM_CALL_WITH_DELAY && busy_wait) {
+			/*
+			 * In maintenance mode we run as fast as
+			 * possible to allow firmware updates to
+			 * complete as fast as possible, but normally
+			 * don't bang on the scheduler.
+			 */
+			if (smi_info->in_maintenance_mode)
+				schedule();
+			else
+				usleep_range(100, 200);
+		} else if (smi_result == SI_SM_IDLE) {
 			if (atomic_read(&smi_info->need_watch)) {
 				schedule_timeout_interruptible(100);
 			} else {
@@ -1106,8 +1118,9 @@ static int ipmi_thread(void *data)
 				__set_current_state(TASK_INTERRUPTIBLE);
 				schedule();
 			}
-		} else
+		} else {
 			schedule_timeout_interruptible(1);
+		}
 	}
 	return 0;
 }
@@ -1286,6 +1299,7 @@ static void set_maintenance_mode(void *send_info, bool enable)
 
 	if (!enable)
 		atomic_set(&smi_info->req_events, 0);
+	smi_info->in_maintenance_mode = enable;
 }
 
 static const struct ipmi_smi_handlers handlers = {
-- 
2.20.1

