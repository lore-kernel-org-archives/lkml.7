Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292F2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9762173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553866742;
	bh=98jJ9oNLxV9vvGTTeUcoU8GtKcSejZXOv18WUM0iyWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V349BvwwrGJSzBEZaridnv1yTAGzJdy8O+szef+IdYKIlqmpcD6jvDDbfmqzD2IPM
	 E1rCtFZ8RXFaKH8WliQUFZnZEzXZgCyzlia6zyOmAZES42W4eEM+5f6bs0zp3Stsal
	 6o+6U6UWVur6adgl9Oh6jfL2DNrIPXXKi9grgqfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfC2NjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbfC2Ni6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:38:58 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BAC421850;
        Fri, 29 Mar 2019 13:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553866737;
        bh=98jJ9oNLxV9vvGTTeUcoU8GtKcSejZXOv18WUM0iyWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+aWrF9rYIMCkEe13Tjb6GXKG4e47pi90Z6zGyi0iXkV9amxYkT6M3cDHH5pH7l5N
         U0OYCBiPsKA1Lop0N72xdtASdK6Xt8pkDYlCUY7kfSxcm5h1kM4nvNIXHELNuBw4vG
         IaLl+5y7ZztkMyyzTL0GFvqgNYTsawqH+tUabDvM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/13] perf pmu: Fix parser error for uncore event alias
Date:   Fri, 29 Mar 2019 10:38:01 -0300
Message-Id: <20190329133801.21004-14-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329133801.21004-1-acme@kernel.org>
References: <20190329133801.21004-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Perf fails to parse uncore event alias, for example:

  # perf stat -e unc_m_clockticks -a --no-merge sleep 1
  event syntax error: 'unc_m_clockticks'
                       \___ parser error

Current code assumes that the event alias is from one specific PMU.

To find the PMU, perf strcmps the PMU name of event alias with the real
PMU name on the system.

However, the uncore event alias may be from multiple PMUs with common
prefix. The PMU name of uncore event alias is the common prefix.

For example, UNC_M_CLOCKTICKS is clock event for iMC, which include 6
PMUs with the same prefix "uncore_imc" on a skylake server.

The real PMU names on the system for iMC are uncore_imc_0 ...
uncore_imc_5.

The strncmp is used to only check the common prefix for uncore event
alias.

With the patch:

  # perf stat -e unc_m_clockticks -a --no-merge sleep 1
  Performance counter stats for 'system wide':

       723,594,722      unc_m_clockticks [uncore_imc_5]
       724,001,954      unc_m_clockticks [uncore_imc_3]
       724,042,655      unc_m_clockticks [uncore_imc_1]
       724,161,001      unc_m_clockticks [uncore_imc_4]
       724,293,713      unc_m_clockticks [uncore_imc_2]
       724,340,901      unc_m_clockticks [uncore_imc_0]

       1.002090060 seconds time elapsed

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: ea1fa48c055f ("perf stat: Handle different PMU names with common prefix")
Link: http://lkml.kernel.org/r/1552672814-156173-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6199a3174ab9..e0429f4ef335 100644
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
2.20.1

