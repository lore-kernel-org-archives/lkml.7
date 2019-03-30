Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F44C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0A62064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907902;
	bh=A3UbMDlX/zOx2baCLKE1JZLZ3LxQVFy5CGV83wDXRNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U/B1XiyU09GdSKXxPIABFXU36E0N/B8aOFaxi9y4gD5wEu/+2fV1pzQYMoG3MZdMW
	 oL8kVfN+fP74ojAiLfpmMGyAN1UjFHrJIRw8147Xw4wtbOSgFdOwzC7l5MF7at9P0n
	 vuvukHRvKP0pXTcLBhJl2f0eFlVe/7IleO//xnOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbfC3AyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731493AbfC3AyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:54:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31293218D3;
        Sat, 30 Mar 2019 00:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907258;
        bh=A3UbMDlX/zOx2baCLKE1JZLZ3LxQVFy5CGV83wDXRNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KGSusXO7wWWKjanGhA9J5QKIW1bf0psn544+xfgc71A7vfR5OM0EnowyR3J3XIbPM
         ozXpD/eaQHoVKOmQBpKgt4iQ90PUtZtQr43YoeAjgvEu5E3adwnw1M9Mjy7nEn0qZu
         GaL7IW4Sdbf945XbMLdEJYbfeBTnQfwvScg7ntGw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabien Dessenne <fabien.dessenne@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 42/52] irqchip/stm32: Don't clear rising/falling config registers at init
Date:   Fri, 29 Mar 2019 20:52:49 -0400
Message-Id: <20190330005301.26868-42-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005301.26868-1-sashal@kernel.org>
References: <20190330005301.26868-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Dessenne <fabien.dessenne@st.com>

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

