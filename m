Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7CFC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7678421874
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559065881;
	bh=1B5SosRbW4nL6NoV9Zk44LVknZdPLnPR6nIIa8e2CkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ybuQhtRn2dPga7G74obBsLUuZKJ5opUEwUIWO80AQOyoyqArY9w5PQ47G+jcEr12p
	 wkYe23e7fnqQ5L7NiZq/xMVMOv4cK4Or4QXs04DrkgSfdAqKkIkMfwZCr9pwhx7s3n
	 IuDBs3D79ouQ2weZYSDnfzB9ntCLReesqjXiVZjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfE1RvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbfE1RvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:51:18 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58CBA21897;
        Tue, 28 May 2019 17:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559065876;
        bh=1B5SosRbW4nL6NoV9Zk44LVknZdPLnPR6nIIa8e2CkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t8PDZKNke1EelopsCxvBd0wnawsymmz1/veB+XTrD4/gr1pFaaWCTz33dffQfI7t7
         q+k66YBz+liDGiIzB6HXoppyMTy2K2EwRR95gRU/7nt8+sNCs8Ig/L0v/UcrEpgKjz
         49uRkVFDnqxpAKdK5SlM/ApdrNSrTrWwfkPq77+o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stanislav Fomichev <sdf@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/14] perf machine: Read also the end of the kernel
Date:   Tue, 28 May 2019 14:50:18 -0300
Message-Id: <20190528175020.13343-13-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528175020.13343-1-acme@kernel.org>
References: <20190528175020.13343-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We mark the end of kernel based on the first module, but that could
cover some bpf program maps. Reading _etext symbol if it's present to
get precise kernel map end.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 28a9541c4835..dc7aafe45a2b 100644
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
 
@@ -1441,7 +1447,7 @@ int machine__create_kernel_maps(struct machine *machine)
 	struct dso *kernel = machine__get_kernel(machine);
 	const char *name = NULL;
 	struct map *map;
-	u64 addr = 0;
+	u64 start = 0, end = ~0ULL;
 	int ret;
 
 	if (kernel == NULL)
@@ -1460,9 +1466,9 @@ int machine__create_kernel_maps(struct machine *machine)
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
@@ -1472,16 +1478,19 @@ int machine__create_kernel_maps(struct machine *machine)
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
2.20.1

