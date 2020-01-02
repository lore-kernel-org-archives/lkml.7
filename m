Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE935C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A281C24649
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004521;
	bh=1JTlfCe1tIVjUlClWU2ggykcUNyTD43fR0kw6uDtt70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jkFsIjP0KgbZOkfJBkRlmYXWHqagI6KAZ8RP4fTt9KWanUGKelE5niY/V/RmUiQXF
	 uCAJnAgKlQuEmazdwIi2CVjYEZwF9V6Z8rJcjhlA2Koz+cid7BeH3leCku0ead5T3B
	 AE4H5goJ2TqW55nl7JMGYA6U4lxFtOq9ct73Ikf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbgABWfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:35:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730534AbgABWfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:35:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E25E520866;
        Thu,  2 Jan 2020 22:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004516;
        bh=1JTlfCe1tIVjUlClWU2ggykcUNyTD43fR0kw6uDtt70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TdKRC/ECaIxzDFMdIcGQw8ZLV+HIFn4d/0AlZLC+UnUgc+5N9CxF7zK4UGtCRX3Q3
         B2IduiVbYDod5N1R4d12lGorh+Om9FQdV6GUMoQ47nqb3Ky1OQcZUoBeQ4yNxHP95u
         9hhdCAbwPIwB+4Ktn2gflytAlPHuDee2dONPGDwk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 040/137] perf probe: Walk function lines in lexical blocks
Date:   Thu,  2 Jan 2020 23:06:53 +0100
Message-Id: <20200102220552.008588331@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit acb6a7047ac2146b723fef69ee1ab6b7143546bf ]

Since some inlined functions are in lexical blocks of given function, we
have to recursively walk through the DIE tree.  Without this fix,
perf-probe -L can miss the inlined functions which is in a lexical block
(like if (..) { func() } case.)

However, even though, to walk the lines in a given function, we don't
need to follow the children DIE of inlined functions because those do
not have any lines in the specified function.

We need to walk though whole trees only if we walk all lines in a given
file, because an inlined function can include another inlined function
in the same file.

Fixes: b0e9cb2802d4 ("perf probe: Fix to search nested inlined functions in CU")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157190836514.1859.15996864849678136353.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index af78d6fc8d12..ef6fa620a426 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -664,10 +664,9 @@ static int __die_walk_funclines_cb(Dwarf_Die *in_die, void *data)
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
@@ -714,6 +713,10 @@ static int __die_walk_culines_cb(Dwarf_Die *sp_die, void *data)
 {
 	struct __line_walk_param *lw = data;
 
+	/*
+	 * Since inlined function can include another inlined function in
+	 * the same file, we need to walk in it recursively.
+	 */
 	lw->retval = __die_walk_funclines(sp_die, true, lw->callback, lw->data);
 	if (lw->retval != 0)
 		return DWARF_CB_ABORT;
@@ -803,8 +806,9 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
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
-- 
2.20.1



