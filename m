Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4C6C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D61208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558996828;
	bh=0tvvsOA4AV2rfSmW8ewQZsHktFYVyoGn6efovM8weyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M1dznV7wX7jNmrhQOARr+hiwXX7xX+oogs98rz1WBPWJ/ql2dMOWtBeFDYdECRDAA
	 ExwlmYXflNJJzbdcho/LTvQu+fK0ApoGO6UqizFzyrzkBbgIWCNMox4EPK2iS5W9Ld
	 cPms2va3hvqE1gNuODQskUaMoshWUtgDgX8pnJ5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfE0Wk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 18:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbfE0Wk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:40:26 -0400
Received: from quaco.ghostprotocols.net (179-240-171-7.3g.claro.net.br [179.240.171.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE23321473;
        Mon, 27 May 2019 22:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558996825;
        bh=0tvvsOA4AV2rfSmW8ewQZsHktFYVyoGn6efovM8weyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JIzk8cceQ+vou4kAqsxfw6y2p0IYnoFxFtCuuOVr/thIzD0onZnPEtU3kLTmgC5re
         X8Lk5GrAQajPwsHJcj3lSwoeZtIOk7I4FgKXVwmUiCcPakkfDMfJo386KE4F+5lg9K
         mNyHXy1WS/eze/1ot9iDDUHduJHAbBjbTZ1txLSY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stanislav Fomichev <sdf@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 33/44] perf dso: Add BPF DSO read and size hooks
Date:   Mon, 27 May 2019 19:37:19 -0300
Message-Id: <20190527223730.11474-34-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add BPF related code into DSO reading paths to return size (bpf_size)
and read the BPF code (bpf_read).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-5-jolsa@kernel.org
[ Use uintptr_t when casting from u64 to u8 pointers ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 49 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 1e6a045adb8c..1fb18292c2d3 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -9,6 +9,8 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <libgen.h>
+#include <bpf/libbpf.h>
+#include "bpf-event.h"
 #include "compress.h"
 #include "namespaces.h"
 #include "path.h"
@@ -706,6 +708,44 @@ bool dso__data_status_seen(struct dso *dso, enum dso_data_status_seen by)
 	return false;
 }
 
+static ssize_t bpf_read(struct dso *dso, u64 offset, char *data)
+{
+	struct bpf_prog_info_node *node;
+	ssize_t size = DSO__DATA_CACHE_SIZE;
+	u64 len;
+	u8 *buf;
+
+	node = perf_env__find_bpf_prog_info(dso->bpf_prog.env, dso->bpf_prog.id);
+	if (!node || !node->info_linear) {
+		dso->data.status = DSO_DATA_STATUS_ERROR;
+		return -1;
+	}
+
+	len = node->info_linear->info.jited_prog_len;
+	buf = (u8 *)(uintptr_t)node->info_linear->info.jited_prog_insns;
+
+	if (offset >= len)
+		return -1;
+
+	size = (ssize_t)min(len - offset, (u64)size);
+	memcpy(data, buf + offset, size);
+	return size;
+}
+
+static int bpf_size(struct dso *dso)
+{
+	struct bpf_prog_info_node *node;
+
+	node = perf_env__find_bpf_prog_info(dso->bpf_prog.env, dso->bpf_prog.id);
+	if (!node || !node->info_linear) {
+		dso->data.status = DSO_DATA_STATUS_ERROR;
+		return -1;
+	}
+
+	dso->data.file_size = node->info_linear->info.jited_prog_len;
+	return 0;
+}
+
 static void
 dso_cache__free(struct dso *dso)
 {
@@ -832,7 +872,11 @@ dso_cache__read(struct dso *dso, struct machine *machine,
 	if (!cache)
 		return -ENOMEM;
 
-	ret = file_read(dso, machine, cache_offset, cache->data);
+	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
+		ret = bpf_read(dso, cache_offset, cache->data);
+	else
+		ret = file_read(dso, machine, cache_offset, cache->data);
+
 	if (ret > 0) {
 		cache->offset = cache_offset;
 		cache->size   = ret;
@@ -941,6 +985,9 @@ int dso__data_file_size(struct dso *dso, struct machine *machine)
 	if (dso->data.status == DSO_DATA_STATUS_ERROR)
 		return -1;
 
+	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return bpf_size(dso);
+
 	return file_size(dso, machine);
 }
 
-- 
2.20.1

