Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20DFC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B40208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620628;
	bh=meFTcUmkxYfq3pNm9SZhxFxrV8BBcqZk9PMJBplnH0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MSE0bdRzYka8MCAPRe23jYhQlSbFbo9N8m8NJDBMFbcpfPVMucHVMDwsfX5D2LZB9
	 P/epZlvxqj6KztRL2rEEI2mO7pT6FktI/wL++paHHZ76Cm1udk3ZWJm+LzV/OzVX6Q
	 Hky9AOL4SsrGGYTyENvJd1RMCEdHMDxKzEeminiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390102AbfIDSK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390085AbfIDSK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:10:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6339208E4;
        Wed,  4 Sep 2019 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620625;
        bh=meFTcUmkxYfq3pNm9SZhxFxrV8BBcqZk9PMJBplnH0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPYOHJ5dn8U80SShYL6JysB545qsQ+uSi6vul8/frsDvtJ8qnlagpmwWMqAL6vcvv
         x17u2NE1L7Cjm+SVr+EzbHXTDfw3kRY/8bhu0dE3bfqu5wh6gk8zPMvDIC+MyqcB6j
         OkZOS/vvItbxAP+oNNvVSjl/hhKt/bKGQ8YBaxMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 034/143] arm64: cpufeature: Dont treat granule sizes as strict
Date:   Wed,  4 Sep 2019 19:52:57 +0200
Message-Id: <20190904175315.385235253@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5717fe5ab38f9ccb32718bcb03bea68409c9cce4 ]

If a CPU doesn't support the page size for which the kernel is
configured, then we will complain and refuse to bring it online. For
secondary CPUs (and the boot CPU on a system booting with EFI), we will
also print an error identifying the mismatch.

Consequently, the only time that the cpufeature code can detect a
granule size mismatch is for a granule other than the one that is
currently being used. Although we would rather such systems didn't
exist, we've unfortunately lost that battle and Kevin reports that
on his amlogic S922X (odroid-n2 board) we end up warning and taining
with defconfig because 16k pages are not supported by all of the CPUs.

In such a situation, we don't actually care about the feature mismatch,
particularly now that KVM only exposes the sanitised view of the CPU
registers (commit 93390c0a1b20 - "arm64: KVM: Hide unsupported AArch64
CPU features from guests"). Treat the granule fields as non-strict and
let Kevin run without a tainted kernel.

Cc: Marc Zyngier <maz@kernel.org>
Reported-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
[catalin.marinas@arm.com: changelog updated with KVM sanitised regs commit]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ae63eedea1c12..68faf535f40a3 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -184,9 +184,17 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
-	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_TGRAN4_SHIFT, 4, ID_AA64MMFR0_TGRAN4_NI),
-	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_TGRAN64_SHIFT, 4, ID_AA64MMFR0_TGRAN64_NI),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_TGRAN16_SHIFT, 4, ID_AA64MMFR0_TGRAN16_NI),
+	/*
+	 * We already refuse to boot CPUs that don't support our configured
+	 * page size, so we can only detect mismatches for a page size other
+	 * than the one we're currently using. Unfortunately, SoCs like this
+	 * exist in the wild so, even though we don't like it, we'll have to go
+	 * along with it and treat them as non-strict.
+	 */
+	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_TGRAN4_SHIFT, 4, ID_AA64MMFR0_TGRAN4_NI),
+	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_TGRAN64_SHIFT, 4, ID_AA64MMFR0_TGRAN64_NI),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_TGRAN16_SHIFT, 4, ID_AA64MMFR0_TGRAN16_NI),
+
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_BIGENDEL0_SHIFT, 4, 0),
 	/* Linux shouldn't care about secure memory */
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_SNSMEM_SHIFT, 4, 0),
-- 
2.20.1



