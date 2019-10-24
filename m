Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C55C47E49
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67542166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571908380;
	bh=0lkkNZZmVpatvfDPtdWe6NAehCmZP5AKVIcEua6Ezno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pyR6xprG99JAGiLFG49Ifc5F7crWSYHL/BXSnialwtVtI1hekwyxb4XlW23O/mVPe
	 bkBaDryPiGGp1vGj47qllFh+s+K24UfSHsW/gb+8mSMu6L34rFVUfMZnMQTJgTbUpd
	 JhLzF4uoAUsklAnfRWfYd+EAe57aeCtHsMhQDVK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392990AbfJXJMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389524AbfJXJMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:12:49 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A232D20856;
        Thu, 24 Oct 2019 09:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571908368;
        bh=0lkkNZZmVpatvfDPtdWe6NAehCmZP5AKVIcEua6Ezno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QYCgJ5fFCeO4jPmLg6FvRBgH5X7p+f0zE0gQKvBamMG+ZGuGsmUP609Jp40uNP/OA
         qsgADnE/LgiEpbEKs2TjwTIJjmm/x0hul0C2yXmDFz84EdW7XRIGggGe2ecO9t/2IK
         gm5+QTedSt07hgA78xNOizBa1+6M6+frkW/T8Y0Q=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 2/3] perf/probe: Walk function lines in lexical blocks
Date:   Thu, 24 Oct 2019 18:12:45 +0900
Message-Id: <157190836514.1859.15996864849678136353.stgit@devnote2>
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

Since some inlined functions are in lexical blocks of given
function, we have to recursively walk through the DIE tree.
Without this fix, perf-probe -L can miss the inlined functions
which is in a lexcical block (like if (..) { func() } case.)

However, even though, to walk the lines in a given function,
we don't need to follow the children DIE of inlined functions
because those do not have any lines in the specified function.

We need to walk though whole trees only if we walk all lines
in a given file, because an inlined function can include
another inlined function in the same file.

Fixes: b0e9cb2802d4 ("perf probe: Fix to search nested inlined functions in CU")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/dwarf-aux.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 2ec24c3bed44..929b7c0567f4 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -678,10 +678,9 @@ static int __die_walk_funclines_cb(Dwarf_Die *in_die, void *data)
 			if (lw->retval != 0)
 				return DIE_FIND_CB_END;
 		}
+		if (!lw->recursive)
+			return DIE_FIND_CB_SIBLING;
 	}
-	if (!lw->recursive)
-		/* Don't need to search recursively */
-		return DIE_FIND_CB_SIBLING;
 
 	if (addr) {
 		fname = dwarf_decl_file(in_die);
@@ -728,6 +727,10 @@ static int __die_walk_culines_cb(Dwarf_Die *sp_die, void *data)
 {
 	struct __line_walk_param *lw = data;
 
+	/*
+	 * Since inlined function can include another inlined function in
+	 * the same file, we need to walk in it recursively.
+	 */
 	lw->retval = __die_walk_funclines(sp_die, true, lw->callback, lw->data);
 	if (lw->retval != 0)
 		return DWARF_CB_ABORT;
@@ -817,8 +820,9 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
 	 */
 	if (rt_die != cu_die)
 		/*
-		 * Don't need walk functions recursively, because nested
-		 * inlined functions don't have lines of the specified DIE.
+		 * Don't need walk inlined functions recursively, because
+		 * inner inlined functions don't have the lines of the
+		 * specified function.
 		 */
 		ret = __die_walk_funclines(rt_die, false, callback, data);
 	else {

