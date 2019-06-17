Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A1EC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460202085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cQzPiUM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfFQTUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:20:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51051 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFQTUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:20:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJKBQo3560384
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:20:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJKBQo3560384
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799212;
        bh=/lZecDiBchJ3TJH73LYnG20o+Xg127Ffr40i4aA6qxo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cQzPiUM12Vap6UtS4FIbSqkSvJLRli5nIJw+1LtWHRvQRXSzuyMHLTrEq7bHoFcl5
         dpW26B41sXXHS22EymlqL6yB7j3I5j4H1zX/KHzZ2Ku/I7vSop/ea7PxkNRZpXJZp8
         w8mbQYD52LlaFkXOJ6MELGI66qCBxbh3PjjDKYghistO4+x2PgaxjS+0/IWYngK209
         dwxhuw9YFYQK7dofgLTzkmJ8e/3X6s+1i+6KOeDok2JOkKGXHhGv21sI1uGwQ/zZo7
         KQIIkjMGWP5n0MzDEVCy6WVKiqvmvPAoEt3W2GmGDz3Pn4hZapJHVLYQRYsuqxcTwd
         knWRH2sM9Angg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJKBIG3560381;
        Mon, 17 Jun 2019 12:20:11 -0700
Date:   Mon, 17 Jun 2019 12:20:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-3399ad9ac234364396f75531203c38be5d2872c7@git.kernel.org>
Cc:     namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        acme@redhat.com, tglx@linutronix.de, mathieu.poirier@linaro.org,
        hpa@zytor.com, suzuki.poulose@arm.com, jolsa@redhat.com,
        peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, leo.yan@linaro.org,
          namhyung@kernel.org, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, mathieu.poirier@linaro.org, hpa@zytor.com,
          jolsa@redhat.com, suzuki.poulose@arm.com, mingo@kernel.org,
          acme@redhat.com, tglx@linutronix.de
In-Reply-To: <20190524173508.29044-2-mathieu.poirier@linaro.org>
References: <20190524173508.29044-2-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Configure contextID tracing in
 CPU-wide mode
Git-Commit-ID: 3399ad9ac234364396f75531203c38be5d2872c7
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

Commit-ID:  3399ad9ac234364396f75531203c38be5d2872c7
Gitweb:     https://git.kernel.org/tip/3399ad9ac234364396f75531203c38be5d2872c7
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Fri, 24 May 2019 11:34:52 -0600
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:50:01 -0300

perf cs-etm: Configure contextID tracing in CPU-wide mode

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
 tools/perf/arch/arm/util/cs-etm.c | 126 ++++++++++++++++++++++++++++++++------
 tools/perf/util/cs-etm.h          |  12 ++++
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
