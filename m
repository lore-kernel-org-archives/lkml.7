Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A446C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7DC20692
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfINTpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 15:45:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:27815 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbfINTpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 15:45:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 12:45:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,506,1559545200"; 
   d="scan'208";a="201286918"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.128.136])
  by fmsmga001.fm.intel.com with ESMTP; 14 Sep 2019 12:45:50 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andy.shevchenko@gmail.com, andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com, darcari@redhat.com,
        Youquan Song <youquan.song@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/5] tools/power/x86/intel-speed-select: Fix high priority core mask over count
Date:   Sat, 14 Sep 2019 12:45:43 -0700
Message-Id: <20190914194547.24271-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190914194547.24271-1-srinivas.pandruvada@linux.intel.com>
References: <20190914194547.24271-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youquan Song <youquan.song@intel.com>

If the CPU package has the less logical CPU than topo_max_cpus, but un-present
CPU's punit_cpu_core will be initiated to 0 and they will be count to core 0

Like below, there are only 10 high priority cores (20 logical CPUs) in the CPU
package, but it count to 27 logic CPUs.

./intel-speed-select base-freq info -l 0 | grep mask
        high-priority-cpu-mask:7f000179,f000179f

With the fix patch:
./intel-speed-select base-freq info -l 0
        high-priority-cpu-mask:00000179,f000179f

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 59753b3917bb..83ac72902b36 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -402,6 +402,9 @@ void set_cpu_mask_from_punit_coremask(int cpu, unsigned long long core_mask,
 			int j;
 
 			for (j = 0; j < topo_max_cpus; ++j) {
+				if (!CPU_ISSET_S(j, present_cpumask_size, present_cpumask))
+					continue;
+
 				if (cpu_map[j].pkg_id == pkg_id &&
 				    cpu_map[j].die_id == die_id &&
 				    cpu_map[j].punit_cpu_core == i) {
-- 
2.17.2

