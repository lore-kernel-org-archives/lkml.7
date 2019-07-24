Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD42FC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3B0229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfGXI1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:27:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:6391 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfGXI1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:27:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 01:27:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,302,1559545200"; 
   d="scan'208,223";a="174812257"
Received: from ubuntu.bj.intel.com (HELO Ubuntu.\040none\041) ([10.238.154.174])
  by orsmga006.jf.intel.com with ESMTP; 24 Jul 2019 01:27:35 -0700
From:   Yunying Sun <yunying.sun@intel.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, ak@linux.intel.com, kan.liang@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Yunying Sun <yunying.sun@intel.com>
Subject: [PATCH RESEND] perf/x86/intel: Bit 13 is valid for Icelake MSR_OFFCORE_RSP_x register
Date:   Wed, 24 Jul 2019 16:29:32 +0800
Message-Id: <20190724082932.12833-1-yunying.sun@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190724073911.12177-1-yunying.sun@intel.com>
References: <20190724073911.12177-1-yunying.sun@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Intel SDM, bit 13 of Icelake MSR_OFFCORE_RSP_x register is valid for
counting hardware generated prefetches of L3 cache. But current bitmasks
in driver takes bit 13 as invalid. Here to fix it.

Before:
$ perf stat -e cpu/event=0xb7,umask=0x1,config1=0x1bfff/u sleep 3
 Performance counter stats for 'sleep 3':
   <not supported>      cpu/event=0xb7,umask=0x1,config1=0x1bfff/u

After:
$ perf stat -e cpu/event=0xb7,umask=0x1,config1=0x1bfff/u sleep 3
 Performance counter stats for 'sleep 3':
             9,293      cpu/event=0xb7,umask=0x1,config1=0x1bfff/u

Signed-off-by: Yunying Sun <yunying.sun@intel.com>
---
 arch/x86/events/intel/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9e911a96972b..b35519cbc8b4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -263,8 +263,8 @@ static struct event_constraint intel_icl_event_constraints[] = {
 };
 
 static struct extra_reg intel_icl_extra_regs[] __read_mostly = {
-	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x3fffff9fffull, RSP_0),
-	INTEL_UEVENT_EXTRA_REG(0x01bb, MSR_OFFCORE_RSP_1, 0x3fffff9fffull, RSP_1),
+	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x3fffffbfffull, RSP_0),
+	INTEL_UEVENT_EXTRA_REG(0x01bb, MSR_OFFCORE_RSP_1, 0x3fffffbfffull, RSP_1),
 	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
 	INTEL_UEVENT_EXTRA_REG(0x01c6, MSR_PEBS_FRONTEND, 0x7fff17, FE),
 	EVENT_EXTRA_END
-- 
2.17.0

