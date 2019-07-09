Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E634CC73C41
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0052173E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562680112;
	bh=rQnB7ykCXfFzqRJ88jyj9sjrvLqMIKiZ1fC4xlwXPCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mbjbZn1CZH9QB4aPUCwDYG2KC7qqB42QMdFsK1W8LADmr+qNVZVMHEhn6gmxGy/p+
	 p3BuoJJcGMYy/CNfXuvhauYbd1zb00WkUyFmrJnENkc3JoEqHQJSJcGVf1Se62U8Mp
	 DzwOAOVkK9U8T56MR+c4/BqYOoOtU7wiUe+mxBf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfGINsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfGINsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:48:30 -0400
Received: from lerouge.home (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D9362171F;
        Tue,  9 Jul 2019 13:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562680109;
        bh=rQnB7ykCXfFzqRJ88jyj9sjrvLqMIKiZ1fC4xlwXPCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YsYBq1fJNBKhqhCCFTzZmyhaLyf5WY3mKf53CUpCh2VP190YEeTaxGHeAGLqiM/ad
         bksqTUk628Ze+yiRcPcZfNKxF25NnlaXzxI0eD4dZAFLm8eIypTQC8MJDy0LkpH0ki
         FNmcBfuh+XXmC8RSrVQdPCnF6eSJzaEg3tkm+PX8=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Borislav Petkov <bp@suse.de>,
        syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/2] perf: Allow a pmu to pin context
Date:   Tue,  9 Jul 2019 15:48:20 +0200
Message-Id: <20190709134821.8027-2-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709134821.8027-1-frederic@kernel.org>
References: <20190709134821.8027-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some PMUs rely on the fact that struct perf_event::hw::target always
point to the actual event target during the whole event lifecycle, ie:
from pmu::init() to event::destroy().

Now perf event ctx swapping on task sched switch breaks that guarantee.

Solve that with providing a way for a PMU to pin the context of an event.

Reported-by: syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com
Cc: Borislav Petkov <bp@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/perf_event.h | 2 ++
 kernel/events/core.c       | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2ddae518dce6..ea700a193865 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -273,6 +273,8 @@ struct pmu {
 	/* number of address filters this PMU can do */
 	unsigned int			nr_addr_filters;
 
+	int				pin_ctx;
+
 	/*
 	 * Fully disable/enable this PMU, can be used to protect from the PMI
 	 * as well as for lazy/batch writing of the MSRs.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 23efe6792abc..6b4bc6fc47aa 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1689,6 +1689,9 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 		ctx->nr_stat++;
 
 	ctx->generation++;
+
+	if (event->pmu->pin_ctx)
+		ctx->pin_count++;
 }
 
 /*
@@ -1885,6 +1888,9 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 		perf_event_set_state(event, PERF_EVENT_STATE_OFF);
 
 	ctx->generation++;
+
+	if (event->pmu->pin_ctx)
+		ctx->pin_count--;
 }
 
 static void perf_group_detach(struct perf_event *event)
-- 
2.21.0

