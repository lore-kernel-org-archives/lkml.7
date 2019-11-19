Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB99C43141
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C6722316
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574163220;
	bh=ebt4oAmvud3x4YqFAHba1lQhIjVOa0Q42SixfNZD5/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1YvCr3GD8FG1Lh8E8xd65njvhXGDJzL+OAcTDUZX+3ZVAy0ARVPzGHfiu/QNMmpx1
	 u3Kc+d3UNOzK3uA7g+diuqe2Saf2f/OaoxVbHzCwgPN3S9YZ+DGABTqGoi1mxDslPl
	 45Uf78JEbT0jr/kbek1yZ+SfvbmpWx87rhGxm6Eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfKSLdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727504AbfKSLdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:33:37 -0500
Received: from quaco.ghostprotocols.net (179.176.11.138.dynamic.adsl.gvt.net.br [179.176.11.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DFE822310;
        Tue, 19 Nov 2019 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574163216;
        bh=ebt4oAmvud3x4YqFAHba1lQhIjVOa0Q42SixfNZD5/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tGcTIqNzdpyza5wzb/duC8d+mIFH6Al6FZmmJBbUnM6+rml18450hHbmyngprUfV9
         y+eRnJCqV2UHzN56wHZk1/PiXI9Ux0mcvr8WVid59heuFpsUi4I4cILJbg1j5V2sVy
         yJLnfm1mWno3CePhzlWTzDZuIiMnv8pD1BrPh9i0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 10/25] perf machine: No need to check if kernel module maps pre-exist
Date:   Tue, 19 Nov 2019 08:32:30 -0300
Message-Id: <20191119113245.19593-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We'only populating maps for kernel modules either from perf.data file
PERF_RECORD_MMAP records or when parsing /proc/modules, so there is no
need to first look if we already have those module maps in the list,
that would mean the kernel has duplicate entries.

So ditch one use of looking up maps by name.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-gnzjg2hhuz6jnrw91m35059y@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 16 ++++++----------
 tools/perf/util/machine.h |  2 --
 tools/perf/util/symbol.c  |  2 +-
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 6804c8247782..7d2e211e376c 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -772,20 +772,16 @@ int machine__process_ksymbol(struct machine *machine __maybe_unused,
 	return machine__process_ksymbol_register(machine, event, sample);
 }
 
-struct map *machine__findnew_module_map(struct machine *machine, u64 start,
-					const char *filename)
+static struct map *machine__addnew_module_map(struct machine *machine, u64 start,
+					      const char *filename)
 {
 	struct map *map = NULL;
-	struct dso *dso = NULL;
 	struct kmod_path m;
+	struct dso *dso;
 
 	if (kmod_path__parse_name(&m, filename))
 		return NULL;
 
-	map = map_groups__find_by_name(&machine->kmaps, m.name);
-	if (map)
-		goto out;
-
 	dso = machine__findnew_module_dso(machine, &m, filename);
 	if (dso == NULL)
 		goto out;
@@ -1384,7 +1380,7 @@ static int machine__create_module(void *arg, const char *name, u64 start,
 	if (arch__fix_module_text_start(&start, &size, name) < 0)
 		return -1;
 
-	map = machine__findnew_module_map(machine, start, name);
+	map = machine__addnew_module_map(machine, start, name);
 	if (map == NULL)
 		return -1;
 	map->end = start + size;
@@ -1559,8 +1555,8 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 				strlen(machine->mmap_name) - 1) == 0;
 	if (event->mmap.filename[0] == '/' ||
 	    (!is_kernel_mmap && event->mmap.filename[0] == '[')) {
-		map = machine__findnew_module_map(machine, event->mmap.start,
-						  event->mmap.filename);
+		map = machine__addnew_module_map(machine, event->mmap.start,
+						 event->mmap.filename);
 		if (map == NULL)
 			goto out_problem;
 
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 18e13c0ccd6a..1016978f575a 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -221,8 +221,6 @@ struct symbol *machine__find_kernel_symbol_by_name(struct machine *machine,
 	return map_groups__find_symbol_by_name(&machine->kmaps, name, mapp);
 }
 
-struct map *machine__findnew_module_map(struct machine *machine, u64 start,
-					const char *filename);
 int arch__fix_module_text_start(u64 *start, u64 *size, const char *name);
 
 int machine__load_kallsyms(struct machine *machine, const char *filename);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b146d87176e7..b5ae82a11d4b 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1530,7 +1530,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
 		/*
 		 * kernel modules know their symtab type - it's set when
-		 * creating a module dso in machine__findnew_module_map().
+		 * creating a module dso in machine__addnew_module_map().
 		 */
 		return kmod && dso->symtab_type == type;
 
-- 
2.21.0

