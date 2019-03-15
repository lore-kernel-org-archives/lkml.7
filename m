Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650CCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A45F2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfCOMQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:16:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38909 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfCOMQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:16:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2FCGHYh1564762
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Mar 2019 05:16:17 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2FCGHtR1564759;
        Fri, 15 Mar 2019 05:16:17 -0700
Date:   Fri, 15 Mar 2019 05:16:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-f764c58b7faa26f5714e6907f892abc2bc0de4f8@git.kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net,
        gregkh@linuxfoundation.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, linux@roeck-us.net,
          gregkh@linuxfoundation.org, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de
In-Reply-To: <20190315081410.GR5996@hirez.programming.kicks-ass.net>
References: <20190315081410.GR5996@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86: Fixup typo in stub functions
Git-Commit-ID: f764c58b7faa26f5714e6907f892abc2bc0de4f8
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

Commit-ID:  f764c58b7faa26f5714e6907f892abc2bc0de4f8
Gitweb:     https://git.kernel.org/tip/f764c58b7faa26f5714e6907f892abc2bc0de4f8
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Fri, 15 Mar 2019 09:14:10 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 15 Mar 2019 13:12:42 +0100

perf/x86: Fixup typo in stub functions

Guenter reported a build warning for CONFIG_CPU_SUP_INTEL=n:

  > With allmodconfig-CONFIG_CPU_SUP_INTEL, this patch results in:
  >
  > In file included from arch/x86/events/amd/core.c:8:0:
  > arch/x86/events/amd/../perf_event.h:1036:45: warning: ‘struct cpu_hw_event’ declared inside parameter list will not be visible outside of this definition or declaration
  >  static inline int intel_cpuc_prepare(struct cpu_hw_event *cpuc, int cpu)

While harmless (an unsed pointer is an unused pointer, no matter the type)
it needs fixing.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: d01b1f96a82e ("perf/x86/intel: Make cpuc allocations consistent")
Link: http://lkml.kernel.org/r/20190315081410.GR5996@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/perf_event.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index b04ae6c8775e..a75955741c50 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1033,12 +1033,12 @@ static inline int intel_pmu_init(void)
 	return 0;
 }
 
-static inline int intel_cpuc_prepare(struct cpu_hw_event *cpuc, int cpu)
+static inline int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 {
 	return 0;
 }
 
-static inline void intel_cpuc_finish(struct cpu_hw_event *cpuc)
+static inline void intel_cpuc_finish(struct cpu_hw_events *cpuc)
 {
 }
 
