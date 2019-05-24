Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E94C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9384021848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXkWbZ+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391408AbfEXRfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:35:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37152 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391077AbfEXRfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id n27so5419348pgm.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BWB6eRLRrW09Jmtj58um2VDPR3CNKPhCszqXJSm+Dmk=;
        b=GXkWbZ+NheHeIFUhuT8VcOsE4YVdLMSJOeDxOcX/3Ice4/hwLnosQ83zB3nGKQ04PK
         r/4puoli9IPCcOGB/jAn5Hx6r70r4Uxq3yEfo40yDl2RA5ODFCn7LSguzdWj2Xd6+bti
         WVRYeNouLoscxEnn59araoOtd7pCqO9Xy2gWz/v3aW5snziNw0MDhBWzkiStYm9WKKYz
         PPGs+PPQR5+91CpI0g/R/fV/hph9ZSm/0zsQJ6+zgGW+bn9QBcLAAhOOR+QMJZN+Vyj5
         h7smvSeZA3vGn2IqVeZR0kKnIPrZhDjvlziOWS376JpurSiD/W2ZnKSI81p4DhwOZ/K/
         LP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BWB6eRLRrW09Jmtj58um2VDPR3CNKPhCszqXJSm+Dmk=;
        b=rSXCVpb/uNGZSaSyePh6m+suOJ9KLYX0eKKVpKddMh/vBaCbdJGE0+ifBS4m4n0BMA
         VucpbeRxnsXXXmAatyNi17mjzNovuzJFUx0eAS56m/ozJpK97szghyyi+cfN4jWGO3Zi
         CkhEjlgfNTim4WmngLIXJAv7KbFo4k9WXnMILcthv7e734FMVjNvEOv/A1wtXrYe+LnT
         YXBiNTEZ2rrW93ThkMOQ3ifFZBXg7xPdh9zw7UXUdaJ0a5qhJpq6uTtn5cuZqDpZ9wcn
         /fy6FZcXLDngm5dVkeE9Qyys7PnkFwTLee34QB7YkSvF09WL8NIfZkx6Cbh1FbWzYLHy
         MqSg==
X-Gm-Message-State: APjAAAXwB7t78QdPBHhClt+Eo2Id2VQfxJnnLnJsFMsL0NeU2iW/f4Of
        s7pKTSXmfeupW2EfiX7tC/4M0w==
X-Google-Smtp-Source: APXvYqxjyfN7L6TA4km5mRvqFh/gQ8/MLel8McEBWjeohNAtIknRUOGc03T/d0WWYPPByIoZihh03Q==
X-Received: by 2002:a17:90a:650c:: with SMTP id i12mr10978396pjj.44.1558719311167;
        Fri, 24 May 2019 10:35:11 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k13sm2809575pgr.90.2019.05.24.10.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:35:10 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, suzuki.poulose@arm.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: [PATCH v2 01/17] perf tools: Configure contextID tracing in CPU-wide mode
Date:   Fri, 24 May 2019 11:34:52 -0600
Message-Id: <20190524173508.29044-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524173508.29044-1-mathieu.poirier@linaro.org>
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When operating in CPU-wide mode being notified of contextID changes is
required so that the decoding mechanic is aware of the process context
switch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
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
2.17.1

