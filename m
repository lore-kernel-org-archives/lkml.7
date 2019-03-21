Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9BEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7612B21917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194508;
	bh=KVGPDkX26x5YjQHEWFotFLN98ffFTwOUhRRjDG+9kmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LHR/Mf12jow+kNewZSNPh3kPmkBEIjvwU/KQ2rOqlrCfeC+K92I/N8GFEmTJy5aar
	 k5Kosq18UEGClVo3ss/UJKx+S0/m7u3muElwsTUit13RzOEDUyk2+uMsST54u/3Wqt
	 mNKuMCuU26ABjWhcrfxG2NPO2OmI4OFkh1rEmg7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfCUSzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbfCUSzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:55:04 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B38E218D8;
        Thu, 21 Mar 2019 18:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194503;
        bh=KVGPDkX26x5YjQHEWFotFLN98ffFTwOUhRRjDG+9kmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nueR6KeUCihUWls5UhJ64nQLbKdoep1h3cV4nCraY2Cg5/uGOM6qwl7sQfAsUjbqr
         WPICNn5f2QkFvuDeg0UC9vq6GyplyvPYhYks4vdk4KwRA8mihxaJeCZAH3oK9z+MZl
         9jkMQ9BtJSIFhZ0eYhi2KV3UcReq+1wO7YOD9KAk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Stanislav Fomichev <sdf@google.com>, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 37/44] perf symbols: Introduce DSO_BINARY_TYPE__BPF_PROG_INFO
Date:   Thu, 21 Mar 2019 15:51:35 -0300
Message-Id: <20190321185142.11441-38-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

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
-- 
2.20.1

