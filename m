Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DBFC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5BE21871
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dyW4TTd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfGCOiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:38:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49525 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCOix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:38:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63Ec3nM3328738
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:38:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63Ec3nM3328738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164684;
        bh=I46oCHmcCO7BXO5lKEn4b+H2hxPPPEE3/RqITB5Ln7I=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=dyW4TTd82m40BzT1en68TPfWQDPrZGWFZXhHivMcLPo74XxYs2aTsKZfKD8eJFnE2
         lmUyoIOSlgcxomowJNwpqwPiv8MGnOFt629P4bRib0sgvZ2Wr/jp/8ODXgXAqcw7xV
         3isw3maM0E+bgzD01uO5AWpNnTg7MpcpTMnagcS4RmJBWHJu/vqt2iyeBAgV8C/HIb
         CyPCBMBUcgFTHWu9DcyCGc9ee3C4G8HgDwXBi/DNfMi9RF+teLXNG9WPK6tLOQ1mKK
         mAkdQ2TqmBjaqfj6PiEKYgHUvOqjW7evX7I7uZk6yxS1QEBANUa7bYmqzTNYIwiGgz
         IyHa9HiPlOaQQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63Ec0Ao3328722;
        Wed, 3 Jul 2019 07:38:00 -0700
Date:   Wed, 3 Jul 2019 07:38:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for John Garry <tipbot@zytor.com>
Message-ID: <tip-730670b1d108c4a8aa1924762738ca38593ee44c@git.kernel.org>
Cc:     acme@redhat.com, peterz@infradead.org, mingo@kernel.org,
        tglx@linutronix.de, namhyung@kernel.org, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, will.deacon@arm.com, hpa@zytor.com,
        ak@linux.intel.com, john.garry@huawei.com, jolsa@kernel.org,
        zhangshaokun@hisilicon.com, mathieu.poirier@linaro.org,
        tmricht@linux.ibm.com, ben@decadent.org.uk,
        brueckner@linux.ibm.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com
Reply-To: alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
          ben@decadent.org.uk, brueckner@linux.ibm.com,
          tmricht@linux.ibm.com, zhangshaokun@hisilicon.com,
          jolsa@kernel.org, mathieu.poirier@linaro.org,
          will.deacon@arm.com, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, john.garry@huawei.com, hpa@zytor.com,
          kan.liang@linux.intel.com, namhyung@kernel.org, mingo@kernel.org,
          tglx@linutronix.de, acme@redhat.com, peterz@infradead.org
In-Reply-To: <1561732552-143038-2-git-send-email-john.garry@huawei.com>
References: <1561732552-143038-2-git-send-email-john.garry@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf pmu: Support more complex PMU event aliasing
Git-Commit-ID: 730670b1d108c4a8aa1924762738ca38593ee44c
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

Commit-ID:  730670b1d108c4a8aa1924762738ca38593ee44c
Gitweb:     https://git.kernel.org/tip/730670b1d108c4a8aa1924762738ca38593ee44c
Author:     John Garry <john.garry@huawei.com>
AuthorDate: Fri, 28 Jun 2019 22:35:49 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 2 Jul 2019 16:07:36 -0300

perf pmu: Support more complex PMU event aliasing

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
 tools/perf/util/pmu.c | 46 +++++++++++++++++++++++++++++++++++++++++-----
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
