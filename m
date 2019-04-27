Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FDAC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784D3216FD
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329296;
	bh=s56HF00oQ/dyXbkRHJCjV8cHgYP2kg19Hndp7439VV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hoU19FPNsibNKey43tX4xfdbcH1jA3bTTEUi3uy4WEeS8B5wgFXcLZnit0x03PMgY
	 e5eyZ8UMaiSqCt9ndlMKiSSPU7u6tP0ZJPacpJFKY3Ars+dYT0ZwHsd6vdyAAsmJH+
	 jNBTMzxyyUCixYAOue4z/ZJVFB+yCwtocddkrGfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfD0Blf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbfD0Bld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:41:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 665B621537;
        Sat, 27 Apr 2019 01:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329292;
        bh=s56HF00oQ/dyXbkRHJCjV8cHgYP2kg19Hndp7439VV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u1zYyrvkuXX123MB7jPe2Xw2KGQVTVlYmMKT3UAVt/9WIMDPAZ8fg2YTYnLnUBBHJ
         2ZDeYC79Vgc+7P3/ttrN5ssN1Qk+IewJzvbBfvAVjnu094U0S7NfCNXCY2l9dTqIJy
         oBVC0F0wXFxXjjtOcVKMaZSymY9Yt30kv8zL65w0=
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
Subject: [PATCH AUTOSEL 4.19 25/53] perf/x86/intel: Initialize TFA MSR
Date:   Fri, 26 Apr 2019 21:40:22 -0400
Message-Id: <20190427014051.7522-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
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
index c02a8e6aff52..de0346d651f0 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3447,6 +3447,12 @@ static void intel_pmu_cpu_starting(int cpu)
 
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

