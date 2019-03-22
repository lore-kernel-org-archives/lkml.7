Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE98C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33BD21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfCVWpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:45:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:15693 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbfCVWp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:45:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 15:45:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="309622834"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.53.177])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2019 15:45:28 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, pprakash@codeaurora.org,
        wangxiongfeng2@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "4 . 20+" <stable@vger.kernel.org>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Also use cppc nominal_perf for base_frequency
Date:   Fri, 22 Mar 2019 15:45:20 -0700
Message-Id: <20190322224520.6740-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190322224520.6740-1-srinivas.pandruvada@linux.intel.com>
References: <20190322224520.6740-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI specifications stat that if the "Guaranteed Performance Register" is
not implemented, OSPM assumes guaranteed performance is always equal to
nominal performance. So for invalid and unimplemented guaranteed
performance register, use nominal performance as guaranteed performance.

This change will fallback to nominal_perf when guranteed_perf is invalid.
If nominal_perf is also invalid, then fallback to existing implementation,
which is to read from HWP Capabilities MSR.

Fixes: 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency attribute")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: 4.20+ <stable@vger.kernel.org> # 4.20+
---
 drivers/cpufreq/intel_pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 7b4b0a7ac68b..e16dea241c55 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -385,6 +385,9 @@ static int intel_pstate_get_cppc_guranteed(int cpu)
 	if (ret)
 		return ret;
 
+	if (!cppc_perf.guaranteed_perf)
+		return cppc_perf.nominal_perf;
+
 	return cppc_perf.guaranteed_perf;
 }
 
-- 
2.17.2

