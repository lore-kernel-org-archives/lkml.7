Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22819C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC6620830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfCYQEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:04:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:30362 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCYQEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:04:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 09:04:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="145078749"
Received: from spandruv-mobl.jf.intel.com ([10.24.11.149])
  by orsmga002.jf.intel.com with ESMTP; 25 Mar 2019 09:04:40 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, pprakash@codeaurora.org,
        wangxiongfeng2@huawei.com, srinivas.pandruvada@linux.intel.com
Subject: [PATCH v2 1/2] ACPI / CPPC: Fix processing for guaranteed performance
Date:   Mon, 25 Mar 2019 09:04:39 -0700
Message-Id: <20190325160440.7575-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190325160440.7575-1-srinivas.pandruvada@linux.intel.com>
References: <20190325160440.7575-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per ACPI specification "Guaranteed Performance Register" is a "Buffer"
field. It can't be "Integer" field. So treat "Integer" type as invalid and
ignore "Guaranteed Performance Register".
Also save one cpc_read() call, when "Guaranteed Performance Register" is
not present, which means register defined as:
"Register(SystemMemory, 0, 0, 0, 0)".

Fixes: 29523f095397 ("ACPI / CPPC: Add support for guaranteed performance")
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: 4.20+ <stable@vger.kernel.org> # 4.20+
---
 drivers/acpi/cppc_acpi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1b207fca1420..d4244e7d0e38 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1150,8 +1150,13 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	cpc_read(cpunum, nominal_reg, &nom);
 	perf_caps->nominal_perf = nom;
 
-	cpc_read(cpunum, guaranteed_reg, &guaranteed);
-	perf_caps->guaranteed_perf = guaranteed;
+	if (guaranteed_reg->type != ACPI_TYPE_BUFFER  ||
+	    IS_NULL_REG(&guaranteed_reg->cpc_entry.reg)) {
+		perf_caps->guaranteed_perf = 0;
+	} else {
+		cpc_read(cpunum, guaranteed_reg, &guaranteed);
+		perf_caps->guaranteed_perf = guaranteed;
+	}
 
 	cpc_read(cpunum, lowest_non_linear_reg, &min_nonlinear);
 	perf_caps->lowest_nonlinear_perf = min_nonlinear;
-- 
2.17.2

