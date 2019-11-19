Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220EEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047082230F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfKSQ7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:59:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52871 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfKSQ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6oE-0007U6-5Z; Tue, 19 Nov 2019 17:56:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E75AD1C19CE;
        Tue, 19 Nov 2019 17:56:49 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:49 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf machine: No need to check if kernel module maps
 pre-exist
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-gnzjg2hhuz6jnrw91m35059y@git.kernel.org>
References: <tip-gnzjg2hhuz6jnrw91m35059y@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157418260988.12247.10814494424697377296.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a94ab91a54c63b9101715b03171219279cc0ee26
Gitweb:        https://git.kernel.org/tip/a94ab91a54c63b9101715b03171219279cc0ee26
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 14 Nov 2019 12:28:41 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 18 Nov 2019 13:01:50 -03:00

perf machine: No need to check if kernel module maps pre-exist

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
index 6804c82..7d2e211 100644
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
index 18e13c0..1016978 100644
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
index b146d87..b5ae82a 100644
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
 
