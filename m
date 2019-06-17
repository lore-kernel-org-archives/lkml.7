Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1B4C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A160D2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfFQJgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:36:13 -0400
Received: from foss.arm.com ([217.140.110.172]:43220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfFQJgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:36:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 130FF344;
        Mon, 17 Jun 2019 02:36:12 -0700 (PDT)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38DCA3F246;
        Mon, 17 Jun 2019 02:36:10 -0700 (PDT)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] clocksource/arm_arch_timer: remove unused return type
Date:   Mon, 17 Jun 2019 10:36:01 +0100
Message-Id: <20190617093601.34511-1-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function 'arch_timer_set_evtstrm_feature' has no return statement
despite its prototype - let's change the function prototype to return
void. This matches the equivalent arm64 implementation.

fixes: 11e34eca5d0a ("clocksource/arm_arch_timer: Extract elf_hwcap use to arch-helper")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm/include/asm/arch_timer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index ae533caec1e9..99175812d903 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -125,7 +125,7 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
 	isb();
 }
 
-static inline bool arch_timer_set_evtstrm_feature(void)
+static inline void arch_timer_set_evtstrm_feature(void)
 {
 	elf_hwcap |= HWCAP_EVTSTRM;
 }
-- 
2.21.0

