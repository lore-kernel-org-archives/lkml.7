Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA28FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B310B20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RByXdn13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfJJShO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 14:37:14 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:46172 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfJJShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:37:12 -0400
Received: by mail-ua1-f74.google.com with SMTP id q34so1835889uad.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 11:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EftUmcfh2fMndNbxJxVdWpzc7l+xpsVMxFffMU0YcFk=;
        b=RByXdn13TQLiKS+hm9U0mhaqZ6bvkhToagPoI5JHiWduMYSbQx40JrsDPrxTJeQ6qw
         dWebEKw982H3Jz1wsux3HPO/lgQ87HySOqOjbqzTy5jGnQjNhZ6OyHeVhL+M1AikNZV9
         4svcU9q7ndmzCGkTXZ3eo7jD1rFYK4xcqTqKwDTxBagdcn25OKZPNrTo2ECTArQke6Qe
         Fael39BnuiUzogXB7IOZocE2vJ+rTJx84xkXbddpwPw408p18gsHTAgE70PNqTZiMzxs
         ZRAk5RJjaCua801H5AlZ3TVbZttz1slP/zVNFf5junz2gNbtydDKAVFqRLESVD7V7vXy
         3nDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EftUmcfh2fMndNbxJxVdWpzc7l+xpsVMxFffMU0YcFk=;
        b=t6QKSH4qjwIzpuvZzHRUoTiZlsUyAl/w1qNXGWD99ExSNpA7OBJ5XkJed0QOymKGb5
         mQHiaDM6X/kcj5YpgERvlT428cuepmTr4f73ToegRXfIWmOZmoMzt0EG0Fzuy3JXWDtq
         XhXeyHuwD1zqs/PJZKF0fVl4VhkLE2nF5cqI49QRaOiIerb31JoVmqbGM8mKGsYA0REi
         Jq+5/58TcxmZ7/iVMYFhGKqD1i8I6T+h5D2ezt5TuKm1u2mPadJmTAtqVoGZYhnTus6B
         B+lhQLdXQbZw2IG/7ZwDwVVWJuZoAJP7Hbs8pnrOAHAPzKnObD/SNvq/2MAeGwin9IZ6
         yyqA==
X-Gm-Message-State: APjAAAWS7tVInuFGcsBL+kHiih4tQRF/zWp4baIC+IP1+0LfOKok5ZmR
        MHos9VrHwjuvi+xd/sXomVVnqqZaiJlo
X-Google-Smtp-Source: APXvYqyfRAGQEDsCp9cZOpmVESofrP1fNtJkLr6to7I6q40QwW4nlEQMhwIZrsIoo6Zqp/v3sRxg77jjaiZ1
X-Received: by 2002:a05:6122:10d4:: with SMTP id l20mr6371219vko.18.1570732629711;
 Thu, 10 Oct 2019 11:37:09 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:36:46 -0700
In-Reply-To: <20191010183649.23768-1-irogers@google.com>
Message-Id: <20191010183649.23768-3-irogers@google.com>
Mime-Version: 1.0
References: <20191010183649.23768-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH 2/5] perf annotate: use run-command.h to fork objdump
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce duplicated logic by using the subcmd library. Ensure when errors
occur they are reported to the caller. Before this patch, if no lines are
read the error status is 0.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 71 +++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 1487849a191a..fc12c5cfe112 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -43,6 +43,7 @@
 #include <linux/string.h>
 #include <bpf/libbpf.h>
 #include <subcmd/parse-options.h>
+#include <subcmd/run-command.h>
 
 /* FIXME: For the HE_COLORSET */
 #include "ui/browser.h"
@@ -1843,12 +1844,18 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
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
+	};
+	struct child_process objdump_process;
 	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
 
 	if (err)
@@ -1878,7 +1885,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 		if (dso__decompress_kmodule_path(dso, symfs_filename,
 						 tmp, sizeof(tmp)) < 0)
-			goto out;
+			return -1;
 
 		decomp = true;
 		strcpy(symfs_filename, tmp);
@@ -1903,38 +1910,28 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
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
@@ -1958,8 +1955,14 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
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
@@ -1969,23 +1972,21 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
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
-- 
2.23.0.581.g78d2f28ef7-goog

