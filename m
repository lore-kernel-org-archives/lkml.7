Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51070C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DB0205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012975;
	bh=MPwwxUkTt38aORLOrp+veLi7LPZTy+4k3yRk92wLig4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JN8Vi/CL5i+al+ciSddWe7HYswNpWVpvbOcNq+ifiHwTjq8fJFGKFZET6EdsmHeCJ
	 q5CoLDUMNCJbgDoT6apOHRGPRtp+qW1OJKp7qPCsN3CYMcJa9bC2NixtyDH7pgiGW2
	 TsL3j9ZzZTocg6G6SLZ3+9PqG6tq8XGIJY6FZRjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfLJVWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:22:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbfLJVLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:11:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20500246A2;
        Tue, 10 Dec 2019 21:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012281;
        bh=MPwwxUkTt38aORLOrp+veLi7LPZTy+4k3yRk92wLig4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j2s/lkExo2uXsNTodZ/iXjmDtoxdHVCbO2R5f/VLFgNxcr52oJDjz22IEZkePEBn5
         dI/qwMM9rhkF99ZnjTk7/LSEpUjux+/19gT18iGu2e11JNofrubhBU3sNyyzYBgYuj
         Kg+9ITJoLPMW5QQhmjxX2JjvMhMejYLGA0jL9Iqs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 224/350] perf probe: Fix to show ranges of variables in functions without entry_pc
Date:   Tue, 10 Dec 2019 16:05:29 -0500
Message-Id: <20191210210735.9077-185-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit af04dd2f8ebaa8fbd46f698714acbf43da14da45 ]

Fix to show ranges of variables (--range and --vars option) in functions
which DIE has only ranges but no entry_pc attribute.

Without this fix:

  # perf probe --range -V clear_tasks_mm_cpumask
  Available variables at clear_tasks_mm_cpumask
  	@<clear_tasks_mm_cpumask+0>
  		(No matched variables)

With this fix:

  # perf probe --range -V clear_tasks_mm_cpumask
  Available variables at clear_tasks_mm_cpumask
	@<clear_tasks_mm_cpumask+0>
		[VAL]	int	cpu	@<clear_tasks_mm_cpumask+[0-35,317-317,2052-2059]>

Committer testing:

Before:

  [root@quaco ~]# perf probe --range -V clear_tasks_mm_cpumask
  Available variables at clear_tasks_mm_cpumask
          @<clear_tasks_mm_cpumask+0>
                  (No matched variables)
  [root@quaco ~]#

After:

  [root@quaco ~]# perf probe --range -V clear_tasks_mm_cpumask
  Available variables at clear_tasks_mm_cpumask
          @<clear_tasks_mm_cpumask+0>
                  [VAL]   int     cpu     @<clear_tasks_mm_cpumask+[0-23,23-105,105-106,106-106,1843-1850,1850-1862]>
  [root@quaco ~]#

Using it:

  [root@quaco ~]# perf probe clear_tasks_mm_cpumask cpu
  Added new event:
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask with cpu)

  You can now use it in all perf tools, such as:

  	perf record -e probe:clear_tasks_mm_cpumask -aR sleep 1

  [root@quaco ~]# perf probe -l
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask@kernel/cpu.c with cpu)
  [root@quaco ~]#
  [root@quaco ~]# perf trace -e probe:*cpumask
  ^C[root@quaco ~]#

Fixes: 349e8d261131 ("perf probe: Add --range option to show a variable's location range")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157199323018.8075.8179744380479673672.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 929b7c0567f44..4b1890204e996 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -997,7 +997,7 @@ static int die_get_var_innermost_scope(Dwarf_Die *sp_die, Dwarf_Die *vr_die,
 	bool first = true;
 	const char *name;
 
-	ret = dwarf_entrypc(sp_die, &entry);
+	ret = die_entrypc(sp_die, &entry);
 	if (ret)
 		return ret;
 
@@ -1060,7 +1060,7 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf)
 	bool first = true;
 	const char *name;
 
-	ret = dwarf_entrypc(sp_die, &entry);
+	ret = die_entrypc(sp_die, &entry);
 	if (ret)
 		return ret;
 
-- 
2.20.1

