Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ABAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2030F21773
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555430521;
	bh=s1Y12AJkYKrl+ZurtkMwCtl4gmBQ3TlEU0mJiXzGy9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1awv6wvDOsYPxzQeXajwSXSHesJ38zL3vDCga0SoZFi8njFH6xVJ8UpgyQRZehqtH
	 ntxgL9lrYl7ECDcpKmxji7JYTKowX+ugd+NfONnhxM6rIGhaTaxRh1FP3veMIegQJP
	 2uLc4T3C2d3hNJSO/xaEJ6yOIpXwVZAucGAX3MsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbfDPQB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:01:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730012AbfDPQB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:01:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E204D309E979;
        Tue, 16 Apr 2019 16:01:57 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D47B05D71D;
        Tue, 16 Apr 2019 16:01:52 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 07/12] perf tools: Check maps for bpf programs
Date:   Tue, 16 Apr 2019 18:01:22 +0200
Message-Id: <20190416160127.30203-8-jolsa@kernel.org>
In-Reply-To: <20190416160127.30203-1-jolsa@kernel.org>
References: <20190416160127.30203-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 16 Apr 2019 16:01:58 +0000 (UTC)
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

Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Fixes: 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
Link: https://lore.kernel.org/lkml/20190403145353.GE32553@kernel.org

Signed-off-by: Song Liu <songliubraving@fb.com>
Link: http://lkml.kernel.org/n/tip-gnffkcoc4nauqcpgvsmwka2w@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.17.2

