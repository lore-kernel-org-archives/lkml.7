Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F182C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 14:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D248D21019
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 14:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="YJHfXUyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfHQOMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 10:12:20 -0400
Received: from mail.efficios.com ([167.114.142.138]:44842 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfHQOMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 10:12:20 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9F3B92488E4;
        Sat, 17 Aug 2019 10:12:18 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id sksPuplM__OJ; Sat, 17 Aug 2019 10:12:17 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1E8092488DF;
        Sat, 17 Aug 2019 10:12:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1E8092488DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1566051137;
        bh=SNTujSYADuzY8bKd9VopWId5R9+DL4DGx++0iJHg2vY=;
        h=From:To:Date:Message-Id;
        b=YJHfXUyL8rQvR7xEL1K+QXBs9VZVv4f+NiMBVwHBTsKgeh36c2pYnFH0SR5SIjMfm
         XDWYmyIH25BpbPYBMTIeQYZxhJZmATQW4rH07ojR8rTv6cVAJS9hUD0J4zS7tFvSw/
         FOZwejqqiShP8EB6hrEkWwPJf0n6kmDySg2RWnd4oVCrTSs454vc72IYwI3PzWi5XP
         WS4U9RAqXqgvs5p2HhhIj+0BQ6pWsnohH5XNO5Tk/RhJW3N5rFHEyB/cbu8+aug/4X
         d5EgUMSzPDMzkUHZT+WhT9DCE/6hUJrUIbFQgdZfJNa43l61657wSomEqDllTcZA0X
         17vImehemIn8w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id AaI95Zvy4VVO; Sat, 17 Aug 2019 10:12:17 -0400 (EDT)
Received: from thinkos.etherlink (unknown [192.222.236.144])
        by mail.efficios.com (Postfix) with ESMTPSA id DADF22488DA;
        Sat, 17 Aug 2019 10:12:16 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH 1/1] Fix: trace sched switch start/stop refcount racy updates
Date:   Sat, 17 Aug 2019 10:12:08 -0400
Message-Id: <20190817141208.15226-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading the sched_cmdline_ref and sched_tgid_ref initial state within
tracing_start_sched_switch without holding the sched_register_mutex is
racy against concurrent updates, which can lead to tracepoint probes
being registered more than once (and thus trigger warnings within
tracepoint.c).

[ Compile-tested only. I suspect it might fix the following syzbot
  report:

  syzbot+774fddf07b7ab29a1e55@syzkaller.appspotmail.com ]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Steven Rostedt (VMware) <rostedt@goodmis.org>
CC: Joel Fernandes (Google) <joel@joelfernandes.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/trace/trace_sched_switch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index e288168661e1..e304196d7c28 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -89,8 +89,10 @@ static void tracing_sched_unregister(void)
 
 static void tracing_start_sched_switch(int ops)
 {
-	bool sched_register = (!sched_cmdline_ref && !sched_tgid_ref);
+	bool sched_register;
+
 	mutex_lock(&sched_register_mutex);
+	sched_register = (!sched_cmdline_ref && !sched_tgid_ref);
 
 	switch (ops) {
 	case RECORD_CMDLINE:
-- 
2.11.0

