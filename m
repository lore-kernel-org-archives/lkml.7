Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04D6C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB43320833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BzkWj16C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfFQOjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:39:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39871 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfFQOju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:39:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEbdjR3458828
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:37:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEbdjR3458828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560782259;
        bh=UinVImuu2pOjMQz1JXsC8Udk8Jq7OBHh7cQbI4MQspM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BzkWj16CDRXEikBexDVVQuTj5VXgjpya9sGB2iQKbCkebGmyW6HWHy2hy/0N1GTMW
         NMSmVcfrQrIYFQrkFPz9MZ6gb5xSByMsp3vxy7/skRswUW+V1o/nEkttMEqLVCsDUt
         CFnoVLQDx0Y0+z7yTEzZU/GxYNSEyEn35rPhBfbtmpgq2/iKYeuuWDUX0o3hd/osnw
         Ui+GLMcwuMi5GkxmBd+hPiPLXDZJyyjJDvzqie7Cp1cx2EHDCAflE62388q12qXN2v
         6mpg8K5eylxqFx12BsGga0PVjLe8PmsacOy2lq+i3aiUaS+WeSpBKt5cHDSHynDPCR
         eWCp0Yp6MfJfA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEbdP33458825;
        Mon, 17 Jun 2019 07:37:39 -0700
Date:   Mon, 17 Jun 2019 07:37:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-c8872d90e0a3651a096860d3241625ccfa1647e0@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, peterz@infradead.org,
        kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, kan.liang@linux.intel.com
In-Reply-To: <1556672028-119221-4-git-send-email-kan.liang@linux.intel.com>
References: <1556672028-119221-4-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/uncore: Factor out box ref/unref
 functions
Git-Commit-ID: c8872d90e0a3651a096860d3241625ccfa1647e0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c8872d90e0a3651a096860d3241625ccfa1647e0
Gitweb:     https://git.kernel.org/tip/c8872d90e0a3651a096860d3241625ccfa1647e0
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 30 Apr 2019 17:53:45 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:36:19 +0200

perf/x86/intel/uncore: Factor out box ref/unref functions

For uncore box which can only be accessed by MSR, its reference
box->refcnt is updated in CPU hot plug. The uncore boxes need to be
initalized and exited accordingly for the first/last CPU of a socket.

Starts from Snow Ridge server, a new type of uncore box is introduced,
which can only be accessed by MMIO. The driver needs to map/unmap
MMIO space for the first/last CPU of a socket.

Extract the codes of box ref/unref and init/exit for reuse later.

There is no functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@kernel.org
Cc: eranian@google.com
Link: https://lkml.kernel.org/r/1556672028-119221-4-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore.c | 54 ++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 342c323e0f6a..7b0c88903d47 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1143,12 +1143,27 @@ static void uncore_change_context(struct intel_uncore_type **uncores,
 		uncore_change_type_ctx(*uncores, old_cpu, new_cpu);
 }
 
-static int uncore_event_cpu_offline(unsigned int cpu)
+static void uncore_box_unref(struct intel_uncore_type **types, int id)
 {
-	struct intel_uncore_type *type, **types = uncore_msr_uncores;
+	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu;
 	struct intel_uncore_box *box;
-	int i, die, target;
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
+	int die, target;
 
 	/* Check if exiting cpu is used for collecting uncore events */
 	if (!cpumask_test_and_clear_cpu(cpu, &uncore_cpu_mask))
@@ -1168,15 +1183,7 @@ static int uncore_event_cpu_offline(unsigned int cpu)
 unref:
 	/* Clear the references */
 	die = topology_logical_die_id(cpu);
-	for (; *types; types++) {
-		type = *types;
-		pmu = type->pmus;
-		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			box = pmu->boxes[die];
-			if (box && atomic_dec_return(&box->refcnt) == 0)
-				uncore_box_exit(box);
-		}
-	}
+	uncore_box_unref(uncore_msr_uncores, die);
 	return 0;
 }
 
@@ -1219,15 +1226,15 @@ cleanup:
 	return -ENOMEM;
 }
 
-static int uncore_event_cpu_online(unsigned int cpu)
+static int uncore_box_ref(struct intel_uncore_type **types,
+			  int id, unsigned int cpu)
 {
-	struct intel_uncore_type *type, **types = uncore_msr_uncores;
+	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu;
 	struct intel_uncore_box *box;
-	int i, ret, die, target;
+	int i, ret;
 
-	die = topology_logical_die_id(cpu);
-	ret = allocate_boxes(types, die, cpu);
+	ret = allocate_boxes(types, id, cpu);
 	if (ret)
 		return ret;
 
@@ -1235,11 +1242,22 @@ static int uncore_event_cpu_online(unsigned int cpu)
 		type = *types;
 		pmu = type->pmus;
 		for (i = 0; i < type->num_boxes; i++, pmu++) {
-			box = pmu->boxes[die];
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
+	int ret, die, target;
+
+	die = topology_logical_die_id(cpu);
+	ret = uncore_box_ref(uncore_msr_uncores, die, cpu);
+	if (ret)
+		return ret;
 
 	/*
 	 * Check if there is an online cpu in the package
