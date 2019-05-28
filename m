Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6101C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0642075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tnck3Tex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfE1VaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:30:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56785 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfE1VaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:30:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4SLTgsE2240754
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 28 May 2019 14:29:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4SLTgsE2240754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559078983;
        bh=zNtj7Mc4odQZV1gNb3k8TscpppokV5E18Uq/s9FRLwk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tnck3TexNg8bL1B6Kce8eulx9ajAxEhdzBOBhcqPbtXytQFwDi7uLdNjeT37Usgrg
         g5xLhtUmpWsEgcH/oTo9XmvAI2u9p8b4ef0mgUco5T3JjNBNoVl9VQ/50rfLnwW0xJ
         MvR8qSxv5mGRY2ei1gFoCSS5Nnnzp2zVhGnFvMtMYNWdQ7h9LftnN1DZVeV+QPhb59
         ojMsSlkfZNT6rtb2N9TAVYiVCnUW8sC1Olz4uwAz2fVXM8ciqSZiv8j38rK6aQYPEI
         V3Qh95MQ7C0xbEU3BSxf5nOAey6ZIib167zgFs2i7DKv4Oz2sXGXMMZiXPgDBrDAJf
         cin5lmoS1Bz6A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4SLTgv32240751;
        Tue, 28 May 2019 14:29:42 -0700
Date:   Tue, 28 May 2019 14:29:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ed9adb2035b5be5896d465b19040262be5f4a824@git.kernel.org>
Cc:     peterz@infradead.org, songliubraving@fb.com, sdf@google.com,
        ak@linux.intel.com, jolsa@kernel.org, tmricht@linux.ibm.com,
        mingo@kernel.org, acme@redhat.com, tglx@linutronix.de,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          acme@redhat.com, alexander.shishkin@linux.intel.com,
          adrian.hunter@intel.com, namhyung@kernel.org,
          tmricht@linux.ibm.com, jolsa@kernel.org, mingo@kernel.org,
          songliubraving@fb.com, peterz@infradead.org, ak@linux.intel.com,
          sdf@google.com
In-Reply-To: <20190508132010.14512-6-jolsa@kernel.org>
References: <20190508132010.14512-6-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf machine: Read also the end of the kernel
Git-Commit-ID: ed9adb2035b5be5896d465b19040262be5f4a824
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ed9adb2035b5be5896d465b19040262be5f4a824
Gitweb:     https://git.kernel.org/tip/ed9adb2035b5be5896d465b19040262be5f4a824
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 8 May 2019 15:20:03 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 09:52:23 -0300

perf machine: Read also the end of the kernel

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
