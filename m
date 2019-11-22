Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EDDC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5B42075B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434702;
	bh=h3/b2+yCd8ajUfmz3OE2zABAbKesYMSTMQLC9be4J6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NIZm9FvzPWPHlYPqcC3folz+OpyrKx8n0wysY4LijJw+wYJS1YDJgTzmdmDXf5Ixe
	 vQNTa5HF6F70dQspljzAOI6wthh+E8T5loADtPvlp0+dzurWFL7Tq3VyUpFoSUJfZC
	 QfJjwUj2NVcUZe/OaPb8Onx3X7zo0FPLAl/WMkcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfKVO6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:58:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbfKVO6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:58:20 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3524B2071F;
        Fri, 22 Nov 2019 14:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434699;
        bh=h3/b2+yCd8ajUfmz3OE2zABAbKesYMSTMQLC9be4J6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TfNRwVxmDpodpYkd2uQmoq4QYWiEApD15UGmiT+tmPqzocukH48UJOOZjsO8wJemT
         uCa3conOwZTlT1MNhY3AMjFA3F42/1kyTSp34gk9Wy0YYmhSMtamrTlDPqF9UDCWeF
         b0lBz6AJusDgFYr4xLBaKERKcM6fj33gmtW6OXmI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 22/26] perf intel-bts: Does not support AUX area sampling
Date:   Fri, 22 Nov 2019 11:57:07 -0300
Message-Id: <20191122145711.3171-23-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add an error message because Intel BTS does not support AUX area
sampling.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-16-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/auxtrace.c  | 2 ++
 tools/perf/arch/x86/util/intel-bts.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 092543cad324..7abc9fd4cbec 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -29,6 +29,8 @@ struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
 	if (intel_pt_pmu)
 		intel_pt_pmu->auxtrace = true;
 	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
+	if (intel_bts_pmu)
+		intel_bts_pmu->auxtrace = true;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (intel_pt_pmu && evsel->core.attr.type == intel_pt_pmu->type)
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index f7f68a50a5cd..27d9e214d068 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -113,6 +113,11 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 	const struct perf_cpu_map *cpus = evlist->core.cpus;
 	bool privileged = perf_event_paranoid_check(-1);
 
+	if (opts->auxtrace_sample_mode) {
+		pr_err("Intel BTS does not support AUX area sampling\n");
+		return -EINVAL;
+	}
+
 	btsr->evlist = evlist;
 	btsr->snapshot_mode = opts->auxtrace_snapshot_mode;
 
-- 
2.21.0

