Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E17C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E570520675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611093;
	bh=T5T+ElXdFMownClrCaGzoY0A3x6xprexCifYw8U5ttM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z9REuHsuuMlPamriPzcxT2SX8ZG6Mw5OyQ39cEcKKq+gSGjqh0tSrjJFHGh4WLqid
	 mT/v1zAmvf/VW4glnSiZ4YceLtdyayeXGpUcdvzeHqpJHkNJKiHEygtSRBSldSpxQ4
	 RBWZIe/fHwdJmTJB/vA4a+smoEoVkfrDsDOAEIbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403908AbfDRSLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:11:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404226AbfDRSL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:11:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A39320652;
        Thu, 18 Apr 2019 18:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611087;
        bh=T5T+ElXdFMownClrCaGzoY0A3x6xprexCifYw8U5ttM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ADmZLtMyyPLVSdcwqReiRgrdEUyj3+qRD7qz4lHL+gfkeYtCrHChZVPraIclmThGh
         Np4saKyVwwHEhkuniNSr+Y4IR4eUcrXfEGMmtFumceIclLkYt2/9qLzWZ3hVHkmdVo
         1nqvQgE68iTWmMhS87KRtETEcMl2+CGzOGf45k/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabien Dessenne <fabien.dessenne@st.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 54/93] irqchip/stm32: Dont set rising configuration registers at init
Date:   Thu, 18 Apr 2019 19:57:32 +0200
Message-Id: <20190418160443.102140041@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6a77623d78b307b34d4cf7886da6a907689bf388 ]

The rising configuration status register (rtsr) is not banked.
As it is shared with the co-processor, it should not be written at probe
time, else the co-processor configuration will be lost.

Fixes: f9fc1745501e ("irqchip/stm32: Add host and driver data structures")
Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-stm32-exti.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 162a7f547f9e..7bd1d4cb2e19 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -716,7 +716,6 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	const struct stm32_exti_bank *stm32_bank;
 	struct stm32_exti_chip_data *chip_data;
 	void __iomem *base = h_data->base;
-	u32 irqs_mask;
 
 	stm32_bank = h_data->drv_data->exti_banks[bank_idx];
 	chip_data = &h_data->chips_data[bank_idx];
@@ -725,10 +724,6 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 
 	raw_spin_lock_init(&chip_data->rlock);
 
-	/* Determine number of irqs supported */
-	writel_relaxed(~0UL, base + stm32_bank->rtsr_ofst);
-	irqs_mask = readl_relaxed(base + stm32_bank->rtsr_ofst);
-
 	/*
 	 * This IP has no reset, so after hot reboot we should
 	 * clear registers to avoid residue
-- 
2.19.1



