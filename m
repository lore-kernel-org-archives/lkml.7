Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83E8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2682064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908148;
	bh=HExsj6AxZfehEKd4FGnkBNvfwIf8GwSg3sPbxrJ2/X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K+QX4J6TcLcL6p1YVdXMwo/0/2c5pUNpQfhsLiID3Uioq7OEYvh9AjpQaPuCqBUZE
	 lbixAu1Iw3/XTw+PIGpUVnzglGq2cFTGEXwE3C5JLWIlOXhtd3ufvl/swwlmt5QVdw
	 ePcJVEhZkr1eCGRCKS+WPpmcsOtHl8O9QwKSI0z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbfC3BJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731043AbfC3Awf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:52:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4077A218FD;
        Sat, 30 Mar 2019 00:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907155;
        bh=HExsj6AxZfehEKd4FGnkBNvfwIf8GwSg3sPbxrJ2/X4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+j09oIChHOANE+fzpxynr3oLAkaXP+N0Kt5Jj6PNpZR9SkucieeukDkhx66TNQTM
         A9XgbBbDKKZnCiJ/am16c+dwWprCovniQbSIlWq0yUnS1Qg5/FM+HFa1fhjsNyjzGY
         h4+dUA1eFw6SGHm6r01h7oEaiYnTrQoWkUvBC/SM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabien Dessenne <fabien.dessenne@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 53/67] irqchip/stm32: Don't clear rising/falling config registers at init
Date:   Fri, 29 Mar 2019 20:50:33 -0400
Message-Id: <20190330005047.25998-53-sashal@kernel.org>
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
index a93296b9b45d..162a7f547f9e 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -735,11 +735,6 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	 */
 	writel_relaxed(0, base + stm32_bank->imr_ofst);
 	writel_relaxed(0, base + stm32_bank->emr_ofst);
-	writel_relaxed(0, base + stm32_bank->rtsr_ofst);
-	writel_relaxed(0, base + stm32_bank->ftsr_ofst);
-	writel_relaxed(~0UL, base + stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		writel_relaxed(~0UL, base + stm32_bank->fpr_ofst);
 
 	pr_info("%pOF: bank%d\n", h_data->node, bank_idx);
 
-- 
2.19.1

