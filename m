Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AE4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BD02089E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494066;
	bh=GTeKPiSpI0Ea9eCn2SaiWsSMjQ1GBjsNhDD41ADmNiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i+nWnfvpoR82OObq4Gfs1rcbGM2Bv0WVZSpl8WDg4DMeTzVt0CaY8fuJsk482PNgA
	 ZZzn0rDJqdmcOFi5vVVmD5nTfM054y/OiLqekIQtK7w2w13ooMPWwezXbTCYk6PQEz
	 +aZS6b+hIqZPph05vAN2FH0OBVbzgRREtufS7sCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391107AbfHVROZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390557AbfHVRIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:08:53 -0400
Received: from sasha-vm.mshome.net (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F78123406;
        Thu, 22 Aug 2019 17:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493732;
        bh=GTeKPiSpI0Ea9eCn2SaiWsSMjQ1GBjsNhDD41ADmNiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MeIZ2fru3N8E4zfz/34+HclMc2GumerQo5p6PebaZIZ/NhTkQJGvhhrb61/5pR/O0
         vIpByZJZXQBJEKgTck9pl53cMk/OWHIfHr2eLKBFxrdYBA3RGMvM/VhlmEi0+UpbrV
         2Gsr95hAmV4AOfEfdqovo97we01TB3c/y9TQCQII=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 070/135] arm64/efi: fix variable 'si' set but not used
Date:   Thu, 22 Aug 2019 13:07:06 -0400
Message-Id: <20190822170811.13303-71-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.2.10-rc1
X-KernelTest-Deadline: 2019-08-24T17:07+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

[ Upstream commit f1d4836201543e88ebe70237e67938168d5fab19 ]

GCC throws out this warning on arm64.

drivers/firmware/efi/libstub/arm-stub.c: In function 'efi_entry':
drivers/firmware/efi/libstub/arm-stub.c:132:22: warning: variable 'si'
set but not used [-Wunused-but-set-variable]

Fix it by making free_screen_info() a static inline function.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/efi.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index c9e9a6978e73e..d3cb42fd51ec2 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -105,7 +105,11 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 	((protocol##_t *)instance)->f(instance, ##__VA_ARGS__)
 
 #define alloc_screen_info(x...)		&screen_info
-#define free_screen_info(x...)
+
+static inline void free_screen_info(efi_system_table_t *sys_table_arg,
+				    struct screen_info *si)
+{
+}
 
 /* redeclare as 'hidden' so the compiler will generate relative references */
 extern struct screen_info screen_info __attribute__((__visibility__("hidden")));
-- 
2.20.1

