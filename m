Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FF7CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A7520882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfJUXUB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 19:20:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38260 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730547AbfJUXSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 19:18:55 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgwq-0003pv-CF; Tue, 22 Oct 2019 01:18:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A316B1C047B;
        Tue, 22 Oct 2019 01:18:47 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:18:47 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libbeauty: Introduce syscall_arg__strtoul_strarrays()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-b1ia3xzcy72hv0u4m168fcd0@git.kernel.org>
References: <tip-b1ia3xzcy72hv0u4m168fcd0@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169992705.29376.7071830026458245961.tip-bot2@tip-bot2>
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

Commit-ID:     1a8a90b823f5e7279f84b39bbcd6c59e266e7dc2
Gitweb:        https://git.kernel.org/tip/1a8a90b823f5e7279f84b39bbcd6c59e266e7dc2
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 18 Oct 2019 15:41:07 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 19 Oct 2019 15:35:01 -03:00

libbeauty: Introduce syscall_arg__strtoul_strarrays()

To allow going from string to integer for 'struct strarrays'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-b1ia3xzcy72hv0u4m168fcd0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 5 +++++
 tools/perf/trace/beauty/beauty.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0e7fc7c..265ea87 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -540,6 +540,11 @@ bool syscall_arg__strtoul_strarray(char *bf, size_t size, struct syscall_arg *ar
 	return strarray__strtoul(arg->parm, bf, size, ret);
 }
 
+bool syscall_arg__strtoul_strarrays(char *bf, size_t size, struct syscall_arg *arg, u64 *ret)
+{
+	return strarrays__strtoul(arg->parm, bf, size, ret);
+}
+
 size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct syscall_arg *arg)
 {
 	return strarray__scnprintf_flags(arg->parm, bf, size, arg->show_string_prefix, arg->val);
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 1b8a30e..1080166 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -125,6 +125,9 @@ size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct sysca
 bool syscall_arg__strtoul_strarray(char *bf, size_t size, struct syscall_arg *arg, u64 *ret);
 #define STUL_STRARRAY syscall_arg__strtoul_strarray
 
+bool syscall_arg__strtoul_strarrays(char *bf, size_t size, struct syscall_arg *arg, u64 *ret);
+#define STUL_STRARRAYS syscall_arg__strtoul_strarrays
+
 size_t syscall_arg__scnprintf_x86_irq_vectors(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_X86_IRQ_VECTORS syscall_arg__scnprintf_x86_irq_vectors
 
