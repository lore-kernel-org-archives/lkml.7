Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397A8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8953218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fspeLboB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IuAAXE1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfCUCH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:07:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57304 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCUCH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 22:07:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 94336609CD; Thu, 21 Mar 2019 02:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553134076;
        bh=CIyV9GkM+pGMGDsQ75GXvsFmmEVC/LMlMKD9BslShRY=;
        h=From:To:Cc:Subject:Date:From;
        b=fspeLboBfhYXVfpof/NVs/Z/gW3/7fEpvvFIDLkio84J/r/V4MYSC2v7xmFq4TZWs
         dkKqRg/QXU76Gs7tSOla6/gWmGD/O9lRGuIVinAKhyzbciAA9lH8P6eMhUrH8Cs0zy
         BmGzkHdHQz38TDK+3VsBCKu9Mz4L9QjUlAYrnDWc=
Received: from psodagud-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA84F60159;
        Thu, 21 Mar 2019 02:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553134074;
        bh=CIyV9GkM+pGMGDsQ75GXvsFmmEVC/LMlMKD9BslShRY=;
        h=From:To:Cc:Subject:Date:From;
        b=IuAAXE1/o4iFStJWbYp0CfjonnFauUisAl4SWw91rctYcfGSmP39QtDThShodFOAs
         kOqTyYeSD6PqRBXejLsgidJvh4jymIuzk7uebP0euyMzIBXVXrCzn4bQWkWbYGKWwf
         S39fIQAaF3V5E0bIeWzS9u8C6s+C/bfEZiKfWw9U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA84F60159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     will.deacon@arm.com, mingo@redhat.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, psodagud@codeaurora.org
Subject: [PATCH] perf: Change PMCR write to read-modify-write
Date:   Wed, 20 Mar 2019 19:07:46 -0700
Message-Id: <1553134066-20272-1-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preserves the bitfields of PMCR_EL0(AArch64) during PMU reset.
Reset routine should write a 1 to PMCR.C and PMCR.P fields only
to reset the counters. Other fields should not be changed
as they could be set before PMU initialization and their
value must be preserved even after reset.

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
---
 arch/arm64/kernel/perf_event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 4addb38..0c1afdd 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -868,8 +868,8 @@ static void armv8pmu_reset(void *info)
 	 * Initialize & Reset PMNC. Request overflow interrupt for
 	 * 64 bit cycle counter but cheat in armv8pmu_write_counter().
 	 */
-	armv8pmu_pmcr_write(ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C |
-			    ARMV8_PMU_PMCR_LC);
+	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_P |
+			ARMV8_PMU_PMCR_C | ARMV8_PMU_PMCR_LC);
 }
 
 static int __armv8_pmuv3_map_event(struct perf_event *event,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

