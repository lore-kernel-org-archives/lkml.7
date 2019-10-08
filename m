Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7E3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7BB2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nj8H4Wwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfJHRAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:00:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44714 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729681AbfJHRAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:00:02 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x98GtRHO030764
        for <linux-kernel@vger.kernel.org>; Tue, 8 Oct 2019 10:00:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=CSwWYGEHn/p8GU5NchIMh59uuf9oyBV2cYSTpXdWu7M=;
 b=nj8H4WwqcTrH4Ay+mLYmeFQr4/SokBvxH4SvkNnQzgMxBIpi7j1uMiXHm0NEfUzm4Qu2
 3bGhCyiKHpa9MLo5Ve6I7La2Rm62Ml08kTLqi2oKtvSwnxIpfe/uKI/slGdywA5Rq8lU
 ZiYby2bsXYrrgXbDOLK4YJE88ljpPpaBf/o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vgehqc24s-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 10:00:00 -0700
Received: from 2401:db00:2050:5076:face:0:9:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Oct 2019 09:59:57 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 5A5FE62E122D; Tue,  8 Oct 2019 09:59:56 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        <stable@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2] perf/core: fix corner case in perf_rotate_context()
Date:   Tue, 8 Oct 2019 09:59:49 -0700
Message-ID: <20191008165949.920548-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_06:2019-10-08,2019-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 suspectscore=1 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910080140
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In perf_rotate_context(), when the first cpu flexible event fail to
schedule, cpu_rotate is 1, while cpu_event is NULL. Since cpu_event is
NULL, perf_rotate_context will _NOT_ call cpu_ctx_sched_out(), thus
cpuctx->ctx.is_active will have EVENT_FLEXIBLE set. Then, the next
perf_event_sched_in() will skip all cpu flexible events because of the
EVENT_FLEXIBLE bit.

In the next call of perf_rotate_context(), cpu_rotate stays 1, and
cpu_event stays NULL, so this process repeats. The end result is, flexible
events on this cpu will not be scheduled (until another event being added
to the cpuctx).

Here is an easy repro of this issue. On Intel CPUs, where ref-cycles
could only use one counter, run one pinned event for ref-cycles, one
flexible event for ref-cycles, and one flexible event for cycles. The
flexible ref-cycles is never scheduled, which is expected. However,
because of this issue, the cycles event is never scheduled either.

perf stat -e ref-cycles:D,ref-cycles,cycles -C 5 -I 1000
           time             counts unit events
    1.000152973         15,412,480      ref-cycles:D
    1.000152973      <not counted>      ref-cycles     (0.00%)
    1.000152973      <not counted>      cycles         (0.00%)
    2.000486957         18,263,120      ref-cycles:D
    2.000486957      <not counted>      ref-cycles     (0.00%)
    2.000486957      <not counted>      cycles         (0.00%)

To fix this, when the flexible_active list is empty, try rotate the
first event in the flexible_groups. Also, rename ctx_first_active() to
ctx_event_to_rotate(), which is more accurate.

Fixes: 8d5bce0c37fa ("perf/core: Optimize perf_rotate_context() event scheduling")
Cc: stable@vger.kernel.org # v4.17+
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/events/core.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3f0cb82e4fbc..b96cefed4fb2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3779,11 +3779,21 @@ static void rotate_ctx(struct perf_event_context *ctx, struct perf_event *event)
 	perf_event_groups_insert(&ctx->flexible_groups, event);
 }
 
+/* pick an event from the flexible_groups to rotate */
 static inline struct perf_event *
-ctx_first_active(struct perf_event_context *ctx)
+ctx_event_to_rotate(struct perf_event_context *ctx)
 {
-	return list_first_entry_or_null(&ctx->flexible_active,
-					struct perf_event, active_list);
+	struct perf_event *event;
+
+	/* pick the first active flexible event */
+	event = list_first_entry_or_null(&ctx->flexible_active,
+					 struct perf_event, active_list);
+
+	/* if no active flexible event, pick the first event */
+	if (!event)
+		event = rb_entry_safe(rb_first(&ctx->flexible_groups.tree),
+				      typeof(*event), group_node);
+	return event;
 }
 
 static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
@@ -3808,9 +3818,9 @@ static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
 	perf_pmu_disable(cpuctx->ctx.pmu);
 
 	if (task_rotate)
-		task_event = ctx_first_active(task_ctx);
+		task_event = ctx_event_to_rotate(task_ctx);
 	if (cpu_rotate)
-		cpu_event = ctx_first_active(&cpuctx->ctx);
+		cpu_event = ctx_event_to_rotate(&cpuctx->ctx);
 
 	/*
 	 * As per the order given at ctx_resched() first 'pop' task flexible
-- 
2.17.1

