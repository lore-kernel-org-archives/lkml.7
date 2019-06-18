Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A08C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3D92070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfFRJsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:48:52 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:47889 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfFRJsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:48:51 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MfYHW-1iEQLo2DIO-00g0zN; Tue, 18 Jun 2019 11:48:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/arm_arch_timer: fix arch_timer_set_evtstrm_feature return type
Date:   Tue, 18 Jun 2019 11:48:27 +0200
Message-Id: <20190618094835.3709679-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UIgZ95nkkhH5yq9mtc64kQSjIUtdTsKX0SLMkEgh0FriqqYmcMv
 kxeFtXo0x1iEJD8RRUXpQLFNbtfh7YVHmah3VW5mD91TUWdcM1FeSZvBaQF7j4ykrXU8U42
 Cbms4G14co/9jhPjG7z8eURv5cGVlcAhzENcDkEO3iYZpq1Lw/8/sc6ZVwGjaOiMKUTpIdv
 nMoDcSbC3beBOQtMsL4UA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NrdTgJmQsLs=:pVVaicY1CbeOugFNSXSVgG
 rOgWiznSoDCUAl9Hqna4Qb3JWHNH1nIjTbjr8aAwykAbW+S78E2Zr6hsxeX0/OJpgFunrxJZ5
 EDGRkVaBqNFI52AjT1TjJWlDEdhYS8IlX8kjXUSpZ9l4gSTwP4ctBNftgEYjxRigP21c+WBuQ
 jj9hcUfMxcSz5MkuK1t7wMjghZs4SaPmRokAIcsf/L2Hg39tdCIGrZ1vAkLuGqou+8fq7Ukom
 lwZKhLZDm3/yVrLTDQsUPOcIKTBpfYK/Lsd2RIyc7gtQGqjEAraA0PjnCefsIy7mUFzDvUkwZ
 6SBdJNUe9g77f/30K/7bnqbzK5oe7K1UVhFi9egyDssXTi4hi9aeYodeVrgOE1bVIMrDzUXr5
 9EjPt2Xb4CEclpaF6B7AOSRwsRZ4S/dcMdCq34HJCDB/3BNVxPhlkxLMDbpumONDaeBSo+ebH
 6cJwd57yQjbnNGSf/d2NElc3/5P5Ju5VSDxB47UFg/w3mdNT8DIRLdRo8B/a8ZmKrfkqa5OFv
 y+caxYZqHrOO3wX3KMrlOsHi8QigOCr8TyOB3xoOZXFqW9/fk4jkzPigdpXceG6KQNfpY1x/+
 6sxUClYH423hLKUrUXc6sPmlx+7eejEzHykSXBpyuyTpvcsiARxHRvQDT8wzRDE/jmOAS+nQl
 zHtNuMDsbenzJNHFjq3x+fd+kj93RQ5mVEhSKD+hSpafKpvQ0BhMW9RMaWavVltwpk/26o2nn
 /5zLosyryCW73sHF+phX2SRKzw5lQltarOH7XA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks like it was copied incorrectly from arm64:

In file included from /git/arm-soc/drivers/clocksource/arm_arch_timer.c:31:
arch/arm/include/asm/arch_timer.h:131:1: error: control reaches end of non-void function [-Werror,-Wreturn-type]

Change the type to 'void' as it should be.

Fixes: 11e34eca5d0a ("clocksource/arm_arch_timer: Extract elf_hwcap use to arch-helper")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
2.20.0

