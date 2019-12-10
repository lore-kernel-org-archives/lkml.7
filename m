Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D8CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE6820637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576015567;
	bh=TSX3u8TuvDwvGrRmuwlb2kWpRf+r/9FlI1r7X6gDfcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jvOx6c8lowIiTLeqbSiDlymn8M6skQvI8yfMCidhCuMIgxYR2jhy6m3Xmw4H1gDaO
	 gez1c8UsB9XY/KzL9+JTdPhSnt3dRrlq1xVW+gYlL7xlV3x+ONQBPjDc0jjW+13uFI
	 1mE8gDxlNCWzjoQgkxBdPoyDwNSlUZ9ZTddSHeGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfLJWGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:06:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbfLJWFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:05:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A63E208C3;
        Tue, 10 Dec 2019 22:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576015535;
        bh=TSX3u8TuvDwvGrRmuwlb2kWpRf+r/9FlI1r7X6gDfcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hm13MZiSZcSdOWRVHLRRiYQqOfvPV5Wz4Ufv6ZhLAquekrmLyyjOTz8/47lDrujiR
         MUGPI3aGqPlJ0y4yWTN0Gl9HdVY249i3lW5qXZ0v8TPaB2Nq1xSkTM6eYQYttLjBA6
         MNSHiPnnysxLhzRyLbofDhMRs0AdVBKVTPFGt1lo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 129/130] perf intel-bts: Does not support AUX area sampling
Date:   Tue, 10 Dec 2019 17:03:00 -0500
Message-Id: <20191210220301.13262-129-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210220301.13262-1-sashal@kernel.org>
References: <20191210220301.13262-1-sashal@kernel.org>
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
index 6aa3f2a38321e..98db6f5ca08ba 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -36,6 +36,8 @@ struct auxtrace_record *auxtrace_record__init_intel(struct perf_evlist *evlist,
 
 	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
 	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
+	if (intel_bts_pmu)
+		intel_bts_pmu->auxtrace = true;
 
 	if (evlist) {
 		evlist__for_each_entry(evlist, evsel) {
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

