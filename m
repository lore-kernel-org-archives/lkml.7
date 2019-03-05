Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499DFC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E6020848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551799554;
	bh=5Yakl3TE5tbIDaojmMNWxzalNsCiM8L9NpwJ5iZSm1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h+j0t8maNXM1AZrmC6XlGCm1wyqBR3OagVDVeRPEQKlCI5gnX+c/5tyylsWK1HnV5
	 6gOfWgtJh/cD3jboLu1CLPOt9beq2dUKBVWXotP6t576on/V0lysGep6xWt0qL1Kix
	 t3e41WIpRYWrYmfrvuOr6CMXu8z1Ciyodcamla7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfCEPZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:25:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728796AbfCEPZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:25:50 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F357CC057F44;
        Tue,  5 Mar 2019 15:25:49 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2A171001E67;
        Tue,  5 Mar 2019 15:25:47 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 4/8] perf tools: Read and store caps/max_precise in perf_pmu
Date:   Tue,  5 Mar 2019 16:25:32 +0100
Message-Id: <20190305152536.21035-5-jolsa@kernel.org>
In-Reply-To: <20190305152536.21035-1-jolsa@kernel.org>
References: <20190305152536.21035-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 05 Mar 2019 15:25:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the caps/max_precise value and store it in struct
perf_pmu to be used when setting the maximum precise_ip
field in following patch.

Link: http://lkml.kernel.org/n/tip-y47h37fzs5t8hy9t0j5g9pyj@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/pmu.c | 14 ++++++++++++++
 tools/perf/util/pmu.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 51d437f55d18..6199a3174ab9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -752,6 +752,19 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 	return NULL;
 }
 
+static int pmu_max_precise(const char *name)
+{
+	char path[PATH_MAX];
+	int max_precise = -1;
+
+	scnprintf(path, PATH_MAX,
+		 "bus/event_source/devices/%s/caps/max_precise",
+		 name);
+
+	sysfs__read_int(path, &max_precise);
+	return max_precise;
+}
+
 static struct perf_pmu *pmu_lookup(const char *name)
 {
 	struct perf_pmu *pmu;
@@ -784,6 +797,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	pmu->name = strdup(name);
 	pmu->type = type;
 	pmu->is_uncore = pmu_is_uncore(name);
+	pmu->max_precise = pmu_max_precise(name);
 	pmu_add_cpu_aliases(&aliases, pmu);
 
 	INIT_LIST_HEAD(&pmu->format);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 47253c3daf55..bd9ec2704a57 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -26,6 +26,7 @@ struct perf_pmu {
 	__u32 type;
 	bool selectable;
 	bool is_uncore;
+	int max_precise;
 	struct perf_event_attr *default_config;
 	struct cpu_map *cpus;
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
-- 
2.17.2

