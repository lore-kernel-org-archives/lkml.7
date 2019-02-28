Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855E6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607542171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbfB1OB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:01:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:54784 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbfB1OB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:01:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 06:01:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,423,1544515200"; 
   d="scan'208";a="150768847"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2019 06:01:25 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, dvyukov@google.com, namhyung@kernel.org,
        xiexiuqi@huawei.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com
Subject: [RFC PATCH] perf: Paper over the hw.target problems
Date:   Thu, 28 Feb 2019 16:01:09 +0200
Message-Id: <20190228140109.64238-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <278ac311-d8f3-2832-5fa1-522471c8c31c@huawei.com>
References: <278ac311-d8f3-2832-5fa1-522471c8c31c@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, we have a race between perf_event_release_kernel() and
perf_free_event(), which happens when parent's event is released while the
child's fork fails (because of a fatal signal, for example), that looks
like this:

cpu X                            cpu Y
-----                            -----
                                 copy_process() error path
perf_release(parent)             +->perf_event_free_task()
+-> lock(child_ctx->mutex)       |  |
+-> remove_from_context(child)   |  |
+-> unlock(child_ctx->mutex)     |  |
|                                |  +-> lock(child_ctx->mutex)
|                                |  +-> unlock(child_ctx->mutex)
|                                +-> free_task(child_task)
+-> put_task_struct(child_task)

Technically, we're still holding a reference to the task via
parent->hw.target, that's not stopping free_task(), so we end up poking at
free'd memory, as is pointed out by KASAN in the syzkaller report (see Link
below). The straightforward fix is to drop the hw.target reference while
the task is still around.

Therein lies the second problem: the users of hw.target (uprobe) assume
that it's around at ->destroy() callback time, where they use it for
context. So, in order to not break the uprobe teardown and avoid leaking
stuff, we need to call ->destroy() at the same time.

This patch fixes the race and the subsequent fallout by doing both these
things at remove_from_context time.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Link: https://syzkaller.appspot.com/bug?extid=a24c397a29ad22d86c98
Reported-by: syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com
---
 kernel/events/core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 36b8320590e8..640695d114f8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2105,6 +2105,27 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
 
 	event_function_call(event, __perf_remove_from_context, (void *)flags);
 
+	/*
+	 * This is as passable as any hw.target handling out there;
+	 * hw.target implies task context, therefore, no migration.
+	 * Which means that we can only get here at the teardown.
+	 */
+	if (event->hw.target) {
+		/*
+		 * Now, the problem with, say uprobes, is that they
+		 * use hw.target for context in their ->destroy()
+		 * callbacks. Supposedly, they may need to poke at
+		 * its contents, so better call it while we still
+		 * have the task.
+		 */
+		if (event->destroy) {
+			event->destroy(event);
+			event->destroy = NULL;
+		}
+		put_task_struct(event->hw.target);
+		event->hw.target = NULL;
+	}
+
 	/*
 	 * The above event_function_call() can NO-OP when it hits
 	 * TASK_TOMBSTONE. In that case we must already have been detached
-- 
2.20.1

