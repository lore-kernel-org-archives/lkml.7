Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7874FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5620320857
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbfB1R7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:59:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:62019 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfB1R7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:59:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 09:59:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,423,1544515200"; 
   d="scan'208";a="147405164"
Received: from chenyu-office.sh.intel.com ([10.239.158.163])
  by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2019 09:59:02 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        yu.chen.surf@gmail.com, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2][RFC v2] ACPI: add "processor.broadcast_ppc" hook to broadcast  _PPC
Date:   Fri,  1 Mar 2019 02:07:47 +0800
Message-Id: <ee0250bfc7709ce0a0cc93bf83336133d5e248c4.1551375162.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551375162.git.yu.c.chen@intel.com>
References: <cover.1551375162.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some problematic platforms, the _PPC notifier is
only delivered to one CPU, which might cause information
inconsistent between CPUs within the package. Thus introduce a boot up parameter to broadcast this _PPC notifier onto all
online CPUs.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/processor_perflib.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index a303fd0e108c..737dbf5aa7f7 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -63,6 +63,10 @@ module_param(ignore_ppc, int, 0644);
 MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
 		 "limited by BIOS, this should help");
 
+static int broadcast_ppc;
+module_param(broadcast_ppc, int, 0644);
+MODULE_PARM_DESC(broadcast_ppc, "Broadcast the ppc to all online CPUs");
+
 #define PPC_REGISTERED   1
 #define PPC_IN_USE       2
 
@@ -180,8 +184,16 @@ void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
 		else
 			acpi_processor_ppc_ost(pr->handle, 0);
 	}
-	if (ret >= 0)
-		cpufreq_update_policy(pr->id);
+	if (ret >= 0) {
+		if (broadcast_ppc) {
+			int cpu;
+
+			for_each_possible_cpu(cpu)
+				cpufreq_update_policy(cpu);
+		} else {
+			cpufreq_update_policy(pr->id);
+		}
+	}
 }
 
 int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
-- 
2.17.1

