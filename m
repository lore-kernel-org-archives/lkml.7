Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4BCC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A4C2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfLXLy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:54:27 -0500
Received: from foss.arm.com ([217.140.110.172]:51516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfLXLy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:54:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C16AF1FB;
        Tue, 24 Dec 2019 03:54:24 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EA043F534;
        Tue, 24 Dec 2019 03:54:23 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Tejun Heo <tj@kernel.org>, surenb@google.com,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Doug Smythies <dsmythies@telus.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH] sched/uclamp: Fix a bug in propagating uclamp value in new cgroups
Date:   Tue, 24 Dec 2019 11:54:04 +0000
Message-Id: <20191224115405.30622-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a new cgroup is created, the effective uclamp value wasn't updated
with a call to cpu_util_update_eff() that looks at the hierarchy and
update to the most restrictive values.

Fix it by ensuring to call cpu_util_update_eff() when a new cgroup
becomes online.

Without this change, the newly created cgroup uses the default
root_task_group uclamp values, which is 1024 for both uclamp_{min, max},
which will cause the rq to to be clamped to max, hence cause the
system to run at max frequency.

The problem was observed on Ubuntu server and was reproduced on Debian
and Buildroot rootfs.

By default, Ubuntu and Debian create a cpu controller cgroup hierarchy
and add all tasks to it - which creates enough noise to keep the rq
uclamp value at max most of the time. Imitating this behavior makes the
problem visible in Buildroot too which otherwise looks fine since it's a
minimal userspace.

Reported-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Doug Smythies <dsmythies@telus.net>
Fixes: 0b60ba2dd342 ("sched/uclamp: Propagate parent clamps")
Link: https://lore.kernel.org/lkml/000701d5b965$361b6c60$a2524520$@net/
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90e4b00ace89..bfe756dee129 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7100,6 +7100,12 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
 
 	if (parent)
 		sched_online_group(tg, parent);
+
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	/* Propagate the effective uclamp value for the new group */
+	cpu_util_update_eff(css);
+#endif
+
 	return 0;
 }
 
-- 
2.17.1

