Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E2BC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E805720863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005165;
	bh=DF/zNNSmy9moWJcGF6ffgJY4tdKF7S2cTuVnmuVeuDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1zYT2C5VW2lrlslhBO2FLJvkPK7FrOOCkZktfUpEh5jbhWdVg3aQG87kmS8K7vkm1
	 SxURfBspwi/cNR/PSlKqoHIC++NrYC842hA2E8+ZSKmHNrQ4irL78sd25X9rbiMnJh
	 HAuKpr3IwpEJNTtKlbl/z/5GGSNTttFREbQIVX2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgABWbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:31:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730120AbgABWbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:31:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ACEE20866;
        Thu,  2 Jan 2020 22:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004272;
        bh=DF/zNNSmy9moWJcGF6ffgJY4tdKF7S2cTuVnmuVeuDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j1vjZYyca/6V7yIX9zRMnXtPQyzATLYCW2bwj0D02dthUE5q2uDQ46sOhiRzYewXF
         1sFSGJw/odXx9yPg/jpAKeVKoyVz5DO3m5oyqDpv+KoG2aXYvGnduzKA1nb3zwdGNn
         QwcElm/IUwki2DpZFupAuo5n2uMuU5GsqLcim3Dk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Thomas Backlund <tmb@mageia.org>
Subject: [PATCH 4.9 110/171] perf probe: Fix to show function entry line as probe-able
Date:   Thu,  2 Jan 2020 23:07:21 +0100
Message-Id: <20200102220602.398963748@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 91e2f539eeda26ab00bd03fae8dc434c128c85ed upstream.

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
Cc: Thomas Backlund <tmb@mageia.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/dwarf-aux.c |   24 +++++++++++++++++++++++-
 tools/perf/util/dwarf-aux.h |    3 +++
 2 files changed, 26 insertions(+), 1 deletion(-)

--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -318,6 +318,28 @@ bool die_is_func_def(Dwarf_Die *dw_die)
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
@@ -730,7 +752,7 @@ static int __die_walk_funclines(Dwarf_Di
 	/* Handle function declaration line */
 	fname = dwarf_decl_file(sp_die);
 	if (fname && dwarf_decl_line(sp_die, &lineno) == 0 &&
-	    dwarf_entrypc(sp_die, &addr) == 0) {
+	    die_entrypc(sp_die, &addr) == 0) {
 		lw.retval = callback(fname, lineno, addr, data);
 		if (lw.retval != 0)
 			goto done;
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -41,6 +41,9 @@ int cu_walk_functions_at(Dwarf_Die *cu_d
 /* Get DW_AT_linkage_name (should be NULL for C binary) */
 const char *die_get_linkage_name(Dwarf_Die *dw_die);
 
+/* Get the lowest PC in DIE (including range list) */
+int die_entrypc(Dwarf_Die *dw_die, Dwarf_Addr *addr);
+
 /* Ensure that this DIE is a subprogram and definition (not declaration) */
 bool die_is_func_def(Dwarf_Die *dw_die);
 


