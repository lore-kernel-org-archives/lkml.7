Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40CBC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04482075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfECIzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:55:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:31447 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfECIzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:55:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:55:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="321087560"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 03 May 2019 01:55:45 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 2/2] perf, pt: Remove software double buffering PMU capability
Date:   Fri,  3 May 2019 11:55:36 +0300
Message-Id: <20190503085536.24119-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503085536.24119-1-alexander.shishkin@linux.intel.com>
References: <20190503085536.24119-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all AUX allocations are high-order by default, the software
double buffering PMU capability doesn't make sense any more, get rid
of it. In case some PMUs choose to opt out, we can re-introduce it.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/intel/pt.c | 3 +--
 include/linux/perf_event.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index fb3a2f13fc70..339d7628080c 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1525,8 +1525,7 @@ static __init int pt_init(void)
 	}
 
 	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
-		pt_pmu.pmu.capabilities =
-			PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_SW_DOUBLEBUF;
+		pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_NO_SG;
 
 	pt_pmu.pmu.capabilities	|= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE;
 	pt_pmu.pmu.attr_groups		 = pt_attr_groups;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index cf023db0e8a2..15a82ff0aefe 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -240,7 +240,6 @@ struct perf_event;
 #define PERF_PMU_CAP_NO_INTERRUPT		0x01
 #define PERF_PMU_CAP_NO_NMI			0x02
 #define PERF_PMU_CAP_AUX_NO_SG			0x04
-#define PERF_PMU_CAP_AUX_SW_DOUBLEBUF		0x08
 #define PERF_PMU_CAP_EXCLUSIVE			0x10
 #define PERF_PMU_CAP_ITRACE			0x20
 #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
-- 
2.20.1

