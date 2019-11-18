Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E689C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F8F20740
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574064717;
	bh=+ZrqIyNVDd8CD6I+ql4krO5LzZpft0p+m6rEtcd6GKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tWSaIeVsnMp7lk9nu+cbsdDt+tlBRVeItUptz4EsVvSYyFlB2qk/WzIYjknSjU4RS
	 agUQKuBPJWWqKYXiw2zPfqlePOgxvhcTierUE19ykIHhhmIlK6elkugnSeQjaoF3x1
	 0ed0Omf00EkHVe03XiL2Zg1TLkug8QBeeoGVD/9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKRIL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:11:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfKRIL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:11:56 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D3672073A;
        Mon, 18 Nov 2019 08:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574064715;
        bh=+ZrqIyNVDd8CD6I+ql4krO5LzZpft0p+m6rEtcd6GKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=boSR8su9Vf1UtkCQtSBx7GXebb6o98JGjtUAK2RUK2MB70V/sJwibjIxyKbnwIjaC
         9eDdvJJrchSFXYqe7BiaW7YWqVKhI7rZVvB6827KxMeBXZ2eTF0l7ELuFOTq3/jrj9
         FrAqODP8c3nMeSYTkS6GyvI6QxnBC9ELhnUWNOMo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v3 1/7] perf probe: Show correct statement line number by perf probe -l
Date:   Mon, 18 Nov 2019 17:11:50 +0900
Message-Id: <157406471067.24476.17463149618465494448.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157406469983.24476.13195800716161845227.stgit@devnote2>
References: <157406469983.24476.13195800716161845227.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwarf_getsrc_die() can return the line which is not a statement
nor the least line number among the lines which shares same address.
This can lead perf probe --list shows incorrect line number for
probed address.
To fix this, this introduces cu_getsrc_die() which returns only a
statement line and which is the least line number (we call it
the representive line for an address), and use it in cu_find_lineinfo().

Also, if the given address is the entry address of a real function,
cu_find_lineinfo() returns the function declared line number instead
of the start line number of the function body.

For example, without this change perf probe -l shows incorrect line
as below.

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


Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/dwarf-aux.c |   62 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 5544bfbd0f6c..aa898014ad12 100644
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
 

