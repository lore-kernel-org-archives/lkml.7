Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46087C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A87F2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfCOSBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:01:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:19141 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbfCOSBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:01:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 11:01:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,483,1544515200"; 
   d="scan'208";a="142392681"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga002.jf.intel.com with ESMTP; 15 Mar 2019 11:01:47 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH] perf pmu: Fix parser error for uncore event alias
Date:   Fri, 15 Mar 2019 11:00:14 -0700
Message-Id: <1552672814-156173-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Perf fails to parse uncore event alias, for example:

  #perf stat -e unc_m_clockticks -a --no-merge sleep 1
  event syntax error: 'unc_m_clockticks'
                       \___ parser error

Current code assumes that the event alias is from one specific PMU.
To find the PMU, perf strcmp the pmu name of event alias with the
real pmu name on the system.
However, the uncore event alias may be from multiple PMUs with common
prefix. The pmu name of uncore event alias is the common prefix.
For example, UNC_M_CLOCKTICKS is clock event for iMC, which include
6 PMUs with the same prefix "uncore_imc" on a skylake server.
The real pmu names on the system for iMC are uncore_imc_0 ...
uncore_imc_5.
The strncmp is used to only check the common prefix for uncore
event alias.

With the patch,
  #perf stat -e unc_m_clockticks -a --no-merge sleep 1
  Performance counter stats for 'system wide':

       723,594,722      unc_m_clockticks [uncore_imc_5]
       724,001,954      unc_m_clockticks [uncore_imc_3]
       724,042,655      unc_m_clockticks [uncore_imc_1]
       724,161,001      unc_m_clockticks [uncore_imc_4]
       724,293,713      unc_m_clockticks [uncore_imc_2]
       724,340,901      unc_m_clockticks [uncore_imc_0]

       1.002090060 seconds time elapsed

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: ea1fa48c055f ("perf stat: Handle different PMU names with common prefix")
---
 tools/perf/util/pmu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 51d437f..395308f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -732,10 +732,20 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 
 		if (!is_arm_pmu_core(name)) {
 			pname = pe->pmu ? pe->pmu : "cpu";
+
+			/*
+			 * uncore alias may be from different PMU
+			 * with common prefix
+			 */
+			if (pmu_is_uncore(name) &&
+			    !strncmp(pname, name, strlen(pname)))
+				goto new_alias;
+
 			if (strcmp(pname, name))
 				continue;
 		}
 
+new_alias:
 		/* need type casts to override 'const' */
 		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
 				(char *)pe->desc, (char *)pe->event,
-- 
2.7.4

