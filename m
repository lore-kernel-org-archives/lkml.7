Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFF5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15982248B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfKLLSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:18:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33741 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfKLLSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBa-0000bP-AJ; Tue, 12 Nov 2019 12:18:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E86521C0357;
        Tue, 12 Nov 2019 12:18:09 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:09 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf probe: Fix to list probe event with correct line number
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <157199321227.8075.14655572419136993015.stgit@devnote2>
References: <157199321227.8075.14655572419136993015.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <157355748948.29376.12970359374833546705.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3895534dd78f0fd4d3f9e05ee52b9cdd444a743e
Gitweb:        https://git.kernel.org/tip/3895534dd78f0fd4d3f9e05ee52b9cdd444a743e
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Fri, 25 Oct 2019 17:46:52 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:06 -03:00

perf probe: Fix to list probe event with correct line number

Since debuginfo__find_probe_point() uses dwarf_entrypc() for finding the
entry address of the function on which a probe is, it will fail when the
function DIE has only ranges attribute.

To fix this issue, use die_entrypc() instead of dwarf_entrypc().

Without this fix, perf probe -l shows incorrect offset:

  # perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask+18446744071579263632@work/linux/linux/kernel/cpu.c)
    probe:clear_tasks_mm_cpumask_1 (on clear_tasks_mm_cpumask+18446744071579263752@work/linux/linux/kernel/cpu.c)

With this:

  # perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask@work/linux/linux/kernel/cpu.c)
    probe:clear_tasks_mm_cpumask_1 (on clear_tasks_mm_cpumask:21@work/linux/linux/kernel/cpu.c)

Committer testing:

Before:

  [root@quaco ~]# perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask+18446744071579765152@kernel/cpu.c)
  [root@quaco ~]#

After:

  [root@quaco ~]# perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask@kernel/cpu.c)
  [root@quaco ~]#

Fixes: 1d46ea2a6a40 ("perf probe: Fix listing incorrect line number with inline function")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157199321227.8075.14655572419136993015.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 2fa932b..88e17a4 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1566,7 +1566,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, unsigned long addr,
 		/* Get function entry information */
 		func = basefunc = dwarf_diename(&spdie);
 		if (!func ||
-		    dwarf_entrypc(&spdie, &baseaddr) != 0 ||
+		    die_entrypc(&spdie, &baseaddr) != 0 ||
 		    dwarf_decl_line(&spdie, &baseline) != 0) {
 			lineno = 0;
 			goto post;
@@ -1583,7 +1583,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, unsigned long addr,
 		while (die_find_top_inlinefunc(&spdie, (Dwarf_Addr)addr,
 						&indie)) {
 			/* There is an inline function */
-			if (dwarf_entrypc(&indie, &_addr) == 0 &&
+			if (die_entrypc(&indie, &_addr) == 0 &&
 			    _addr == addr) {
 				/*
 				 * addr is at an inline function entry.
