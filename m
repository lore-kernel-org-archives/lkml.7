Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F166C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7206D2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733057AbfFYTPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:15:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731166AbfFYTPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:15:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E2E5208E3;
        Tue, 25 Jun 2019 19:15:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hfquv-0002J7-BY; Tue, 25 Jun 2019 15:15:45 -0400
Message-Id: <20190625191545.245259106@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 25 Jun 2019 15:15:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 03/12] kprobes: Fix to init kprobes in subsys_initcall
References: <20190625191510.599310671@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since arm64 kernel initializes breakpoint trap vector in arch_initcall(),
initializing kprobe (and run smoke test) in postcore_initcall() causes
a kernel panic.

To fix this issue, move the kprobe initialization in subsys_initcall()
(which is called right afer the arch_initcall).

In-kernel kprobe users (ftrace and bpf) are using fs_initcall() which is
called after subsys_initcall(), so this shouldn't cause more problem.

Link: http://lkml.kernel.org/r/155956708268.12228.10363800793132214198.stgit@devnote2

Reported-by: Anders Roxell <anders.roxell@linaro.org>
Fixes: b5f8b32c93b2 ("kprobes: Initialize kprobes at postcore_initcall")
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 54aaaad00a47..5471efbeb937 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2289,7 +2289,7 @@ static int __init init_kprobes(void)
 		init_test_probes();
 	return err;
 }
-postcore_initcall(init_kprobes);
+subsys_initcall(init_kprobes);
 
 #ifdef CONFIG_DEBUG_FS
 static void report_probe(struct seq_file *pi, struct kprobe *p,
-- 
2.20.1


