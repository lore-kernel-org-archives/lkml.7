Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC66BC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AA92054F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562124514;
	bh=E5HWvXZgTeSKHxIKhqZ/E3l3wGCI1IPSGpHB2y/QAV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m7MtSn9r3n8ag6FUmg/x+FLJQs4JoLzAGEySq3COKrX3+hqZOzUogppCM1hhMbGtQ
	 ZHsfXdw6ydF2xLrvJ8kC04ZISU1YJtCsnU1okXaKPFunXX4gr5Jy+nnoNwGz5hr04t
	 dktxBiUmyfvvHYFmyr+17Q/AeuqDAO1fT+kmISyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfGCD2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727373AbfGCD2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:28:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BD4621850;
        Wed,  3 Jul 2019 03:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562124511;
        bh=E5HWvXZgTeSKHxIKhqZ/E3l3wGCI1IPSGpHB2y/QAV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WoJa7Iru2ljQE3R5Dx237lQe4g8tSPMFcFlQpuAmUygJ1ue3RnuBbQc4o5HoVJX+L
         SOihDqDB/DX22YgJFZO3OjPBav1B6kphrS6Tmaf5InsVmiyXN+CbnMtAKqhlKFeGvs
         KvG8grMKIJlw59KW4m6NXwhHJKdboRhAq9d3j3Y8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/18] perf pmu: Support more complex PMU event aliasing
Date:   Wed,  3 Jul 2019 00:27:37 -0300
Message-Id: <20190703032746.21692-10-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
References: <20190703032746.21692-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

The jevent "Unit" field is used for uncore PMU alias definition.

The form uncore_pmu_example_X is supported, where "X" is a wildcard, to
support multiple instances of the same PMU in a system.

Unfortunately this format not suitable for all uncore PMUs; take the
Hisi DDRC uncore PMU for example, where the name is in the form
hisi_scclX_ddrcY.

For for current jevent parsing, we would be required to hardcode an
uncore alias translation for each possible value of X. This is not
scalable.

Instead, add support for "Unit" field in the form "hisi_sccl,ddrc",
where we can match by hisi_scclX and ddrcY. Tokens  in Unit field are
delimited by ','.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Link: http://lkml.kernel.org/r/1561732552-143038-2-git-send-email-john.garry@huawei.com
[ Shut up older gcc complianing about the last arg to strtok_r() being uninitialized, set that tmp to NULL ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 46 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8139a1f3ed39..55f4de6442e3 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -701,6 +701,46 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
 	return map;
 }
 
+static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
+{
+	char *tmp = NULL, *tok, *str;
+	bool res;
+
+	str = strdup(pmu_name);
+	if (!str)
+		return false;
+
+	/*
+	 * uncore alias may be from different PMU with common prefix
+	 */
+	tok = strtok_r(str, ",", &tmp);
+	if (strncmp(pmu_name, tok, strlen(tok))) {
+		res = false;
+		goto out;
+	}
+
+	/*
+	 * Match more complex aliases where the alias name is a comma-delimited
+	 * list of tokens, orderly contained in the matching PMU name.
+	 *
+	 * Example: For alias "socket,pmuname" and PMU "socketX_pmunameY", we
+	 *	    match "socket" in "socketX_pmunameY" and then "pmuname" in
+	 *	    "pmunameY".
+	 */
+	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
+		name = strstr(name, tok);
+		if (!name) {
+			res = false;
+			goto out;
+		}
+	}
+
+	res = true;
+out:
+	free(str);
+	return res;
+}
+
 /*
  * From the pmu_events_map, find the table of PMU events that corresponds
  * to the current running CPU. Then, add all PMU events from that table
@@ -731,12 +771,8 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 			break;
 		}
 
-		/*
-		 * uncore alias may be from different PMU
-		 * with common prefix
-		 */
 		if (pmu_is_uncore(name) &&
-		    !strncmp(pname, name, strlen(pname)))
+		    pmu_uncore_alias_match(pname, name))
 			goto new_alias;
 
 		if (strcmp(pname, name))
-- 
2.20.1

