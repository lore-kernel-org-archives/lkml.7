Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A27C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828E6208D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfKSQ6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:58:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52888 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfKSQ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6o7-0007OY-Oo; Tue, 19 Nov 2019 17:56:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A6E251C19D0;
        Tue, 19 Nov 2019 17:56:48 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:48 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf probe: Verify given line is a representive line
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <157406472071.24476.14915451439785001021.stgit@devnote2>
References: <157406472071.24476.14915451439785001021.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <157418260863.12247.14871130437933372652.tip-bot2@tip-bot2>
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

Commit-ID:     1ae5d88a4eefacd4a3643170c20cf6403a24d254
Gitweb:        https://git.kernel.org/tip/1ae5d88a4eefacd4a3643170c20cf6403a24d254
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Mon, 18 Nov 2019 17:12:00 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 18 Nov 2019 18:58:25 -03:00

perf probe: Verify given line is a representive line

Verify user given probe line is a representive line (which doesn't share
the address with other lines or the line is the least line among the
lines which shares same address), and if not, it shows what is the
representive line.

Without this fix, user can put a probe on the lines which is not a a
representive line. But since this is not a representive line, perf probe
-l shows a representive line number instead of user given line number.
e.g. (put kernel_read:3, but listed as kernel_read:2)

  # perf probe -a kernel_read:3
  Added new event:
    probe:kernel_read    (on kernel_read:3)

  You can now use it in all perf tools, such as:

  	perf record -e probe:kernel_read -aR sleep 1

  # perf probe -l
    probe:kernel_read    (on kernel_read:2@linux-5.0.0/fs/read_write.c)

With this fix, perf probe doesn't allow user to put a probe on a
representive line, and tell what is the representive line.

  # perf probe -a kernel_read:3
  This line is sharing the addrees with other lines.
  Please try to probe at kernel_read:2 instead.
    Error: Failed to add events.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Link: http://lore.kernel.org/lkml/157406472071.24476.14915451439785001021.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 36 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 9ecea45..ef1b320 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -776,6 +776,39 @@ static Dwarf_Die *find_best_scope(struct probe_finder *pf, Dwarf_Die *die_mem)
 	return fsp.found ? die_mem : NULL;
 }
 
+static int verify_representive_line(struct probe_finder *pf, const char *fname,
+				int lineno, Dwarf_Addr addr)
+{
+	const char *__fname, *__func = NULL;
+	Dwarf_Die die_mem;
+	int __lineno;
+
+	/* Verify line number and address by reverse search */
+	if (cu_find_lineinfo(&pf->cu_die, addr, &__fname, &__lineno) < 0)
+		return 0;
+
+	pr_debug2("Reversed line: %s:%d\n", __fname, __lineno);
+	if (strcmp(fname, __fname) || lineno == __lineno)
+		return 0;
+
+	pr_warning("This line is sharing the addrees with other lines.\n");
+
+	if (pf->pev->point.function) {
+		/* Find best match function name and lines */
+		pf->addr = addr;
+		if (find_best_scope(pf, &die_mem)
+		    && die_match_name(&die_mem, pf->pev->point.function)
+		    && dwarf_decl_line(&die_mem, &lineno) == 0) {
+			__func = dwarf_diename(&die_mem);
+			__lineno -= lineno;
+		}
+	}
+	pr_warning("Please try to probe at %s:%d instead.\n",
+		   __func ? : __fname, __lineno);
+
+	return -ENOENT;
+}
+
 static int probe_point_line_walker(const char *fname, int lineno,
 				   Dwarf_Addr addr, void *data)
 {
@@ -786,6 +819,9 @@ static int probe_point_line_walker(const char *fname, int lineno,
 	if (lineno != pf->lno || strtailcmp(fname, pf->fname) != 0)
 		return 0;
 
+	if (verify_representive_line(pf, fname, lineno, addr))
+		return -ENOENT;
+
 	pf->addr = addr;
 	sc_die = find_best_scope(pf, &die_mem);
 	if (!sc_die) {
