Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C49C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97442085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ilOL9vYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfFQTcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:32:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56847 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbfFQTcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:32:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJW2Xw3564783
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:32:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJW2Xw3564783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799922;
        bh=wxL7jpLY4uI94mdWoZ/mpY2o15arvjmRjp0NPR1C5sY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ilOL9vYg8xC5u4cqvq2FxBSp7aN4lOG7GZWH85qhLZ1K12g1IYQ/+/G0H35VEZXPI
         N6+nXaHkuNReq1FT9iPEQxBh5pya4Ir0mbjNSw3GMOblNl0ZAEaXu7VUl/BD+aRUXD
         KRVlCGHk+GXUlNu9o8IE9gt7MSCF5JpSzjnQV1RqhVnLIGACArI/nokrjsAeVv/N/h
         Flk1eQTQPvpvDI4w2GPPOiv75wuo/rjmKdRF0VeZmGOPH2ZkRfw/Uwe48oMLJadiB9
         Y7qWuHMihiMXPT4z+2y6GMuVOihau19Rv+5k39tZkqYuiHZMDc0hqRUVkKuzxQZfqg
         4hpqZ26Z7026g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJW2BI3564780;
        Mon, 17 Jun 2019 12:32:02 -0700
Date:   Mon, 17 Jun 2019 12:32:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-b74d8686a18b36adecc710597198d5ef2dd5ef14@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de, jolsa@kernel.org, acme@redhat.com,
        peterz@infradead.org, ak@linux.intel.com, kan.liang@linux.intel.com
Reply-To: peterz@infradead.org, kan.liang@linux.intel.com,
          ak@linux.intel.com, acme@redhat.com, hpa@zytor.com,
          jolsa@kernel.org, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <1559688644-106558-1-git-send-email-kan.liang@linux.intel.com>
References: <1559688644-106558-1-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cpumap: Retrieve die id information
Git-Commit-ID: b74d8686a18b36adecc710597198d5ef2dd5ef14
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

Commit-ID:  b74d8686a18b36adecc710597198d5ef2dd5ef14
Gitweb:     https://git.kernel.org/tip/b74d8686a18b36adecc710597198d5ef2dd5ef14
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 4 Jun 2019 15:50:40 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:50:02 -0300

perf cpumap: Retrieve die id information

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
