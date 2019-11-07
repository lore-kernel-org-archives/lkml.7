Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEB6C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCCE2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153424;
	bh=ekc9XmUCfd9XhqG6clnQXWkfd7JDjRpc9OWEsrp/LOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MaNw4fEN4ZbPXuLCJ+MArTRQLx2tCTQof2NfYBbXEGuyk+QQm9/8ptAB43mdm//9S
	 EstJCVKqYOljOLlE9ENSVOUOewkl9+po2KWukDYrykHZ551/P16ZDvs3Qy2pfXxet9
	 lGJVLKIgi7ADDmO4S4raCiHMykkE4Xud/s2LnWbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfKGTDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:03:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:42724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfKGTDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:03:42 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BE4821882;
        Thu,  7 Nov 2019 19:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153421;
        bh=ekc9XmUCfd9XhqG6clnQXWkfd7JDjRpc9OWEsrp/LOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y6M5Co2nkRorU34fpraZ1id00ojbPkVYvBsypJYbAcSK7yQJ7wVx0lxmbWdKAXgU+
         Ug8dZrTmTYsHtH554L6Pp8DpvncxrGpaaoN3k7nJ6p50+zmnpLWOtVkMl0ILKOBR70
         6DFhMFItI7IuSK/3upqP5P7eQ+nf/+4uRuFLtQqc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 23/63] perf probe: Fix to show inlined function callsite without entry_pc
Date:   Thu,  7 Nov 2019 15:59:31 -0300
Message-Id: <20191107190011.23924-24-acme@kernel.org>
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
---
 tools/perf/util/dwarf-aux.c | 2 +-
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
-- 
2.21.0

