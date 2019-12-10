Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7534C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CB2206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013774;
	bh=L+2oSyzaNEcB9ZSY6dtN10o48H5PiwT/LfhvlXc+kwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WgCM71j/VJH/Y3IERQZRidz5o4w/E7ntjwKIwfKxu06w0MxwjbqlK0PTizKZBeX5f
	 P5SFmUGWx3ump690Uen0BYuaJxCZkEVfVOPenLNnw4ZWv8ZhQzEv25FnIz0hYITAfl
	 Zek4Wiivqm3aAb+4fLC1u4S3lPjgPwu0sR6D0oD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbfLJVgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:36:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729872AbfLJVf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:35:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63D09207FF;
        Tue, 10 Dec 2019 21:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013756;
        bh=L+2oSyzaNEcB9ZSY6dtN10o48H5PiwT/LfhvlXc+kwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvbAInExnKOX9Dcntaxj3wLzsRuINw6bqSOi3feBxO/Lop+g4F3bE27pMMC6p3Oet
         uZ8sIdXWMgYzo0dkFLELo5+30PBL+hhV5kskHddYkAsCehjzzJpxGN7AT5l+MD3FRz
         Y2LDWsST6NjJeAMJLDbi3B69Q1/FIdqkQ1ydrETE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 176/177] perf intel-bts: Does not support AUX area sampling
Date:   Tue, 10 Dec 2019 16:32:20 -0500
Message-Id: <20191210213221.11921-176-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 32a1ece4bdbde24734ab16484bad7316f03fc42d ]

Add an error message because Intel BTS does not support AUX area
sampling.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-16-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/arch/x86/util/auxtrace.c  | 2 ++
 tools/perf/arch/x86/util/intel-bts.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index b135af62011ce..c28b6516d41d9 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -36,6 +36,8 @@ struct auxtrace_record *auxtrace_record__init_intel(struct perf_evlist *evlist,
 
 	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
 	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
+	if (intel_bts_pmu)
+		intel_bts_pmu->auxtrace = true;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (intel_pt_pmu && evsel->attr.type == intel_pt_pmu->type)
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 781df40b29660..b6120ef8b4a45 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -118,6 +118,11 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 	const struct cpu_map *cpus = evlist->cpus;
 	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
 
+	if (opts->auxtrace_sample_mode) {
+		pr_err("Intel BTS does not support AUX area sampling\n");
+		return -EINVAL;
+	}
+
 	btsr->evlist = evlist;
 	btsr->snapshot_mode = opts->auxtrace_snapshot_mode;
 
-- 
2.20.1

