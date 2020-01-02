Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FD9C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03A420866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004144;
	bh=NtelcdEIdK+ar6S/bYmnjVZ2NGQS+MVd1fmP4SE3GDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l+/Pl31AElHUKBWL4hzEtXL621nVz54n2zbX1rjq5Nwe1btmGAuYPkSmVFpwDjAMj
	 1pY+eJ48ItnFoH19HrJUybsQbOQDNQqJch6WjwDUEvyqqMt4JoumMcEkgKMPSAE/0u
	 RKasea90eFKtc9yuipvLAWS6af2CMAm26Xjv8xLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgABW3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:29:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729977AbgABW27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:28:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D33052253D;
        Thu,  2 Jan 2020 22:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004138;
        bh=NtelcdEIdK+ar6S/bYmnjVZ2NGQS+MVd1fmP4SE3GDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPEaASerXbIzbqeXVxxorxIsylfGRxjXLQxbUC8WkFXf/NLaDM4SI0DoUm1lHuxxY
         ePDIKGxBkADR/RdSbFjAWixr9bqWllvov6a3ZkHLdr4N7Q7/6hUtsCoCL8mas9qTg4
         zzTkeMFvODHdbrGXZHWi04c4PSBO9x/SBpvPt8zY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 054/171] perf probe: Fix to show ranges of variables in functions without entry_pc
Date:   Thu,  2 Jan 2020 23:06:25 +0100
Message-Id: <20200102220554.462281303@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 7e7e57208323..574ba3ac4fba 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1007,7 +1007,7 @@ static int die_get_var_innermost_scope(Dwarf_Die *sp_die, Dwarf_Die *vr_die,
 	bool first = true;
 	const char *name;
 
-	ret = dwarf_entrypc(sp_die, &entry);
+	ret = die_entrypc(sp_die, &entry);
 	if (ret)
 		return ret;
 
@@ -1070,7 +1070,7 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf)
 	bool first = true;
 	const char *name;
 
-	ret = dwarf_entrypc(sp_die, &entry);
+	ret = die_entrypc(sp_die, &entry);
 	if (ret)
 		return ret;
 
-- 
2.20.1



