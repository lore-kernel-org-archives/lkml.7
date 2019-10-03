Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21CCC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95350218DE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfJCLMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:12:19 -0400
Received: from foss.arm.com ([217.140.110.172]:41770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbfJCLMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:12:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E7EA1576;
        Thu,  3 Oct 2019 04:12:17 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B2563F706;
        Thu,  3 Oct 2019 04:12:16 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com,
        Julien Grall <julien.grall@arm.com>, mark.brown@arm.com
Subject: [PATCH 1/4] arm64: cpufeature: Effectively expose FRINT capability to userspace
Date:   Thu,  3 Oct 2019 12:12:08 +0100
Message-Id: <20191003111211.483-2-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191003111211.483-1-julien.grall@arm.com>
References: <20191003111211.483-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HWCAP framework will detect a new capability based on the sanitized
version of the ID registers.

Sanitization is based on a whitelist, so any field not described will end
up to be zeroed.

At the moment, ID_AA64ISAR1_EL1.FRINTTS is not described in
ftr_id_aa64isar1. This means the field will be zeroed and therefore the
userspace will not be able to see the HWCAP even if the hardware
supports the feature.

This can be fixed by describing the field in ftr_id_aa64isar1.

Fixes: ca9503fc9e98 ("arm64: Expose FRINT capabilities to userspace")
Signed-off-by: Julien Grall <julien.grall@arm.com>
Cc: mark.brown@arm.com
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9323bcc40a58..cabebf1a7976 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -136,6 +136,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
 
 static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_SB_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_FRINTTS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_GPI_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
-- 
2.11.0

