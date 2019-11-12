Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E58C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504F1222C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKLLR7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:17:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33395 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfKLLR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:17:58 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBG-0000HH-FI; Tue, 12 Nov 2019 12:17:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 27FC11C0084;
        Tue, 12 Nov 2019 12:17:54 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:17:53 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf probe: Skip end-of-sequence and non statement lines
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <157241936090.32002.12156347518596111660.stgit@devnote2>
References: <157241936090.32002.12156347518596111660.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <157355747383.29376.10426327530011036953.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f4d99bdfd124823a81878b44b5e8750b97f73902
Gitweb:        https://git.kernel.org/tip/f4d99bdfd124823a81878b44b5e8750b97f73902
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Wed, 30 Oct 2019 16:09:21 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 07 Nov 2019 08:30:18 -03:00

perf probe: Skip end-of-sequence and non statement lines

Skip end-of-sequence and non-statement lines while walking through lines
list.

The "end-of-sequence" line information means:

 "the current address is that of the first byte after the
  end of a sequence of target machine instructions."
 (DWARF version 4 spec 6.2.2)

This actually means out of scope and we can not probe on it.

On the other hand, the statement lines (is_stmt) means:

 "the current instruction is a recommended breakpoint location.
  A recommended breakpoint location is intended to “represent”
  a line, a statement and/or a semantically distinct subpart
  of a statement."

 (DWARF version 4 spec 6.2.2)

So, non-statement line info also should be skipped.

These can reduce unneeded probe points and also avoid an error.

E.g. without this patch:

  # perf probe -a "clear_tasks_mm_cpumask:1"
  Added new events:
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask:1)
    probe:clear_tasks_mm_cpumask_1 (on clear_tasks_mm_cpumask:1)
    probe:clear_tasks_mm_cpumask_2 (on clear_tasks_mm_cpumask:1)
    probe:clear_tasks_mm_cpumask_3 (on clear_tasks_mm_cpumask:1)
    probe:clear_tasks_mm_cpumask_4 (on clear_tasks_mm_cpumask:1)

  You can now use it in all perf tools, such as:

  	perf record -e probe:clear_tasks_mm_cpumask_4 -aR sleep 1

  #

This puts 5 probes on one line, but acutally it's not inlined function.
This is because there are many non statement instructions at the
function prologue.

With this patch:

  # perf probe -a "clear_tasks_mm_cpumask:1"
  Added new event:
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask:1)

  You can now use it in all perf tools, such as:

  	perf record -e probe:clear_tasks_mm_cpumask -aR sleep 1

  #

Now perf-probe skips unneeded addresses.

Committer testing:

Slightly different results, but similar:

Before:

  # uname -a
  Linux quaco 5.3.8-200.fc30.x86_64 #1 SMP Tue Oct 29 14:46:22 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
  #
  # perf probe -a "clear_tasks_mm_cpumask:1"
  Added new events:
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask:1)
    probe:clear_tasks_mm_cpumask_1 (on clear_tasks_mm_cpumask:1)
    probe:clear_tasks_mm_cpumask_2 (on clear_tasks_mm_cpumask:1)

  You can now use it in all perf tools, such as:

  	perf record -e probe:clear_tasks_mm_cpumask_2 -aR sleep 1

  #

After:

  # perf probe -a "clear_tasks_mm_cpumask:1"
  Added new event:
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask:1)

  You can now use it in all perf tools, such as:

  	perf record -e probe:clear_tasks_mm_cpumask -aR sleep 1

  # perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask@kernel/cpu.c)
  #

Fixes: 4cc9cec636e7 ("perf probe: Introduce lines walker interface")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157241936090.32002.12156347518596111660.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dwarf-aux.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index ac82fd9..f31001d 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -782,6 +782,7 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
 	int decl = 0, inl;
 	Dwarf_Die die_mem, *cu_die;
 	size_t nlines, i;
+	bool flag;
 
 	/* Get the CU die */
 	if (dwarf_tag(rt_die) != DW_TAG_compile_unit) {
@@ -812,6 +813,12 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
 				  "Possible error in debuginfo.\n");
 			continue;
 		}
+		/* Skip end-of-sequence */
+		if (dwarf_lineendsequence(line, &flag) != 0 || flag)
+			continue;
+		/* Skip Non statement line-info */
+		if (dwarf_linebeginstatement(line, &flag) != 0 || !flag)
+			continue;
 		/* Filter lines based on address */
 		if (rt_die != cu_die) {
 			/*
