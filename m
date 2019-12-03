Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53CCC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C962073F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLCONn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:13:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:23216 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbfLCONk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:13:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 06:13:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,273,1571727600"; 
   d="scan'208";a="218639915"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.50])
  by fmsmga001.fm.intel.com with ESMTP; 03 Dec 2019 06:13:39 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 RESEND 03/14] perf/x86/intel: Move BTS index to 47
Date:   Tue,  3 Dec 2019 06:12:01 -0800
Message-Id: <20191203141212.7704-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203141212.7704-1-kan.liang@linux.intel.com>
References: <20191203141212.7704-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The bit 48 in the PERF_GLOBAL_STATUS is used to indicate the overflow
status of PERF_METRICS counters now.

Move BTS index to 47.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V4

 arch/x86/include/asm/perf_event.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 55a4d05ba6ec..7df1d5b78aa8 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -185,11 +185,11 @@ struct x86_pmu_capability {
 /*
  * We model BTS tracing as another fixed-mode PMC.
  *
- * We choose a value in the middle of the fixed event range, since lower
+ * We choose value 47 for the fixed index of BTS, since lower
  * values are used by actual fixed events and higher values are used
  * to indicate other overflow conditions in the PERF_GLOBAL_STATUS msr.
  */
-#define INTEL_PMC_IDX_FIXED_BTS				(INTEL_PMC_IDX_FIXED + 16)
+#define INTEL_PMC_IDX_FIXED_BTS				(INTEL_PMC_IDX_FIXED + 15)
 
 #define GLOBAL_STATUS_COND_CHG				BIT_ULL(63)
 #define GLOBAL_STATUS_BUFFER_OVF			BIT_ULL(62)
-- 
2.17.1

