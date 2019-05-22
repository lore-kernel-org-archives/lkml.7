Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD45C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03F5217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558553094;
	bh=mibAVy0PVVNwmlo5Q1CNdnmUfDT2lZ1LOSe4QVCbVEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g5vk0fT3nZs/6WIP6/28l+x15qSqGBbBuDhqx1I7ey484iwmFNOxNcyikDGzAbO4t
	 0VEDqYxCBARkJjO70JoEKYGm6LWhV2AwntYVhD5Cp2Oe7XyJd5403v9UYEZSu2aeiU
	 AOobgoHXvT8klMMlbgGYgqNXIfw5ZCe8+YpBp8OU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbfEVTYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731392AbfEVTYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:24:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEDDF20879;
        Wed, 22 May 2019 19:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553085;
        bh=mibAVy0PVVNwmlo5Q1CNdnmUfDT2lZ1LOSe4QVCbVEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gW5igHF8QNPQhQLKu/TfP7/8XdNQqTOaubfCukgVgNSAV7roZgSeJ5JHjaVrBuqDO
         KlLfcsF9Qbc0jALKUDmaf4x8iJMKymGPjrp7270sMkpK+74VRySHyLFQEkFmGRvmBM
         o5gN0zTXGZ4VYYrjYoMBLaztf8CTP4+pWZiEIX4A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 039/317] ARM: vdso: Remove dependency with the arch_timer driver internals
Date:   Wed, 22 May 2019 15:19:00 -0400
Message-Id: <20190522192338.23715-39-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192338.23715-1-sashal@kernel.org>
References: <20190522192338.23715-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit 1f5b62f09f6b314c8d70b9de5182dae4de1f94da ]

The VDSO code uses the kernel helper that was originally designed
to abstract the access between 32 and 64bit systems. It worked so
far because this function is declared as 'inline'.

As we're about to revamp that part of the code, the VDSO would
break. Let's fix it by doing what should have been done from
the start, a proper system register access.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/cp15.h   | 2 ++
 arch/arm/vdso/vgettimeofday.c | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index 07e27f212dc75..d2453e2d3f1f3 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -68,6 +68,8 @@
 #define BPIALL				__ACCESS_CP15(c7, 0, c5, 6)
 #define ICIALLU				__ACCESS_CP15(c7, 0, c5, 0)
 
+#define CNTVCT				__ACCESS_CP15_64(1, c14)
+
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 
 static inline unsigned long get_cr(void)
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index a9dd619c6c290..7bdbf5d5c47d3 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -18,9 +18,9 @@
 #include <linux/compiler.h>
 #include <linux/hrtimer.h>
 #include <linux/time.h>
-#include <asm/arch_timer.h>
 #include <asm/barrier.h>
 #include <asm/bug.h>
+#include <asm/cp15.h>
 #include <asm/page.h>
 #include <asm/unistd.h>
 #include <asm/vdso_datapage.h>
@@ -123,7 +123,8 @@ static notrace u64 get_ns(struct vdso_data *vdata)
 	u64 cycle_now;
 	u64 nsec;
 
-	cycle_now = arch_counter_get_cntvct();
+	isb();
+	cycle_now = read_sysreg(CNTVCT);
 
 	cycle_delta = (cycle_now - vdata->cs_cycle_last) & vdata->cs_mask;
 
-- 
2.20.1

