Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEB8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA7421D81
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfKDLDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:03:37 -0500
Received: from mga04.intel.com ([192.55.52.120]:13209 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728310AbfKDLDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:03:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 03:03:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="232021219"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga002.fm.intel.com with ESMTP; 04 Nov 2019 03:03:08 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 03/10] tools/power/x86/intel-speed-select: Correct CLX-N frequency units
Date:   Mon,  4 Nov 2019 03:02:39 -0800
Message-Id: <20191104110246.70465-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191104110246.70465-1-srinivas.pandruvada@linux.intel.com>
References: <20191104110246.70465-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In CLX_N base_frequency is read from cpufreq sysfs, where units are in
KHz. The internal units in the code matches the real ratios which are
in 100MHz scale. So when storing units for CLX-N frequencies, convert
to 100MHz scale.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 1c20048b42e7..bfa42fc6c4d2 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -840,8 +840,8 @@ static int clx_n_config(int cpu)
 	}
 
 	/* convert frequencies back to ratios */
-	pbf_info->p1_high = pbf_info->p1_high / DISP_FREQ_MULTIPLIER;
-	pbf_info->p1_low = pbf_info->p1_low / DISP_FREQ_MULTIPLIER;
+	pbf_info->p1_high = pbf_info->p1_high / 100000;
+	pbf_info->p1_low = pbf_info->p1_low / 100000;
 
 	/* create high priority cpu mask */
 	pbf_info->core_cpumask_size = alloc_cpu_set(&pbf_info->core_cpumask);
@@ -856,7 +856,7 @@ static int clx_n_config(int cpu)
 		cpu_bf = parse_int_file(1,
 			"/sys/devices/system/cpu/cpu%d/cpufreq/base_frequency",
 					i);
-		cpu_bf = cpu_bf / DISP_FREQ_MULTIPLIER;
+		cpu_bf = cpu_bf / 100000;
 		if (cpu_bf == pbf_info->p1_high)
 			CPU_SET_S(i, pbf_info->core_cpumask_size,
 				  pbf_info->core_cpumask);
-- 
2.17.2

