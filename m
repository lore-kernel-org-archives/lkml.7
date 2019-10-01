Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98D7C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4F021920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569928451;
	bh=AdBjSELZJhlgyRvsjG8O19Gi25UGUWyRyAzRlfwaJ0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eXCTlcZdimNsMFSBcdd6nR89dkuBNbvINK7BAYL/d8vX+qaKziF9wcZ9NsZHleR1A
	 rGp6ZVYR/SpwbCRxgYF0unLY0C5rMMuVdrEJ+2lefPVzI3vf02vpnd3iIIwGKrgu/7
	 9g3uJFfNie6BR8MUDiy6yb9PjFK1mi3qPMYcFCkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbfJALOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfJALOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:14:09 -0400
Received: from quaco.ghostprotocols.net (177.206.223.101.dynamic.adsl.gvt.net.br [177.206.223.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC7521D80;
        Tue,  1 Oct 2019 11:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569928448;
        bh=AdBjSELZJhlgyRvsjG8O19Gi25UGUWyRyAzRlfwaJ0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hoYG9D5fMu+tXD1bKhCd6bNsoVMROHmI1277Gvl97Whw1hpVBwNq7CBGXVf5mT/jK
         KyogFWSdBJ1MPEnTrTHf/sl1XPMz9CT6dIE6XXvr5ArU/OXhad7laHfCAT3YSlTXoZ
         kkjoP8tK1a1Dm3VH4VGU1190/6Ess+l+FBtj6ViA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 24/24] perf annotate: Don't return -1 for error when doing BPF disassembly
Date:   Tue,  1 Oct 2019 08:12:16 -0300
Message-Id: <20191001111216.7208-25-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index b49ecdd51188..4036c7f7b0fb 100644
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
index 116e21f49da6..d76fd0e81f46 100644
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
-- 
2.21.0

