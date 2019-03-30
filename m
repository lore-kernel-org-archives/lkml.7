Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6991C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8AF206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908135;
	bh=JC9RdOgK4vmqE5NlTns/u3WjAVFX7aJYCUlJrQStTNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1CV3wUHYrGw5/9H4iEbLMbI5Hqsln9J7niEwNrVKql75piBdGs3+0jdBEqDx9JVwk
	 I87klPddCGNdfim+s0qFNe1uvPpJtThvEFgOu7d8+3yVMUS3Ul3oyeEaQ8F5fw1VLN
	 TqNxXMZuhYFZl9vGbj/UOg0sYiQjpy0/wILdUb6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbfC3Awh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731049AbfC3Awg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:52:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57F8E218D3;
        Sat, 30 Mar 2019 00:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907156;
        bh=JC9RdOgK4vmqE5NlTns/u3WjAVFX7aJYCUlJrQStTNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sePpXp5/2C/s8XjpY2B1yhpnDuD2MFMhnMXoYXV4LFfqSiFp10yoO5o7Briv3J2fh
         4SVmWNwm5w7mYnhag17tsBq87jWIw6vZffGn5mku7PLLy1GXrwYV4Pq25Ga8nd5lFD
         i1EncJG7chz+yZVJ3tyNyn4M4VNRePXzK7Q8fFAY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabien Dessenne <fabien.dessenne@st.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 54/67] irqchip/stm32: Don't set rising configuration registers at init
Date:   Fri, 29 Mar 2019 20:50:34 -0400
Message-Id: <20190330005047.25998-54-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Dessenne <fabien.dessenne@st.com>

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

