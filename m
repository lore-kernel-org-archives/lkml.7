Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B15EC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E345E20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004147;
	bh=TUW1YUbnK5ZSP11+qLepT2hjKbi/LiZ7AI04j4Z73qE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JVXKdtAs6dYEP0aF3Y2Wq/SbFf3wVnxFHKRcPue8Mm2wdYqNeo54Zh7CdFv/9cG/C
	 /oxZ8fE0o+LARX2QiWgvXfCrJKafBYiQtHCVJkR2/z7i5hmDusk9l58EQ8bTzbgL2a
	 QemQctv8EfTXrOCu3VeSg+9XEeG2zzymhGrjtfzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgABW3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:29:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729974AbgABW3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:29:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B22020866;
        Thu,  2 Jan 2020 22:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004140;
        bh=TUW1YUbnK5ZSP11+qLepT2hjKbi/LiZ7AI04j4Z73qE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zfCYZc/8msMk0WymClp9NY0npQFoPrhNbjZARENCEaW2DtBJMktSKshv5eFdTXyNx
         IloDXJH2TqeoH6kmsnVPT0ginZNbFG8PPvr0H7WVpv/HpE/XPM+fHIJUKYj59UQXiz
         O1md5ZXG+TnXamxP26CqoX8aiZHzVPqarsPHKu1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 055/171] perf probe: Fix to show inlined function callsite without entry_pc
Date:   Thu,  2 Jan 2020 23:06:26 +0100
Message-Id: <20200102220554.607955684@linuxfoundation.org>
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

[ Upstream commit 18e21eb671dc87a4f0546ba505a89ea93598a634 ]

Fix 'perf probe --line' option to show inlined function callsite lines
even if the function DIE has only ranges.

Without this:

  # perf probe -L amd_put_event_constraints
  ...
      2  {
      3         if (amd_has_nb(cpuc) && amd_is_nb_event(&event->hw))
                        __amd_put_nb_event_constraints(cpuc, event);
      5  }

With this patch:

  # perf probe -L amd_put_event_constraints
  ...
      2  {
      3         if (amd_has_nb(cpuc) && amd_is_nb_event(&event->hw))
      4                 __amd_put_nb_event_constraints(cpuc, event);
      5  }

Committer testing:

Before:

  [root@quaco ~]# perf probe -L amd_put_event_constraints
  <amd_put_event_constraints@/usr/src/debug/kernel-5.2.fc30/linux-5.2.18-200.fc30.x86_64/arch/x86/events/amd/core.c:0>
        0  static void amd_put_event_constraints(struct cpu_hw_events *cpuc,
                                                struct perf_event *event)
        2  {
        3         if (amd_has_nb(cpuc) && amd_is_nb_event(&event->hw))
                          __amd_put_nb_event_constraints(cpuc, event);
        5  }

           PMU_FORMAT_ATTR(event, "config:0-7,32-35");
           PMU_FORMAT_ATTR(umask, "config:8-15"   );

  [root@quaco ~]#

After:

  [root@quaco ~]# perf probe -L amd_put_event_constraints
  <amd_put_event_constraints@/usr/src/debug/kernel-5.2.fc30/linux-5.2.18-200.fc30.x86_64/arch/x86/events/amd/core.c:0>
        0  static void amd_put_event_constraints(struct cpu_hw_events *cpuc,
                                                struct perf_event *event)
        2  {
        3         if (amd_has_nb(cpuc) && amd_is_nb_event(&event->hw))
        4                 __amd_put_nb_event_constraints(cpuc, event);
        5  }

           PMU_FORMAT_ATTR(event, "config:0-7,32-35");
           PMU_FORMAT_ATTR(umask, "config:8-15"   );

  [root@quaco ~]# perf probe amd_put_event_constraints:4
  Added new event:
    probe:amd_put_event_constraints (on amd_put_event_constraints:4)

  You can now use it in all perf tools, such as:

  	perf record -e probe:amd_put_event_constraints -aR sleep 1

  [root@quaco ~]#

  [root@quaco ~]# perf probe -l
    probe:amd_put_event_constraints (on amd_put_event_constraints:4@arch/x86/events/amd/core.c)
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask@kernel/cpu.c)
  [root@quaco ~]#

Using it:

  [root@quaco ~]# perf trace -e probe:*
  ^C[root@quaco ~]#

Ok, Intel system here... :-)

Fixes: 4cc9cec636e7 ("perf probe: Introduce lines walker interface")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157199322107.8075.12659099000567865708.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 574ba3ac4fba..3aea343c7179 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -683,7 +683,7 @@ static int __die_walk_funclines_cb(Dwarf_Die *in_die, void *data)
 	if (dwarf_tag(in_die) == DW_TAG_inlined_subroutine) {
 		fname = die_get_call_file(in_die);
 		lineno = die_get_call_lineno(in_die);
-		if (fname && lineno > 0 && dwarf_entrypc(in_die, &addr) == 0) {
+		if (fname && lineno > 0 && die_entrypc(in_die, &addr) == 0) {
 			lw->retval = lw->callback(fname, lineno, addr, lw->data);
 			if (lw->retval != 0)
 				return DIE_FIND_CB_END;
-- 
2.20.1



