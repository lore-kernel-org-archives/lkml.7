Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7172FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4959921D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571993219;
	bh=mOY8k8MUu58dp5lg/2CDtLKLce93A6FHiu1bWkMvodA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZpbcDIrJD43YXPrBBkXvboWkG3bclkYx4zGVwbLHdiKgfTCH6j3qwlj61FRmBAdem
	 IqjhxzAyifs19Ek3gHnu/bUyIfZZRDd/SkoOTKvvSRggaNPbqx8DcmIaDQsVu6c6js
	 7M0C4cZxQ6ilscREuFNr4FPKTWvqvrX458b5ncAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408559AbfJYIq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408545AbfJYIq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:46:56 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95C1E21D7B;
        Fri, 25 Oct 2019 08:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571993215;
        bh=mOY8k8MUu58dp5lg/2CDtLKLce93A6FHiu1bWkMvodA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HiyoNmAFdZBmXG6RseleNHpklvFdTeeFnA+ki6jfAhelNsx2Hqq1Hx+0ueSiZTQoS
         GyjjunFyvm5KTcZQE+BA+sWBmM2/DuH8MvnzVEfykLcjwMEUKTBhjIbjAuuFi+slIp
         nLbO4bH57dIym9ddyzyXwGTPGN2CxPrdR87mILMg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 4/6] perf/probe: Fix to list probe event with correct line number
Date:   Fri, 25 Oct 2019 17:46:52 +0900
Message-Id: <157199321227.8075.14655572419136993015.stgit@devnote2>
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

Since debuginfo__find_probe_point() uses dwarf_entrypc() for
finding the entry address of the function on which a probe is,
it will fail when the function DIE has only ranges attribute.

To fix this issue, use die_entrypc() instead of dwarf_entrypc().

Without this fix, perf probe -l shows incorrect offset.
  # perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask+18446744071579263632@work/linux/linux/kernel/cpu.c)
    probe:clear_tasks_mm_cpumask_1 (on clear_tasks_mm_cpumask+18446744071579263752@work/linux/linux/kernel/cpu.c)

With this,
  # perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask@work/linux/linux/kernel/cpu.c)
    probe:clear_tasks_mm_cpumask_1 (on clear_tasks_mm_cpumask:21@work/linux/linux/kernel/cpu.c)

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

