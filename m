Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6B8C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D35C21670
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="q+/09MRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfD2Gk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:40:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38205 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfD2Gk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:40:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3T6d6l4784096
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 28 Apr 2019 23:39:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3T6d6l4784096
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556519947;
        bh=By94weL1iGn8VcVcN5ZCjzI7uVWC8EfRyQlB+QhIaoo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=q+/09MRx80XlaRETuhqFUi909cc4zGPVBD0Fic745VWOQ0l4XyfgYr9DLSyOIMjNN
         xkWutV2/F+ZqBrToEx6USQ8I2ZgS1OTuiw8IDEScVuIfBfec928EhBLSESwwPRxuYP
         vaKndPl6+HFr/7qKL63svjOMmUZz+buE14U6O1QSXEuwWuVuvZQMSwnw8mveWxhI4l
         ueDMlpbWw+15LyVXeZmmBb5+Ta0dbM58JFO9npNPVyF9tDhazSuHR4O7HRz6l+mCra
         Unos/B1MsKWeIa2yG/paSi5cuK6G3xzng5FLxoIVIWvmouMvpXcLuCG6ZGyEzx27Mz
         qTOzV5ZB8+gKw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3T6d3MJ784077;
        Sun, 28 Apr 2019 23:39:03 -0700
Date:   Sun, 28 Apr 2019 23:39:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-e8bd5814989b994cf1b0cb179e1c777e40c0f02c@git.kernel.org>
Cc:     ast@kernel.org, rostedt@goodmis.org, tim.c.chen@linux.intel.com,
        dave@stgolabs.net, hpa@zytor.com, peterz@infradead.org,
        guro@fb.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        tglx@linutronix.de, daniel@iogearbox.net,
        huang.ying.caritas@gmail.com, will.deacon@arm.com,
        longman@redhat.com, torvalds@linux-foundation.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, guro@fb.com,
          peterz@infradead.org, hpa@zytor.com, dave@stgolabs.net,
          tim.c.chen@linux.intel.com, rostedt@goodmis.org, ast@kernel.org,
          torvalds@linux-foundation.org, longman@redhat.com,
          will.deacon@arm.com, huang.ying.caritas@gmail.com,
          daniel@iogearbox.net, tglx@linutronix.de
In-Reply-To: <20190423200318.GY14281@hirez.programming.kicks-ass.net>
References: <20190423200318.GY14281@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] trace: Fix preempt_enable_no_resched() abuse
Git-Commit-ID: e8bd5814989b994cf1b0cb179e1c777e40c0f02c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e8bd5814989b994cf1b0cb179e1c777e40c0f02c
Gitweb:     https://git.kernel.org/tip/e8bd5814989b994cf1b0cb179e1c777e40c0f02c
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue, 23 Apr 2019 22:03:18 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 29 Apr 2019 08:27:09 +0200

trace: Fix preempt_enable_no_resched() abuse

Unless there is a call into schedule() in the immediate
(deterministic) future, one must not use preempt_enable_no_resched().
It can cause a preemption to go missing and thereby cause arbitrary
delays, breaking the PREEMPT=y invariant.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: huang ying <huang.ying.caritas@gmail.com>
Fixes: 2c2d7329d8af ("tracing/ftrace: use preempt_enable_no_resched_notrace in ring_buffer_time_stamp()")
Link: https://lkml.kernel.org/r/20190423200318.GY14281@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 41b6f96e5366..4ee8d8aa3d0f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -762,7 +762,7 @@ u64 ring_buffer_time_stamp(struct ring_buffer *buffer, int cpu)
 
 	preempt_disable_notrace();
 	time = rb_time_stamp(buffer);
-	preempt_enable_no_resched_notrace();
+	preempt_enable_notrace();
 
 	return time;
 }
