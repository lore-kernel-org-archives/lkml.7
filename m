Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930D4ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6672C218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389567AbfJOTTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:19:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45692 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389436AbfJOTSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:48 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSLF-00067i-B6; Tue, 15 Oct 2019 21:18:45 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 33/34] tracing: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:18:20 +0200
Message-Id: <20191015191821.11479-34-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Add additional header output for PREEMPT_RT.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/trace/ftrace-uses.rst | 2 +-
 kernel/trace/trace.c                | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftra=
ce-uses.rst
index 1fbc69894eed0..1e0020b0bc745 100644
--- a/Documentation/trace/ftrace-uses.rst
+++ b/Documentation/trace/ftrace-uses.rst
@@ -146,7 +146,7 @@ FTRACE_OPS_FL_RECURSION_SAFE
 	itself or any nested functions that those functions call.
=20
 	If this flag is set, it is possible that the callback will also
-	be called with preemption enabled (when CONFIG_PREEMPT is set),
+	be called with preemption enabled (when CONFIG_PREEMPTION is set),
 	but this is not guaranteed.
=20
 FTRACE_OPS_FL_IPMODIFY
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6a0ee91783656..c13caba27c368 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3654,6 +3654,8 @@ print_trace_header(struct seq_file *m, struct trace_i=
terator *iter)
 		   "desktop",
 #elif defined(CONFIG_PREEMPT)
 		   "preempt",
+#elif defined(CONFIG_PREEMPT_RT)
+		   "preempt_rt",
 #else
 		   "unknown",
 #endif
--=20
2.23.0

