Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48480C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF69208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329376;
	bh=KoqGDfFG6P4eELhrdxw4qI6CMJ4ya+2fqPUEP+TZfyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UVCkl/CV9e5RX/12XwGNWZ9tRyrwwt4DsvBQssHCvv7BQVA6hsTCPQg9Qn/JU8ph1
	 JHxAvvsqOOVj86Zb84qLQ6EvY4z9HySS5KpImI9rAYsuD5W/h6LKER9EUTGckH8IEh
	 JsJfl9Dqe9RFr2CyiVwdFJBEALCMSo/rNYtQIlbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfD0Bmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfD0Bmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:42:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C95512166E;
        Sat, 27 Apr 2019 01:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329371;
        bh=KoqGDfFG6P4eELhrdxw4qI6CMJ4ya+2fqPUEP+TZfyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VxEGPIL1HrJMv/uuplybQ1reSzj3hnaQ2bOBz2Ehyjgg+E5UQ2pSi+tGaK/7jyssK
         Rkql0TF3xE+djE0QRPPqZEfp1GaAfk0/fWBAGflVRItDGiXwojEAkvw/QHpeT+f/GE
         ZO1U5lqjOpiPvGcj3p7VVblbT1+fs1/LBr4znNiY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, tonyj@suse.com,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 14/32] perf/x86/intel: Initialize TFA MSR
Date:   Fri, 26 Apr 2019 21:42:05 -0400
Message-Id: <20190427014224.8274-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014224.8274-1-sashal@kernel.org>
References: <20190427014224.8274-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit d7262457e35dbe239659e62654e56f8ddb814bed ]

Stephane reported that the TFA MSR is not initialized by the kernel,
but the TFA bit could set by firmware or as a leftover from a kexec,
which makes the state inconsistent.

Reported-by: Stephane Eranian <eranian@google.com>
Tested-by: Nelson DSouza <nelson.dsouza@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: tonyj@suse.com
Link: https://lkml.kernel.org/r/20190321123849.GN6521@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6e1a1ceeed51..d2279ece6976 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3427,6 +3427,12 @@ static void intel_pmu_cpu_starting(int cpu)
 
 	cpuc->lbr_sel = NULL;
 
+	if (x86_pmu.flags & PMU_FL_TFA) {
+		WARN_ON_ONCE(cpuc->tfa_shadow);
+		cpuc->tfa_shadow = ~0ULL;
+		intel_set_tfa(cpuc, false);
+	}
+
 	if (x86_pmu.version > 1)
 		flip_smm_bit(&x86_pmu.attr_freeze_on_smi);
 
-- 
2.19.1

