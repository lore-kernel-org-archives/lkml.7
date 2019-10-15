Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3566ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B7621848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfJOFf6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:35:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42013 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbfJOFcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:00 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFR4-0000F9-JJ; Tue, 15 Oct 2019 07:31:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5F7891C0105;
        Tue, 15 Oct 2019 07:31:43 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:43 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Add a strtoul() method to 'struct
 syscall_arg_fmt'
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-wgqq48agcgr95b8dmn6fygtr@git.kernel.org>
References: <tip-wgqq48agcgr95b8dmn6fygtr@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750329.12254.9112211069914938976.tip-bot2@tip-bot2>
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

Commit-ID:     3f41b77843b338e836f52cc2d486be689d6cb9c1
Gitweb:        https://git.kernel.org/tip/3f41b77843b338e836f52cc2d486be689d6cb9c1
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 09 Oct 2019 16:06:43 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 09 Oct 2019 16:06:43 -03:00

perf trace: Add a strtoul() method to 'struct syscall_arg_fmt'

This will go from a string to a number, so that filter expressions can
be constructed with strings and then, before applying the tracepoint
filters (or eBPF, in the future) we can map those strings to numbers.

The first one will be for 'msr' tracepoint arguments, but real quickly
we will be able to reuse all strarrays for that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wgqq48agcgr95b8dmn6fygtr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2c19680..faa5bf4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -86,8 +86,12 @@
 # define F_LINUX_SPECIFIC_BASE	1024
 #endif
 
+/*
+ * strtoul: Go from a string to a value, i.e. for msr: MSR_FS_BASE to 0xc0000100
+ */
 struct syscall_arg_fmt {
 	size_t	   (*scnprintf)(char *bf, size_t size, struct syscall_arg *arg);
+	bool	   (*strtoul)(char *bf, size_t size, struct syscall_arg *arg, u64 *val);
 	unsigned long (*mask_val)(struct syscall_arg *arg, unsigned long val);
 	void	   *parm;
 	const char *name;
@@ -1543,8 +1547,10 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
                } else {
 			struct syscall_arg_fmt *fmt = syscall_arg_fmt__find_by_name(field->name);
 
-			if (fmt)
+			if (fmt) {
 				arg->scnprintf = fmt->scnprintf;
+				arg->strtoul   = fmt->strtoul;
+			}
 		}
 	}
 
