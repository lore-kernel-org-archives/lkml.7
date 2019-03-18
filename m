Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BEAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D074D214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901631;
	bh=WB+WnKuE+7Xx1t830uueUImXHHVBlLa73KzzojHWnLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W/bZyRxYIKtFPIkyKuhzjOFL1mqTR2ZhyBX5ew2D+nWoqB4ul90AdpN3enmob6V0/
	 XbK/NJWjgjBCYovR8GZKWuAAgknNbTmVTMyOpKZEaT/B9lN1rv1K2GSdf4S/p5EBak
	 HIlfNIDP7bw3M1RjnGkX0Sq03Ud3Sze6fQQJ1RyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfCRJdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728906AbfCRJdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:33:47 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CD60214AF;
        Mon, 18 Mar 2019 09:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901626;
        bh=WB+WnKuE+7Xx1t830uueUImXHHVBlLa73KzzojHWnLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UxZnp7DLcg3rZK0NeZKwrDgXtKCt/WKnphVGAfOU3cn+bnyVVz4QueTSNsGLuvKrg
         kk3+SfXKawRuf9yQWeuwEBNpElksUDlQz2iSbp9Vwx8lYKXurJy6SbUAWGUAku8PPJ
         cXqanztH8NczmX2KgsyQ61eEeGvwB9S9WTjpk9gY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.19 38/52] perf/x86: Fixup typo in stub functions
Date:   Mon, 18 Mar 2019 10:25:35 +0100
Message-Id: <20190318084018.015238657@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit f764c58b7faa26f5714e6907f892abc2bc0de4f8 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/perf_event.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1030,12 +1030,12 @@ static inline int intel_pmu_init(void)
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
 


