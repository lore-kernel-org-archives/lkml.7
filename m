Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6E3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C177218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbfC2Uo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:44:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57727 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730157AbfC2Uo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:44:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2TKhIuE3938940
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 13:43:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2TKhI7k3938932;
        Fri, 29 Mar 2019 13:43:18 -0700
Date:   Fri, 29 Mar 2019 13:43:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-e94d6b7f615e6dfbaf9fba7db6011db561461d0c@git.kernel.org>
Cc:     hpa@zytor.com, kan.liang@linux.intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, jolsa@kernel.org,
        tglx@linutronix.de, tmricht@linux.ibm.com, mingo@kernel.org
Reply-To: mingo@kernel.org, tmricht@linux.ibm.com, tglx@linutronix.de,
          ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com,
          acme@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <1552672814-156173-1-git-send-email-kan.liang@linux.intel.com>
References: <1552672814-156173-1-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf pmu: Fix parser error for uncore event alias
Git-Commit-ID: e94d6b7f615e6dfbaf9fba7db6011db561461d0c
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

Commit-ID:  e94d6b7f615e6dfbaf9fba7db6011db561461d0c
Gitweb:     https://git.kernel.org/tip/e94d6b7f615e6dfbaf9fba7db6011db561461d0c
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Fri, 15 Mar 2019 11:00:14 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 28 Mar 2019 15:53:27 -0300

perf pmu: Fix parser error for uncore event alias

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
