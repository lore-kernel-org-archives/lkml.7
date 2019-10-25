Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06507CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6B821D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571993227;
	bh=1m6175mvrd/tSKJ1gPQXPqQ3w5Dzw4sXbYs39c/bz3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zebnI1Rl5qLWrq6oTm60LrDbibRmpLgkBWmkKK66GrUH9KO8PGSpNf4U+8oB8/2TJ
	 6rhNv7Pxhf7/ru5Ljtw5ESed11Ql0y78PsYEeHK55nsNVd1ymZ+R5TRbTkkwGsjyJg
	 Qb5YwkocvN0SOpjv6+zujr7HwjF+tO4MI8aO3umk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408578AbfJYIrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408445AbfJYIrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:47:05 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 811BE21D7B;
        Fri, 25 Oct 2019 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571993224;
        bh=1m6175mvrd/tSKJ1gPQXPqQ3w5Dzw4sXbYs39c/bz3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KXuZuaTh+mYZoDNwtt3cNiJmUNUJyCY12xAMilojRfBd9U3XmR6G4BPH3z8FEVvQz
         ETdgYiHhC1soNy6SSMLABG27NJPWU7+gimSk4+UklXTRLmbplbLzmR9vQCD7BGsK9B
         N0QgeC5FtfVLuGQGHiYWq/2hMba4ti15+86w6r4I=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 5/6] perf/probe: Fix to show inlined function callsite without entry_pc
Date:   Fri, 25 Oct 2019 17:47:01 +0900
Message-Id: <157199322107.8075.12659099000567865708.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157199317547.8075.1010940983970397945.stgit@devnote2>
References: <157199317547.8075.1010940983970397945.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix perf-probe --line option to show inlined function callsite
lines even if the function DIE has only ranges.

Without this,
  # tools/perf/perf probe -L amd_put_event_constraints
  ...
      2  {
      3         if (amd_has_nb(cpuc) && amd_is_nb_event(&event->hw))
                        __amd_put_nb_event_constraints(cpuc, event);
      5  }

With this patch,
  # tools/perf/perf probe -L amd_put_event_constraints
  ...
      2  {
      3         if (amd_has_nb(cpuc) && amd_is_nb_event(&event->hw))
      4                 __amd_put_nb_event_constraints(cpuc, event);
      5  }

Fixes: 4cc9cec636e7 ("perf probe: Introduce lines walker interface")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/dwarf-aux.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 063f71da6b63..e0c507d6b3b4 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -695,7 +695,7 @@ static int __die_walk_funclines_cb(Dwarf_Die *in_die, void *data)
 	if (dwarf_tag(in_die) == DW_TAG_inlined_subroutine) {
 		fname = die_get_call_file(in_die);
 		lineno = die_get_call_lineno(in_die);
-		if (fname && lineno > 0 && dwarf_entrypc(in_die, &addr) == 0) {
+		if (fname && lineno > 0 && die_entrypc(in_die, &addr) == 0) {
 			lw->retval = lw->callback(fname, lineno, addr, lw->data);
 			if (lw->retval != 0)
 				return DIE_FIND_CB_END;

