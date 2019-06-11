Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92752C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B5D2184E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279732;
	bh=WV8RbOS6lQTQntZS0EPqrmva7AHoKfiOwZcciJD8N+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xW8K71BhvPMAjoBT5hD0H8gsvXLvIAE/KvnMKgLRs6XejySO+GbGiSndUcEdMHM3J
	 48/If+tz36K+ojnWUEI36kp/pnFCKGFTcip+p56UsEQ7jVIxm1vjPpB6BENEi7/0vu
	 Ilbp7Lo1mnX67pNzLDj7uE081JzNr3e97dW4jjoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392351AbfFKTCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391901AbfFKTCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:02:10 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FF7421841;
        Tue, 11 Jun 2019 19:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279729;
        bh=WV8RbOS6lQTQntZS0EPqrmva7AHoKfiOwZcciJD8N+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y55pUGQG0lsfPmIkGvGhab81nrkgQRjEX9JWBvKznZQ66SaQoJJisSTvkFDIa0N3n
         +3E9YixzQspiFhWVtO5SE+1icNS4t3UNZqfkW5tDInVxSj3pR8+FZIZV69RMG7Wg3n
         gCxErI0v3lb6E00r2tjk4NJofOIAvyV6Qo0e7OSI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 37/85] perf cs-etm: Configure contextID tracing in CPU-wide mode
Date:   Tue, 11 Jun 2019 15:58:23 -0300
Message-Id: <20190611185911.11645-38-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

When operating in CPU-wide mode being notified of contextID changes is
required so that the decoding mechanic is aware of the process context
switch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki Poulouse <suzuki.poulose@arm.com>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-2-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 126 +++++++++++++++++++++++++-----
 tools/perf/util/cs-etm.h          |  12 +++
 2 files changed, 119 insertions(+), 19 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 911426721170..3912f0bf04ed 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -35,8 +35,100 @@ struct cs_etm_recording {
 	size_t			snapshot_size;
 };
 
+static const char *metadata_etmv3_ro[CS_ETM_PRIV_MAX] = {
+	[CS_ETM_ETMCCER]	= "mgmt/etmccer",
+	[CS_ETM_ETMIDR]		= "mgmt/etmidr",
+};
+
+static const char *metadata_etmv4_ro[CS_ETMV4_PRIV_MAX] = {
+	[CS_ETMV4_TRCIDR0]		= "trcidr/trcidr0",
+	[CS_ETMV4_TRCIDR1]		= "trcidr/trcidr1",
+	[CS_ETMV4_TRCIDR2]		= "trcidr/trcidr2",
+	[CS_ETMV4_TRCIDR8]		= "trcidr/trcidr8",
+	[CS_ETMV4_TRCAUTHSTATUS]	= "mgmt/trcauthstatus",
+};
+
 static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
 
+static int cs_etm_set_context_id(struct auxtrace_record *itr,
+				 struct perf_evsel *evsel, int cpu)
+{
+	struct cs_etm_recording *ptr;
+	struct perf_pmu *cs_etm_pmu;
+	char path[PATH_MAX];
+	int err = -EINVAL;
+	u32 val;
+
+	ptr = container_of(itr, struct cs_etm_recording, itr);
+	cs_etm_pmu = ptr->cs_etm_pmu;
+
+	if (!cs_etm_is_etmv4(itr, cpu))
+		goto out;
+
+	/* Get a handle on TRCIRD2 */
+	snprintf(path, PATH_MAX, "cpu%d/%s",
+		 cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR2]);
+	err = perf_pmu__scan_file(cs_etm_pmu, path, "%x", &val);
+
+	/* There was a problem reading the file, bailing out */
+	if (err != 1) {
+		pr_err("%s: can't read file %s\n",
+		       CORESIGHT_ETM_PMU_NAME, path);
+		goto out;
+	}
+
+	/*
+	 * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID tracing
+	 * is supported:
+	 *  0b00000 Context ID tracing is not supported.
+	 *  0b00100 Maximum of 32-bit Context ID size.
+	 *  All other values are reserved.
+	 */
+	val = BMVAL(val, 5, 9);
+	if (!val || val != 0x4) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* All good, let the kernel know */
+	evsel->attr.config |= (1 << ETM_OPT_CTXTID);
+	err = 0;
+
+out:
+
+	return err;
+}
+
+static int cs_etm_set_option(struct auxtrace_record *itr,
+			     struct perf_evsel *evsel, u32 option)
+{
+	int i, err = -EINVAL;
+	struct cpu_map *event_cpus = evsel->evlist->cpus;
+	struct cpu_map *online_cpus = cpu_map__new(NULL);
+
+	/* Set option of each CPU we have */
+	for (i = 0; i < cpu__max_cpu(); i++) {
+		if (!cpu_map__has(event_cpus, i) ||
+		    !cpu_map__has(online_cpus, i))
+			continue;
+
+		switch (option) {
+		case ETM_OPT_CTXTID:
+			err = cs_etm_set_context_id(itr, evsel, i);
+			if (err)
+				goto out;
+			break;
+		default:
+			goto out;
+		}
+	}
+
+	err = 0;
+out:
+	cpu_map__put(online_cpus);
+	return err;
+}
+
 static int cs_etm_parse_snapshot_options(struct auxtrace_record *itr,
 					 struct record_opts *opts,
 					 const char *str)
@@ -105,8 +197,9 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 				container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 	struct perf_evsel *evsel, *cs_etm_evsel = NULL;
-	const struct cpu_map *cpus = evlist->cpus;
+	struct cpu_map *cpus = evlist->cpus;
 	bool privileged = (geteuid() == 0 || perf_event_paranoid() < 0);
+	int err = 0;
 
 	ptr->evlist = evlist;
 	ptr->snapshot_mode = opts->auxtrace_snapshot_mode;
@@ -241,19 +334,24 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 
 	/*
 	 * In the case of per-cpu mmaps, we need the CPU on the
-	 * AUX event.
+	 * AUX event.  We also need the contextID in order to be notified
+	 * when a context switch happened.
 	 */
-	if (!cpu_map__empty(cpus))
+	if (!cpu_map__empty(cpus)) {
 		perf_evsel__set_sample_bit(cs_etm_evsel, CPU);
 
+		err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_CTXTID);
+		if (err)
+			goto out;
+	}
+
 	/* Add dummy event to keep tracking */
 	if (opts->full_auxtrace) {
 		struct perf_evsel *tracking_evsel;
-		int err;
 
 		err = parse_events(evlist, "dummy:u", NULL);
 		if (err)
-			return err;
+			goto out;
 
 		tracking_evsel = perf_evlist__last(evlist);
 		perf_evlist__set_tracking_event(evlist, tracking_evsel);
@@ -266,7 +364,8 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 			perf_evsel__set_sample_bit(tracking_evsel, TIME);
 	}
 
-	return 0;
+out:
+	return err;
 }
 
 static u64 cs_etm_get_config(struct auxtrace_record *itr)
@@ -314,6 +413,8 @@ static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
 	config_opts = cs_etm_get_config(itr);
 	if (config_opts & BIT(ETM_OPT_CYCACC))
 		config |= BIT(ETM4_CFG_BIT_CYCACC);
+	if (config_opts & BIT(ETM_OPT_CTXTID))
+		config |= BIT(ETM4_CFG_BIT_CTXTID);
 	if (config_opts & BIT(ETM_OPT_TS))
 		config |= BIT(ETM4_CFG_BIT_TS);
 	if (config_opts & BIT(ETM_OPT_RETSTK))
@@ -363,19 +464,6 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 	       (etmv3 * CS_ETMV3_PRIV_SIZE));
 }
 
-static const char *metadata_etmv3_ro[CS_ETM_PRIV_MAX] = {
-	[CS_ETM_ETMCCER]	= "mgmt/etmccer",
-	[CS_ETM_ETMIDR]		= "mgmt/etmidr",
-};
-
-static const char *metadata_etmv4_ro[CS_ETMV4_PRIV_MAX] = {
-	[CS_ETMV4_TRCIDR0]		= "trcidr/trcidr0",
-	[CS_ETMV4_TRCIDR1]		= "trcidr/trcidr1",
-	[CS_ETMV4_TRCIDR2]		= "trcidr/trcidr2",
-	[CS_ETMV4_TRCIDR8]		= "trcidr/trcidr8",
-	[CS_ETMV4_TRCAUTHSTATUS]	= "mgmt/trcauthstatus",
-};
-
 static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu)
 {
 	bool ret = false;
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 0e97c196147a..826c9eedaf5c 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -103,6 +103,18 @@ struct intlist *traceid_list;
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
 
+/*
+ * Create a contiguous bitmask starting at bit position @l and ending at
+ * position @h. For example
+ * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
+ *
+ * Carbon copy of implementation found in $KERNEL/include/linux/bitops.h
+ */
+#define GENMASK(h, l) \
+	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+
+#define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
+
 #define CS_ETM_HEADER_SIZE (CS_HEADER_VERSION_0_MAX * sizeof(u64))
 
 #define __perf_cs_etmv3_magic 0x3030303030303030ULL
-- 
2.20.1

