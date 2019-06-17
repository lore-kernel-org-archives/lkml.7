Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532ECC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193F420833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xkx4r9up"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfFQOjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:39:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41295 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFQOjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:39:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEd57o3459270
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:39:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEd57o3459270
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560782345;
        bh=Yhrt+g0YRRauwKyVrK6izZoIf6F7iLtXvNBKHD0Zhl0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xkx4r9upAhINFsOMtqy3DZEU6dKnkx8CsrpxNZJyJSHJ/Xnj6hUQHlGXgbZhHsK39
         uys/ZW+Q+K2SSHWjS+i6YcFRrCZxU98iFHdY0pwawBE7V4kUQdkjGET0GFCGFz9F22
         ha1ILOqAccd7uWyl5+TDXyGiHaLMt7Cv904L7z/3ET2tarAAo0tyAuunT01nshLjp/
         eL+uk7m+qSwyaaRkwTqqNSF/zbZiRdTU6sbJnbprrS6fes3rTKBhUVKkYHxl8ooXTi
         G1WBaueVDfXvYNK608UpJt/B7O9lQFAVOQLclrG1cwB9Lo6kxJIOhQWwCEx7NZazP/
         uQkfkIFxF1DJw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEd5603459267;
        Mon, 17 Jun 2019 07:39:05 -0700
Date:   Mon, 17 Jun 2019 07:39:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-07ce734dd8adc0f170d43c15a9b91b707a21b9d7@git.kernel.org>
Cc:     tglx@linutronix.de, torvalds@linux-foundation.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, kan.liang@linux.intel.com, hpa@zytor.com
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de,
          mingo@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
          hpa@zytor.com
In-Reply-To: <1556672028-119221-6-git-send-email-kan.liang@linux.intel.com>
References: <1556672028-119221-6-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/uncore: Clean up client IMC
Git-Commit-ID: 07ce734dd8adc0f170d43c15a9b91b707a21b9d7
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

Commit-ID:  07ce734dd8adc0f170d43c15a9b91b707a21b9d7
Gitweb:     https://git.kernel.org/tip/07ce734dd8adc0f170d43c15a9b91b707a21b9d7
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 30 Apr 2019 17:53:47 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:36:21 +0200

perf/x86/intel/uncore: Clean up client IMC

The client IMC block is accessed by MMIO. Current code uses an informal
way to access the block, which is not recommended.

Clean up the code by using __iomem annotation and the accessor
functions (read[lq]()).

Move exit_box() and read_counter() to generic code, which can be shared
with the server code later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@kernel.org
Cc: eranian@google.com
Link: https://lkml.kernel.org/r/1556672028-119221-6-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore.c     | 15 +++++++++++++++
 arch/x86/events/intel/uncore.h     |  6 +++++-
 arch/x86/events/intel/uncore_snb.c | 16 ++--------------
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 442f30e5e49a..8bb537143d86 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -120,6 +120,21 @@ u64 uncore_msr_read_counter(struct intel_uncore_box *box, struct perf_event *eve
 	return count;
 }
 
+void uncore_mmio_exit_box(struct intel_uncore_box *box)
+{
+	if (box->io_addr)
+		iounmap(box->io_addr);
+}
+
+u64 uncore_mmio_read_counter(struct intel_uncore_box *box,
+			     struct perf_event *event)
+{
+	if (!box->io_addr)
+		return 0;
+
+	return readq(box->io_addr + event->hw.event_base);
+}
+
 /*
  * generic get constraint function for shared match/mask registers.
  */
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index fc5f48816005..cdd9691365a1 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -2,6 +2,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <asm/apicdef.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #include <linux/perf_event.h>
 #include "../perf_event.h"
@@ -128,7 +129,7 @@ struct intel_uncore_box {
 	struct hrtimer hrtimer;
 	struct list_head list;
 	struct list_head active_list;
-	void *io_addr;
+	void __iomem *io_addr;
 	struct intel_uncore_extra_reg shared_regs[0];
 };
 
@@ -502,6 +503,9 @@ static inline struct intel_uncore_box *uncore_event_to_box(struct perf_event *ev
 
 struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu);
 u64 uncore_msr_read_counter(struct intel_uncore_box *box, struct perf_event *event);
+void uncore_mmio_exit_box(struct intel_uncore_box *box);
+u64 uncore_mmio_read_counter(struct intel_uncore_box *box,
+			     struct perf_event *event);
 void uncore_pmu_start_hrtimer(struct intel_uncore_box *box);
 void uncore_pmu_cancel_hrtimer(struct intel_uncore_box *box);
 void uncore_pmu_event_start(struct perf_event *event, int flags);
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index b0ca4f88c6f2..dbaa1b088a30 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -428,11 +428,6 @@ static void snb_uncore_imc_init_box(struct intel_uncore_box *box)
 	box->hrtimer_duration = UNCORE_SNB_IMC_HRTIMER_INTERVAL;
 }
 
-static void snb_uncore_imc_exit_box(struct intel_uncore_box *box)
-{
-	iounmap(box->io_addr);
-}
-
 static void snb_uncore_imc_enable_box(struct intel_uncore_box *box)
 {}
 
@@ -445,13 +440,6 @@ static void snb_uncore_imc_enable_event(struct intel_uncore_box *box, struct per
 static void snb_uncore_imc_disable_event(struct intel_uncore_box *box, struct perf_event *event)
 {}
 
-static u64 snb_uncore_imc_read_counter(struct intel_uncore_box *box, struct perf_event *event)
-{
-	struct hw_perf_event *hwc = &event->hw;
-
-	return (u64)*(unsigned int *)(box->io_addr + hwc->event_base);
-}
-
 /*
  * Keep the custom event_init() function compatible with old event
  * encoding for free running counters.
@@ -578,13 +566,13 @@ static struct pmu snb_uncore_imc_pmu = {
 
 static struct intel_uncore_ops snb_uncore_imc_ops = {
 	.init_box	= snb_uncore_imc_init_box,
-	.exit_box	= snb_uncore_imc_exit_box,
+	.exit_box	= uncore_mmio_exit_box,
 	.enable_box	= snb_uncore_imc_enable_box,
 	.disable_box	= snb_uncore_imc_disable_box,
 	.disable_event	= snb_uncore_imc_disable_event,
 	.enable_event	= snb_uncore_imc_enable_event,
 	.hw_config	= snb_uncore_imc_hw_config,
-	.read_counter	= snb_uncore_imc_read_counter,
+	.read_counter	= uncore_mmio_read_counter,
 };
 
 static struct intel_uncore_type snb_uncore_imc = {
