Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DD1C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AAD218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfCOSSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:18:48 -0400
Received: from mail.ahsoftware.de ([88.99.227.106]:50676 "EHLO
        mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfCOSSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:18:48 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Mar 2019 14:18:47 EDT
Received: by mail.ahsoftware.de (Postfix, from userid 115)
        id 18FC4101EEB; Fri, 15 Mar 2019 19:11:59 +0100 (CET)
Received: from xu4q.ahsoftware (unknown [IPv6:2a02:810c:280:31aa:6ad4:5651:15f3:92d4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.ahsoftware.de (Postfix) with ESMTPSA id 6A3F4101E7B;
        Fri, 15 Mar 2019 19:11:57 +0100 (CET)
Received: by xu4q.ahsoftware (Postfix, from userid 65534)
        id 1983483451; Fri, 15 Mar 2019 19:11:57 +0100 (CET)
Received: from krabat.ahsoftware (unknown [IPv6:feee::5246:5dff:fe8b:95f8])
        by xu4q.ahsoftware (Postfix) with ESMTP id 10AAC83450;
        Fri, 15 Mar 2019 18:11:54 +0000 (UTC)
From:   Alexander Holler <holler@ahsoftware.de>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Holler <holler@ahsoftware.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org
Subject: [PATCH] perf/x86/intel: fix 2 typos
Date:   Fri, 15 Mar 2019 19:25:42 +0100
Message-Id: <20190315182542.1700-1-holler@ahsoftware.de>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if fix is functional correct, but at least it compiles now.
It failed before with a config for an AMD CPU.

Bug was introduced with commit d01b1f96a82e5dd7841a1d39db3abfdaf95f70ab
"perf/x86/intel: Make cpuc allocations consistent" which was merged
with 004cc08675b761fd82288bab1b5ba5e1ca746eca.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org>
---
 arch/x86/events/perf_event.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index b04ae6c..a759557 100644
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
 
-- 
2.9.5

