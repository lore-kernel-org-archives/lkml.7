Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A603FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8022221904
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfDOSn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:43:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:30899 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbfDOSn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:43:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 11:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,354,1549958400"; 
   d="scan'208";a="136032391"
Received: from otc-lr-04.jf.intel.com ([10.54.39.141])
  by orsmga006.jf.intel.com with ESMTP; 15 Apr 2019 11:43:26 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/5] perf/x86/intel/uncore: Extract codes of box ref/unref
Date:   Mon, 15 Apr 2019 11:41:53 -0700
Message-Id: <1555353716-35041-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555353716-35041-1-git-send-email-kan.liang@linux.intel.com>
References: <1555353716-35041-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

For uncore box which can only be accessed by MSR, its reference
box->refcnt is updated in CPU hot plug. The uncore boxes needs to be
init/exit accordingly for the first/last CPU of a socket.
Starts from Snow Ridge server, a new type of uncore box is introduced,
which can only be accessed by MMIO. The driver needs to map/unmap
MMIO space for the first/last CPU of a socket.

Extract the codes of box ref/unref and init/exit for reuse later.

There is no functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 55 +++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index ee23b50..0b72ca5 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1140,12 +1140,27 @@ static void uncore_change_context(struct intel_uncore_type **uncores,
 		uncore_change_type_ctx(*uncores, old_cpu, new_cpu);
 }
 
-static int uncore_event_cpu_offline(unsigned int cpu)
+static void uncore_box_unref(struct intel_uncore_type **types, int id)
 {
-	struct intel_uncore_type *type, **types = uncore_msr_uncores;
+	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu;
 	struct intel_uncore_box *box;
-	int i, pkg, target;
+	int i;
+
+	for (; *types; types++) {
+		type = *types;
+		pmu = type->pmus;
+		for (i = 0; i < type->num_boxes; i++, pmu++) {
+			box = pmu->boxes[id];
+			if (box && atomic_dec_return(&box->refcnt) == 0)
+				uncore_box_exit(box);
+		}
+	}
+}
+
+static int uncore_event_cpu_offline(unsigned int cpu)
+{
+	int pkg, target;
 
 	/* Check if exiting cpu is used for collecting uncore events */
 	if (!cpumask_test_and_clear_cpu(cpu, &uncore_cpu_mask))
@@ -1165,15 +1180,7 @@ static int uncore_event_cpu_offline(unsigned int cpu)
 unref:
 	/* Clear the references */
 	pkg = topology_logical_package_id(cpu);
-	for (; *types; types++) {
-		type = *types;
-		pmu = type->pmus;
-		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			box = pmu->boxes[pkg];
-			if (box && atomic_dec_return(&box->refcnt) == 0)
-				uncore_box_exit(box);
-		}
-	}
+	uncore_box_unref(uncore_msr_uncores, pkg);
 	return 0;
 }
 
@@ -1215,16 +1222,15 @@ static int allocate_boxes(struct intel_uncore_type **types,
 	}
 	return -ENOMEM;
 }
-
-static int uncore_event_cpu_online(unsigned int cpu)
+static int uncore_box_ref(struct intel_uncore_type **types,
+			  int id, unsigned int cpu)
 {
-	struct intel_uncore_type *type, **types = uncore_msr_uncores;
+	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu;
 	struct intel_uncore_box *box;
-	int i, ret, pkg, target;
+	int i, ret;
 
-	pkg = topology_logical_package_id(cpu);
-	ret = allocate_boxes(types, pkg, cpu);
+	ret = allocate_boxes(types, id, cpu);
 	if (ret)
 		return ret;
 
@@ -1232,11 +1238,22 @@ static int uncore_event_cpu_online(unsigned int cpu)
 		type = *types;
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			box = pmu->boxes[pkg];
+			box = pmu->boxes[id];
 			if (box && atomic_inc_return(&box->refcnt) == 1)
 				uncore_box_init(box);
 		}
 	}
+	return 0;
+}
+
+static int uncore_event_cpu_online(unsigned int cpu)
+{
+	int ret, pkg, target;
+
+	pkg = topology_logical_package_id(cpu);
+	ret = uncore_box_ref(uncore_msr_uncores, pkg, cpu);
+	if (ret)
+		return ret;
 
 	/*
 	 * Check if there is an online cpu in the package
-- 
2.7.4

