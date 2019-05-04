Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944ACC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 15:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E605206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 15:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556982962;
	bh=2tT0/GLwxnsiOeUGyr8qZzZ+DM978jXD/NJPBgex2ME=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kqjvQL3w4IbzVJVeG/UHYS+VINlO2/oZzeHn7BDLnUA/Ra9qFtfnlnB4WYNZKbu3y
	 rBGtnnstOWpj/GfgMsFBezP7gZnGtaHxtKmk8Ty7cXH9vdrx96/53jEkA1739fkSDC
	 xG6Hfc2E3Xw4Tx56qvhqSAJRKE8MeNeBj740Rt0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfEDPQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 11:16:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfEDPQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 11:16:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B1C9C05E770;
        Sat,  4 May 2019 15:16:00 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27E3160BE2;
        Sat,  4 May 2019 15:15:56 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephane Eranian <eranian@google.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Lendacky Thomas <Thomas.Lendacky@amd.com>,
        David Arcari <darcari@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Fix race in intel_pmu_disable_event
Date:   Sat,  4 May 2019 17:15:56 +0200
Message-Id: <20190504151556.31031-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sat, 04 May 2019 15:16:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New race in x86_pmu_stop was introduced by replacing the
atomic __test_and_clear_bit of cpuc->active_mask by separate
test_bit and __clear_bit calls in following patch:

  3966c3feca3f ("x86/perf/amd: Remove need to check "running" bit in NMI handler")

The race causes panic for PEBS events with enabled callchains:

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
  ...
  RIP: 0010:perf_prepare_sample+0x8c/0x530
  Call Trace:
   <NMI>
   perf_event_output_forward+0x2a/0x80
   __perf_event_overflow+0x51/0xe0
   handle_pmi_common+0x19e/0x240
   intel_pmu_handle_irq+0xad/0x170
   perf_event_nmi_handler+0x2e/0x50
   nmi_handle+0x69/0x110
   default_do_nmi+0x3e/0x100
   do_nmi+0x11a/0x180
   end_repeat_nmi+0x16/0x1a
  RIP: 0010:native_write_msr+0x6/0x20
  ...
   </NMI>
   intel_pmu_disable_event+0x98/0xf0
   x86_pmu_stop+0x6e/0xb0
   x86_pmu_del+0x46/0x140
   event_sched_out.isra.97+0x7e/0x160
  ...

The event is configured to make samples from PEBS drain code,
but when it's disabled, we'll go through NMI path instead,
where data->callchain will not get allocated and we'll crash:

          x86_pmu_stop
            test_bit(hwc->idx, cpuc->active_mask)
            intel_pmu_disable_event(event)
            {
              ...
              intel_pmu_pebs_disable(event);
              ...

EVENT OVERFLOW ->  <NMI>
                     intel_pmu_handle_irq
                       handle_pmi_common
   TEST PASSES ->        test_bit(bit, cpuc->active_mask))
                           perf_event_overflow
                             perf_prepare_sample
                             {
                               ...
                               if (!(sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY))
                                     data->callchain = perf_callchain(event, regs);

         CRASH ->              size += data->callchain->nr;
                             }
                   </NMI>
              ...
              x86_pmu_disable_event(event)
            }

            __clear_bit(hwc->idx, cpuc->active_mask);

Fixing this by disabling the event itself before setting
off the PEBS bit.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: Lendacky Thomas <Thomas.Lendacky@amd.com>
Cc: David Arcari <darcari@redhat.com>
Fixes: 3966c3feca3f ("x86/perf/amd: Remove need to check "running" bit in NMI handler")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/intel/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4b4dac089635..ef763f535e3a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2159,15 +2159,19 @@ static void intel_pmu_disable_event(struct perf_event *event)
 	cpuc->intel_ctrl_host_mask &= ~(1ull << hwc->idx);
 	cpuc->intel_cp_status &= ~(1ull << hwc->idx);
 
-	if (unlikely(event->attr.precise_ip))
-		intel_pmu_pebs_disable(event);
-
 	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
 		intel_pmu_disable_fixed(hwc);
 		return;
 	}
 
 	x86_pmu_disable_event(event);
+
+	/*
+	 * Needs to be called after x86_pmu_disable_event,
+	 * so we don't trigger the event without PEBS bit set.
+	 */
+	if (unlikely(event->attr.precise_ip))
+		intel_pmu_pebs_disable(event);
 }
 
 static void intel_pmu_del_event(struct perf_event *event)
-- 
2.20.1

