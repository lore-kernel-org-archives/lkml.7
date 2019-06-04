Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77003C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D34324873
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559646359;
	bh=QCciAXZOWSYqp12nDOySk0Dfu903DAThXA8VOOFo/O8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0GepxTjf9f5c/tGrfWn422fhc9OQPG0cWzM7igW4KIrzcqNBChKd0BWt4v50ZgRT6
	 W/08FHpadlD+dxFr4/yGPfM7oPfhVFXgF9eBLfclRxEBVjAUYLC4Nki0Xue/rP8f1y
	 Beb5hIQrEeJHT1onZRBJxOwPQLcAk++1ZRP60r6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfFDLF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbfFDLF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:05:56 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E7E9247FC;
        Tue,  4 Jun 2019 11:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559646356;
        bh=QCciAXZOWSYqp12nDOySk0Dfu903DAThXA8VOOFo/O8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G18gyFNIj3nVOkLmOnLE4/LHinmOO9jGBJSCia8IiXmo/ZDmlkFGLVzdtND19AVr4
         3Ps9CVq+rNe9IUrWdxCFdNdXn+fTfS+jgTvMjCbjHKlZ17ShbjAL3MXb28x2KMWUkC
         vs4gnF9H882dSDdwI1l5cE31rB5G3zgSbgtx8V68=
From:   guoren@kernel.org
To:     marc.zyngier@arm.com, mark.rutland@arm.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        guoren@kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V4 4/4] irqchip/irq-csky-mpintc: Remove unnecessary loop in interrupt handler
Date:   Tue,  4 Jun 2019 19:05:06 +0800
Message-Id: <1559646306-18860-5-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559646306-18860-1-git-send-email-guoren@kernel.org>
References: <1559646306-18860-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

csky_mpintc_handler()
  ->handle_domain_irq()
    ->irq_exit()
      ->invoke_softirq()
        ->__do_softirq()
          ->local_irq_enable()

If new interrupt coming, it'll get into interrupt trap before return to
csky_mpintc_handler(). So there is no need loop in csky_mpintc_handler.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-csky-mpintc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index 2740dd5..122cd43 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -75,11 +75,8 @@ static void csky_mpintc_handler(struct pt_regs *regs)
 {
 	void __iomem *reg_base = this_cpu_read(intcl_reg);
 
-	do {
-		handle_domain_irq(root_domain,
-				  readl_relaxed(reg_base + INTCL_RDYIR),
-				  regs);
-	} while (readl_relaxed(reg_base + INTCL_HPPIR) & BIT(31));
+	handle_domain_irq(root_domain,
+		readl_relaxed(reg_base + INTCL_RDYIR), regs);
 }
 
 static void csky_mpintc_enable(struct irq_data *d)
-- 
2.7.4

