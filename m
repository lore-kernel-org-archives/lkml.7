Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B362C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A92205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012867;
	bh=tAbFYOoxcn51RpAMI0jKgF/Wshvkc/kFB0GWGJLeoG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rDqIKKp6GHZi7QCslWGERXETK6IYK8HCPJJK0OlakElWajW5WFDQ4Uh92QHYZZw5n
	 n6iu7j7uvtZIrtmqlPqEDWK5uZK/y492AJRYh6Stw5assHy/s7xTsCh47Oz0gCWtjJ
	 9SPKi8FdUulbscRq39h9YO6DGo8FoWCJFY5jmEBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfLJVLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:11:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbfLJVLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:11:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1CEE246BF;
        Tue, 10 Dec 2019 21:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012308;
        bh=tAbFYOoxcn51RpAMI0jKgF/Wshvkc/kFB0GWGJLeoG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6lpSmT7lRZteQcPbzSJgxrw2k8vooZf45pspkmzmQVY7tDEZLgHWyY3EYkEg4qxA
         2USyNP5vcmXhVFiPmQzqH8cZUpu8P163HJDAQXwN3OCpbOZ2HjAAeMSETsOlyDevOS
         8gjEHMS91QPIA2lKcTIGWR0aRDAsRN63XA5qc9D0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Honglei Wang <honglei.wang@oracle.com>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>, cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 244/350] cgroup: freezer: don't change task and cgroups status unnecessarily
Date:   Tue, 10 Dec 2019 16:05:49 -0500
Message-Id: <20191210210735.9077-205-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Honglei Wang <honglei.wang@oracle.com>

[ Upstream commit 742e8cd3e1ba6f19cad6d912f8d469df5557d0fd ]

It's not necessary to adjust the task state and revisit the state
of source and destination cgroups if the cgroups are not in freeze
state and the task itself is not frozen.

And in this scenario, it wakes up the task who's not supposed to be
ready to run.

Don't do the unnecessary task state adjustment can help stop waking
up the task without a reason.

Signed-off-by: Honglei Wang <honglei.wang@oracle.com>
Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/freezer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 8cf0106806789..3984dd6b8ddbc 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -230,6 +230,15 @@ void cgroup_freezer_migrate_task(struct task_struct *task,
 	if (task->flags & PF_KTHREAD)
 		return;
 
+	/*
+	 * It's not necessary to do changes if both of the src and dst cgroups
+	 * are not freezing and task is not frozen.
+	 */
+	if (!test_bit(CGRP_FREEZE, &src->flags) &&
+	    !test_bit(CGRP_FREEZE, &dst->flags) &&
+	    !task->frozen)
+		return;
+
 	/*
 	 * Adjust counters of freezing and frozen tasks.
 	 * Note, that if the task is frozen, but the destination cgroup is not
-- 
2.20.1

