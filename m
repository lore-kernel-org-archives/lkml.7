Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E9AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796462086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfJOFeY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:34:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42128 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfJOFcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRD-0000N1-1O; Tue, 15 Oct 2019 07:32:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5A4A01C04D1;
        Tue, 15 Oct 2019 07:31:47 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:47 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Add array of chars scnprintf beautifier
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-rlll7tmcqe1g4odtaifil5re@git.kernel.org>
References: <tip-rlll7tmcqe1g4odtaifil5re@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750724.12254.17152871616001206067.tip-bot2@tip-bot2>
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

Commit-ID:     9597945d7fb42460e9f2559d1273302ebde85bbf
Gitweb:        https://git.kernel.org/tip/9597945d7fb42460e9f2559d1273302ebde85bbf
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 04 Oct 2019 14:56:40 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 07 Oct 2019 12:22:18 -03:00

perf trace: Add array of chars scnprintf beautifier

Needed for sched's traceoints prev/next comm, where, unlike with
syscalls, we are not dealing with an integer or pointer, but an array
straight out from the ring buffer.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-rlll7tmcqe1g4odtaifil5re@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f30296c..b3fb208 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -91,6 +91,7 @@ struct syscall_arg_fmt {
 	unsigned long (*mask_val)(struct syscall_arg *arg, unsigned long val);
 	void	   *parm;
 	const char *name;
+	u16	   nr_entries; // for arrays
 	bool	   show_zero;
 };
 
@@ -522,6 +523,16 @@ size_t syscall_arg__scnprintf_long(char *bf, size_t size, struct syscall_arg *ar
 	return scnprintf(bf, size, "%ld", arg->val);
 }
 
+static size_t syscall_arg__scnprintf_char_array(char *bf, size_t size, struct syscall_arg *arg)
+{
+	// XXX Hey, maybe for sched:sched_switch prev/next comm fields we can
+	//     fill missing comms using thread__set_comm()...
+	//     here or in a special syscall_arg__scnprintf_pid_sched_tp...
+	return scnprintf(bf, size, "\"%-.*s\"", arg->fmt->nr_entries, arg->val);
+}
+
+#define SCA_CHAR_ARRAY syscall_arg__scnprintf_char_array
+
 static const char *bpf_cmd[] = {
 	"MAP_CREATE", "MAP_LOOKUP_ELEM", "MAP_UPDATE_ELEM", "MAP_DELETE_ELEM",
 	"MAP_GET_NEXT_KEY", "PROG_LOAD",
@@ -1491,7 +1502,10 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			arg->scnprintf = SCA_PID;
 		else if (strcmp(field->type, "umode_t") == 0)
 			arg->scnprintf = SCA_MODE_T;
-		else if ((strcmp(field->type, "int") == 0 ||
+		else if ((field->flags & TEP_FIELD_IS_ARRAY) && strstarts(field->type, "char")) {
+			arg->scnprintf = SCA_CHAR_ARRAY;
+			arg->nr_entries = field->arraylen;
+		} else if ((strcmp(field->type, "int") == 0 ||
 			  strcmp(field->type, "unsigned int") == 0 ||
 			  strcmp(field->type, "long") == 0) &&
 			 len >= 2 && strcmp(field->name + len - 2, "fd") == 0) {
