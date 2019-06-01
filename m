Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0512C46470
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABD4274BA
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395888;
	bh=SVlgSoGR56p9bQCDkoRB9u0+RerzryqMJb1jlyeZN9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sls+N4AIkY475FIpEkTcnGIxPd63v7TkBYaauBdeKdaOa5yMUg4Cci2WX7QNCA5Ir
	 k6m69RDJj1kBPyo2q2nt3H50dimsWvdh54kLCsUvit+v32KPWAHv9w/7INVEXqja0Z
	 nOTrrL7j4+PRwn1QQ/u0OR2iEZ3EoBgEM7owAmAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbfFANZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729511AbfFANZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:25:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8578E27375;
        Sat,  1 Jun 2019 13:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395537;
        bh=SVlgSoGR56p9bQCDkoRB9u0+RerzryqMJb1jlyeZN9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sEWADxcdf62Y8SBc7BOtqQqudE2vYNPykUK/ftXJcyGcv6XsPAquVSN5fqGXYclBz
         af64MiANyDJ3NummVeFeRtIupaIRm1zAaEpuUf1Uq1TbULssNrispeAMA2py1FXc9P
         0DW6jgt93C7cF7YC2Cy4bgFk0mHzu+Si9CiuvBH0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, jolsa@redhat.com,
        kan.liang@intel.com, vincent.weaver@maine.edu,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 16/74] perf/x86/intel: Allow PEBS multi-entry in watermark mode
Date:   Sat,  1 Jun 2019 09:24:03 -0400
Message-Id: <20190601132501.27021-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132501.27021-1-sashal@kernel.org>
References: <20190601132501.27021-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

[ Upstream commit c7a286577d7592720c2f179aadfb325a1ff48c95 ]

This patch fixes a restriction/bug introduced by:

   583feb08e7f7 ("perf/x86/intel: Fix handling of wakeup_events for multi-entry PEBS")

The original patch prevented using multi-entry PEBS when wakeup_events != 0.
However given that wakeup_events is part of a union with wakeup_watermark, it
means that in watermark mode, PEBS multi-entry is also disabled which is not the
intent. This patch fixes this by checking is watermark mode is enabled.

Signed-off-by: Stephane Eranian <eranian@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: jolsa@redhat.com
Cc: kan.liang@intel.com
Cc: vincent.weaver@maine.edu
Fixes: 583feb08e7f7 ("perf/x86/intel: Fix handling of wakeup_events for multi-entry PEBS")
Link: http://lkml.kernel.org/r/20190514003400.224340-1-eranian@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cb8178a2783a8..e98e238d37750 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2867,7 +2867,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		return ret;
 
 	if (event->attr.precise_ip) {
-		if (!(event->attr.freq || event->attr.wakeup_events)) {
+		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
 			if (!(event->attr.sample_type &
 			      ~intel_pmu_free_running_flags(event)))
-- 
2.20.1

