Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6C3C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F14F206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642737;
	bh=Fms0++2fgYIgEPp4j5dKIin41R46jM+7pq9Avku3TKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v4VEXA7su+IZaFxAx+DgG2Q+/bCFv/JMjxOQowSNA2givppikZTA0cQ/ftETvbzU4
	 oZ6x9S4KoSE0UihiEDwR3zMlC/l2Dzusuo9rQONwep5geGw7pR2jpiyZzSpQd9Ze2e
	 IhQvU1OaHKpITN/9uBFxbb2mGKG79T9lcETKRgPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbfL2SFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 13:05:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732024AbfL2RvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:51:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A1BF206A4;
        Sun, 29 Dec 2019 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641866;
        bh=Fms0++2fgYIgEPp4j5dKIin41R46jM+7pq9Avku3TKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vx+amJTr/Sb1YSM44XyJNDjU1flI3rALaPNy8wiePvr5ijE3SDWk41wV1cXIKjrOq
         NuZ0WlKT7MN/36dnwaAmR9dl8/3xoWxZ5qO2GXM+3xi8bZAjIDXUmgzS1YS0dJSkpc
         ED7OHJ1ma93qVUaInwyr0/KV9DyenF0NrQUvpjbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 245/434] perf probe: Fix to list probe event with correct line number
Date:   Sun, 29 Dec 2019 18:24:58 +0100
Message-Id: <20191229172718.158972713@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 3895534dd78f0fd4d3f9e05ee52b9cdd444a743e ]

Since debuginfo__find_probe_point() uses dwarf_entrypc() for finding the
entry address of the function on which a probe is, it will fail when the
function DIE has only ranges attribute.

To fix this issue, use die_entrypc() instead of dwarf_entrypc().

Without this fix, perf probe -l shows incorrect offset:

  # perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask+18446744071579263632@work/linux/linux/kernel/cpu.c)
    probe:clear_tasks_mm_cpumask_1 (on clear_tasks_mm_cpumask+18446744071579263752@work/linux/linux/kernel/cpu.c)

With this:

  # perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask@work/linux/linux/kernel/cpu.c)
    probe:clear_tasks_mm_cpumask_1 (on clear_tasks_mm_cpumask:21@work/linux/linux/kernel/cpu.c)

Committer testing:

Before:

  [root@quaco ~]# perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask+18446744071579765152@kernel/cpu.c)
  [root@quaco ~]#

After:

  [root@quaco ~]# perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask@kernel/cpu.c)
  [root@quaco ~]#

Fixes: 1d46ea2a6a40 ("perf probe: Fix listing incorrect line number with inline function")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157199321227.8075.14655572419136993015.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/probe-finder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index cd9f95e5044e..7c8d30fb2b99 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1578,7 +1578,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, unsigned long addr,
 		/* Get function entry information */
 		func = basefunc = dwarf_diename(&spdie);
 		if (!func ||
-		    dwarf_entrypc(&spdie, &baseaddr) != 0 ||
+		    die_entrypc(&spdie, &baseaddr) != 0 ||
 		    dwarf_decl_line(&spdie, &baseline) != 0) {
 			lineno = 0;
 			goto post;
@@ -1595,7 +1595,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, unsigned long addr,
 		while (die_find_top_inlinefunc(&spdie, (Dwarf_Addr)addr,
 						&indie)) {
 			/* There is an inline function */
-			if (dwarf_entrypc(&indie, &_addr) == 0 &&
+			if (die_entrypc(&indie, &_addr) == 0 &&
 			    _addr == addr) {
 				/*
 				 * addr is at an inline function entry.
-- 
2.20.1



