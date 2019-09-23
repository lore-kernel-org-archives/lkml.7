Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79328C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B48D217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733194AbfIWS7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:59:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:39248 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733169AbfIWS7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:59:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 11:59:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,541,1559545200"; 
   d="scan'208";a="203187152"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga001.fm.intel.com with ESMTP; 23 Sep 2019 11:59:07 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     prarit@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] tools/power/x86/intel-speed-select: Refuse to disable core-power when getting used
Date:   Mon, 23 Sep 2019 11:59:06 -0700
Message-Id: <20190923185906.76032-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190923185906.76032-1-srinivas.pandruvada@linux.intel.com>
References: <20190923185906.76032-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The turbo-freq feature is dependent on the core-power feature. If the
core-power feature is disabled while the turbo-freq feature is enabled,
this will break the turbo-freq feature. This is a firmware limitation,
where they can't return error under this scenario.

So when trying to disable core-power, make sure that the turbo-freq
feature is not enabled. If it enabled, return error if user is trying to
disable the core-power feature.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../power/x86/intel-speed-select/isst-core.c  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/power/x86/intel-speed-select/isst-core.c b/tools/power/x86/intel-speed-select/isst-core.c
index 6dee5332c9d3..67d32f2b9bea 100644
--- a/tools/power/x86/intel-speed-select/isst-core.c
+++ b/tools/power/x86/intel-speed-select/isst-core.c
@@ -649,6 +649,27 @@ int isst_pm_qos_config(int cpu, int enable_clos, int priority_type)
 	unsigned int req, resp;
 	int ret;
 
+	if (!enable_clos) {
+		struct isst_pkg_ctdp pkg_dev;
+		struct isst_pkg_ctdp_level_info ctdp_level;
+
+		ret = isst_get_ctdp_levels(cpu, &pkg_dev);
+		if (ret) {
+			debug_printf("isst_get_ctdp_levels\n");
+			return ret;
+		}
+
+		ret = isst_get_ctdp_control(cpu, pkg_dev.current_level,
+					    &ctdp_level);
+		if (ret)
+			return ret;
+
+		if (ctdp_level.fact_enabled) {
+			debug_printf("Turbo-freq feature must be disabled first\n");
+			return -EINVAL;
+		}
+	}
+
 	ret = isst_send_mbox_command(cpu, CONFIG_CLOS, CLOS_PM_QOS_CONFIG, 0, 0,
 				     &resp);
 	if (ret)
-- 
2.17.2

