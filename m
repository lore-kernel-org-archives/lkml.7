Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6EAECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3C92086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfJOFco convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:32:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42242 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbfJOFcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:20 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRO-0000W6-PB; Tue, 15 Oct 2019 07:32:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 142621C06FE;
        Tue, 15 Oct 2019 07:31:52 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:51 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Separate 'struct syscall_fmt' definition
 from syscall_fmts variable
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-2x1jgiev13zt4njaanlnne0d@git.kernel.org>
References: <tip-2x1jgiev13zt4njaanlnne0d@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111751192.12254.9281174335251506181.tip-bot2@tip-bot2>
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

Commit-ID:     9b2036cd329924082acfa5dec58deec12fa1f5e8
Gitweb:        https://git.kernel.org/tip/9b2036cd329924082acfa5dec58deec12fa1f5e8
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 01 Oct 2019 15:16:33 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 07 Oct 2019 12:22:17 -03:00

perf trace: Separate 'struct syscall_fmt' definition from syscall_fmts variable

As this has all the things needed to format tracepoints events, not just
syscalls, that, after all, are just tracepoints with a set in stone ABI,
i.e. order and number of parameters.

For tracepoints we'll create a

  static struct syscall_fmt tracepoint_fmts[]

array and will fill the ->arg[] entries with the beautifier for each
positional argument and record the name, then, when we need it, we'll
just check that the position has the same name, maybe even type, so that
we can do some check that the tracepoint hasn't changed, if it has, we
can even reorder things.

Keep calling it syscall_fmt but use it as well for tracepoints, do it
this way to minimize changes and reuse what is in place for syscalls,
we'll see.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-2x1jgiev13zt4njaanlnne0d@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ee330f5..cb85343 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -702,7 +702,7 @@ struct syscall_arg_fmt {
 	bool	   show_zero;
 };
 
-static struct syscall_fmt {
+struct syscall_fmt {
 	const char *name;
 	const char *alias;
 	struct {
@@ -714,7 +714,9 @@ static struct syscall_fmt {
 	bool	   errpid;
 	bool	   timeout;
 	bool	   hexret;
-} syscall_fmts[] = {
+};
+
+static struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "access",
 	  .arg = { [1] = { .scnprintf = SCA_ACCMODE,  /* mode */ }, }, },
 	{ .name	    = "arch_prctl",
