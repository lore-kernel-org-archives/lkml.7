Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA69DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3F9206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713393;
	bh=4m2YY3kKOHnRfOoNKZbWa4BUpwdbHMSSTVOkdf7tzZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UcELu8E6An41pvYaDBKEcqI7IDHe6MxpFuVysJr5FOXsEVCKj4jkpGbN76JfNgIIY
	 kBJZc8C44VROMdkMt0ieJ1Z+gIEUlBJ5xYLUwQ1QDk2rdcWSzFq5GdGmtIxjy1x/Fi
	 H1pNfc5vC6MUKZzZnGynSCZ0JF3Kvfz/HJnwrce4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389964AbfC0TDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389137AbfC0SN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:13:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E9E2054F;
        Wed, 27 Mar 2019 18:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710407;
        bh=4m2YY3kKOHnRfOoNKZbWa4BUpwdbHMSSTVOkdf7tzZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gJX3DWaNUDTyblx68s3xTkkVLV6C146zjVpk+T3EbOZBT93muqrUDDwgPLv+Z5AJg
         gDC9DFq+5XmsCtQQwL5smIcgskPX1JFECrVA+iYxz0wfadPjDVG8LIB7s/rTD+f9EY
         EIWLlbIQTwlbbPAF/413WbAcBjg7PUILap6ysBFU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrea Righi <righi.andrea@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 105/192] kprobes: Prohibit probing on RCU debug routine
Date:   Wed, 27 Mar 2019 14:08:57 -0400
Message-Id: <20190327181025.13507-105-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit a39f15b9644fac3f950f522c39e667c3af25c588 ]

Since kprobe itself depends on RCU, probing on RCU debug
routine can cause recursive breakpoint bugs.

Prohibit probing on RCU debug routines.

int3
 ->do_int3()
   ->ist_enter()
     ->RCU_LOCKDEP_WARN()
       ->debug_lockdep_rcu_enabled() -> int3

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrea Righi <righi.andrea@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/154998807741.31052.11229157537816341591.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/update.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 39cb23d22109..81688a133552 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -52,6 +52,7 @@
 #include <linux/tick.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/sched/isolation.h>
+#include <linux/kprobes.h>
 
 #define CREATE_TRACE_POINTS
 
@@ -253,6 +254,7 @@ int notrace debug_lockdep_rcu_enabled(void)
 	       current->lockdep_recursion == 0;
 }
 EXPORT_SYMBOL_GPL(debug_lockdep_rcu_enabled);
+NOKPROBE_SYMBOL(debug_lockdep_rcu_enabled);
 
 /**
  * rcu_read_lock_held() - might we be in RCU read-side critical section?
-- 
2.19.1

