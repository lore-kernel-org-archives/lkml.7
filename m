Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4B3CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A24206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572080435;
	bh=BN1vCo1lxvJNELEHME/UQOuAmjZyIXA8X3dFkT3QX7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bxW9Ajivr3P8yL4Nda4VvJIZLSqdouGHtEHfM/MaZM6KxJ6ViZfTnLiHOGOXuxRcv
	 D+htAusFN+WdNgan0CCuR6QNy3SzMTW3JoDCXJV20eHcJnX85uFR55AZAzLvGgxefX
	 6TEgk5e6MgH/Xoe6nZSxq7enkPqVJKKmJBxDm+1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfJZJAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 05:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJZJAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 05:00:33 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9A7F206DD;
        Sat, 26 Oct 2019 09:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572080432;
        bh=BN1vCo1lxvJNELEHME/UQOuAmjZyIXA8X3dFkT3QX7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICwQlkEI3uUuJllfqtEGyVqSECPgTGLc8Z56sFUxm/+xrpsIiklKWLeIbMHlB0DSu
         qyb9ubBgdIteapIOKA7Aaala9co2UwbDb0iTXWpQDgn+BGPOzdLrk0BCeYT0CJOUky
         LeJ5hCirnNBIGYV40eFkPldcLeIPrHEaf7tpckVk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH V2 1/6] perf/probe: Fix wrong address verification
Date:   Sat, 26 Oct 2019 18:00:28 +0900
Message-Id: <157208042815.16551.12801888522537614542.stgit@devnote2>
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

Since there are some DIE which has only ranges instead of the
combination of entrypc/highpc, address verification must use
dwarf_haspc() instead of dwarf_entrypc/dwarf_highpc.

Also, the ranges only DIE will have a partial code in different
section (e.g. unlikely code will be in text.unlikely as "FUNC.cold"
symbol). In that case, we can not use dwarf_entrypc() or
die_entrypc(), because the offset from original DIE can be
a minus value.

Instead, this simply gets the symbol and offset from symtab.

Without this patch;
  # tools/perf/perf probe -D clear_tasks_mm_cpumask:1
  Failed to get entry address of clear_tasks_mm_cpumask
    Error: Failed to add events.

And with this patch
  # perf probe -D clear_tasks_mm_cpumask:1
  p:probe/clear_tasks_mm_cpumask _text+632816
  p:probe/clear_tasks_mm_cpumask_1 _text+632821
  p:probe/clear_tasks_mm_cpumask_2 _text+632830

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Fixes: 576b523721b7 ("perf probe: Fix probing symbols with optimization suffix")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-finder.c |   32 ++++++++++----------------------
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

