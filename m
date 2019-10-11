Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EEBC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FA321D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824503;
	bh=QE9qQNOIpCv9TMk1AAxFBdgRq0mBKZ10oqpCTyjQIRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WaK/H4RcU/LkYu+X3QWpbQO22hq48D/rHqGkDdV87HHZZQv3ef631y8qY/tfUVHJ8
	 z2rNdOge2PQ0rZDgqL9ZXu0jx+YygSClRV8/4xQ9JI/7JMMBL21CjPCwG2Y4zs23Jg
	 hjzk/vi4QRfvdWyax2i4ON4p/4iT5gpshCnL9fDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfJKUIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbfJKUIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:08:21 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A76BC222BE;
        Fri, 11 Oct 2019 20:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824501;
        bh=QE9qQNOIpCv9TMk1AAxFBdgRq0mBKZ10oqpCTyjQIRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvmtJzuAT5+Xj/smB1FZILmS92MxleKnjU7NvXuy8U95O0t0f/cT5MncEZoe5QPmV
         XDwTPBTo5WnDAYIiZQrk1Z7MxXeCJm5j4rRoCsUv7vGCKeE0xSbXSrXhG78BzhP43j
         MOJF2OzmvFiz2xkfJw0vUyDX3L0fEEDpFjxNMrhk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 21/69] perf trace: Add the syscall_arg_fmt pointer to syscall_arg
Date:   Fri, 11 Oct 2019 17:05:11 -0300
Message-Id: <20191011200559.7156-22-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 tools/perf/builtin-trace.c       | 45 ++++++++++++++++----------------
 tools/perf/trace/beauty/beauty.h |  3 +++
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 82d39ef43d9c..f30296c72415 100644
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
index 7e06605f7c76..4cc4f6b3d4a1 100644
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
-- 
2.21.0

