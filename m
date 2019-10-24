Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EDACA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D055820856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571908380;
	bh=WpaFv6ptX98DGoonOl6ONLPRjLrKbffTyfsnO9niVsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ohXGYQyRHcYc1qan90oQkUZ5QfOn5OVN9F0tEtXFWmrjR1HCgXYxsYcZQG+WLtra/
	 SPp8613jpYypRjSR+RALWnJGzpTos+mPpvAjIpBaSe9sWyWv7QFfzjnX+PMFUPODrI
	 CUVbnUpqXN4ZpAsyEUQVpdBI5rsF+WAAXLhUQIrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393000AbfJXJM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389110AbfJXJM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:12:58 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A048B20856;
        Thu, 24 Oct 2019 09:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571908377;
        bh=WpaFv6ptX98DGoonOl6ONLPRjLrKbffTyfsnO9niVsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQH+3n0cmyUVIX0LdWipuWHsUyhRxs9rAiXK2rDb9qtI0G39yTsfwdzXVny8dA7tH
         cANKPfovoVjr6WCBi8EoxQ0f32an6xtNCQK042GgF4jjqFvscTOQJFrRc3hO18ZzGB
         v9G5c2ElWJkomfb55hk/G2fSmX4lB6DOhkoFws0w=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 3/3] perf/probe: Fix to show function entry line as probe-able
Date:   Thu, 24 Oct 2019 18:12:54 +0900
Message-Id: <157190837419.1859.4619125803596816752.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157190834681.1859.7399361844806238387.stgit@devnote2>
References: <157190834681.1859.7399361844806238387.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix die_walk_lines() to list the function entry line correctly.
Since the dwarf_entrypc() does not return the entry pc if the DIE
has only range attribute, __die_walk_funclines() fails to list
the declaration line (entry line) in that case.

To solve this issue, this introduces die_entrypc() which correctly
returns the entry PC (the first address range) even if the DIE has
only range attribute. With this fix die_walk_lines() shows the
function entry line is able to probe correctly.

Fixes: 4cc9cec636e7 ("perf probe: Introduce lines walker interface")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/dwarf-aux.c |   24 +++++++++++++++++++++++-
 tools/perf/util/dwarf-aux.h |    3 +++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 929b7c0567f4..063f71da6b63 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -307,6 +307,28 @@ bool die_is_func_def(Dwarf_Die *dw_die)
 		dwarf_attr(dw_die, DW_AT_declaration, &attr) == NULL);
 }
 
+/**
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
 /**
  * die_is_func_instance - Ensure that this DIE is an instance of a subprogram
  * @dw_die: a DIE
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
index f204e5892403..506006e0cf66 100644
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
 

