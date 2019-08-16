Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C41EC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD612133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="N9Q1lszF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfHPO05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 10:26:57 -0400
Received: from mail.efficios.com ([167.114.142.138]:41450 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfHPO04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:26:56 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0C0642C5488;
        Fri, 16 Aug 2019 10:26:55 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 0fhhrkBioaPA; Fri, 16 Aug 2019 10:26:54 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5805E2C5482;
        Fri, 16 Aug 2019 10:26:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5805E2C5482
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1565965614;
        bh=iv5HRQ6OkRkJ/Hf3iplLYJ2enbTgUjEJAUMw9DOMKqg=;
        h=From:To:Date:Message-Id;
        b=N9Q1lszF8gNgCfJsN5NGp9bLpt4EAjKRzV/XSAP4wdF/w/sgF3FG847G2rjd7QXJh
         EHQVly0mSzgJWbBuGhux+9edn9wBi+79gUN+MyrCg+wyQCfKd1VML36E0lnq92FLXz
         v2LswUY5Sc7cYQSQtOoVd51J7DofrnVDcL/pnqOEnBLiIhRLDMuZiEP/8USr3QiOs1
         CMxoZ+QmDVvbElXYulyBSNKtKjzX9/v9+9OWE1J2Xmg3JML+i0OW6IW3mGyhnOBoPY
         tPl4WxXGg51avYa8ArWzQfCJ58il6kOW6tqfuy1CHya+O5J7jXoJkOUlLSdW2CbaRb
         EIAR5H/YsiAxA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 03ZSjcovp2hx; Fri, 16 Aug 2019 10:26:54 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 0C6212C5478;
        Fri, 16 Aug 2019 10:26:54 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Date:   Fri, 16 Aug 2019 10:26:43 -0400
Message-Id: <20190816142643.13758-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <00000000000076ecf3059030d3f1@google.com>
References: <00000000000076ecf3059030d3f1@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading the sched_cmdline_ref and sched_tgid_ref initial state within
tracing_start_sched_switch without holding the sched_register_mutex is
racy against concurrent updates, which can lead to tracepoint probes
being registered more than once (and thus trigger warnings within
tracepoint.c).

Also, write and read to/from those variables should be done with
WRITE_ONCE() and READ_ONCE(), given that those are read within tracing
probes without holding the sched_register_mutex.

[ Compile-tested only. I suspect it might fix the following syzbot
  report:

  syzbot+774fddf07b7ab29a1e55@syzkaller.appspotmail.com ]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Joel Fernandes (Google) <joel@joelfernandes.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Steven Rostedt (VMware) <rostedt@goodmis.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/trace/trace_sched_switch.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index e288168661e1..902e8bf59aeb 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -26,8 +26,8 @@ probe_sched_switch(void *ignore, bool preempt,
 {
 	int flags;
 
-	flags = (RECORD_TGID * !!sched_tgid_ref) +
-		(RECORD_CMDLINE * !!sched_cmdline_ref);
+	flags = (RECORD_TGID * !!READ_ONCE(sched_tgid_ref)) +
+		(RECORD_CMDLINE * !!READ_ONCE(sched_cmdline_ref));
 
 	if (!flags)
 		return;
@@ -39,8 +39,8 @@ probe_sched_wakeup(void *ignore, struct task_struct *wakee)
 {
 	int flags;
 
-	flags = (RECORD_TGID * !!sched_tgid_ref) +
-		(RECORD_CMDLINE * !!sched_cmdline_ref);
+	flags = (RECORD_TGID * !!READ_ONCE(sched_tgid_ref)) +
+		(RECORD_CMDLINE * !!READ_ONCE(sched_cmdline_ref));
 
 	if (!flags)
 		return;
@@ -89,21 +89,28 @@ static void tracing_sched_unregister(void)
 
 static void tracing_start_sched_switch(int ops)
 {
-	bool sched_register = (!sched_cmdline_ref && !sched_tgid_ref);
+	bool sched_register;
+
 	mutex_lock(&sched_register_mutex);
+	sched_register = (!sched_cmdline_ref && !sched_tgid_ref);
 
 	switch (ops) {
 	case RECORD_CMDLINE:
-		sched_cmdline_ref++;
+		WRITE_ONCE(sched_cmdline_ref, sched_cmdline_ref + 1);
 		break;
 
 	case RECORD_TGID:
-		sched_tgid_ref++;
+		WRITE_ONCE(sched_tgid_ref, sched_tgid_ref + 1);
 		break;
+
+	default:
+		WARN_ONCE(1, "Unsupported tracing op: %d", ops);
+		goto end;
 	}
 
-	if (sched_register && (sched_cmdline_ref || sched_tgid_ref))
+	if (sched_register)
 		tracing_sched_register();
+end:
 	mutex_unlock(&sched_register_mutex);
 }
 
@@ -113,16 +120,21 @@ static void tracing_stop_sched_switch(int ops)
 
 	switch (ops) {
 	case RECORD_CMDLINE:
-		sched_cmdline_ref--;
+		WRITE_ONCE(sched_cmdline_ref, sched_cmdline_ref - 1);
 		break;
 
 	case RECORD_TGID:
-		sched_tgid_ref--;
+		WRITE_ONCE(sched_tgid_ref, sched_tgid_ref - 1);
 		break;
+
+	default:
+		WARN_ONCE(1, "Unsupported tracing op: %d", ops);
+		goto end;
 	}
 
 	if (!sched_cmdline_ref && !sched_tgid_ref)
 		tracing_sched_unregister();
+end:
 	mutex_unlock(&sched_register_mutex);
 }
 
-- 
2.11.0

