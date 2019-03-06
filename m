Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD537C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8787B20840
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbfCFKRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:17:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730170AbfCFKRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:17:21 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E397420828;
        Wed,  6 Mar 2019 10:17:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1h1Tbz-0002A9-Tp; Wed, 06 Mar 2019 05:17:19 -0500
Message-Id: <20190306101719.811308335@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 06 Mar 2019 05:16:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 2/2] tracing: Use strncpy instead of memcpy when copying comm in trace.c
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

Link: http://lkml.kernel.org/r/1d6ebac26570c2a29ce9fb575379f17ef5c8b81b.1551802084.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3835f7ed3293..e9cc47e59d25 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1497,7 +1497,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	max_data->critical_start = data->critical_start;
 	max_data->critical_end = data->critical_end;
 
-	memcpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
+	strncpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
 	max_data->pid = tsk->pid;
 	/*
 	 * If tsk == current, then use current_uid(), as that does not use
@@ -1923,7 +1923,7 @@ static inline char *get_saved_cmdlines(int idx)
 
 static inline void set_cmdline(int idx, const char *cmdline)
 {
-	memcpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
+	strncpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
 }
 
 static int allocate_cmdlines_buffer(unsigned int val,
-- 
2.20.1


