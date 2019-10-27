Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70584CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C66020B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210615;
	bh=kFr3bpDwZ5IbEy2fGNnG6yQKM9J6DQNIfylmPpZdyng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BdpJgevh+UMeTyX8w/kIbOT+03xWxaZHugCJ2rKJK4+3EtROTmr8CdkWs+xmRBZQ/
	 XEqsab33/uakd0KScit60wHziWuG60kmoLvNW3iXoVhKAEJfBY+QJ+xgYyERbH4UzP
	 eguma8A/NB0r12a5NcbsFC9ZMG4iqK1C2voPwzl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfJ0VKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729643AbfJ0VKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:10:11 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DB2F20873;
        Sun, 27 Oct 2019 21:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210610;
        bh=kFr3bpDwZ5IbEy2fGNnG6yQKM9J6DQNIfylmPpZdyng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t+94c8RNjMHGiMQnl+x+n0I6i3YpDJzm3GJ88bADGgxpoXyjCeD5t7olwdC9SRRvE
         ABK40ex8vvi/poAYVIlpoHzEQt+/B6JpGRga+q8zjTCqO2AOnTINnQdGWFdbFphAro
         H2FNZ2/9MZph9n3wL+8ke35zDagpFgT4eydSJYs4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 075/119] arm64: Always enable ssb vulnerability detection
Date:   Sun, 27 Oct 2019 22:00:52 +0100
Message-Id: <20191027203341.465064712@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Linton <jeremy.linton@arm.com>

[ Upstream commit d42281b6e49510f078ace15a8ea10f71e6262581 ]

Ensure we are always able to detect whether or not the CPU is affected
by SSB, so that we can later advertise this to userspace.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
[will: Use IS_ENABLED instead of #ifdef]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/cpufeature.h |    4 ----
 arch/arm64/kernel/cpu_errata.c      |    9 +++++----
 2 files changed, 5 insertions(+), 8 deletions(-)

--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -493,11 +493,7 @@ static inline int arm64_get_ssbd_state(v
 #endif
 }
 
-#ifdef CONFIG_ARM64_SSBD
 void arm64_set_ssbd_mitigation(bool state);
-#else
-static inline void arm64_set_ssbd_mitigation(bool state) {}
-#endif
 
 #endif /* __ASSEMBLY__ */
 
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -231,7 +231,6 @@ enable_smccc_arch_workaround_1(const str
 }
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
 
-#ifdef CONFIG_ARM64_SSBD
 DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
 
 int ssbd_state __read_mostly = ARM64_SSBD_KERNEL;
@@ -304,6 +303,11 @@ void __init arm64_enable_wa2_handling(st
 
 void arm64_set_ssbd_mitigation(bool state)
 {
+	if (!IS_ENABLED(CONFIG_ARM64_SSBD)) {
+		pr_info_once("SSBD disabled by kernel configuration\n");
+		return;
+	}
+
 	if (this_cpu_has_cap(ARM64_SSBS)) {
 		if (state)
 			asm volatile(SET_PSTATE_SSBS(0));
@@ -423,7 +427,6 @@ out_printmsg:
 
 	return required;
 }
-#endif	/* CONFIG_ARM64_SSBD */
 
 #define CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)	\
 	.matches = is_affected_midr_range,			\
@@ -627,14 +630,12 @@ const struct arm64_cpu_capabilities arm6
 		.cpu_enable = enable_smccc_arch_workaround_1,
 	},
 #endif
-#ifdef CONFIG_ARM64_SSBD
 	{
 		.desc = "Speculative Store Bypass Disable",
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		.capability = ARM64_SSBD,
 		.matches = has_ssbd_mitigation,
 	},
-#endif
 	{
 	}
 };


