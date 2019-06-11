Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2484C0650E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789D22183E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279736;
	bh=cDrzeJSkXqGaacGcyOg5AohAub8v5Pm5EBqkuiQbOi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vGBRwvy6PoJLovE/mJOSPNWOBQT8NxDLriFhq4T4tI7CNk2DU3WvcAajQ0GhM29D8
	 8bmHzbBoB1EVel0KeJ3199FFnlitfVMQ/111D0HzOhGs2vYnFUiTn8GOVW3vyWxGW1
	 zaCaCAZf2LJkNM3h6EzN9r1JlNNbIk28T169mAwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392361AbfFKTCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391901AbfFKTCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:02:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20AF12183F;
        Tue, 11 Jun 2019 19:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279733;
        bh=cDrzeJSkXqGaacGcyOg5AohAub8v5Pm5EBqkuiQbOi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m7gJ7Cux9lSXuM4wOzBZpNj0jKbOfAcQmw1T1l59P6NrhcHyxkWQ3fEnv6RneNrLF
         cdBwjHMOMtdEfU5TuzySss7YyCJmvODSTNY8yOSqU8dK6lxyDUXmS+wR5164OjqBS5
         pyJ8ldTZ370yyHq40xv2LMz9lwmv1oX7u41+79I0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 38/85] perf cs-etm: Configure timestamp generation in CPU-wide mode
Date:   Tue, 11 Jun 2019 15:58:24 -0300
Message-Id: <20190611185911.11645-39-acme@kernel.org>
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

When operating in CPU-wide mode tracers need to generate timestamps in
order to correlate the code being traced on one CPU with what is executed
on other CPUs.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-3-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 57 +++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 3912f0bf04ed..be1e4f20affa 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -99,6 +99,54 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
 	return err;
 }
 
+static int cs_etm_set_timestamp(struct auxtrace_record *itr,
+				struct perf_evsel *evsel, int cpu)
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
+	/* Get a handle on TRCIRD0 */
+	snprintf(path, PATH_MAX, "cpu%d/%s",
+		 cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
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
+	 * TRCIDR0.TSSIZE, bit [28-24], indicates whether global timestamping
+	 * is supported:
+	 *  0b00000 Global timestamping is not implemented
+	 *  0b00110 Implementation supports a maximum timestamp of 48bits.
+	 *  0b01000 Implementation supports a maximum timestamp of 64bits.
+	 */
+	val &= GENMASK(28, 24);
+	if (!val) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* All good, let the kernel know */
+	evsel->attr.config |= (1 << ETM_OPT_TS);
+	err = 0;
+
+out:
+	return err;
+}
+
 static int cs_etm_set_option(struct auxtrace_record *itr,
 			     struct perf_evsel *evsel, u32 option)
 {
@@ -118,6 +166,11 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
 			if (err)
 				goto out;
 			break;
+		case ETM_OPT_TS:
+			err = cs_etm_set_timestamp(itr, evsel, i);
+			if (err)
+				goto out;
+			break;
 		default:
 			goto out;
 		}
@@ -343,6 +396,10 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 		err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_CTXTID);
 		if (err)
 			goto out;
+
+		err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_TS);
+		if (err)
+			goto out;
 	}
 
 	/* Add dummy event to keep tracking */
-- 
2.20.1

