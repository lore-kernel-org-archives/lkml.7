Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A28C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A0821881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbfICRRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 13:17:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54298 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbfICRRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:17:04 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1i5CQQ-0006gX-1l; Tue, 03 Sep 2019 17:17:02 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH 2/2] sched: allow sched_getattr with old size
Date:   Tue,  3 Sep 2019 14:16:45 -0300
Message-Id: <20190903171645.28090-2-cascardo@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903171645.28090-1-cascardo@canonical.com>
References: <20190903171645.28090-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit a509a7cd7974 (sched/uclamp: Extend sched_setattr() to support
utilization clamping), using sched_getattr with size 48 will return E2BIG.

This breaks, for example, chrt.
$ chrt -p $$
chrt: failed to get pid 26306's policy: Argument list too long
$

With this fix, when using the old size, the utilization clamping values will be
absent from sched_attr. When using the new size or some larger size, they will
be present.

After the fix, chrt works again.
$ chrt -p $$
pid 4649's current scheduling policy: SCHED_OTHER
pid 4649's current scheduling priority: 0
$

The drawback with this solution is that userspace will ignore there are
non-default utilization clamps, but it's arguable whether returning E2BIG in
this case makes sense when that same userspace doesn't know about those values
anyway.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Fixes: a509a7cd7974 (sched/uclamp: Extend sched_setattr() to support utilization clamping)
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
---
 kernel/sched/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0fd67281e656..0ccc7fa80da6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5183,8 +5183,10 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		attr.sched_nice = task_nice(p);
 
 #ifdef CONFIG_UCLAMP_TASK
-	attr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
-	attr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
+	if (size >= SCHED_ATTR_SIZE_VER1) {
+		attr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
+		attr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
+	}
 #endif
 
 	rcu_read_unlock();
-- 
2.20.1

