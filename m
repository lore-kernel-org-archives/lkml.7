Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B27C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFEE21850
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279805;
	bh=q0Tqmh/fCwXi4c42KaDFqgN6OKEZyWWTOUYAyRrQPLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bUTEZdQPuMIUbEZF2rTCZLLyTFQoXLd7ofpCozWVF9NSgtRdvk16CfXSZgLwyB/yn
	 S/0dYWxzzc1e0Cb+EUd6g1WI/U0A5qr+zWNQHjhqq9PQcZ6tzS3OcLcDh69tFClA8S
	 WC2vQPoYHYqPypMjjhdQ9hUprPTLzECjYgnABkvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392529AbfFKTDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388229AbfFKTDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:03:23 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 414792183F;
        Tue, 11 Jun 2019 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279802;
        bh=q0Tqmh/fCwXi4c42KaDFqgN6OKEZyWWTOUYAyRrQPLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMRNbXyWS0Up7OUET9i1qtKc5mymLUB3/lFpOQCnezlkPJX2rh2keohFGv7Gc/OUH
         LZOm3v3fzrlIKKhgWszrD7Dk3691+VHbeVbrocaaPdYKrLLYyef8eRnwReik/ijXmI
         Hsiv+lXHzubApEWU9XB6L4owznuqCDcRNf7EAO5Q=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 54/85] perf cpumap: Retrieve die id information
Date:   Tue, 11 Jun 2019 15:58:40 -0300
Message-Id: <20190611185911.11645-55-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

There is no function to retrieve die id information of a given CPU.

Add cpu_map__get_die_id() to retrieve die id information.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1559688644-106558-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 7 +++++++
 tools/perf/util/cpumap.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 0b599229bc7e..7db1365c667e 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -373,6 +373,13 @@ int cpu_map__build_map(struct cpu_map *cpus, struct cpu_map **res,
 	return 0;
 }
 
+int cpu_map__get_die_id(int cpu)
+{
+	int value, ret = cpu__get_topology_int(cpu, "die_id", &value);
+
+	return ret ?: value;
+}
+
 int cpu_map__get_core_id(int cpu)
 {
 	int value, ret = cpu__get_topology_int(cpu, "core_id", &value);
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index f00ce624b9f7..6762ff9e7ad5 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -25,6 +25,7 @@ size_t cpu_map__snprint_mask(struct cpu_map *map, char *buf, size_t size);
 size_t cpu_map__fprintf(struct cpu_map *map, FILE *fp);
 int cpu_map__get_socket_id(int cpu);
 int cpu_map__get_socket(struct cpu_map *map, int idx, void *data);
+int cpu_map__get_die_id(int cpu);
 int cpu_map__get_core_id(int cpu);
 int cpu_map__get_core(struct cpu_map *map, int idx, void *data);
 int cpu_map__build_socket_map(struct cpu_map *cpus, struct cpu_map **sockp);
-- 
2.20.1

