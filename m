Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CDAC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76B120643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CD4oZsZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfDSTFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:05:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbfDSTDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JHIaau359225
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 10:18:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JHIaau359225
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555694317;
        bh=ngWiqLqGtYA35SkXbPzhoNP/NtqTzfKdA63DMpBdT7g=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=CD4oZsZG02SbmZMkiKsYK9bPfFOarqAA7kz3oK0uBUcjRydYTtoxaaIconXFlZXDb
         p1w9XDGgjIyWkjvo4zT1DfKzYXTcbNC6iOvb/wyemDlMOt9EA5jKCEGXKeBwL7UQWD
         zD6N6ggkogGDIoCBWpY9xIst2GOirv3XsK6fB1EizKKQieBKNRT0kJzKF0LtS/3kVH
         YZ6nUvwAFbTxnkSgdVGruzdKtqAp2n5BSHCHerjN9nJjAffzhFvZDrst4e5zbVWBwH
         r5P+k9RWJeECKVQS73SBRjx5itzob2ju1FfM0I1r71ikqGrs512KPagtSby66uGRz3
         Wd94bINf3NIcA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JHIZ4u359222;
        Fri, 19 Apr 2019 10:18:35 -0700
Date:   Fri, 19 Apr 2019 10:18:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-a93e0b2365e81e5a5b61f25e269b5dc73d242cba@git.kernel.org>
Cc:     andrii.nakryiko@gmail.com, tglx@linutronix.de, yhs@fb.com,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, mingo@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, linux-kernel@vger.kernel.org, kafai@fb.com,
        songliubraving@fb.com, acme@redhat.com, hpa@zytor.com,
        peterz@infradead.org, jolsa@kernel.org, ak@linux.intel.com
Reply-To: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, ast@kernel.org, daniel@iogearbox.net,
          linux-kernel@vger.kernel.org, andrii.nakryiko@gmail.com,
          tglx@linutronix.de, yhs@fb.com, namhyung@kernel.org,
          songliubraving@fb.com, acme@redhat.com, hpa@zytor.com,
          peterz@infradead.org, jolsa@kernel.org, ak@linux.intel.com,
          kafai@fb.com
In-Reply-To: <20190416160127.30203-8-jolsa@kernel.org>
References: <20190416160127.30203-8-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Check maps for bpf programs
Git-Commit-ID: a93e0b2365e81e5a5b61f25e269b5dc73d242cba
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

Commit-ID:  a93e0b2365e81e5a5b61f25e269b5dc73d242cba
Gitweb:     https://git.kernel.org/tip/a93e0b2365e81e5a5b61f25e269b5dc73d242cba
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Tue, 16 Apr 2019 18:01:22 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 17 Apr 2019 14:30:11 -0300

perf tools: Check maps for bpf programs

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
