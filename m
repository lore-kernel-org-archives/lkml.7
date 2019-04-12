Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B56C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7C820818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDLTJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:09:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfDLTJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:09:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 840CB2CD80A;
        Fri, 12 Apr 2019 19:09:18 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com [10.18.17.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB7D1600C2;
        Fri, 12 Apr 2019 19:09:17 +0000 (UTC)
From:   Bandan Das <bsd@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] perf/x86: descriptive failure messages for PMU init
Date:   Fri, 12 Apr 2019 15:09:17 -0400
Message-ID: <jpg5zrjavmq.fsf@linux.bootlegged.copy>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 12 Apr 2019 19:09:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There's a default warning message that gets printed, however,
there are various failure conditions:
 - a msr read can fail
 - a msr write can fail
 - a msr has an unexpected value
 - all msrs have unexpected values (disable PMU)

Also, commit commit 005bd0077a79 ("perf/x86: Modify error message in
virtualized environment") completely removed printing the msr in
question but these messages could be helpful for debugging vPMUs as
well. Add them back and change them to pr_debugs, this keeps the
behavior the same for baremetal.

Lastly, use %llx to silence checkpatch

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 arch/x86/events/core.c | 66 ++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 16 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e2b1447192a8..786e03893a0c 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -192,9 +192,16 @@ static void release_pmc_hardware(void) {}
 
 static bool check_hw_exists(void)
 {
-	u64 val, val_fail = -1, val_new= ~0;
-	int i, reg, reg_fail = -1, ret = 0;
-	int bios_fail = 0;
+	u64 val = -1, val_fail = -1, val_new = ~0;
+	int i, reg = -1, reg_fail = -1, ret = 0;
+	bool virt = boot_cpu_has(X86_FEATURE_HYPERVISOR) ? true : false;
+	enum {
+	      READ_FAIL	   =	1,
+	      WRITE_FAIL   =	2,
+	      PMU_FAIL	   =	3,
+	      BIOS_FAIL	   =	4,
+	};
+	int status = 0;
 	int reg_safe = -1;
 
 	/*
@@ -204,10 +211,13 @@ static bool check_hw_exists(void)
 	for (i = 0; i < x86_pmu.num_counters; i++) {
 		reg = x86_pmu_config_addr(i);
 		ret = rdmsrl_safe(reg, &val);
-		if (ret)
+		if (ret) {
+			status = READ_FAIL;
 			goto msr_fail;
+		}
+
 		if (val & ARCH_PERFMON_EVENTSEL_ENABLE) {
-			bios_fail = 1;
+			status = BIOS_FAIL;
 			val_fail = val;
 			reg_fail = reg;
 		} else {
@@ -218,11 +228,13 @@ static bool check_hw_exists(void)
 	if (x86_pmu.num_counters_fixed) {
 		reg = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
 		ret = rdmsrl_safe(reg, &val);
-		if (ret)
+		if (ret) {
+			status = READ_FAIL;
 			goto msr_fail;
+		}
 		for (i = 0; i < x86_pmu.num_counters_fixed; i++) {
 			if (val & (0x03 << i*4)) {
-				bios_fail = 1;
+				status = BIOS_FAIL;
 				val_fail = val;
 				reg_fail = reg;
 			}
@@ -236,7 +248,7 @@ static bool check_hw_exists(void)
 	 */
 
 	if (reg_safe == -1) {
-		reg = reg_safe;
+		status = PMU_FAIL;
 		goto msr_fail;
 	}
 
@@ -246,18 +258,22 @@ static bool check_hw_exists(void)
 	 * (qemu/kvm) that don't trap on the MSR access and always return 0s.
 	 */
 	reg = x86_pmu_event_addr(reg_safe);
-	if (rdmsrl_safe(reg, &val))
+	if (rdmsrl_safe(reg, &val)) {
+		status = READ_FAIL;
 		goto msr_fail;
+	}
 	val ^= 0xffffUL;
 	ret = wrmsrl_safe(reg, val);
 	ret |= rdmsrl_safe(reg, &val_new);
-	if (ret || val != val_new)
+	if (ret || val != val_new) {
+		status = WRITE_FAIL;
 		goto msr_fail;
+	}
 
 	/*
 	 * We still allow the PMU driver to operate:
 	 */
-	if (bios_fail) {
+	if (status == BIOS_FAIL) {
 		pr_cont("Broken BIOS detected, complain to your hardware vendor.\n");
 		pr_err(FW_BUG "the BIOS has corrupted hw-PMU resources (MSR %x is %Lx)\n",
 			      reg_fail, val_fail);
@@ -266,12 +282,30 @@ static bool check_hw_exists(void)
 	return true;
 
 msr_fail:
-	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+	if (virt)
 		pr_cont("PMU not available due to virtualization, using software events only.\n");
-	} else {
-		pr_cont("Broken PMU hardware detected, using software events only.\n");
-		pr_err("Failed to access perfctr msr (MSR %x is %Lx)\n",
-		       reg, val_new);
+	switch (status) {
+	case READ_FAIL:
+		if (virt)
+			pr_debug("Failed to read perfctr msr (MSR %x)\n", reg);
+		else
+			pr_err("Failed to read perfctr msr (MSR %x)\n", reg);
+		break;
+	case WRITE_FAIL:
+		if (virt)
+			pr_debug("Failed to write perfctr msr (MSR %x, wrote: %llx, read: %llx)\n",
+				 reg, val, val_new);
+		else
+			pr_err("Failed to write perfctr msr (MSR %x, wrote: %llx, read: %llx)\n",
+				 reg, val, val_new);
+		break;
+	case PMU_FAIL:
+		/* fall through for default message */
+	default:
+		if (virt)
+			pr_debug("Broken PMU hardware detected, using software events only.\n");
+		else
+			pr_cont("Broken PMU hardware detected, using software events only.\n");
 	}
 
 	return false;
-- 
2.19.2

