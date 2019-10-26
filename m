Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688F7CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397A8206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572080470;
	bh=CltL0q5wIP+7btlpwWvZG4nt5GaTdAzDee2YcvmEGTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mdg/BtpaEcelZ7NSSoKhGgqPqjNAM42JQXM0g/ksKTl7cBzmun5EmTlXr2MwiXf/q
	 NmyZYCr2o0D1TIX45hm+2b3S1/Is64yksy4JmxRqF+hxIbpT4y5dkxEUcXgWd1K2mB
	 2OAjZXAfd8WAxfivTiB/utjm3O60kXNctDioWR9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfJZJBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 05:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJZJBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 05:01:08 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD6B6206DD;
        Sat, 26 Oct 2019 09:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572080468;
        bh=CltL0q5wIP+7btlpwWvZG4nt5GaTdAzDee2YcvmEGTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g9B+3MvUADvzCgGJc8znINttn/Q9zTImLyToRMTbKl69Krt90G+njb2fpFzZihvpO
         ABf3UbGR5d1tY8CTndl3J2T3vg4lKqClCF1swZ2rpflXs3B/QhYNr33rN0VjOynVLP
         YyZoEdeNiqULC2L42dryKdaw9Ik1C1XOaPs4hqEE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH V2 5/6] perf/probe: Fix to show inlined function callsite without entry_pc
Date:   Sat, 26 Oct 2019 18:01:04 +0900
Message-Id: <157208046449.16551.10150500484956159170.stgit@devnote2>
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

Fix perf-probe --line option to show inlined function callsite
lines even if the function DIE has only ranges.

Without this,
  # perf probe -L amd_put_event_constraints
  <amd_put_event_constraints@/build/linux-pvZVvI/linux-5.0.0/arch/x86/events/amd/core.c:0>
      0  static void amd_put_event_constraints(struct cpu_hw_events *cpuc,
                                              struct perf_event *event)
      2  {
      3         if (amd_has_nb(cpuc) && amd_is_nb_event(&event->hw))
                        __amd_put_nb_event_constraints(cpuc, event);
      5  }


With this patch,
  # perf probe -L amd_put_event_constraints
  <amd_put_event_constraints@/build/linux-pvZVvI/linux-5.0.0/arch/x86/events/amd/core.c:0>
      0  static void amd_put_event_constraints(struct cpu_hw_events *cpuc,
                                              struct perf_event *event)
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

