Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC68C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1793218B8
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfGXMx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:53:28 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38614 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfGXMx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:53:28 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C139F200254;
        Wed, 24 Jul 2019 14:53:25 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B2DDD200214;
        Wed, 24 Jul 2019 14:53:25 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0857B205EE;
        Wed, 24 Jul 2019 14:53:24 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Frank Li <Frank.li@nxp.com>
Subject: [PATCH] perf/core: Fix creating kernel counters for PMUs that override event->cpu
Date:   Wed, 24 Jul 2019 15:53:24 +0300
Message-Id: <c4ebe0503623066896d7046def4d6b1e06e0eb2e.1563972056.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some hardware PMU drivers will override perf_event.cpu inside their
event_init callback. This causes a lockdep splat when initialized through
the kernel API:

WARNING: CPU: 0 PID: 250 at kernel/events/core.c:2917 ctx_sched_out+0x78/0x208
CPU: 0 PID: 250 Comm: systemd-udevd Not tainted 5.3.0-rc1-next-20190723-00024-g94e04593c88a #80
Hardware name: FSL i.MX8MM EVK board (DT)
pstate: 40000085 (nZcv daIf -PAN -UAO)
pc : ctx_sched_out+0x78/0x208
lr : ctx_sched_out+0x78/0x208
sp : ffff0000127a3750
x29: ffff0000127a3750 x28: 0000000000000000
x27: ffff00001162bf20 x26: ffff000008cf3310
x25: ffff0000127a3de0 x24: ffff0000115ff808
x23: ffff7dffbff851b8 x22: 0000000000000004
x21: ffff7dffbff851b0 x20: 0000000000000000
x19: ffff7dffbffc51b0 x18: 0000000000000010
x17: 0000000000000001 x16: 0000000000000007
x15: 2e8ba2e8ba2e8ba3 x14: 0000000000005114
x13: ffff0000117d5e30 x12: ffff000011898378
x11: 0000000000000000 x10: ffff0000117d5000
x9 : 0000000000000045 x8 : 0000000000000000
x7 : ffff000010168194 x6 : ffff0000117d59d0
x5 : 0000000000000001 x4 : ffff80007db56128
x3 : ffff80007db56128 x2 : 0d9c118347a77600
x1 : 0000000000000000 x0 : 0000000000000024
Call trace:
 ctx_sched_out+0x78/0x208
 __perf_install_in_context+0x160/0x248
 remote_function+0x58/0x68
 generic_exec_single+0x100/0x180
 smp_call_function_single+0x174/0x1b8
 perf_install_in_context+0x178/0x188
 perf_event_create_kernel_counter+0x118/0x160

Fix by calling perf_install_in_context with event->cpu, just like
perf_event_open

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
I don't understand why PMUs outside the core are bound to a CPU anyway,
all this patch does is attempt to satisfy the assumptions made by
__perf_install_in_context and ctx_sched_out at init time so that lockdep
no longer complains.

ctx_sched_out asserts ctx->lock which seems to be taken by
__perf_install_in_context:

	struct perf_event_context *ctx = event->ctx;
	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
	...
	raw_spin_lock(&cpuctx->ctx.lock);

The lockdep warning happens when ctx != &cpuctx->ctx which can happen if
__perf_install_in_context is called on a cpu other than event->cpu.

Found while working on this patch:
https://patchwork.kernel.org/patch/11056785/

 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 026a14541a38..0463c1151bae 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11272,11 +11272,11 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 	if (!exclusive_event_installable(event, ctx)) {
 		err = -EBUSY;
 		goto err_unlock;
 	}
 
-	perf_install_in_context(ctx, event, cpu);
+	perf_install_in_context(ctx, event, event->cpu);
 	perf_unpin_context(ctx);
 	mutex_unlock(&ctx->mutex);
 
 	return event;
 
-- 
2.17.1

