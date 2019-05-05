Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A6BC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 11:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301FF208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 11:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hoxKBKeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfEELEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 07:04:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37645 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfEELEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 07:04:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x45B43kp3633648
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 5 May 2019 04:04:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x45B43kp3633648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557054244;
        bh=cb6rbEve70zFesliu7ytgLEO3Jn0Hsj0V0ySRJP6enw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=hoxKBKeNu1+4sFiYCCBOwPQfw/HY/mgCA7h762TecVhPrzUNaNpaK+M3sKrDo6Vbs
         ikjqTc93Gh8fdv3AauS3RiZQhKP1ZuJmZUpGotUqKRWkrv6gkTbFUYnVG2GETWFiqF
         n+2jLRGRiDLGFzJFXjmzC6RyOzh1Z3ptcl96TzcPz0p4Pl33zjHxWRFCuV6WPZw/sM
         kS4LrbV9uuRQtWpxDp6RS6eOPi9ld2id+K8c84sg+tRVu0Ilp0y+898TLtDQw8pREC
         nmum3R/LIWrtX43QNhMe3F9mUA8SaKcL/oi46Ut5oo+SY7lrznIH9gKS4YqCaTkLIq
         vfUA06/gbEGiA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x45B43vx3633642;
        Sun, 5 May 2019 04:04:03 -0700
Date:   Sun, 5 May 2019 04:04:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-6f55967ad9d9752813e36de6d5fdbd19741adfc7@git.kernel.org>
Cc:     vincent.weaver@maine.edu, acme@redhat.com, Thomas.Lendacky@amd.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        eranian@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, darcari@redhat.com,
        tglx@linutronix.de, jolsa@redhat.com
Reply-To: jolsa@redhat.com, tglx@linutronix.de, hpa@zytor.com,
          darcari@redhat.com, peterz@infradead.org, jolsa@kernel.org,
          torvalds@linux-foundation.org, mingo@kernel.org,
          vincent.weaver@maine.edu, Thomas.Lendacky@amd.com,
          linux-kernel@vger.kernel.org, eranian@google.com,
          acme@redhat.com, alexander.shishkin@linux.intel.com
In-Reply-To: <20190504151556.31031-1-jolsa@kernel.org>
References: <20190504151556.31031-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Fix race in
 intel_pmu_disable_event()
Git-Commit-ID: 6f55967ad9d9752813e36de6d5fdbd19741adfc7
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

Commit-ID:  6f55967ad9d9752813e36de6d5fdbd19741adfc7
Gitweb:     https://git.kernel.org/tip/6f55967ad9d9752813e36de6d5fdbd19741adfc7
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sat, 4 May 2019 17:15:56 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 5 May 2019 13:00:48 +0200

perf/x86/intel: Fix race in intel_pmu_disable_event()

New race in x86_pmu_stop() was introduced by replacing the
atomic __test_and_clear_bit() of cpuc->active_mask by separate
test_bit() and __clear_bit() calls in the following commit:

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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Arcari <darcari@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Lendacky Thomas <Thomas.Lendacky@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: 3966c3feca3f ("x86/perf/amd: Remove need to check "running" bit in NMI handler")
Link: http://lkml.kernel.org/r/20190504151556.31031-1-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f9451566cd9b..d35f4775d5f1 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2091,15 +2091,19 @@ static void intel_pmu_disable_event(struct perf_event *event)
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
