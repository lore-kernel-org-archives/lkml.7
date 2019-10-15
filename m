Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B870C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD3D21925
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfJOFcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:32:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42083 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbfJOFcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:05 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFR9-0000I7-2d; Tue, 15 Oct 2019 07:31:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5F7E11C04E8;
        Tue, 15 Oct 2019 07:31:45 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:45 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Allow associating scnprintf routines
 with well known arg names
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-89ptht6s5fez82lykuwq1eyb@git.kernel.org>
References: <tip-89ptht6s5fez82lykuwq1eyb@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750531.12254.10430004196569872399.tip-bot2@tip-bot2>
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

Commit-ID:     5d88099bc00dccddf5da18e25e1223f01644f7a2
Gitweb:        https://git.kernel.org/tip/5d88099bc00dccddf5da18e25e1223f01644f7a2
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 07 Oct 2019 15:50:15 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 09 Oct 2019 11:23:52 -03:00

perf trace: Allow associating scnprintf routines with well known arg names

For instance 'msr' appears in several tracepoints, so we can associate
it with a single scnprintf() routine auto-generated from kernel headers,
as will be done in followup patches.

Start with an empty array of associations.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-89ptht6s5fez82lykuwq1eyb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8303d83..d52972c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1479,6 +1479,27 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 	return 0;
 }
 
+static struct syscall_arg_fmt syscall_arg_fmts__by_name[] = {
+};
+
+static int syscall_arg_fmt__cmp(const void *name, const void *fmtp)
+{
+       const struct syscall_arg_fmt *fmt = fmtp;
+       return strcmp(name, fmt->name);
+}
+
+static struct syscall_arg_fmt *
+__syscall_arg_fmt__find_by_name(struct syscall_arg_fmt *fmts, const int nmemb, const char *name)
+{
+       return bsearch(name, fmts, nmemb, sizeof(struct syscall_arg_fmt), syscall_arg_fmt__cmp);
+}
+
+static struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *name)
+{
+       const int nmemb = ARRAY_SIZE(syscall_arg_fmts__by_name);
+       return __syscall_arg_fmt__find_by_name(syscall_arg_fmts__by_name, nmemb, name);
+}
+
 static struct tep_format_field *
 syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field)
 {
@@ -1518,6 +1539,11 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			 * 7 unsigned long
 			 */
 			arg->scnprintf = SCA_FD;
+               } else {
+			struct syscall_arg_fmt *fmt = syscall_arg_fmt__find_by_name(field->name);
+
+			if (fmt)
+				arg->scnprintf = fmt->scnprintf;
 		}
 	}
 
