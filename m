Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D62C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EB2218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153374;
	bh=yiD25ZCcf16X7K4M+YWVhUqe4DG4sVNvzWNuh6CGMMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KQLnT9qSbnYd1EmwAzzhwR/xXww17aIHkj1WnN5zI+gLC4lFIRfyJ9An355R8ZYjA
	 mQ8lZuWPT8vKHcEZ8s4wq1YjgIDDP/ALql2IXEdVj4ST4hlFci1NCmRzL/SFzlnd8Y
	 VBIHn9TIXsPrUouVzzthv5kO2XF75CVQJdA8RHLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfKGTCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:02:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfKGTCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:02:52 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4754F21882;
        Thu,  7 Nov 2019 19:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153372;
        bh=yiD25ZCcf16X7K4M+YWVhUqe4DG4sVNvzWNuh6CGMMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L57qINgW6O0jmCRh+OvYdxCXGY/HMTCZFBXy0Bg57u4Vt0ZdBL2Vv/lf3kIEABLan
         DTjSmqYN1CbjmR2ZGxdVjQWFFP+3P8S312ql/wJ8RbdCajfwh8ZxW2Slo3OazsEqy1
         HVlLy55RmSIphMLil9I6OyMrAw++It4SyLACCCXE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/63] perf probe: Walk function lines in lexical blocks
Date:   Thu,  7 Nov 2019 15:59:24 -0300
Message-Id: <20191107190011.23924-17-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

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
---
 tools/perf/util/dwarf-aux.c | 14 +++++++++-----
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
-- 
2.21.0

