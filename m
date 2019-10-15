Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE08ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B6E2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfJOFc0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:32:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42136 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbfJOFcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRD-0000Nf-JC; Tue, 15 Oct 2019 07:32:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9E8A31C0450;
        Tue, 15 Oct 2019 07:31:47 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:47 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Add the syscall_arg_fmt pointer to syscall_arg
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-01qmjqv6cb1nj1qy4khdexce@git.kernel.org>
References: <tip-01qmjqv6cb1nj1qy4khdexce@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750752.12254.6721159931666505587.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     888ca854e275fcfbb13206d32bb01c0576fc5546
Gitweb:        https://git.kernel.org/tip/888ca854e275fcfbb13206d32bb01c0576fc5546
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 04 Oct 2019 14:52:30 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 07 Oct 2019 12:22:18 -03:00

perf trace: Add the syscall_arg_fmt pointer to syscall_arg

So that the scnprintf beautifiers can access it, as will be the case
with the char array one in the following csets, that needs to know
the number of elements in an array.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-01qmjqv6cb1nj1qy4khdexce@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 45 +++++++++++++++----------------
 tools/perf/trace/beauty/beauty.h |  3 ++-
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 82d39ef..f30296c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -86,6 +86,28 @@
 # define F_LINUX_SPECIFIC_BASE	1024
 #endif
 
+struct syscall_arg_fmt {
+	size_t	   (*scnprintf)(char *bf, size_t size, struct syscall_arg *arg);
+	unsigned long (*mask_val)(struct syscall_arg *arg, unsigned long val);
+	void	   *parm;
+	const char *name;
+	bool	   show_zero;
+};
+
+struct syscall_fmt {
+	const char *name;
+	const char *alias;
+	struct {
+		const char *sys_enter,
+			   *sys_exit;
+	}	   bpf_prog_name;
+	struct syscall_arg_fmt arg[6];
+	u8	   nr_args;
+	bool	   errpid;
+	bool	   timeout;
+	bool	   hexret;
+};
+
 struct trace {
 	struct perf_tool	tool;
 	struct syscalltbl	*sctbl;
@@ -695,28 +717,6 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 #include "trace/beauty/socket_type.c"
 #include "trace/beauty/waitid_options.c"
 
-struct syscall_arg_fmt {
-	size_t	   (*scnprintf)(char *bf, size_t size, struct syscall_arg *arg);
-	unsigned long (*mask_val)(struct syscall_arg *arg, unsigned long val);
-	void	   *parm;
-	const char *name;
-	bool	   show_zero;
-};
-
-struct syscall_fmt {
-	const char *name;
-	const char *alias;
-	struct {
-		const char *sys_enter,
-			   *sys_exit;
-	}	   bpf_prog_name;
-	struct syscall_arg_fmt arg[6];
-	u8	   nr_args;
-	bool	   errpid;
-	bool	   timeout;
-	bool	   hexret;
-};
-
 static struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "access",
 	  .arg = { [1] = { .scnprintf = SCA_ACCMODE,  /* mode */ }, }, },
@@ -1771,6 +1771,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (arg.mask & bit)
 				continue;
 
+			arg.fmt = &sc->arg_fmt[arg.idx];
 			val = syscall_arg__val(&arg, arg.idx);
 			/*
 			 * Some syscall args need some mask, most don't and
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 7e06605..4cc4f6b 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -78,6 +78,8 @@ struct augmented_arg {
 	u64  value[];
 };
 
+struct syscall_arg_fmt;
+
 /**
  * @val: value of syscall argument being formatted
  * @args: All the args, use syscall_args__val(arg, nth) to access one
@@ -94,6 +96,7 @@ struct augmented_arg {
 struct syscall_arg {
 	unsigned long val;
 	unsigned char *args;
+	struct syscall_arg_fmt *fmt;
 	struct {
 		struct augmented_arg *args;
 		int		     size;
