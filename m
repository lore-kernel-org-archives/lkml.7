Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F113CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE4021D80
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572080461;
	bh=4OfLu5M/qizHkoIjljuD0E+k8A4IXSWXef87FPXIGoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tTMU54Svml4R6aXWEOhxJElxQoMaflWyJaiMzi3UodaIReRwWl22LcmphutzLEk9N
	 YP4yEZIRzAlBYkq7AgkEpCqK+my3CBhx8J4s4HA+KGLfSOoCzihmZYxNZACoBxRR1P
	 1hZQvoLi6QFuhGWXqQZy6I4W0mRmc1ggmiFUT1Ro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfJZJBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 05:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJZJA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 05:00:59 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E504D206DD;
        Sat, 26 Oct 2019 09:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572080459;
        bh=4OfLu5M/qizHkoIjljuD0E+k8A4IXSWXef87FPXIGoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=srqJOzTMQEKFEIwOFNCw+HcOkKOnw3b67BakVQX2Y8rsF+W9G/koNOb8lm+LZDVCs
         4DuHDEmnqcgWzaBSLdBp71XqQYAz5gaoHW4FScxo0WGmEuuYe3JN5q46hOaFsNXo+8
         lUJptBWkv9nm+G1HdtwpjCkU0u978YlYBDPntA0M=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH V2 4/6] perf/probe: Fix to list probe event with correct line number
Date:   Sat, 26 Oct 2019 18:00:55 +0900
Message-Id: <157208045549.16551.8525171850902896682.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157208041894.16551.2733647209130045685.stgit@devnote2>
References: <157208041894.16551.2733647209130045685.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since debuginfo__find_probe_point() uses dwarf_entrypc() for
finding the entry address of the function on which a probe is,
it will fail when the function DIE has only ranges attribute.

To fix this issue, use die_entrypc() instead of dwarf_entrypc().

Without this fix, perf probe -l shows incorrect offset.

  # perf probe --force -a clear_tasks_mm_cpumask:0 clear_tasks_mm_cpumask:21
  Added new events:
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask)
    probe:clear_tasks_mm_cpumask_1 (on clear_tasks_mm_cpumask:21)

  You can now use it in all perf tools, such as:

	perf record -e probe:clear_tasks_mm_cpumask_1 -aR sleep 1

  # perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask+18446744071579478000@linux-5.0.0/kernel/cpu.c)
    probe:clear_tasks_mm_cpumask_1 (on clear_tasks_mm_cpumask+18446744071579478067@linux-5.0.0/kernel/cpu.c)

With this,
  # perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask@linux-5.0.0/kernel/cpu.c)
    probe:clear_tasks_mm_cpumask_1 (on clear_tasks_mm_cpumask:21@linux-5.0.0/kernel/cpu.c)

Fixes: 1d46ea2a6a40 ("perf probe: Fix listing incorrect line number with inline function")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-finder.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 2fa932bcf960..88e17a4f5ac3 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1566,7 +1566,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, unsigned long addr,
 		/* Get function entry information */
 		func = basefunc = dwarf_diename(&spdie);
 		if (!func ||
-		    dwarf_entrypc(&spdie, &baseaddr) != 0 ||
+		    die_entrypc(&spdie, &baseaddr) != 0 ||
 		    dwarf_decl_line(&spdie, &baseline) != 0) {
 			lineno = 0;
 			goto post;
@@ -1583,7 +1583,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, unsigned long addr,
 		while (die_find_top_inlinefunc(&spdie, (Dwarf_Addr)addr,
 						&indie)) {
 			/* There is an inline function */
-			if (dwarf_entrypc(&indie, &_addr) == 0 &&
+			if (die_entrypc(&indie, &_addr) == 0 &&
 			    _addr == addr) {
 				/*
 				 * addr is at an inline function entry.

