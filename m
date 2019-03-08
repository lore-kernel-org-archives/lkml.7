Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F7EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61841206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o41lkOl7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JtYN7lxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfCHTK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:10:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51256 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCHTK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:10:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1380660328; Fri,  8 Mar 2019 19:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552072257;
        bh=KIuY/fnsBMdVj6LI3KgOrerVjV+pV+jtJWAGSUdkvcI=;
        h=From:To:Cc:Subject:Date:From;
        b=o41lkOl78Rt0k2la8UqwoxxgJC4RbN2BLn3yWa7JS4ysQhzSS+/1/NwZQTo2upMAT
         JEfIGUEzULvdSk7i+jPFQsaVf+mGLuGJF+AyrbaM3jZxTJPpdq9/bQVA9BgN3arTk0
         l428Be7aDQsXSt0EGT/RYY5QCU80OWZLxkJ8j0Ic=
Received: from neeraju-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44ED160328;
        Fri,  8 Mar 2019 19:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552072256;
        bh=KIuY/fnsBMdVj6LI3KgOrerVjV+pV+jtJWAGSUdkvcI=;
        h=From:To:Cc:Subject:Date:From;
        b=JtYN7lxRbzqdsq5hkrqsf5qQFbnfOTm/Q9MyAtI78XlQBaHHdrkwwL6aCQXyONGap
         nmF38Q3/oV1utNOImJDnGoGvg10JDtxY7FaF8cHGDWnJ2DSbIywnQixwEoyZyBgucU
         jReDqLABqYI9oa4S7yptYpIdP+KYAJRJ0s6qNTpc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44ED160328
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu/rcutorture: Fix expected forward progress duration in oom notifier
Date:   Sat,  9 Mar 2019 00:40:45 +0530
Message-Id: <1552072245-31273-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a possible miscalculation in rcutorture_oom_notify(),
for the expected forward progress duration of current
forward progress test.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index f14d1b1..5d09f79 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1848,7 +1848,7 @@ static int rcutorture_oom_notify(struct notifier_block *self,
 	WARN(1, "%s invoked upon OOM during forward-progress testing.\n",
 	     __func__);
 	rcu_torture_fwd_cb_hist();
-	rcu_fwd_progress_check(1 + (jiffies - READ_ONCE(rcu_fwd_startat) / 2));
+	rcu_fwd_progress_check(1 + (jiffies - READ_ONCE(rcu_fwd_startat)) / 2);
 	WRITE_ONCE(rcu_fwd_emergency_stop, true);
 	smp_mb(); /* Emergency stop before free and wait to avoid hangs. */
 	pr_info("%s: Freed %lu RCU callbacks.\n",
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

