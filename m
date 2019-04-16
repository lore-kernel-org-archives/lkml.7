Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71517C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FADA206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555430514;
	bh=kftF+6MiNRMbpHirl40vS9fNiSmbLVl073f/ZLdYsbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pvZyVQWkvx4auJCOfcJGmQqXq3S8AvVs7bBerBfnlwmkOjTaenHHQpsIg25E7xd0+
	 2+6uJ8OR6W4Ufcy+5ei2OZktExrLQALxtSYGQ8drNkLNPmf6GqMDNo0T6QDr0txcua
	 4dNeBJqFagCwZ9KeCuAjS8ozVKGijVWf/ykcOK1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfDPQBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:01:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbfDPQBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:01:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBB14C05242C;
        Tue, 16 Apr 2019 16:01:49 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A495C5D71A;
        Tue, 16 Apr 2019 16:01:47 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 05/12] perf tools: Read also the end of the kernel
Date:   Tue, 16 Apr 2019 18:01:20 +0200
Message-Id: <20190416160127.30203-6-jolsa@kernel.org>
In-Reply-To: <20190416160127.30203-1-jolsa@kernel.org>
References: <20190416160127.30203-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 16 Apr 2019 16:01:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We mark the end of kernel based on the first module,
but that could cover some bpf program maps. Reading
_etext symbol if it's present to get precise kernel
map end.

Link: http://lkml.kernel.org/n/tip-ynut991ttyyhvo1sbhlm4c42@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3c520baa198c..ad0205fbb506 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -924,7 +924,8 @@ const char *ref_reloc_sym_names[] = {"_text", "_stext", NULL};
  * symbol_name if it's not that important.
  */
 static int machine__get_running_kernel_start(struct machine *machine,
-					     const char **symbol_name, u64 *start)
+					     const char **symbol_name,
+					     u64 *start, u64 *end)
 {
 	char filename[PATH_MAX];
 	int i, err = -1;
@@ -949,6 +950,11 @@ static int machine__get_running_kernel_start(struct machine *machine,
 		*symbol_name = name;
 
 	*start = addr;
+
+	err = kallsyms__get_function_start(filename, "_etext", &addr);
+	if (!err)
+		*end = addr;
+
 	return 0;
 }
 
@@ -1440,7 +1446,7 @@ int machine__create_kernel_maps(struct machine *machine)
 	struct dso *kernel = machine__get_kernel(machine);
 	const char *name = NULL;
 	struct map *map;
-	u64 addr = 0;
+	u64 start = 0, end = ~0ULL;
 	int ret;
 
 	if (kernel == NULL)
@@ -1459,9 +1465,9 @@ int machine__create_kernel_maps(struct machine *machine)
 				 "continuing anyway...\n", machine->pid);
 	}
 
-	if (!machine__get_running_kernel_start(machine, &name, &addr)) {
+	if (!machine__get_running_kernel_start(machine, &name, &start, &end)) {
 		if (name &&
-		    map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map, name, addr)) {
+		    map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map, name, start)) {
 			machine__destroy_kernel_maps(machine);
 			ret = -1;
 			goto out_put;
@@ -1471,16 +1477,19 @@ int machine__create_kernel_maps(struct machine *machine)
 		 * we have a real start address now, so re-order the kmaps
 		 * assume it's the last in the kmaps
 		 */
-		machine__update_kernel_mmap(machine, addr, ~0ULL);
+		machine__update_kernel_mmap(machine, start, end);
 	}
 
 	if (machine__create_extra_kernel_maps(machine, kernel))
 		pr_debug("Problems creating extra kernel maps, continuing anyway...\n");
 
-	/* update end address of the kernel map using adjacent module address */
-	map = map__next(machine__kernel_map(machine));
-	if (map)
-		machine__set_kernel_mmap(machine, addr, map->start);
+	if (end == ~0ULL) {
+		/* update end address of the kernel map using adjacent module address */
+		map = map__next(machine__kernel_map(machine));
+		if (map)
+			machine__set_kernel_mmap(machine, start, map->start);
+	}
+
 out_put:
 	dso__put(kernel);
 	return ret;
-- 
2.17.2

