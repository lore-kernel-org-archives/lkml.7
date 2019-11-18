Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FDCC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D61F2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574064727;
	bh=pK4+YU2Csm6Ii8Ve8VrvowxzzcCdY0EVHRB0Cm+o19M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OW5ae813at1yvxeV+Eodp6d4kuiuWx3YKASX8RfQNmVosBY+ks8KaxYgKKTsDKOa0
	 YbVorW36ou+OcTLUXNSaxCujwR8+jVjIIm1ELdKpH2G41G2a3DHVDObsvmXiD7GKY4
	 oyUosUUdS1I1StCHKWZKgQJOHYYnDjM3MoGS3+Ss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKRIMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:12:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfKRIMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:12:06 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 430712075C;
        Mon, 18 Nov 2019 08:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574064725;
        bh=pK4+YU2Csm6Ii8Ve8VrvowxzzcCdY0EVHRB0Cm+o19M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVtzMVHx6AjqgaQqBlDHtmlg4gyALZpFdM5TAi7Ij000UApkPkPVlDMc/WzQwiFtw
         Op5mwIpjx2zZlPPLIMCjjIOJlMuriwUtYOYQAZ/Yi7Ef71cuYlIThcirxJXMCn+aqZ
         S8supnna/54ZiKgg68npC7S5g7Xq1Byg2HLwSDTo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v3 2/7] perf probe: Verify given line is a representive line
Date:   Mon, 18 Nov 2019 17:12:00 +0900
Message-Id: <157406472071.24476.14915451439785001021.stgit@devnote2>
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

Verify user given probe line is a representive line (which doesn't
share the address with other lines or the line is the least line
among the lines which shares same address), and if not, it shows
what is the representive line.

Without this fix, user can put a probe on the lines which is not a
a representive line. But since this is not a representive line,
perf probe -l shows a representive line number instead of user given
line number. e.g. (put kernel_read:3, but listed as kernel_read:2)

  # perf probe -a kernel_read:3
  Added new event:
    probe:kernel_read    (on kernel_read:3)

  You can now use it in all perf tools, such as:

  	perf record -e probe:kernel_read -aR sleep 1

  # perf probe -l
    probe:kernel_read    (on kernel_read:2@linux-5.0.0/fs/read_write.c)

With this fix, perf probe doesn't allow user to put a probe on
a representive line, and tell what is the representive line.

  # perf probe -a kernel_read:3
  This line is sharing the addrees with other lines.
  Please try to probe at kernel_read:2 instead.
    Error: Failed to add events.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-finder.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 9ecea45da4ca..ef1b320cedf8 100644
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

