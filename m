Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB331C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFD220866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442087;
	bh=VqG4FZRI+dVo9MMkJCdyJAXeK5IqGqDxWPwenGrh/9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CPIWocJApBoCuIuCwQbOqeupziVlXt9vKR6zb+n/wTU+gMelX3E2stMwuPNvJpsLd
	 lyNZq35ZFFi+5Aqrd2OBMWLmJRviEyv2N2oETw0ncGwoa78OFLfjebJDWDUimEq3PS
	 BKoXXupByldZ17AvCnV2PXllU3rjedn2dyr278iI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390479AbfFMQIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731299AbfFMIpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:45:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0C472173C;
        Thu, 13 Jun 2019 08:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415521;
        bh=VqG4FZRI+dVo9MMkJCdyJAXeK5IqGqDxWPwenGrh/9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3fQhppnXBZ2KayTmwp5VIFfUDKlKLWpbY6V/qlL8F5NkKT8FpUJQE6s99Wp/MFtN
         FCaNt8mEVhYfX62r2TyALUM994/2vVgYE2S+wmTS7492q9tqfzgBaFUEyj/5WjubLs
         r5B3lcyh/uIprMAYzuvv1O/JZgRsyy1Pw5BNVP3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephane Eranian <eranian@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, jolsa@redhat.com,
        kan.liang@intel.com, vincent.weaver@maine.edu,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 031/155] perf/x86/intel: Allow PEBS multi-entry in watermark mode
Date:   Thu, 13 Jun 2019 10:32:23 +0200
Message-Id: <20190613075654.710782552@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index d35f4775d5f1..82dad001d1ea 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3189,7 +3189,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		return ret;
 
 	if (event->attr.precise_ip) {
-		if (!(event->attr.freq || event->attr.wakeup_events)) {
+		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
 			if (!(event->attr.sample_type &
 			      ~intel_pmu_large_pebs_flags(event)))
-- 
2.20.1



