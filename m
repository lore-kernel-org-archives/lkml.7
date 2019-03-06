Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768E1C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E31920840
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbfCFKRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:17:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730169AbfCFKRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:17:21 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E38BC20675;
        Wed,  6 Mar 2019 10:17:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1h1Tbz-00029f-PI; Wed, 06 Mar 2019 05:17:19 -0500
Message-Id: <20190306101719.677685287@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 06 Mar 2019 05:16:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 1/2] tracing: Use strncpy instead of memcpy when copying comm for hist
 triggers
References: <20190306101657.474580583@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Because there may be random garbage beyond a string's null terminator,
code that might use the entire comm array e.g. histogram keys, can
give unexpected results if that garbage is copied in too, so avoid
that possibility by using strncpy instead of memcpy.

Link: http://lkml.kernel.org/r/1eb9f096a8086c3c82c7fc087c900005143cec54.1551802084.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c7774fa119a7..ca46339f3009 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2141,7 +2141,7 @@ static inline void save_comm(char *comm, struct task_struct *task)
 		return;
 	}
 
-	memcpy(comm, task->comm, TASK_COMM_LEN);
+	strncpy(comm, task->comm, TASK_COMM_LEN);
 }
 
 static void hist_elt_data_free(struct hist_elt_data *elt_data)
@@ -3557,7 +3557,7 @@ static bool cond_snapshot_update(struct trace_array *tr, void *cond_data)
 	elt_data = context->elt->private_data;
 	track_elt_data = track_data->elt.private_data;
 	if (elt_data->comm)
-		memcpy(track_elt_data->comm, elt_data->comm, TASK_COMM_LEN);
+		strncpy(track_elt_data->comm, elt_data->comm, TASK_COMM_LEN);
 
 	track_data->updated = true;
 
-- 
2.20.1


