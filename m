Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B397C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AEC256D2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190773;
	bh=oDp3VEB09fC7B/D5QmrWyIiX/u6HdGaoyP3JsUBBgxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hUtzz8F7EaNCk0OzOIhfY3wyP+YqqEa5+an6hnDZZYROfXfgotn7T7dv5u3Msge+z
	 Of4ncQ9m70q3T1IA3wtviPuRlGtjjMu+2xHOqkzdhxsITCDvymA8/oln/Wq6VmxWU7
	 reNKss5A2mkhA/Ad1FGdfv5veaTDZaiM9PdD4FOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbfE3Ecv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729511AbfE3DNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:13:34 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D5832454E;
        Thu, 30 May 2019 03:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186013;
        bh=oDp3VEB09fC7B/D5QmrWyIiX/u6HdGaoyP3JsUBBgxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AY9jXOHFmtifvXhXNopsexVGBGTEmHJkw8P2kw6yYgAro2NoY9VM2cwwj7Ddrxc/u
         hqmqTIVkGk/Euxjxcw8fD1BmVTSB9QTERvoGPlvG7r/2ZhAVpBke72Br0ygVKYTmWu
         ic0nz5NhGUt9bani80tXgBo7/d+mjhalVYMDLbn0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 077/346] ARM: vdso: Remove dependency with the arch_timer driver internals
Date:   Wed, 29 May 2019 20:02:30 -0700
Message-Id: <20190530030545.008780722@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



