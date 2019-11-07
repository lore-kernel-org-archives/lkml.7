Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB18C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2439B2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153404;
	bh=7KI1VZDJfay6DUglYPSy+O3w4iEFOv5wwyfb8yRV5TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O1gSlp7Frx/otrR8Ywm6qnxTU3Gmv1DIiSVqHn8Gb388SnjLlLJDdsL+YGtr/RXYD
	 Ogxhfad87Nj3d25twjTVvW15e6sBjs0AzTaI5xpetC+fOQAHg0jCMOsRnmGAeX/uLL
	 sVH+D0LOIbOVWmIv6Xrjy2RpAjl5GEl4b6qh862A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfKGTDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:03:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfKGTDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:03:22 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C648621D6C;
        Thu,  7 Nov 2019 19:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153401;
        bh=7KI1VZDJfay6DUglYPSy+O3w4iEFOv5wwyfb8yRV5TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJGoLht7WPCNhH3OV+W7/NGLVT9ictw6H+ph99wvWAAuFyVOf4ePt7dfermlP/Lxk
         EZSCnJ/DrYTUGwKmKXzyg3A6nbDQ6q3GsQB7aDiJiUFYS+89zXO/LN8Yl5j+Mwr9MN
         bLJhiLv2OUJsNu48fqUnLYzjjl19Dbs+KJrvAfcE=
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
Subject: [PATCH 20/63] perf probe: Fix to probe a function which has no entry pc
Date:   Thu,  7 Nov 2019 15:59:28 -0300
Message-Id: <20191107190011.23924-21-acme@kernel.org>
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

Fix 'perf probe' to probe a function which has no entry pc or low pc but
only has ranges attribute.

probe_point_search_cb() uses dwarf_entrypc() to get the probe address,
but that doesn't work for the function DIE which has only ranges
attribute. Use die_entrypc() instead.

Without this fix:

  # perf probe -k ../build-x86_64/vmlinux -D clear_tasks_mm_cpumask:0
  Probe point 'clear_tasks_mm_cpumask' not found.
    Error: Failed to add events.

With this:

  # perf probe -k ../build-x86_64/vmlinux -D clear_tasks_mm_cpumask:0
  p:probe/clear_tasks_mm_cpumask clear_tasks_mm_cpumask+0

Committer testing:

Before:

  [root@quaco ~]# perf probe clear_tasks_mm_cpumask:0
  Probe point 'clear_tasks_mm_cpumask' not found.
    Error: Failed to add events.
  [root@quaco ~]#

After:

  [root@quaco ~]# perf probe clear_tasks_mm_cpumask:0
  Added new event:
    probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask)

  You can now use it in all perf tools, such as:

  	perf record -e probe:clear_tasks_mm_cpumask -aR sleep 1

  [root@quaco ~]#

Using it with 'perf trace':

  [root@quaco ~]# perf trace -e probe:clear_tasks_mm_cpumask

Doesn't seem to be used in x86_64:

  $ find . -name "*.c" | xargs grep clear_tasks_mm_cpumask
  ./kernel/cpu.c: * clear_tasks_mm_cpumask - Safely clear tasks' mm_cpumask for a CPU
  ./kernel/cpu.c:void clear_tasks_mm_cpumask(int cpu)
  ./arch/xtensa/kernel/smp.c:	clear_tasks_mm_cpumask(cpu);
  ./arch/csky/kernel/smp.c:	clear_tasks_mm_cpumask(cpu);
  ./arch/sh/kernel/smp.c:	clear_tasks_mm_cpumask(cpu);
  ./arch/arm/kernel/smp.c:	clear_tasks_mm_cpumask(cpu);
  ./arch/powerpc/mm/nohash/mmu_context.c:	clear_tasks_mm_cpumask(cpu);
  $ find . -name "*.h" | xargs grep clear_tasks_mm_cpumask
  ./include/linux/cpu.h:void clear_tasks_mm_cpumask(int cpu);
  $ find . -name "*.S" | xargs grep clear_tasks_mm_cpumask
  $

Fixes: e1ecbbc3fa83 ("perf probe: Fix to handle optimized not-inlined functions")
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157199319438.8075.4695576954550638618.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 2b6513e5725c..71633f55f045 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -982,7 +982,7 @@ static int probe_point_search_cb(Dwarf_Die *sp_die, void *data)
 		param->retval = find_probe_point_by_line(pf);
 	} else if (die_is_func_instance(sp_die)) {
 		/* Instances always have the entry address */
-		dwarf_entrypc(sp_die, &pf->addr);
+		die_entrypc(sp_die, &pf->addr);
 		/* But in some case the entry address is 0 */
 		if (pf->addr == 0) {
 			pr_debug("%s has no entry PC. Skipped\n",
-- 
2.21.0

