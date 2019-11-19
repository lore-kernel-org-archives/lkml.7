Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E88AC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636B9223D1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfKSQ56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:57:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52936 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbfKSQ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6o9-0007Ji-AT; Tue, 19 Nov 2019 17:56:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0413F1C19CD;
        Tue, 19 Nov 2019 17:56:48 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:47 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf probe: Trace a magic number if variable is not found
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <157406476931.24476.6261475888681844285.stgit@devnote2>
References: <157406476931.24476.6261475888681844285.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <157418260791.12247.14118221435895111613.tip-bot2@tip-bot2>
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

Commit-ID:     cb4027308570841869ec0c6bdafc9658c10f28a3
Gitweb:        https://git.kernel.org/tip/cb4027308570841869ec0c6bdafc9658c10f28a3
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Mon, 18 Nov 2019 17:12:49 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 18 Nov 2019 19:09:23 -03:00

perf probe: Trace a magic number if variable is not found

Trace a magic number as immediate value if the target variable is not
found at some probe points which is based on one probe event.

This feature is good for the case if you trace a source code line with
some local variables, which is compiled into several instructions and
some of the variables are optimized out on some instructions.

Even if so, with this feature, perf probe trace a magic number instead
of such disappeared variables and fold those probes on one event.

E.g. without this patch:

  # perf probe -D "pud_page_vaddr pud"
  Failed to find 'pud' in this function.
  Failed to find 'pud' in this function.
  Failed to find 'pud' in this function.
  Failed to find 'pud' in this function.
  Failed to find 'pud' in this function.
  Failed to find 'pud' in this function.
  Failed to find 'pud' in this function.
  Failed to find 'pud' in this function.
  Failed to find 'pud' in this function.
  Failed to find 'pud' in this function.
  Failed to find 'pud' in this function.
  Failed to find 'pud' in this function.
  Failed to find 'pud' in this function.
  Failed to find 'pud' in this function.
  Failed to find 'pud' in this function.
  Failed to find 'pud' in this function.
  p:probe/pud_page_vaddr _text+23480787 pud=%ax:x64
  p:probe/pud_page_vaddr _text+23808453 pud=%bp:x64
  p:probe/pud_page_vaddr _text+23558082 pud=%ax:x64
  p:probe/pud_page_vaddr _text+328373 pud=%r8:x64
  p:probe/pud_page_vaddr _text+348448 pud=%bx:x64
  p:probe/pud_page_vaddr _text+23816818 pud=%bx:x64

With this patch:

  # perf probe -D "pud_page_vaddr pud" | head
  spurious_kernel_fault is blacklisted function, skip it.
  vmalloc_fault is blacklisted function, skip it.
  p:probe/pud_page_vaddr _text+23480787 pud=%ax:x64
  p:probe/pud_page_vaddr _text+149051 pud=\deade12d:x64
  p:probe/pud_page_vaddr _text+23808453 pud=%bp:x64
  p:probe/pud_page_vaddr _text+315926 pud=\deade12d:x64
  p:probe/pud_page_vaddr _text+23807209 pud=\deade12d:x64
  p:probe/pud_page_vaddr _text+23557365 pud=%ax:x64
  p:probe/pud_page_vaddr _text+314097 pud=%di:x64
  p:probe/pud_page_vaddr _text+314015 pud=\deade12d:x64
  p:probe/pud_page_vaddr _text+313893 pud=\deade12d:x64
  p:probe/pud_page_vaddr _text+324083 pud=\deade12d:x64

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Link: http://lore.kernel.org/lkml/157406476931.24476.6261475888681844285.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c  |  2 +-
 tools/perf/util/probe-event.h  |  3 ++-
 tools/perf/util/probe-finder.c | 62 ++++++++++++++++++++++++++++++---
 tools/perf/util/probe-finder.h |  1 +-
 4 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 8f963a1..52b2d16 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -46,7 +46,7 @@
 #define PERFPROBE_GROUP "probe"
 
 bool probe_event_dry_run;	/* Dry run flag */
-struct probe_conf probe_conf;
+struct probe_conf probe_conf = { .magic_num = DEFAULT_PROBE_MAGIC_NUM };
 
 #define semantic_error(msg ...) pr_err("Semantic error :" msg)
 
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 96a319c..4f0eb3a 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -16,10 +16,13 @@ struct probe_conf {
 	bool	no_inlines;
 	bool	cache;
 	int	max_probes;
+	unsigned long	magic_num;
 };
 extern struct probe_conf probe_conf;
 extern bool probe_event_dry_run;
 
+#define DEFAULT_PROBE_MAGIC_NUM	0xdeade12d	/* u32: 3735937325 */
+
 struct symbol;
 
 /* kprobe-tracer and uprobe-tracer tracing point */
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 33e9005..38d6cd2 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -536,6 +536,14 @@ next:
 		return 0;
 }
 
+static void print_var_not_found(const char *varname)
+{
+	pr_err("Failed to find the location of the '%s' variable at this address.\n"
+	       " Perhaps it has been optimized out.\n"
+	       " Use -V with the --range option to show '%s' location range.\n",
+		varname, varname);
+}
+
 /* Show a variables in kprobe event format */
 static int convert_variable(Dwarf_Die *vr_die, struct probe_finder *pf)
 {
@@ -547,11 +555,11 @@ static int convert_variable(Dwarf_Die *vr_die, struct probe_finder *pf)
 
 	ret = convert_variable_location(vr_die, pf->addr, pf->fb_ops,
 					&pf->sp_die, pf->machine, pf->tvar);
+	if (ret == -ENOENT && pf->skip_empty_arg)
+		/* This can be found in other place. skip it */
+		return 0;
 	if (ret == -ENOENT || ret == -EINVAL) {
-		pr_err("Failed to find the location of the '%s' variable at this address.\n"
-		       " Perhaps it has been optimized out.\n"
-		       " Use -V with the --range option to show '%s' location range.\n",
-		       pf->pvar->var, pf->pvar->var);
+		print_var_not_found(pf->pvar->var);
 	} else if (ret == -ENOTSUP)
 		pr_err("Sorry, we don't support this variable location yet.\n");
 	else if (ret == 0 && pf->pvar->field) {
@@ -598,6 +606,8 @@ static int find_variable(Dwarf_Die *sc_die, struct probe_finder *pf)
 		/* Search again in global variables */
 		if (!die_find_variable_at(&pf->cu_die, pf->pvar->var,
 						0, &vr_die)) {
+			if (pf->skip_empty_arg)
+				return 0;
 			pr_warning("Failed to find '%s' in this function.\n",
 				   pf->pvar->var);
 			ret = -ENOENT;
@@ -1384,6 +1394,44 @@ end:
 	return ret;
 }
 
+static int fill_empty_trace_arg(struct perf_probe_event *pev,
+				struct probe_trace_event *tevs, int ntevs)
+{
+	char **valp;
+	char *type;
+	int i, j, ret;
+
+	for (i = 0; i < pev->nargs; i++) {
+		type = NULL;
+		for (j = 0; j < ntevs; j++) {
+			if (tevs[j].args[i].value) {
+				type = tevs[j].args[i].type;
+				break;
+			}
+		}
+		if (j == ntevs) {
+			print_var_not_found(pev->args[i].var);
+			return -ENOENT;
+		}
+		for (j = 0; j < ntevs; j++) {
+			valp = &tevs[j].args[i].value;
+			if (*valp)
+				continue;
+
+			ret = asprintf(valp, "\\%lx", probe_conf.magic_num);
+			if (ret < 0)
+				return -ENOMEM;
+			/* Note that type can be NULL */
+			if (type) {
+				tevs[j].args[i].type = strdup(type);
+				if (!tevs[j].args[i].type)
+					return -ENOMEM;
+			}
+		}
+	}
+	return 0;
+}
+
 /* Find probe_trace_events specified by perf_probe_event from debuginfo */
 int debuginfo__find_trace_events(struct debuginfo *dbg,
 				 struct perf_probe_event *pev,
@@ -1402,7 +1450,13 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
 	tf.tevs = *tevs;
 	tf.ntevs = 0;
 
+	if (pev->nargs != 0 && immediate_value_is_supported())
+		tf.pf.skip_empty_arg = true;
+
 	ret = debuginfo__find_probes(dbg, &tf.pf);
+	if (ret >= 0 && tf.pf.skip_empty_arg)
+		ret = fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
+
 	if (ret < 0) {
 		for (i = 0; i < tf.ntevs; i++)
 			clear_probe_trace_event(&tf.tevs[i]);
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
index 670c477..11be100 100644
--- a/tools/perf/util/probe-finder.h
+++ b/tools/perf/util/probe-finder.h
@@ -87,6 +87,7 @@ struct probe_finder {
 	unsigned int		machine;	/* Target machine arch */
 	struct perf_probe_arg	*pvar;		/* Current target variable */
 	struct probe_trace_arg	*tvar;		/* Current result variable */
+	bool			skip_empty_arg;	/* Skip non-exist args */
 };
 
 struct trace_event_finder {
