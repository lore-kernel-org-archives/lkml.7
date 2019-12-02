Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187D7C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F33217F9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575281740;
	bh=VFEjD3rWysPcuxgSvHRR7T5OPSD7O8/ZP7SYzqnrnX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sLQ5e1WTfZRKD42omcIkqZp0FVwMcVBUr9Hx7KjKBV+7CL0mj4b2/t9y7+2HnX0yJ
	 PgZ9ANS3++MxmIKAoYR2YTaBKrqaiRpCpB4fmmpTc+dMhGDihFBoNz3v9CD0GMDJqz
	 jHAkaZF0jHLFWipksDuwlZihshaykQcwEGH8Kglk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfLBKPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 05:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbfLBKPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:15:39 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03381217F5;
        Mon,  2 Dec 2019 10:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575281738;
        bh=VFEjD3rWysPcuxgSvHRR7T5OPSD7O8/ZP7SYzqnrnX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hphbbm5IyKQ+LCv/oQIW3KcoMDBYvBiVFgeBYAU5sarw+CuXQRB1qc9vYQ5BFDNK2
         FcW+Iu+RBWxFo/W97UWzL8taWjJvbKdsdBl1btcsmxJPi9kMO37+XTvy1EGPEzWkFS
         Rej3EAbsAoeULdEJiP+yDzBE7q1W8igSDihNY9vQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 12/22] tracing: kprobes: Register to dynevent earlier stage
Date:   Mon,  2 Dec 2019 19:15:32 +0900
Message-Id: <157528173278.22451.13188904692743183893.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157528159833.22451.14878731055438721716.stgit@devnote2>
References: <157528159833.22451.14878731055438721716.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register kprobe event to dynevent in subsys_initcall level.
This will allow kernel to register new kprobe events in
fs_initcall level via trace_run_command.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5899911a5720..5584405b899d 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1685,11 +1685,12 @@ static __init void setup_boot_kprobe_events(void)
 	enable_boot_kprobe_events();
 }
 
-/* Make a tracefs interface for controlling probe points */
-static __init int init_kprobe_trace(void)
+/*
+ * Register dynevent at subsys_initcall. This allows kernel to setup kprobe
+ * events in fs_initcall without tracefs.
+ */
+static __init int init_kprobe_trace_early(void)
 {
-	struct dentry *d_tracer;
-	struct dentry *entry;
 	int ret;
 
 	ret = dyn_event_register(&trace_kprobe_ops);
@@ -1699,6 +1700,16 @@ static __init int init_kprobe_trace(void)
 	if (register_module_notifier(&trace_kprobe_module_nb))
 		return -EINVAL;
 
+	return 0;
+}
+subsys_initcall(init_kprobe_trace_early);
+
+/* Make a tracefs interface for controlling probe points */
+static __init int init_kprobe_trace(void)
+{
+	struct dentry *d_tracer;
+	struct dentry *entry;
+
 	d_tracer = tracing_init_dentry();
 	if (IS_ERR(d_tracer))
 		return 0;

