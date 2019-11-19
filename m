Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE1CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A0722400
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfKSQ5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:57:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52874 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbfKSQ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6o9-0007P8-Fj; Tue, 19 Nov 2019 17:56:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CB1C51C19D1;
        Tue, 19 Nov 2019 17:56:48 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:48 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf probe: Show correct statement line number by
 perf probe -l
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <157406471067.24476.17463149618465494448.stgit@devnote2>
References: <157406471067.24476.17463149618465494448.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <157418260878.12247.9502844079335473718.tip-bot2@tip-bot2>
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

Commit-ID:     57f95bf5f88295612871c36cb0de5069e50570f8
Gitweb:        https://git.kernel.org/tip/57f95bf5f88295612871c36cb0de5069e50570f8
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Mon, 18 Nov 2019 17:11:50 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 18 Nov 2019 18:56:27 -03:00

perf probe: Show correct statement line number by perf probe -l

The dwarf_getsrc_die() can return the line which is not a statement nor
the least line number among the lines which shares same address.

This can lead perf probe --list shows incorrect line number for probed
address.

To fix this, this introduces cu_getsrc_die() which returns only a
statement line and which is the least line number (we call it the
representive line for an address), and use it in cu_find_lineinfo().

Also, if the given address is the entry address of a real function,
cu_find_lineinfo() returns the function declared line number instead of
the start line number of the function body.

For example, without this change perf probe -l shows incorrect line as
below.

  # perf probe -a kernel_read:2
  Added new event:
    probe:kernel_read    (on kernel_read:2)

  You can now use it in all perf tools, such as:

  	perf record -e probe:kernel_read -aR sleep 1

  # perf probe -l
    probe:kernel_read    (on kernel_read:1@linux-5.0.0/fs/read_write.c)

With this fix, it shows correct line number as below;

  # perf probe -l
    probe:kernel_read    (on kernel_read:2@linux-5.0.0/fs/read_write.c)

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Link: http://lore.kernel.org/lkml/157406471067.24476.17463149618465494448.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dwarf-aux.c | 62 +++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 5544bfb..aa89801 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -59,6 +59,51 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die)
 	return dwarf_formstring(&attr);
 }
 
+/* Unlike dwarf_getsrc_die(), cu_getsrc_die() only returns statement line */
+static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
+{
+	Dwarf_Addr laddr;
+	Dwarf_Lines *lines;
+	Dwarf_Line *line;
+	size_t nlines, l, u, n;
+	bool flag;
+
+	if (dwarf_getsrclines(cu_die, &lines, &nlines) != 0 ||
+	    nlines == 0)
+		return NULL;
+
+	/* Lines are sorted by address, use binary search */
+	l = 0; u = nlines - 1;
+	while (l < u) {
+		n = u - (u - l) / 2;
+		line = dwarf_onesrcline(lines, n);
+		if (!line || dwarf_lineaddr(line, &laddr) != 0)
+			return NULL;
+		if (addr < laddr)
+			u = n - 1;
+		else
+			l = n;
+	}
+	/* Going backward to find the lowest line */
+	do {
+		line = dwarf_onesrcline(lines, --l);
+		if (!line || dwarf_lineaddr(line, &laddr) != 0)
+			return NULL;
+	} while (laddr == addr);
+	l++;
+	/* Going foward to find the statement line */
+	do {
+		line = dwarf_onesrcline(lines, l++);
+		if (!line || dwarf_lineaddr(line, &laddr) != 0 ||
+		    dwarf_linebeginstatement(line, &flag) != 0)
+			return NULL;
+		if (laddr > addr)
+			return NULL;
+	} while (!flag);
+
+	return line;
+}
+
 /**
  * cu_find_lineinfo - Get a line number and file name for given address
  * @cu_die: a CU DIE
@@ -72,17 +117,26 @@ int cu_find_lineinfo(Dwarf_Die *cu_die, unsigned long addr,
 		    const char **fname, int *lineno)
 {
 	Dwarf_Line *line;
-	Dwarf_Addr laddr;
+	Dwarf_Die die_mem;
+	Dwarf_Addr faddr;
 
-	line = dwarf_getsrc_die(cu_die, (Dwarf_Addr)addr);
-	if (line && dwarf_lineaddr(line, &laddr) == 0 &&
-	    addr == (unsigned long)laddr && dwarf_lineno(line, lineno) == 0) {
+	if (die_find_realfunc(cu_die, (Dwarf_Addr)addr, &die_mem)
+	    && die_entrypc(&die_mem, &faddr) == 0 &&
+	    faddr == addr) {
+		*fname = dwarf_decl_file(&die_mem);
+		dwarf_decl_line(&die_mem, lineno);
+		goto out;
+	}
+
+	line = cu_getsrc_die(cu_die, (Dwarf_Addr)addr);
+	if (line && dwarf_lineno(line, lineno) == 0) {
 		*fname = dwarf_linesrc(line, NULL, NULL);
 		if (!*fname)
 			/* line number is useless without filename */
 			*lineno = 0;
 	}
 
+out:
 	return *lineno ?: -ENOENT;
 }
 
