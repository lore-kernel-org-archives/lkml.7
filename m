Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7B7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFC52083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901429;
	bh=sgJn+lSlcdal580iYbXK8z+MEiZ96f0R5XAWCcEvZHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eCf6UYWhUpLTPj6yWcX/xN6ubLTdBfBXFUh3L0AIlJ1iZ3CZeiNGbeUAsvdEYBhPn
	 tzDzwte5/xsE582rVap6nQQaknOXvbk2uKzoi58zqGDHf+vbAX6eugc8tREKyUZQF/
	 FnfPmeX46kuUkvIF2d+2Vts5EE8nfQZ49Sxnq7+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfCRJa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbfCRJaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:30:25 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A3D5214AF;
        Mon, 18 Mar 2019 09:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901425;
        bh=sgJn+lSlcdal580iYbXK8z+MEiZ96f0R5XAWCcEvZHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNnkpCjMIl/FxSlVcaCWRTJGhcmBx5zqWWl3+noYsDxKoTY5Ot4LQSWpfRzDr+3vd
         4gZ7b6/AubKKKPMio5TNBVjLwPCrLv7CFb90sXJ53hh9lv7XhVr4kBCs2pgKHX3QFB
         0qJx+Y61LdVtnAUX0NMylJXA0+RTqijN+5XciPco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.20 40/52] perf/x86: Fixup typo in stub functions
Date:   Mon, 18 Mar 2019 10:25:27 +0100
Message-Id: <20190318083847.975535822@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083843.398913295@linuxfoundation.org>
References: <20190318083843.398913295@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1032,12 +1032,12 @@ static inline int intel_pmu_init(void)
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
 


