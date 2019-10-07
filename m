Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC0EECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF9221721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfJGOtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:49:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44518 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbfJGOtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:46 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUK2-0005v1-Kp; Mon, 07 Oct 2019 16:49:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4CDA71C032F;
        Mon,  7 Oct 2019 16:49:14 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:14 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf annotate: Don't return -1 for error when
 doing BPF disassembly
Cc:     "Russell King - ARM Linux admin" <linux@armlinux.org.uk>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-usevw9r2gcipfcrbpaueurw0@git.kernel.org>
References: <tip-usevw9r2gcipfcrbpaueurw0@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157045975426.9978.12248126879315343549.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     11aad897f6d1a28eae3b7e5b293647c522d65819
Gitweb:        https://git.kernel.org/tip/11aad897f6d1a28eae3b7e5b293647c522d65819
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 30 Sep 2019 16:04:21 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 30 Sep 2019 17:30:06 -03:00

perf annotate: Don't return -1 for error when doing BPF disassembly

Return errno when open_memstream() fails and add two new speciall error
codes for when an invalid, non BPF file or one without BTF is passed to
symbol__disassemble_bpf(), so that its callers can rely on
symbol__strerror_disassemble() to convert that to a human readable error
message that can help figure out what is wrong, with hints even.

Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Song Liu <songliubraving@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/n/tip-usevw9r2gcipfcrbpaueurw0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 19 +++++++++++++++----
 tools/perf/util/annotate.h |  2 ++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b49ecdd..4036c7f 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1637,6 +1637,13 @@ int symbol__strerror_disassemble(struct symbol *sym __maybe_unused, struct map *
 	case SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING:
 		scnprintf(buf, buflen, "Problems while parsing the CPUID in the arch specific initialization.");
 		break;
+	case SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE:
+		scnprintf(buf, buflen, "Invalid BPF file: %s.", dso->long_name);
+		break;
+	case SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF:
+		scnprintf(buf, buflen, "The %s BPF file has no BTF section, compile with -g or use pahole -J.",
+			  dso->long_name);
+		break;
 	default:
 		scnprintf(buf, buflen, "Internal error: Invalid %d error code\n", errnum);
 		break;
@@ -1719,13 +1726,13 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	char tpath[PATH_MAX];
 	size_t buf_size;
 	int nr_skip = 0;
-	int ret = -1;
 	char *buf;
 	bfd *bfdf;
+	int ret;
 	FILE *s;
 
 	if (dso->binary_type != DSO_BINARY_TYPE__BPF_PROG_INFO)
-		return -1;
+		return SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE;
 
 	pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n", __func__,
 		  sym->name, sym->start, sym->end - sym->start);
@@ -1738,8 +1745,10 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	assert(bfd_check_format(bfdf, bfd_object));
 
 	s = open_memstream(&buf, &buf_size);
-	if (!s)
+	if (!s) {
+		ret = errno;
 		goto out;
+	}
 	init_disassemble_info(&info, s,
 			      (fprintf_ftype) fprintf);
 
@@ -1748,8 +1757,10 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 
 	info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
 						 dso->bpf_prog.id);
-	if (!info_node)
+	if (!info_node) {
+		return SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
 		goto out;
+	}
 	info_linear = info_node->info_linear;
 	sub_id = dso->bpf_prog.sub_id;
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 116e21f..d76fd0e 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -372,6 +372,8 @@ enum symbol_disassemble_errno {
 	SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF,
 	SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING,
 	SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP,
+	SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE,
+	SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF,
 
 	__SYMBOL_ANNOTATE_ERRNO__END,
 };
