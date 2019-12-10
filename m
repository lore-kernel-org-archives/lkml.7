Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED750C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38F02077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576017429;
	bh=oABqJgDIY6ykJjr7dw4PaCk0zOANQg1HDKNFdbpasyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DKLaU42wIf5ginpvtrigUL0NiIATddqGMMUsuBNdFncx4MKixJh5dlBgZcFrQtM8R
	 vPfVEinDPwdn0vhkjZEeQ0E+Z34v4fMuAbj1yVdZn/swnYzrnUsdgrfngk88Ile96o
	 AW9f9HRwZx4c69+dYpQE8kP4Cg/430kp9ujUmF6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfLJWhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:37:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728739AbfLJWeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:34:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B41A22077B;
        Tue, 10 Dec 2019 22:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017248;
        bh=oABqJgDIY6ykJjr7dw4PaCk0zOANQg1HDKNFdbpasyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aEMjBtmh/NJ2Qd6ftK4NDQ3+iAOUD0R0Z05Tt0tks2tiBx7pfkqm+tBhHBLNcU4fv
         Caumkta/E4akJi7fSJq5k1cdxrvNoruay9VfDX0EIfuvOX5GnBV+aCDWKEj0T00Kcy
         to5dhqPokcqHgrS3DVBtnZQpiND19KsjcvF9KDsQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 44/71] perf probe: Fix to show ranges of variables in functions without entry_pc
Date:   Tue, 10 Dec 2019 17:32:49 -0500
Message-Id: <20191210223316.14988-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210223316.14988-1-sashal@kernel.org>
References: <20191210223316.14988-1-sashal@kernel.org>
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
index ef6fa620a4264..ed7777ed4d384 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -989,7 +989,7 @@ static int die_get_var_innermost_scope(Dwarf_Die *sp_die, Dwarf_Die *vr_die,
 	bool first = true;
 	const char *name;
 
-	ret = dwarf_entrypc(sp_die, &entry);
+	ret = die_entrypc(sp_die, &entry);
 	if (ret)
 		return ret;
 
@@ -1050,7 +1050,7 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf)
 	bool first = true;
 	const char *name;
 
-	ret = dwarf_entrypc(sp_die, &entry);
+	ret = die_entrypc(sp_die, &entry);
 	if (ret)
 		return ret;
 
-- 
2.20.1

