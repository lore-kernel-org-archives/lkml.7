Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E68C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45D221925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfCVWnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:43:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbfCVWnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:43:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMgYwe755789
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:42:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMgXHG755784;
        Fri, 22 Mar 2019 15:42:33 -0700
Date:   Fri, 22 Mar 2019 15:42:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-9b86d04d53b98399017fea44e9047165ffe12d42@git.kernel.org>
Cc:     namhyung@kernel.org, ast@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, hpa@zytor.com, daniel@iogearbox.net,
        acme@redhat.com, jolsa@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, sdf@google.com, songliubraving@fb.com
Reply-To: ast@kernel.org, tglx@linutronix.de, namhyung@kernel.org,
          daniel@iogearbox.net, hpa@zytor.com, peterz@infradead.org,
          songliubraving@fb.com, sdf@google.com,
          linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@kernel.org,
          mingo@kernel.org
In-Reply-To: <20190312053051.2690567-13-songliubraving@fb.com>
References: <20190312053051.2690567-13-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf symbols: Introduce
 DSO_BINARY_TYPE__BPF_PROG_INFO
Git-Commit-ID: 9b86d04d53b98399017fea44e9047165ffe12d42
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9b86d04d53b98399017fea44e9047165ffe12d42
Gitweb:     https://git.kernel.org/tip/9b86d04d53b98399017fea44e9047165ffe12d42
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Mon, 11 Mar 2019 22:30:48 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:07 -0300

perf symbols: Introduce DSO_BINARY_TYPE__BPF_PROG_INFO

Introduce a new dso type DSO_BINARY_TYPE__BPF_PROG_INFO for BPF programs. In
symbol__disassemble(), DSO_BINARY_TYPE__BPF_PROG_INFO dso will call into a new
function symbol__disassemble_bpf() in an upcoming patch, where annotation line
information is filled based bpf_prog_info and btf saved in given perf_env.

Committer notes:

Removed the unnamed union with 'bpf_prog' and 'cache' in 'struct dso',
to fix this bug when exiting 'perf top':

  # perf top
  perf: Segmentation fault
  -------- backtrace --------
  perf[0x5a785a]
  /lib64/libc.so.6(+0x385bf)[0x7fd68443c5bf]
  perf(rb_first+0x2b)[0x4d6eeb]
  perf(dso__delete+0xb7)[0x4dffb7]
  perf[0x4f9e37]
  perf(perf_session__delete+0x64)[0x504df4]
  perf(cmd_top+0x1957)[0x454467]
  perf[0x4aad18]
  perf(main+0x61c)[0x42ec7c]
  /lib64/libc.so.6(__libc_start_main+0xf2)[0x7fd684428412]
  perf(_start+0x2d)[0x42eead]
  #
  # addr2line -fe ~/bin/perf 0x4dffb7
  dso_cache__free
  /home/acme/git/perf/tools/perf/util/dso.c:713

That is trying to access the dso->data.cache, and that is not used with
BPF programs, so we end up accessing what is in bpf_prog.first_member,
b00m.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: kernel-team@fb.com
Link: http://lkml.kernel.org/r/20190312053051.2690567-13-songliubraving@fb.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c    | 1 +
 tools/perf/util/dso.h    | 8 ++++++++
 tools/perf/util/symbol.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ab8a455d2283..e059976d9d93 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -184,6 +184,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 	case DSO_BINARY_TYPE__KALLSYMS:
 	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
 	case DSO_BINARY_TYPE__JAVA_JIT:
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 		ret = -1;
 		break;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index bb417c54c25a..6e3f63781e51 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -14,6 +14,7 @@
 
 struct machine;
 struct map;
+struct perf_env;
 
 enum dso_binary_type {
 	DSO_BINARY_TYPE__KALLSYMS = 0,
@@ -35,6 +36,7 @@ enum dso_binary_type {
 	DSO_BINARY_TYPE__KCORE,
 	DSO_BINARY_TYPE__GUEST_KCORE,
 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
+	DSO_BINARY_TYPE__BPF_PROG_INFO,
 	DSO_BINARY_TYPE__NOT_FOUND,
 };
 
@@ -189,6 +191,12 @@ struct dso {
 		u64		 debug_frame_offset;
 		u64		 eh_frame_hdr_offset;
 	} data;
+	/* bpf prog information */
+	struct {
+		u32		id;
+		u32		sub_id;
+		struct perf_env	*env;
+	} bpf_prog;
 
 	union { /* Tool specific area */
 		void	 *priv;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 58442ca5e3c4..5cbad55cd99d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1455,6 +1455,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
 		return true;
 
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 	default:
 		return false;
