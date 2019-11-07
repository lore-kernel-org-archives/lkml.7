Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BE7C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1F92085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153397;
	bh=Cv7fP7lB++HEyfuo3xQse54iZKM9re7sKCqZgklI+4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u3ESLrEmt/i4rggSn1yZStUFnjNPvOtrKp/F9ZC9PRhJRI36QNl2QGRIpAgNe+hkS
	 BInLXp544UkNNaZWTlRm75y4oHSnjoTfj8/XeaYY9gb5PO3XYR2MvF1L5oZjDdY3rz
	 15+5ndql7yXNZ15hflnZRLACuXgVrLVYXa19vy0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfKGTDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:03:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfKGTDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:03:15 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D00EC21882;
        Thu,  7 Nov 2019 19:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153394;
        bh=Cv7fP7lB++HEyfuo3xQse54iZKM9re7sKCqZgklI+4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SyObW8LNDJ5hrCVv687rIyrzcbj2B8BZdT/i3VMZUNhgUWA8h8Ue9QmdEACfOxelW
         +olhQwFTpOWE3ogfgDUJTZTMC18VL2f6OrZ7giXHpIvkxFQX+TeURLE4HyHACMT19J
         Yu2hi/CF7rmmBMRaZAs8uvfEv+OifHSVcIUK4SRI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 19/63] perf probe: Fix wrong address verification
Date:   Thu,  7 Nov 2019 15:59:27 -0300
Message-Id: <20191107190011.23924-20-acme@kernel.org>
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

Since there are some DIE which has only ranges instead of the
combination of entrypc/highpc, address verification must use
dwarf_haspc() instead of dwarf_entrypc/dwarf_highpc.

Also, the ranges only DIE will have a partial code in different section
(e.g. unlikely code will be in text.unlikely as "FUNC.cold" symbol). In
that case, we can not use dwarf_entrypc() or die_entrypc(), because the
offset from original DIE can be a minus value.

Instead, this simply gets the symbol and offset from symtab.

Without this patch;

  # perf probe -D clear_tasks_mm_cpumask:1
  Failed to get entry address of clear_tasks_mm_cpumask
    Error: Failed to add events.

And with this patch:

  # perf probe -D clear_tasks_mm_cpumask:1
  p:probe/clear_tasks_mm_cpumask clear_tasks_mm_cpumask+0
  p:probe/clear_tasks_mm_cpumask_1 clear_tasks_mm_cpumask+5
  p:probe/clear_tasks_mm_cpumask_2 clear_tasks_mm_cpumask+8
  p:probe/clear_tasks_mm_cpumask_3 clear_tasks_mm_cpumask+16
  p:probe/clear_tasks_mm_cpumask_4 clear_tasks_mm_cpumask+82

Committer testing:

I managed to reproduce the above:

  [root@quaco ~]# perf probe -D clear_tasks_mm_cpumask:1
  p:probe/clear_tasks_mm_cpumask _text+919968
  p:probe/clear_tasks_mm_cpumask_1 _text+919973
  p:probe/clear_tasks_mm_cpumask_2 _text+919976
  [root@quaco ~]#

But then when trying to actually put the probe in place, it fails if I
use :0 as the offset:

  [root@quaco ~]# perf probe -L clear_tasks_mm_cpumask | head -5
  <clear_tasks_mm_cpumask@/usr/src/debug/kernel-5.2.fc30/linux-5.2.18-200.fc30.x86_64/kernel/cpu.c:0>
        0  void clear_tasks_mm_cpumask(int cpu)
        1  {
        2  	struct task_struct *p;

  [root@quaco ~]# perf probe clear_tasks_mm_cpumask:0
  Probe point 'clear_tasks_mm_cpumask' not found.
    Error: Failed to add events.
  [root@quaco

The next patch is needed to fix this case.

Fixes: 576b523721b7 ("perf probe: Fix probing symbols with optimization suffix")
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157199318513.8075.10463906803299647907.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index cd9f95e5044e..2b6513e5725c 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -604,38 +604,26 @@ static int convert_to_trace_point(Dwarf_Die *sp_die, Dwfl_Module *mod,
 				  const char *function,
 				  struct probe_trace_point *tp)
 {
-	Dwarf_Addr eaddr, highaddr;
+	Dwarf_Addr eaddr;
 	GElf_Sym sym;
 	const char *symbol;
 
 	/* Verify the address is correct */
-	if (dwarf_entrypc(sp_die, &eaddr) != 0) {
-		pr_warning("Failed to get entry address of %s\n",
-			   dwarf_diename(sp_die));
-		return -ENOENT;
-	}
-	if (dwarf_highpc(sp_die, &highaddr) != 0) {
-		pr_warning("Failed to get end address of %s\n",
-			   dwarf_diename(sp_die));
-		return -ENOENT;
-	}
-	if (paddr > highaddr) {
-		pr_warning("Offset specified is greater than size of %s\n",
+	if (!dwarf_haspc(sp_die, paddr)) {
+		pr_warning("Specified offset is out of %s\n",
 			   dwarf_diename(sp_die));
 		return -EINVAL;
 	}
 
-	symbol = dwarf_diename(sp_die);
+	/* Try to get actual symbol name from symtab */
+	symbol = dwfl_module_addrsym(mod, paddr, &sym, NULL);
 	if (!symbol) {
-		/* Try to get the symbol name from symtab */
-		symbol = dwfl_module_addrsym(mod, paddr, &sym, NULL);
-		if (!symbol) {
-			pr_warning("Failed to find symbol at 0x%lx\n",
-				   (unsigned long)paddr);
-			return -ENOENT;
-		}
-		eaddr = sym.st_value;
+		pr_warning("Failed to find symbol at 0x%lx\n",
+			   (unsigned long)paddr);
+		return -ENOENT;
 	}
+	eaddr = sym.st_value;
+
 	tp->offset = (unsigned long)(paddr - eaddr);
 	tp->address = (unsigned long)paddr;
 	tp->symbol = strdup(symbol);
-- 
2.21.0

