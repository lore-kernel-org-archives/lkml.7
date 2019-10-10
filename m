Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176CAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B7A208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697340;
	bh=S+0Okuy49xg+IxUOb8mc1qP1Q2gPrQqsCjKimb1zDNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZHjagQFcBou0tuzheO8TAukttIEus4gnbhTahcg1xHlQtDzcJ88udji2hAjVeJ+xM
	 7IPDLunCGCsnWmZflrrqx4Z3+6sxzSRJY52uwgT+tMNncaiXDIKb+68gkrPpEA2AAA
	 DID1gOUn8guJs6kYOx8yIJ6uyRpkibaS7qXs/cBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbfJJIs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389713AbfJJIsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:48:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69DC22064A;
        Thu, 10 Oct 2019 08:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697334;
        bh=S+0Okuy49xg+IxUOb8mc1qP1Q2gPrQqsCjKimb1zDNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yq6Ck7RClMeZdbGEkk7oSbNVvgPsxu+weTGT1uba8Sd3X8N8N6H0OU2KfqOgczcPC
         KkxUiu5stn5Z1Wndsw7cgHKUliGHIyjqHA3mF7riZ3EI81SNLySUMWYlVGYic2kSrb
         FSekAmFkaoJ6n7rNEAQrhIpAaHxKAfgUjjHIQRhU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.19 104/114] arm64: Use firmware to detect CPUs that are not affected by Spectre-v2
Date:   Thu, 10 Oct 2019 10:36:51 +0200
Message-Id: <20191010083613.719382595@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083544.711104709@linuxfoundation.org>
References: <20191010083544.711104709@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

commit 517953c2c47f9c00a002f588ac856a5bc70cede3 upstream.

The SMCCC ARCH_WORKAROUND_1 service can indicate that although the
firmware knows about the Spectre-v2 mitigation, this particular
CPU is not vulnerable, and it is thus not necessary to call
the firmware on this CPU.

Let's use this information to our benefit.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpu_errata.c |   32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -198,22 +198,36 @@ static int detect_harden_bp_fw(void)
 	case PSCI_CONDUIT_HVC:
 		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-		if ((int)res.a0 < 0)
+		switch ((int)res.a0) {
+		case 1:
+			/* Firmware says we're just fine */
+			return 0;
+		case 0:
+			cb = call_hvc_arch_workaround_1;
+			/* This is a guest, no need to patch KVM vectors */
+			smccc_start = NULL;
+			smccc_end = NULL;
+			break;
+		default:
 			return -1;
-		cb = call_hvc_arch_workaround_1;
-		/* This is a guest, no need to patch KVM vectors */
-		smccc_start = NULL;
-		smccc_end = NULL;
+		}
 		break;
 
 	case PSCI_CONDUIT_SMC:
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-		if ((int)res.a0 < 0)
+		switch ((int)res.a0) {
+		case 1:
+			/* Firmware says we're just fine */
+			return 0;
+		case 0:
+			cb = call_smc_arch_workaround_1;
+			smccc_start = __smccc_workaround_1_smc_start;
+			smccc_end = __smccc_workaround_1_smc_end;
+			break;
+		default:
 			return -1;
-		cb = call_smc_arch_workaround_1;
-		smccc_start = __smccc_workaround_1_smc_start;
-		smccc_end = __smccc_workaround_1_smc_end;
+		}
 		break;
 
 	default:


