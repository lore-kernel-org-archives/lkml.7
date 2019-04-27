Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9219DC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C96D2166E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329287;
	bh=m8Uv4mu0G420dZMTfAaTAzt4QTqiurP9GomMjd4p7P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K0mTa1ECAHZEZy6BDLW1MANDAJ/WduYjYBmfoGEzyxaOxbIAjeM+vsyK0ZTHNXKcA
	 i9LRnK1S9G30F09wHYKPThuCZfkUbeVRc6mTZMe0K7/CnLIBGqBjTeP+KfRVpVAcv9
	 2RAfH9Uoh1+g7ssMELfc+pR4DUW1JvpCtN9fLKa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfD0Bl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbfD0BlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:41:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D692320C01;
        Sat, 27 Apr 2019 01:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329284;
        bh=m8Uv4mu0G420dZMTfAaTAzt4QTqiurP9GomMjd4p7P8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UhsLBDh/sKUeel18zywKqX4u5pVsq0VQ4sG/oIW/6FMyt1x288ZP/9ZeKmDtPCTDv
         uXHHtN8sf+M+B3pNFIHbEh/9mAq6esllkrMGM/WdlmD+lAbv55dtjUfi6lj8M8dVaI
         xegMIY+z4ASTaGHtGBFdJ55JAmeqmnU4WWwysZfg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chong Qiao <qiaochong@loongson.cn>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 21/53] MIPS: KGDB: fix kgdb support for SMP platforms.
Date:   Fri, 26 Apr 2019 21:40:18 -0400
Message-Id: <20190427014051.7522-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chong Qiao <qiaochong@loongson.cn>

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
index eb6c0d582626..2c1e30ca7ee4 100644
--- a/arch/mips/kernel/kgdb.c
+++ b/arch/mips/kernel/kgdb.c
@@ -33,6 +33,7 @@
 #include <asm/processor.h>
 #include <asm/sigcontext.h>
 #include <linux/uaccess.h>
+#include <asm/irq_regs.h>
 
 static struct hard_trap_info {
 	unsigned char tt;	/* Trap type code for MIPS R3xxx and R4xxx */
@@ -214,7 +215,7 @@ static void kgdb_call_nmi_hook(void *ignored)
 	old_fs = get_fs();
 	set_fs(get_ds());
 
-	kgdb_nmicallback(raw_smp_processor_id(), NULL);
+	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
 
 	set_fs(old_fs);
 }
-- 
2.19.1

