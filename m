Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA9120882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbfJUXUX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 19:20:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38246 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730526AbfJUXSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 19:18:54 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgwn-0003oB-UN; Tue, 22 Oct 2019 01:18:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4117C1C0086;
        Tue, 22 Oct 2019 01:18:45 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:18:44 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libbeauty: Introduce strarray__strtoul_flags()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-8xst3zrqqogax7fmfzwymvbl@git.kernel.org>
References: <tip-8xst3zrqqogax7fmfzwymvbl@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169992475.29376.13318379428779194980.tip-bot2@tip-bot2>
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

Commit-ID:     154c978d484c610468727c361576b7cfe9c3fec7
Gitweb:        https://git.kernel.org/tip/154c978d484c610468727c361576b7cfe9c3fec7
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Sat, 19 Oct 2019 15:17:30 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 19 Oct 2019 15:35:02 -03:00

libbeauty: Introduce strarray__strtoul_flags()

Counterpart of strarray__scnprintf_flags(), i.e. from a expression like:

   # perf trace -e syscalls:sys_enter_mmap --filter="flags==PRIVATE|FIXED|DENYWRITE"

I.e. that "flags==PRIVATE|FIXED|DENYWRITE", turn that into

   # perf trace -e syscalls:sys_enter_mmap --filter=0x812

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8xst3zrqqogax7fmfzwymvbl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 45 ++++++++++++++++++++++++++++++-
 tools/perf/trace/beauty/beauty.h |  1 +-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 72ef3b3..73c5c14 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -586,6 +586,49 @@ bool strarray__strtoul(struct strarray *sa, char *bf, size_t size, u64 *ret)
 	return false;
 }
 
+bool strarray__strtoul_flags(struct strarray *sa, char *bf, size_t size, u64 *ret)
+{
+	u64 val = 0;
+	char *tok = bf, *sep, *end;
+
+	*ret = 0;
+
+	while (size != 0) {
+		int toklen = size;
+
+		sep = memchr(tok, '|', size);
+		if (sep != NULL) {
+			size -= sep - tok + 1;
+
+			end = sep - 1;
+			while (end > tok && isspace(*end))
+				--end;
+
+			toklen = end - tok + 1;
+		}
+
+		while (isspace(*tok))
+			++tok;
+
+		if (isalpha(*tok) || *tok == '_') {
+			if (!strarray__strtoul(sa, tok, toklen, &val))
+				return false;
+		} else {
+			bool is_hexa = tok[0] == 0 && (tok[1] = 'x' || tok[1] == 'X');
+
+			val = strtoul(tok, NULL, is_hexa ? 16 : 0);
+		}
+
+		*ret |= (1 << (val - 1));
+
+		if (sep == NULL)
+			break;
+		tok = sep + 1;
+	}
+
+	return true;
+}
+
 bool strarrays__strtoul(struct strarrays *sas, char *bf, size_t size, u64 *ret)
 {
 	int i;
@@ -3676,7 +3719,7 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
 			}
 
 		right_end = right + 1;
-		while (isalnum(*right_end) || *right_end == '_')
+		while (isalnum(*right_end) || *right_end == '_' || *right_end == '|')
 			++right_end;
 
 		if (isalpha(*right)) {
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 1080166..e12b222 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -32,6 +32,7 @@ size_t strarray__scnprintf_suffix(struct strarray *sa, char *bf, size_t size, co
 size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, bool show_prefix, unsigned long flags);
 
 bool strarray__strtoul(struct strarray *sa, char *bf, size_t size, u64 *ret);
+bool strarray__strtoul_flags(struct strarray *sa, char *bf, size_t size, u64 *ret);
 
 struct trace;
 struct thread;
