Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C82C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1802230F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574163262;
	bh=sdLUW/3RYP2Ne8eeKGiOg2q24i/rbWA++p3JrRvxOxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nAWIKDPf+Zqj8eKt8KnEf7aOzi0O6tI2CSSNZ8NGeGdd9gYbchPdrpd0xt0PYbap6
	 zAp1n7ax/twILyKHyiB3HSzlswmF/ZxTnvzZqMqk8G3P7YffRAqMp0Yu7Z7oYFU6Az
	 424cAHdTYSRbBRqEMDg1mwW4pEBQG/AMtgv2ADGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfKSLeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:34:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfKSLeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:34:15 -0500
Received: from quaco.ghostprotocols.net (179.176.11.138.dynamic.adsl.gvt.net.br [179.176.11.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0F1320679;
        Tue, 19 Nov 2019 11:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574163254;
        bh=sdLUW/3RYP2Ne8eeKGiOg2q24i/rbWA++p3JrRvxOxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mrKSI3AFLqd0w0W8R4evDtcEA2KHR+xCS7MkIfZ4sQQXH2L+JqLnCiKxQQyeDAtWo
         xbNN2SQcjDJovEnzJaC9qOjpATt8BeRgas43NkY314tJza32+PNvtE9k9n9d+N3j5Z
         1f0tfmGtfI0QfcyaUwFq5X6EuRUEDo6z5a1UCq08=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 19/25] perf probe: Verify given line is a representive line
Date:   Tue, 19 Nov 2019 08:32:39 -0300
Message-Id: <20191119113245.19593-20-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

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
 tools/perf/util/probe-finder.c | 36 ++++++++++++++++++++++++++++++++++
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
-- 
2.21.0

