Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77E5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9608B22469
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKLLUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:20:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33804 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfKLLSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:21 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBd-0000e5-AT; Tue, 12 Nov 2019 12:18:17 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6EC1E1C04A9;
        Tue, 12 Nov 2019 12:18:12 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:12 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf probe: Fix to show function entry line as probe-able
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <157190837419.1859.4619125803596816752.stgit@devnote2>
References: <157190837419.1859.4619125803596816752.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <157355749205.29376.7472271446729295271.tip-bot2@tip-bot2>
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

Commit-ID:     91e2f539eeda26ab00bd03fae8dc434c128c85ed
Gitweb:        https://git.kernel.org/tip/91e2f539eeda26ab00bd03fae8dc434c128c85ed
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Thu, 24 Oct 2019 18:12:54 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:06 -03:00

perf probe: Fix to show function entry line as probe-able

Fix die_walk_lines() to list the function entry line correctly.  Since
the dwarf_entrypc() does not return the entry pc if the DIE has only
range attribute, __die_walk_funclines() fails to list the declaration
line (entry line) in that case.

To solve this issue, this introduces die_entrypc() which correctly
returns the entry PC (the first address range) even if the DIE has only
range attribute. With this fix die_walk_lines() shows the function entry
line is able to probe correctly.

Fixes: 4cc9cec636e7 ("perf probe: Introduce lines walker interface")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157190837419.1859.4619125803596816752.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dwarf-aux.c | 24 +++++++++++++++++++++++-
 tools/perf/util/dwarf-aux.h |  3 +++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 929b7c0..063f71d 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -308,6 +308,28 @@ bool die_is_func_def(Dwarf_Die *dw_die)
 }
 
 /**
+ * die_entrypc - Returns entry PC (the lowest address) of a DIE
+ * @dw_die: a DIE
+ * @addr: where to store entry PC
+ *
+ * Since dwarf_entrypc() does not return entry PC if the DIE has only address
+ * range, we have to use this to retrieve the lowest address from the address
+ * range attribute.
+ */
+int die_entrypc(Dwarf_Die *dw_die, Dwarf_Addr *addr)
+{
+	Dwarf_Addr base, end;
+
+	if (!addr)
+		return -EINVAL;
+
+	if (dwarf_entrypc(dw_die, addr) == 0)
+		return 0;
+
+	return dwarf_ranges(dw_die, 0, &base, addr, &end) < 0 ? -ENOENT : 0;
+}
+
+/**
  * die_is_func_instance - Ensure that this DIE is an instance of a subprogram
  * @dw_die: a DIE
  *
@@ -713,7 +735,7 @@ static int __die_walk_funclines(Dwarf_Die *sp_die, bool recursive,
 	/* Handle function declaration line */
 	fname = dwarf_decl_file(sp_die);
 	if (fname && dwarf_decl_line(sp_die, &lineno) == 0 &&
-	    dwarf_entrypc(sp_die, &addr) == 0) {
+	    die_entrypc(sp_die, &addr) == 0) {
 		lw.retval = callback(fname, lineno, addr, data);
 		if (lw.retval != 0)
 			goto done;
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index f204e58..506006e 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -29,6 +29,9 @@ int cu_walk_functions_at(Dwarf_Die *cu_die, Dwarf_Addr addr,
 /* Get DW_AT_linkage_name (should be NULL for C binary) */
 const char *die_get_linkage_name(Dwarf_Die *dw_die);
 
+/* Get the lowest PC in DIE (including range list) */
+int die_entrypc(Dwarf_Die *dw_die, Dwarf_Addr *addr);
+
 /* Ensure that this DIE is a subprogram and definition (not declaration) */
 bool die_is_func_def(Dwarf_Die *dw_die);
 
