Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F01CA9EC9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87B820650
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572913015;
	bh=sj+RCbS9Rraf5FEpFnF/HB1YuDpktkYgCJU2hNATacg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uTKc4MO6qLIAZtyx8PgZBjkS1o5VnpEji0HHI9NyAaL3fsU2btDCsLseI9FNOWGuQ
	 3NYGk2gnyhQ8MZFB5Z5q99KkDXJBNulZ0pZy86DZ19uX2phyglmg9Vmnzsg8tSFFAx
	 zNuW680Ao4FnCPe0QIASqta0taRrYqoBxb0SxMvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbfKEAQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 19:16:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:41342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387415AbfKEAQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:16:54 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81B25204FD;
        Tue,  5 Nov 2019 00:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572913013;
        bh=sj+RCbS9Rraf5FEpFnF/HB1YuDpktkYgCJU2hNATacg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yvsXIEMdO/yzze+H8kSZh2CYmHkMRhDKunL9nyAQTy9qXb/brZY4Rfw55WPW9qM4q
         5ruNft1x7EXUWLk5B57n2i1YYWDg2mxhy9pc1RdJcS54uDd2uHh+qUfHaOwt2pXHBS
         4BuvNbiSAKUHkRffsIWyawF2vzNf6Y/ClWWE4498=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/5] perf probe: Return a better scope DIE if there is no best scope
Date:   Tue,  5 Nov 2019 09:16:49 +0900
Message-Id: <157291300887.19771.14936015360963292236.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157291299825.19771.5190465639558208592.stgit@devnote2>
References: <157291299825.19771.5190465639558208592.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make find_best_scope() returns innermost DIE at given address if
there is no best matched scope DIE. Since Gcc sometimes generates
intuitively strange line info which is out of inlined function
address range, we need this fixup.

Without this, sometimes perf probe failed to probe on a line
inside an inlined function.
  # perf probe -D ksys_open:3
  Failed to find scope of probe point.
    Error: Failed to add events.

With this fix, perf probe can probe it.
  # perf probe -D ksys_open:3
  p:probe/ksys_open _text+25707308
  p:probe/ksys_open_1 _text+25710596
  p:probe/ksys_open_2 _text+25711114
  p:probe/ksys_open_3 _text+25711343
  p:probe/ksys_open_4 _text+25714058
  p:probe/ksys_open_5 _text+2819653
  p:probe/ksys_open_6 _text+2819701

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-finder.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index f441e0174334..9ecea45da4ca 100644
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

