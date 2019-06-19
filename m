Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7443EC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5252720B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbfFSI2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:28:17 -0400
Received: from [192.198.146.188] ([192.198.146.188]:13318 "EHLO
        E6440.gar.corp.intel.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731134AbfFSI2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:28:17 -0400
Received: from E6440.gar.corp.intel.com (localhost [127.0.0.1])
        by E6440.gar.corp.intel.com (Postfix) with ESMTP id 414CDC1165;
        Wed, 19 Jun 2019 16:28:14 +0800 (CST)
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     gs0622@gmail.com, Harry Pan <harry.pan@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Darren Hart <dvhart@infradead.org>
Subject: [PATCH v3] platform/x86: intel_pmc_core: transform Pkg C-state residency from TSC ticks into microseconds
Date:   Wed, 19 Jun 2019 16:28:01 +0800
Message-Id: <20190619082801.21699-1-harry.pan@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528025727.6014-1-harry.pan@intel.com>
References: <20190528025727.6014-1-harry.pan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to the Intel SDM Vol.4, the package C-state residency counters
of modern IA micro-architecture are all ticking in TSC frequency,
hence we can apply simple math to transform the ticks into microseconds.
i.e.,
residency (ms) = count / tsc_khz
residency (us) = count / tsc_khz * 1000

This also aligns to other sysfs debug entries of residency counter in
the same metric in microseconds, benefits reading and scripting.

v2: restore the accidentally deleted newline, no function change.
v3: apply kernel do_div() macro to calculate division

Signed-off-by: Harry Pan <harry.pan@intel.com>

---

 drivers/platform/x86/intel_pmc_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index f2c621b55f49..ab798efacc85 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -24,6 +24,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/msr.h>
+#include <asm/tsc.h>
 
 #include "intel_pmc_core.h"
 
@@ -738,7 +739,9 @@ static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
 		if (rdmsrl_safe(map[index].bit_mask, &pcstate_count))
 			continue;
 
-		seq_printf(s, "%-8s : 0x%llx\n", map[index].name,
+		pcstate_count *= 1000;
+		do_div(pcstate_count, tsc_khz);
+		seq_printf(s, "%-8s : %llu\n", map[index].name,
 			   pcstate_count);
 	}
 
-- 
2.20.1

