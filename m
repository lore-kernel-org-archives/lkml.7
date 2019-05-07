Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04D0C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D1620825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fDuNh05p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfEGQPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:15:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59902 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726411AbfEGQPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:15:53 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47GF08B024617
        for <linux-kernel@vger.kernel.org>; Tue, 7 May 2019 09:15:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=5WZvqTbRwexyJMsW7Lx/6ck6XpNZz35L9yW664OM5Mg=;
 b=fDuNh05pgDFy9xHmZTjkEw8B86mPyJZmA/fH4TkOtrCPK4JGJMfu0z3toogcGDSLqlb/
 IIcoEVsFbszEvv8I2I1R5gANsFbW2aos5M//mONcFAsWOfOUApBhVLxz3cQdlZD/ali0
 Ed2L0mNfuyrmJR6KTMm4IKmGBi6IZZ+j5Yw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sb6gx9fv1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:15:51 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 7 May 2019 09:15:49 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id AECE462E1871; Tue,  7 May 2019 09:15:47 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
CC:     Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2] perf: allow non-privileged uprobe for user processes
Date:   Tue, 7 May 2019 09:15:45 -0700
Message-ID: <20190507161545.788381-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, non-privileged user could only use uprobe with

    kernel.perf_event_paranoid = -1

However, setting perf_event_paranoid to -1 leaks other users' processes to
non-privileged uprobes.

To introduce proper permission control of uprobes, we are building the
following system:
  A daemon with CAP_SYS_ADMIN is in charge to create uprobes via tracefs;
  Users asks the daemon to create uprobes;
  Then user can attach uprobe only to processes owned by the user.

This patch allows non-privileged user to attach uprobe to processes owned
by the user.

The following example shows how to use uprobe with non-privileged user.
This is based on Brendan's blog post [1]

1. Create uprobe with root:
  sudo perf probe -x 'readline%return +0($retval):string'

2. Then non-root user can use the uprobe as:
  perf record -vvv -e probe_bash:readline__return -p <pid> sleep 20
  perf script

[1] http://www.brendangregg.com/blog/2015-06-28/linux-ftrace-uprobe.html

Signed-off-by: Song Liu <songliubraving@fb.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
---
 kernel/events/core.c        | 4 ++--
 kernel/trace/trace_uprobe.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index abbd4b3b96c2..3005c80f621d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8532,9 +8532,9 @@ static int perf_tp_event_match(struct perf_event *event,
 	if (event->hw.state & PERF_HES_STOPPED)
 		return 0;
 	/*
-	 * All tracepoints are from kernel-space.
+	 * If exclude_kernel, only trace user-space tracepoints (uprobes)
 	 */
-	if (event->attr.exclude_kernel)
+	if (event->attr.exclude_kernel && !user_mode(regs))
 		return 0;
 
 	if (!perf_tp_filter_match(event, data))
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index be78d99ee6bc..bfd3040b4cfb 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1304,7 +1304,7 @@ static inline void init_trace_event_call(struct trace_uprobe *tu,
 	call->event.funcs = &uprobe_funcs;
 	call->class->define_fields = uprobe_event_define_fields;
 
-	call->flags = TRACE_EVENT_FL_UPROBE;
+	call->flags = TRACE_EVENT_FL_UPROBE | TRACE_EVENT_FL_CAP_ANY;
 	call->class->reg = trace_uprobe_register;
 	call->data = tu;
 }
-- 
2.17.1

