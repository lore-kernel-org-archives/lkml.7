Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC423C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C1221850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbfB1Hnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:43:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35975 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfB1Hnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:43:51 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7hJdP2948107
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:43:19 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7hJji2948104;
        Wed, 27 Feb 2019 23:43:19 -0800
Date:   Wed, 27 Feb 2019 23:43:19 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-lz14w0esqyt1333aon05jpwc@git.kernel.org>
Cc:     tglx@linutronix.de, yhs@fb.com, daniel@iogearbox.net,
        jolsa@kernel.org, mingo@kernel.org, ast@kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        hpa@zytor.com, namhyung@kernel.org, kafai@fb.com, acme@redhat.com
Reply-To: jolsa@kernel.org, daniel@iogearbox.net, yhs@fb.com,
          tglx@linutronix.de, kafai@fb.com, namhyung@kernel.org,
          acme@redhat.com, ast@kernel.org, mingo@kernel.org,
          adrian.hunter@intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Add bpf_map dumper
Git-Commit-ID: d19f856479feef7c1383f02b87688563a0ef7a14
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

Commit-ID:  d19f856479feef7c1383f02b87688563a0ef7a14
Gitweb:     https://git.kernel.org/tip/d19f856479feef7c1383f02b87688563a0ef7a14
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 19 Feb 2019 16:11:56 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Feb 2019 16:11:56 -0300

perf bpf: Add bpf_map dumper

At some point I'll suggest moving this to libbpf, for now I'll
experiment with ways to dump BPF maps set by events in 'perf trace',
starting with a very basic dumper for the current very limited needs
of the augmented_raw_syscalls code: dumping booleans.

Having functions that apply to the map keys and values and do table
lookup in things like syscall id to string tables should come next.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-lz14w0esqyt1333aon05jpwc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build     |  1 +
 tools/perf/util/bpf_map.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/bpf_map.h | 22 +++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 3008d49fa587..8dd3102301ea 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -115,6 +115,7 @@ perf-y += branch.o
 perf-y += mem2node.o
 
 perf-$(CONFIG_LIBBPF) += bpf-loader.o
+perf-$(CONFIG_LIBBPF) += bpf_map.o
 perf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
 perf-$(CONFIG_LIBELF) += symbol-elf.o
 perf-$(CONFIG_LIBELF) += probe-file.o
diff --git a/tools/perf/util/bpf_map.c b/tools/perf/util/bpf_map.c
new file mode 100644
index 000000000000..eb853ca67cf4
--- /dev/null
+++ b/tools/perf/util/bpf_map.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+#include "util/bpf_map.h"
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+static bool bpf_map_def__is_per_cpu(const struct bpf_map_def *def)
+{
+	return def->type == BPF_MAP_TYPE_PERCPU_HASH ||
+	       def->type == BPF_MAP_TYPE_PERCPU_ARRAY ||
+	       def->type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+	       def->type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE;
+}
+
+static void *bpf_map_def__alloc_value(const struct bpf_map_def *def)
+{
+	if (bpf_map_def__is_per_cpu(def))
+		return malloc(round_up(def->value_size, 8) * sysconf(_SC_NPROCESSORS_CONF));
+
+	return malloc(def->value_size);
+}
+
+int bpf_map__fprintf(struct bpf_map *map, FILE *fp)
+{
+	const struct bpf_map_def *def = bpf_map__def(map);
+	void *prev_key = NULL, *key, *value;
+	int fd = bpf_map__fd(map), err;
+	int printed = 0;
+
+	if (fd < 0)
+		return fd;
+
+	if (IS_ERR(def))
+		return PTR_ERR(def);
+
+	err = -ENOMEM;
+	key = malloc(def->key_size);
+	if (key == NULL)
+		goto out;
+
+	value = bpf_map_def__alloc_value(def);
+	if (value == NULL)
+		goto out_free_key;
+
+	while ((err = bpf_map_get_next_key(fd, prev_key, key) == 0)) {
+		int intkey = *(int *)key;
+
+		if (!bpf_map_lookup_elem(fd, key, value)) {
+			bool boolval = *(bool *)value;
+			if (boolval)
+				printed += fprintf(fp, "[%d] = %d,\n", intkey, boolval);
+		} else {
+			printed += fprintf(fp, "[%d] = ERROR,\n", intkey);
+		}
+
+		prev_key = key;
+	}
+
+	if (err == ENOENT)
+		err = printed;
+
+	free(value);
+out_free_key:
+	free(key);
+out:
+	return err;
+}
diff --git a/tools/perf/util/bpf_map.h b/tools/perf/util/bpf_map.h
new file mode 100644
index 000000000000..d6abd5e47af8
--- /dev/null
+++ b/tools/perf/util/bpf_map.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#ifndef __PERF_BPF_MAP_H
+#define __PERF_BPF_MAP_H 1
+
+#include <stdio.h>
+#include <linux/compiler.h>
+struct bpf_map;
+
+#ifdef HAVE_LIBBPF_SUPPORT
+
+int bpf_map__fprintf(struct bpf_map *map, FILE *fp);
+
+#else
+
+static inline int bpf_map__fprintf(struct bpf_map *map __maybe_unused, FILE *fp __maybe_unused)
+{
+	return 0;
+}
+
+#endif // HAVE_LIBBPF_SUPPORT
+
+#endif // __PERF_BPF_MAP_H
