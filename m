Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06052C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D352A218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbfDXIGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:06:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7247 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726904AbfDXIGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:06:31 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1FDD84E3C71669D2D616;
        Wed, 24 Apr 2019 16:06:29 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Apr 2019
 16:06:19 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <tj@kernel.org>, <hannes@cmpxchg.org>, <lizefan@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] cgroup: remove set but not used variable 'cgrp'
Date:   Wed, 24 Apr 2019 16:06:14 +0800
Message-ID: <20190424080614.11876-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

kernel/cgroup/cgroup.c: In function 'cgroup_post_fork':
kernel/cgroup/cgroup.c:5946:19: warning: variable 'cgrp' set but not used [-Wunused-but-set-variable]

It is never used since introduction in
commit 76f969e8948d ("cgroup: cgroup v2 freezer")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/cgroup/cgroup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6f09f9b..c9f208d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5943,11 +5943,8 @@ void cgroup_post_fork(struct task_struct *child)
 		 * the task into the frozen state.
 		 */
 		if (unlikely(cgroup_task_freeze(child))) {
-			struct cgroup *cgrp;
-
 			spin_lock(&child->sighand->siglock);
 			WARN_ON_ONCE(child->frozen);
-			cgrp = cset->dfl_cgrp;
 			child->jobctl |= JOBCTL_TRAP_FREEZE;
 			spin_unlock(&child->sighand->siglock);
 
-- 
2.7.4


