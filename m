Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0130AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20832189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfH1GAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:00:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:22123 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfH1GAV (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:00:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 23:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="181924727"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga007.fm.intel.com with ESMTP; 27 Aug 2019 23:00:19 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 0/4] perf: Fix uncore metric issue
Date:   Wed, 28 Aug 2019 13:59:28 +0800
Message-Id: <20190828055932.8269-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some uncore metrics don't work as expected. For example, on cascadelakex,

root@lkp-csl-2sp2:~# perf stat -M UNC_M_PMM_BANDWIDTH.TOTAL -a -- sleep 1

 Performance counter stats for 'system wide':

           1841092      unc_m_pmm_rpq_inserts
           3680816      unc_m_pmm_wpq_inserts

       1.001775055 seconds time elapsed

root@lkp-csl-2sp2:~# perf stat -M UNC_M_PMM_READ_LATENCY -a -- sleep 1

 Performance counter stats for 'system wide':

         860649746      unc_m_pmm_rpq_occupancy.all
           1840557      unc_m_pmm_rpq_inserts
       12790627455      unc_m_clockticks

       1.001773348 seconds time elapsed

No metrics 'UNC_M_PMM_BANDWIDTH.TOTAL' or 'UNC_M_PMM_READ_LATENCY' are
reported.

The issue is, the case of an alias expanding to mulitple events is
not supported, typically the uncore events.
(see comments in find_evsel_group()). For detail, please check the
description in patch 'perf util: Support multiple events for metricgroup'.

With this patch set,

root@lkp-csl-2sp2:~# perf stat -M UNC_M_PMM_BANDWIDTH.TOTAL -a -- sleep 1

 Performance counter stats for 'system wide':

           1842108      unc_m_pmm_rpq_inserts     #    337.2 MB/sec  UNC_M_PMM_BANDWIDTH.TOTAL
           3682209      unc_m_pmm_wpq_inserts

       1.001819706 seconds time elapsed

root@lkp-csl-2sp2:~# perf stat -M UNC_M_PMM_READ_LATENCY -a -- sleep 1

 Performance counter stats for 'system wide':

         861970685      unc_m_pmm_rpq_occupancy.all #    219.4 ns  UNC_M_PMM_READ_LATENCY
           1842772      unc_m_pmm_rpq_inserts
       12790196356      unc_m_clockticks

       1.001749103 seconds time elapsed

Now we can see the correct metrics 'UNC_M_PMM_BANDWIDTH.TOTAL' and
'UNC_M_PMM_READ_LATENCY'.

Haiyan Song (1):
  perf vendor events intel: Update cascadelakex uncore events to v1.04

Jin Yao (3):
  perf util: Change convert_scale from static to global
  perf util: Scale the metric result
  perf util: Support multiple events for metricgroup

 .../arch/x86/cascadelakex/uncore-memory.json  |  191 ++
 .../arch/x86/cascadelakex/uncore-other.json   | 1809 ++++++++++++++++-
 tools/perf/util/evsel.h                       |    1 +
 tools/perf/util/metricgroup.c                 |   87 +-
 tools/perf/util/metricgroup.h                 |    1 +
 tools/perf/util/pmu.c                         |    6 +-
 tools/perf/util/pmu.h                         |    2 +
 tools/perf/util/stat-shadow.c                 |   65 +-
 8 files changed, 2075 insertions(+), 87 deletions(-)

-- 
2.17.1

