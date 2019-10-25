Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC53CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FC5222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571993202;
	bh=NaSIMsvr5bN7V9GDcs0rLIhE7/ss27EKQwvF38aiT2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NSbskpNOhCBkQ64g4i/aGqJ2C6AgpUrgbo6pvylUPGuGQXlSS8k0igwDacTEIkvOw
	 F4HJ/fa2jg5KYDqF1gXS4pG1q5LVBY7+wRLQdCbQFqFcFn9Mn3m8tDE1PXuTh+ihH3
	 fHFvO3P18bAubmqTz8Qia17a+6QeSXnWOQ5ph/g8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408510AbfJYIql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:46:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408483AbfJYIqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:46:38 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B39F621D71;
        Fri, 25 Oct 2019 08:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571993197;
        bh=NaSIMsvr5bN7V9GDcs0rLIhE7/ss27EKQwvF38aiT2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jcdcbnyt5ZmeP10NBAMrbl3M+yBZ0Sybma//I4vpU/30D4UevXL8J8ONPoEj0wFUJ
         54HHy9ESmxrP4nk3IXrs4KHFyRz+Oe2L6VZ8ep4AGcnuaKKORQK5RzhS9JczACB8sf
         lGUWmN574wJ2p/2y+3kFR5vqWyOJkk5nMwJ7vAuA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 2/6] perf/probe: Fix to probe a function which has no entry pc
Date:   Fri, 25 Oct 2019 17:46:34 +0900
Message-Id: <157199319438.8075.4695576954550638618.stgit@devnote2>
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

Fix perf probe to probe a function which has no entry pc or
low pc but only has ranges attribute.

probe_point_search_cb() uses dwarf_entrypc() to get the
probe address, but that doesn't work for the function DIE
which has only ranges attribute. Use die_entrypc() instead.

Without this fix,
  # tools/perf/perf probe -k ../build-x86_64/vmlinux -D clear_tasks_mm_cpumask:0
  Probe point 'clear_tasks_mm_cpumask' not found.
    Error: Failed to add events.

With this,
  # tools/perf/perf probe -k ../build-x86_64/vmlinux -D clear_tasks_mm_cpumask:0
  p:probe/clear_tasks_mm_cpumask clear_tasks_mm_cpumask+0

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Fixes: e1ecbbc3fa83 ("perf probe: Fix to handle optimized not-inlined functions")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-finder.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 2b6513e5725c..71633f55f045 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -982,7 +982,7 @@ static int probe_point_search_cb(Dwarf_Die *sp_die, void *data)
 		param->retval = find_probe_point_by_line(pf);
 	} else if (die_is_func_instance(sp_die)) {
 		/* Instances always have the entry address */
-		dwarf_entrypc(sp_die, &pf->addr);
+		die_entrypc(sp_die, &pf->addr);
 		/* But in some case the entry address is 0 */
 		if (pf->addr == 0) {
 			pr_debug("%s has no entry PC. Skipped\n",

