Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C445CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4CD222C2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfJVADy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:03:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730602AbfJVADw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:03:52 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgxO-0004Dj-8n; Tue, 22 Oct 2019 01:19:22 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E50121C047B;
        Tue, 22 Oct 2019 01:19:16 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:16 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf annotate: Use libsubcmd's run-command.h to fork objdump
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        clang-built-linux@googlegroups.com, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191010183649.23768-3-irogers@google.com>
References: <20191010183649.23768-3-irogers@google.com>
MIME-Version: 1.0
Message-ID: <157169995659.29376.6123115248233017394.tip-bot2@tip-bot2>
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

Commit-ID:     4235949944d1bb244c85fd184cdc2f78e9df848b
Gitweb:        https://git.kernel.org/tip/4235949944d1bb244c85fd184cdc2f78e9df848b
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 10 Oct 2019 11:36:46 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 08:39:01 -03:00

perf annotate: Use libsubcmd's run-command.h to fork objdump

Reduce duplicated logic by using the subcmd library. Ensure when errors
occur they are reported to the caller. Before this patch, if no lines
are read the error status is 0.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: clang-built-linux@googlegroups.com
Link: http://lore.kernel.org/lkml/20191010183649.23768-3-irogers@google.com
Link: http://lore.kernel.org/lkml/20191015003418.62563-1-irogers@google.com
[ merged follow up fix for NULL termination as in the 2nd link above ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 72 +++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f9c39a7..9835666 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -43,6 +43,7 @@
 #include <linux/string.h>
 #include <bpf/libbpf.h>
 #include <subcmd/parse-options.h>
+#include <subcmd/run-command.h>
 
 /* FIXME: For the HE_COLORSET */
 #include "ui/browser.h"
@@ -1864,12 +1865,19 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	struct kcore_extract kce;
 	bool delete_extract = false;
 	bool decomp = false;
-	int stdout_fd[2];
 	int lineno = 0;
 	int nline;
-	pid_t pid;
 	char *line;
 	size_t line_len;
+	const char *objdump_argv[] = {
+		"/bin/sh",
+		"-c",
+		NULL, /* Will be the objdump command to run. */
+		"--",
+		NULL, /* Will be the symfs path. */
+		NULL,
+	};
+	struct child_process objdump_process;
 	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
 
 	if (err)
@@ -1899,7 +1907,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 		if (dso__decompress_kmodule_path(dso, symfs_filename,
 						 tmp, sizeof(tmp)) < 0)
-			goto out;
+			return -1;
 
 		decomp = true;
 		strcpy(symfs_filename, tmp);
@@ -1924,38 +1932,28 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 	pr_debug("Executing: %s\n", command);
 
-	err = -1;
-	if (pipe(stdout_fd) < 0) {
-		pr_err("Failure creating the pipe to run %s\n", command);
-		goto out_free_command;
-	}
-
-	pid = fork();
-	if (pid < 0) {
-		pr_err("Failure forking to run %s\n", command);
-		goto out_close_stdout;
-	}
+	objdump_argv[2] = command;
+	objdump_argv[4] = symfs_filename;
 
-	if (pid == 0) {
-		close(stdout_fd[0]);
-		dup2(stdout_fd[1], 1);
-		close(stdout_fd[1]);
-		execl("/bin/sh", "sh", "-c", command, "--", symfs_filename,
-		      NULL);
-		perror(command);
-		exit(-1);
+	/* Create a pipe to read from for stdout */
+	memset(&objdump_process, 0, sizeof(objdump_process));
+	objdump_process.argv = objdump_argv;
+	objdump_process.out = -1;
+	if (start_command(&objdump_process)) {
+		pr_err("Failure starting to run %s\n", command);
+		err = -1;
+		goto out_free_command;
 	}
 
-	close(stdout_fd[1]);
-
-	file = fdopen(stdout_fd[0], "r");
+	file = fdopen(objdump_process.out, "r");
 	if (!file) {
 		pr_err("Failure creating FILE stream for %s\n", command);
 		/*
 		 * If we were using debug info should retry with
 		 * original binary.
 		 */
-		goto out_free_command;
+		err = -1;
+		goto out_close_stdout;
 	}
 
 	/* Storage for getline. */
@@ -1979,8 +1977,14 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	}
 	free(line);
 
-	if (nline == 0)
+	err = finish_command(&objdump_process);
+	if (err)
+		pr_err("Error running %s\n", command);
+
+	if (nline == 0) {
+		err = -1;
 		pr_err("No output from %s\n", command);
+	}
 
 	/*
 	 * kallsyms does not have symbol sizes so there may a nop at the end.
@@ -1990,23 +1994,21 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		delete_last_nop(sym);
 
 	fclose(file);
-	err = 0;
+
+out_close_stdout:
+	close(objdump_process.out);
+
 out_free_command:
 	free(command);
-out_remove_tmp:
-	close(stdout_fd[0]);
 
+out_remove_tmp:
 	if (decomp)
 		unlink(symfs_filename);
 
 	if (delete_extract)
 		kcore_extract__delete(&kce);
-out:
-	return err;
 
-out_close_stdout:
-	close(stdout_fd[1]);
-	goto out_free_command;
+	return err;
 }
 
 static void calc_percent(struct sym_hist *sym_hist,
