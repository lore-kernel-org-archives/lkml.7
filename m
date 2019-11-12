Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C69C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7730C22469
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfKLLVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:21:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33695 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfKLLSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:16 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBL-0000Hl-UP; Tue, 12 Nov 2019 12:18:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8BF281C047B;
        Tue, 12 Nov 2019 12:17:54 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:17:54 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf probe: Return a better scope DIE if there is no
 best scope
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <157291300887.19771.14936015360963292236.stgit@devnote2>
References: <157291300887.19771.14936015360963292236.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <157355747423.29376.8608445663818956550.tip-bot2@tip-bot2>
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

Commit-ID:     c701636aeec4c173208697d68da6e4271125564b
Gitweb:        https://git.kernel.org/tip/c701636aeec4c173208697d68da6e4271125564b
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Tue, 05 Nov 2019 09:16:49 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 07 Nov 2019 08:30:18 -03:00

perf probe: Return a better scope DIE if there is no best scope

Make find_best_scope() returns innermost DIE at given address if there
is no best matched scope DIE. Since Gcc sometimes generates intuitively
strange line info which is out of inlined function address range, we
need this fixup.

Without this, sometimes perf probe failed to probe on a line inside an
inlined function:

  # perf probe -D ksys_open:3
  Failed to find scope of probe point.
    Error: Failed to add events.

With this fix, 'perf probe' can probe it:

  # perf probe -D ksys_open:3
  p:probe/ksys_open _text+25707308
  p:probe/ksys_open_1 _text+25710596
  p:probe/ksys_open_2 _text+25711114
  p:probe/ksys_open_3 _text+25711343
  p:probe/ksys_open_4 _text+25714058
  p:probe/ksys_open_5 _text+2819653
  p:probe/ksys_open_6 _text+2819701

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Link: http://lore.kernel.org/lkml/157291300887.19771.14936015360963292236.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 88e17a4..582f8c3 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -744,6 +744,16 @@ static int find_best_scope_cb(Dwarf_Die *fn_die, void *data)
 	return 0;
 }
 
+/* Return innermost DIE */
+static int find_inner_scope_cb(Dwarf_Die *fn_die, void *data)
+{
+	struct find_scope_param *fsp = data;
+
+	memcpy(fsp->die_mem, fn_die, sizeof(Dwarf_Die));
+	fsp->found = true;
+	return 1;
+}
+
 /* Find an appropriate scope fits to given conditions */
 static Dwarf_Die *find_best_scope(struct probe_finder *pf, Dwarf_Die *die_mem)
 {
@@ -755,8 +765,13 @@ static Dwarf_Die *find_best_scope(struct probe_finder *pf, Dwarf_Die *die_mem)
 		.die_mem = die_mem,
 		.found = false,
 	};
+	int ret;
 
-	cu_walk_functions_at(&pf->cu_die, pf->addr, find_best_scope_cb, &fsp);
+	ret = cu_walk_functions_at(&pf->cu_die, pf->addr, find_best_scope_cb,
+				   &fsp);
+	if (!ret && !fsp.found)
+		cu_walk_functions_at(&pf->cu_die, pf->addr,
+				     find_inner_scope_cb, &fsp);
 
 	return fsp.found ? die_mem : NULL;
 }
