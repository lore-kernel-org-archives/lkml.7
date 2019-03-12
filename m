Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C40C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DF9214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="iWX512ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfCLFba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:31:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36446 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727418AbfCLFbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:31:25 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2C5UKfw026757
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:31:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=t29XrZKDOQAoITz6zkok4xCE2MtGKySahIol7M2A6JM=;
 b=iWX512rusyNBQKmAzo1ar3BfetpxkX+Yca6z7WNFHokPjWv1sI4SmlYxLSiLhrtK4yE8
 XcdZuGd0+OjBWB1yS9Gqt6d5C2u0NpLGAFuz3NjwsrtJFpWtMgPNDSEaKve0MaY2FItm
 NRqZCp7yOG0Vt9vwzSH8HkQVLIFRjV7ocXk= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r64rs0986-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:31:24 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 11 Mar 2019 22:31:21 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id A9BCB62E2019; Mon, 11 Mar 2019 22:31:21 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v9 perf,bpf 13/15] perf, bpf: process PERF_BPF_EVENT_PROG_LOAD for annotation
Date:   Mon, 11 Mar 2019 22:30:49 -0700
Message-ID: <20190312053051.2690567-14-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190312053051.2690567-1-songliubraving@fb.com>
References: <20190312053051.2690567-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds processing of PERF_BPF_EVENT_PROG_LOAD, which sets proper
DSO type/id/etc of memory regions mapped to BPF programs to
DSO_BINARY_TYPE__BPF_PROG_INFO

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/bpf-event.c | 54 +++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index e02a38a98d8d..af434de3a23e 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -12,6 +12,7 @@
 #include "machine.h"
 #include "env.h"
 #include "session.h"
+#include "map.h"
 
 #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
 
@@ -25,12 +26,65 @@ static int snprintf_hex(char *buf, size_t size, unsigned char *data, size_t len)
 	return ret;
 }
 
+static int machine__process_bpf_event_load(struct machine *machine,
+					   union perf_event *event,
+					   struct perf_sample *sample __maybe_unused)
+{
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_info_node *info_node;
+	struct perf_env *env = machine->env;
+	int id = event->bpf_event.id;
+	unsigned int i;
+
+	/* perf-record, no need to handle bpf-event */
+	if (env == NULL)
+		return 0;
+
+	info_node = perf_env__find_bpf_prog_info(env, id);
+	if (!info_node)
+		return 0;
+	info_linear = info_node->info_linear;
+
+	for (i = 0; i < info_linear->info.nr_jited_ksyms; i++) {
+		u64 *addrs = (u64 *)(info_linear->info.jited_ksyms);
+		u64 addr = addrs[i];
+		struct map *map;
+
+		map = map_groups__find(&machine->kmaps, addr);
+
+		if (map) {
+			map->dso->binary_type = DSO_BINARY_TYPE__BPF_PROG_INFO;
+			map->dso->bpf_prog.id = id;
+			map->dso->bpf_prog.sub_id = i;
+			map->dso->bpf_prog.env = env;
+		}
+	}
+	return 0;
+}
+
 int machine__process_bpf_event(struct machine *machine __maybe_unused,
 			       union perf_event *event,
 			       struct perf_sample *sample __maybe_unused)
 {
 	if (dump_trace)
 		perf_event__fprintf_bpf_event(event, stdout);
+
+	switch (event->bpf_event.type) {
+	case PERF_BPF_EVENT_PROG_LOAD:
+		return machine__process_bpf_event_load(machine, event, sample);
+
+	case PERF_BPF_EVENT_PROG_UNLOAD:
+		/*
+		 * Do not free bpf_prog_info and btf of the program here,
+		 * as annotation still need them. They will be freed at
+		 * the end of the session.
+		 */
+		break;
+	default:
+		pr_debug("unexpected bpf_event type of %d\n",
+			 event->bpf_event.type);
+		break;
+	}
 	return 0;
 }
 
-- 
2.17.1

