Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B503C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B45A2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfJOFfs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:35:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42024 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728457AbfJOFcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFR4-0000EV-Cb; Tue, 15 Oct 2019 07:31:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 24B8A1C0482;
        Tue, 15 Oct 2019 07:31:43 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:43 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Introduce a strtoul() method for 'struct
 strarrays'
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-r2hpaahf8lishyb1owko9vs1@git.kernel.org>
References: <tip-r2hpaahf8lishyb1owko9vs1@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750300.12254.14854506277817723991.tip-bot2@tip-bot2>
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

Commit-ID:     d0a3a1041005d9273d18669819e2a6dfed922a4d
Gitweb:        https://git.kernel.org/tip/d0a3a1041005d9273d18669819e2a6dfed922a4d
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 09 Oct 2019 16:11:36 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 09 Oct 2019 16:11:36 -03:00

perf trace: Introduce a strtoul() method for 'struct strarrays'

And also for 'struct strarray', since its needed to implement
strarrays__strtoul(). This just traverses the entries and when finding a
match, returns (offset + index), i.e. the value associated with the
searched string.

E.g. "EFER" (MSR_EFER) returns:

  # grep -w EFER -B2 /tmp/build/perf/trace/beauty/generated/x86_arch_MSRs_array.c
  #define x86_64_specific_MSRs_offset 0xc0000080
  static const char *x86_64_specific_MSRs[] = {
	[0xc0000080 - x86_64_specific_MSRs_offset] = "EFER",
  #

  0xc0000080

This will be auto-attached to 'struct syscall_arg_fmt' entries
associated with strarrays as soon as we add a ->strarray and ->strarrays
to 'struct syscall_arg_fmt'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-r2hpaahf8lishyb1owko9vs1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 28 ++++++++++++++++++++++++++++
 tools/perf/trace/beauty/beauty.h |  5 +++++
 2 files changed, 33 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index faa5bf4..50a1aeb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -477,6 +477,34 @@ size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const 
 	return printed;
 }
 
+bool strarray__strtoul(struct strarray *sa, char *bf, size_t size, u64 *ret)
+{
+	int i;
+
+	for (i = 0; i < sa->nr_entries; ++i) {
+		if (sa->entries[i] && strncmp(sa->entries[i], bf, size) == 0 && sa->entries[i][size] == '\0') {
+			*ret = sa->offset + i;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+bool strarrays__strtoul(struct strarrays *sas, char *bf, size_t size, u64 *ret)
+{
+	int i;
+
+	for (i = 0; i < sas->nr_entries; ++i) {
+		struct strarray *sa = sas->entries[i];
+
+		if (strarray__strtoul(sa, bf, size, ret))
+			return true;
+	}
+
+	return false;
+}
+
 size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size,
 					struct syscall_arg *arg)
 {
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index aa3fac8..919ac45 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <sys/types.h>
+#include <stdbool.h>
 
 struct strarray {
 	u64	    offset;
@@ -29,6 +30,8 @@ struct strarray {
 size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_prefix, int val);
 size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, bool show_prefix, unsigned long flags);
 
+bool strarray__strtoul(struct strarray *sa, char *bf, size_t size, u64 *ret);
+
 struct trace;
 struct thread;
 
@@ -51,6 +54,8 @@ struct strarrays {
 
 size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const char *intfmt, bool show_prefix, int val);
 
+bool strarrays__strtoul(struct strarrays *sas, char *bf, size_t size, u64 *ret);
+
 size_t pid__scnprintf_fd(struct trace *trace, pid_t pid, int fd, char *bf, size_t size);
 
 extern struct strarray strarray__socket_families;
