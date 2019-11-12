Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95098C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749BE224D4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfKLLSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:18:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33863 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfKLLS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBf-0000cM-Ux; Tue, 12 Nov 2019 12:18:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E8C3D1C04F3;
        Tue, 12 Nov 2019 12:18:10 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:10 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf probe: Fix to probe a function which has no entry pc
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <157199319438.8075.4695576954550638618.stgit@devnote2>
References: <157199319438.8075.4695576954550638618.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <157355749051.29376.230277997554016412.tip-bot2@tip-bot2>
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

Commit-ID:     5d16dbcc311d91267ddb45c6da4f187be320ecee
Gitweb:        https://git.kernel.org/tip/5d16dbcc311d91267ddb45c6da4f187be320ecee
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Fri, 25 Oct 2019 17:46:34 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:06 -03:00

perf probe: Fix to probe a function which has no entry pc

Fix 'perf probe' to probe a function which has no entry pc or low pc but
only has ranges attribute.

probe_point_search_cb() uses dwarf_entrypc() to get the probe address,
but that doesn't work for the function DIE which has only ranges
attribute. Use die_entrypc() instead.

Without this fix:

  # perf probe -k ../build-x86_64/vmlinux -D clear_tasks_mm_cpumask:0
  Probe point 'clear_tasks_mm_cpumask' not found.
    Error: Failed to add events.

With this:

  # perf probe -k ../build-x86_64/vmlinux -D clear_tasks_mm_cpumask:0
  p:probe/clear_tasks_mm_cpumask clear_tasks_mm_cpumask+0

Committer testing:

Before:

  [root@quaco ~]# perf probe clear_tasks_mm_cpumask:0
  Probe point 'clear_tasks_mm_cpumask' not found.
    Error: Failed to add events.
  [root@quaco ~]#

After:

  [root@quaco ~]# perf probe clear_tasks_mm_cpumask:0
  Added new event:
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask)

  You can now use it in all perf tools, such as:

  	perf record -e probe:clear_tasks_mm_cpumask -aR sleep 1

  [root@quaco ~]#

Using it with 'perf trace':

  [root@quaco ~]# perf trace -e probe:clear_tasks_mm_cpumask

Doesn't seem to be used in x86_64:

  $ find . -name "*.c" | xargs grep clear_tasks_mm_cpumask
  ./kernel/cpu.c: * clear_tasks_mm_cpumask - Safely clear tasks' mm_cpumask for a CPU
  ./kernel/cpu.c:void clear_tasks_mm_cpumask(int cpu)
  ./arch/xtensa/kernel/smp.c:	clear_tasks_mm_cpumask(cpu);
  ./arch/csky/kernel/smp.c:	clear_tasks_mm_cpumask(cpu);
  ./arch/sh/kernel/smp.c:	clear_tasks_mm_cpumask(cpu);
  ./arch/arm/kernel/smp.c:	clear_tasks_mm_cpumask(cpu);
  ./arch/powerpc/mm/nohash/mmu_context.c:	clear_tasks_mm_cpumask(cpu);
  $ find . -name "*.h" | xargs grep clear_tasks_mm_cpumask
  ./include/linux/cpu.h:void clear_tasks_mm_cpumask(int cpu);
  $ find . -name "*.S" | xargs grep clear_tasks_mm_cpumask
  $

Fixes: e1ecbbc3fa83 ("perf probe: Fix to handle optimized not-inlined functions")
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157199319438.8075.4695576954550638618.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 2b6513e..71633f5 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -982,7 +982,7 @@ static int probe_point_search_cb(Dwarf_Die *sp_die, void *data)
 		param->retval = find_probe_point_by_line(pf);
 	} else if (die_is_func_instance(sp_die)) {
 		/* Instances always have the entry address */
-		dwarf_entrypc(sp_die, &pf->addr);
+		die_entrypc(sp_die, &pf->addr);
 		/* But in some case the entry address is 0 */
 		if (pf->addr == 0) {
 			pr_debug("%s has no entry PC. Skipped\n",
