Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349FAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0716B21872
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610399;
	bh=Sk7bLpbMRmcZzjpegfyGyIzthvgSc74dKtvsMe3rWgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T3/V/hC3+/ncHKpmu7UfRzMlUm+wi8YRi6OXiOWZ5MMCQgIvZ0qgTY4DXG3o8IiR4
	 wDydMmyGtP6zbBbPn0ySIKs3uyOF42M7eTbIIhRsBXf0sBdFxlt3VpIdpND+Rn1ur2
	 DRBSNQJlUIhjUUyKnmSjn8xYNGiSitXUmiqNKRWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390251AbfDRR74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389831AbfDRR7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:59:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05EE221871;
        Thu, 18 Apr 2019 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610389;
        bh=Sk7bLpbMRmcZzjpegfyGyIzthvgSc74dKtvsMe3rWgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oybIr2arKG/K7S/7epdCM+YSia20JMouULFhlIEG8/SSzzWXGE+RmvlPsFp9RyJec
         cGRRwQvvDunPpu+lWqxmYlodKnxpw91/MR65sVz7wf5Jc2boU7VfCzcM1vhaJT7Txk
         zi8ytbEBJ3gE27ldwSEgAchJG1CpJNWXCGEmX2OI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Loic Pallardy <loic.pallardy@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 042/110] irqchip/stm32: Dont clear rising/falling config registers at init
Date:   Thu, 18 Apr 2019 19:56:31 +0200
Message-Id: <20190418160442.913689929@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0dda09666f50eae9c5b794dd89b1fd8a8d89d714 ]

Falling and rising configuration and status registers are not banked.
As they are shared with M4 co-processor, they should not be cleared
at probe time, else M4 co-processor configuration will be lost.

Fixes: f9fc1745501e ("irqchip/stm32: Add host and driver data structures")
Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-stm32-exti.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 0a2088e12d96..97b27f338c30 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -650,11 +650,6 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	 */
 	writel_relaxed(0, base + stm32_bank->imr_ofst);
 	writel_relaxed(0, base + stm32_bank->emr_ofst);
-	writel_relaxed(0, base + stm32_bank->rtsr_ofst);
-	writel_relaxed(0, base + stm32_bank->ftsr_ofst);
-	writel_relaxed(~0UL, base + stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		writel_relaxed(~0UL, base + stm32_bank->fpr_ofst);
 
 	pr_info("%s: bank%d, External IRQs available:%#x\n",
 		node->full_name, bank_idx, irqs_mask);
-- 
2.19.1



