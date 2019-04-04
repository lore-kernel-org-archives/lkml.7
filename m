Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF682C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A20218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368613;
	bh=+rhhA4lt0OxCjBffbaVOtmMZTAebDZ1uTa9UCA8QEk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kPR7FoETsWzcoqRYD2jbVmorFnHQgg9ZhZqVQxg2D2FZET8Jk+YZ2+Y0yHcNcHYM+
	 p8GbyGoEGSSBSPQwEXGweUvgHKfF6N4NgNt03YT1eeHsnx+Tmq2Y2rgX/E4xgspr6n
	 MH4LESWaBm9GT4ZtqWJi+EJaFUbyYd+/C1SlS96Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbfDDJDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:03:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730827AbfDDJDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:03:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C70CB21741;
        Thu,  4 Apr 2019 09:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368611;
        bh=+rhhA4lt0OxCjBffbaVOtmMZTAebDZ1uTa9UCA8QEk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBJoqax7myvY/T8NmjhLrDy8OFSJK+U72JUsCcReoxk/1oGeETll17ArnY4upFDJa
         dbGC192s4cdGrKzkJIrKVqtQmXquyNCxC/RUISTim1605XG1+jVyY0k/383gtbAjiC
         3dE80T7qiOB5QgqmrwD7GGjVyZlbxq1iLLA2bRKg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
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
Subject: [PATCH 4.19 103/187] kprobes: Prohibit probing on RCU debug routine
Date:   Thu,  4 Apr 2019 10:47:20 +0200
Message-Id: <20190404084608.072585576@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



