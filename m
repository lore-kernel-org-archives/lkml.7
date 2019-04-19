Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB761C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7867920449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698736;
	bh=oVA2er8WzZWYbe1nK1ZN6qlCSt5JXcRg5X+tIpeq+/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xHYL+e4zqlC+ZV8sh8u5TCz3d2MBMnnvzYTXRuOyA/odkvu3Mepn2zliLm9OqryHC
	 mbpqevLnYkGvd2kwbVkTPzAhf2JN5xzVyBGKcy25ysq+8MxrVZ28fO1+JOr6ZwjRHt
	 IBKpTxDX4z8D3K4UliHbETGHg66VCYeOa+VNSI5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfDSScP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbfDSS3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:17 -0400
Received: from quaco.ghostprotocols.net (unknown [177.102.80.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 888C42196F;
        Fri, 19 Apr 2019 12:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555677059;
        bh=oVA2er8WzZWYbe1nK1ZN6qlCSt5JXcRg5X+tIpeq+/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dWWB7VDOjegMQTCwzsBHvX8q1Kuu09JDKtyP3N03IZ0Np7U5004da29U4jCt1LsUl
         YGR9qm9BsSrwGcS21w/34owP4k2/Lx9Yynb7p8VMLpjDWPsfiwEIXdhI7O+7x76xhZ
         ssFG6z1kncHHt2KfpsvclxWVEH8gKb4ZoGAgISgA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/7] perf tools: Check maps for bpf programs
Date:   Fri, 19 Apr 2019 09:30:26 -0300
Message-Id: <20190419123029.11328-5-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419123029.11328-1-acme@kernel.org>
References: <20190419123029.11328-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

As reported by Jiri Olsa in:

  "[BUG] perf: intel_pt won't display kernel function"
  https://lore.kernel.org/lkml/20190403143738.GB32001@krava

Recent changes to support PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT
broke --kallsyms option. This is because it broke test __map__is_kmodule.

This patch fixes this by adding check for bpf program, so that these maps
are not mistaken as kernel modules.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yonghong Song <yhs@fb.com>
Link: http://lkml.kernel.org/r/20190416160127.30203-8-jolsa@kernel.org
Fixes: 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 16 ++++++++++++++++
 tools/perf/util/map.h |  4 +++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index e32628cd20a7..28d484ef74ae 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -261,6 +261,22 @@ bool __map__is_extra_kernel_map(const struct map *map)
 	return kmap && kmap->name[0];
 }
 
+bool __map__is_bpf_prog(const struct map *map)
+{
+	const char *name;
+
+	if (map->dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return true;
+
+	/*
+	 * If PERF_RECORD_BPF_EVENT is not included, the dso will not have
+	 * type of DSO_BINARY_TYPE__BPF_PROG_INFO. In such cases, we can
+	 * guess the type based on name.
+	 */
+	name = map->dso->short_name;
+	return name && (strstr(name, "bpf_prog_") == name);
+}
+
 bool map__has_symbols(const struct map *map)
 {
 	return dso__has_symbols(map->dso);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 0e20749f2c55..dc93787c74f0 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -159,10 +159,12 @@ int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name,
 
 bool __map__is_kernel(const struct map *map);
 bool __map__is_extra_kernel_map(const struct map *map);
+bool __map__is_bpf_prog(const struct map *map);
 
 static inline bool __map__is_kmodule(const struct map *map)
 {
-	return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map);
+	return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map) &&
+	       !__map__is_bpf_prog(map);
 }
 
 bool map__has_symbols(const struct map *map);
-- 
2.20.1

