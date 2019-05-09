Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F41C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE94217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427967;
	bh=NMYyZT0F0YGxz2ey2INVI3Xw3PP5AjmNPCWm6Y2eH8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RYDn5cfKMOWIVLAD/ewaKDHBi5U2/rXFpwBLDxtOEfjrV6rMnoPenagKsCT0Vjc3a
	 gt3lACOG68GCHOXI9Fy12LF2T1oim8p7a1xIaXfTNTy92rRoR0qBHnaBgg/0Z0xyOt
	 F0yPN+72MRoIxi9uWg8FvX/FB+ky9ed0LrGApo50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfEISwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728749AbfEISwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:52:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2D4B217F5;
        Thu,  9 May 2019 18:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427961;
        bh=NMYyZT0F0YGxz2ey2INVI3Xw3PP5AjmNPCWm6Y2eH8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1/jjW6rlUSLUXeFynj1CI7MUf4dDnMHsSjo9ihhlSLx8t7lx8qmm2iPqdf+vjFEN
         XTT04+8pBayaBKVfiy+jz+uoyQxIUjKu4Rm1MV+V2HUNGs5xXdIabG6xh+p43Oujbf
         F4U7OYTQVj7emrKigNtB+kN6fS3iItHT9msAmN4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chong Qiao <qiaochong@loongson.cn>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 33/95] MIPS: KGDB: fix kgdb support for SMP platforms.
Date:   Thu,  9 May 2019 20:41:50 +0200
Message-Id: <20190509181311.612414702@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181309.180685671@linuxfoundation.org>
References: <20190509181309.180685671@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ab8a6d821179ab9bea1a9179f535ccba6330c1ed ]

KGDB_call_nmi_hook is called by other cpu through smp call.
MIPS smp call is processed in ipi irq handler and regs is saved in
 handle_int.
So kgdb_call_nmi_hook get regs by get_irq_regs and regs will be passed
 to kgdb_cpu_enter.

Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: QiaoChong <qiaochong@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/kgdb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
index 149100e1bc7c4..90f37626100fe 100644
--- a/arch/mips/kernel/kgdb.c
+++ b/arch/mips/kernel/kgdb.c
@@ -33,6 +33,7 @@
 #include <asm/processor.h>
 #include <asm/sigcontext.h>
 #include <linux/uaccess.h>
+#include <asm/irq_regs.h>
 
 static struct hard_trap_info {
 	unsigned char tt;	/* Trap type code for MIPS R3xxx and R4xxx */
@@ -214,7 +215,7 @@ void kgdb_call_nmi_hook(void *ignored)
 	old_fs = get_fs();
 	set_fs(get_ds());
 
-	kgdb_nmicallback(raw_smp_processor_id(), NULL);
+	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
 
 	set_fs(old_fs);
 }
-- 
2.20.1



