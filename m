Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE385C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F92218FD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907346;
	bh=DuBdEdG4C10uQ/VybgsnniNYLisy4B48gkFMudNEeGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m0t8vLyRGli2jpJ0/55qQV81KGZmpynTPWeaMgLZT6MpuhSBFpkX7er6I7/6dKqIm
	 PPGJyE64S4kXIBWRsPqb0fg4GtJnoYyCHpVWQo3caDwHH/yXsY1+CzIg9p/NzLA/Cb
	 srgzX1EHbwLWcpMCoZ9EHPRYgtYomQxgmYE2nAIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbfC3Azp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730632AbfC3Azm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:55:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B35E62064A;
        Sat, 30 Mar 2019 00:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907341;
        bh=DuBdEdG4C10uQ/VybgsnniNYLisy4B48gkFMudNEeGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LnI4UfFXr90spiIab2PmmMNNh6OrA/1W28Z9py+4/twQQm3qEfYtTtQiIlupYw3mV
         8E7/V7SI9xgyjKCyqH2OjTGjMM1E4iINCCa+CW3bWN8pouQDxKeXgqOnrPAcvoomkG
         4wWMWgzOwkBbXQwSEi5S6UT98Gzh/YHVeBwxINBo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jianguo Chen <chenjianguo3@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 30/37] irqchip/mbigen: Don't clear eventid when freeing an MSI
Date:   Fri, 29 Mar 2019 20:54:31 -0400
Message-Id: <20190330005441.27540-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005441.27540-1-sashal@kernel.org>
References: <20190330005441.27540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianguo Chen <chenjianguo3@huawei.com>

[ Upstream commit fca269f201a8d9985c0a31fb60b15d4eb57cef80 ]

mbigen_write_msg clears eventid bits of a mbigen register
when free a interrupt, because msi_domain_deactivate memset
struct msg to zero. Then multiple mbigen pins with zero eventid
will report the same interrupt number.

The eventid clear call trace:
                free_irq
                __free_irq
                irq_shutdown
                irq_domain_deactivate_irq
                __irq_domain_deactivate_irq
                __irq_domain_deactivate_irq
                msi_domain_deactivate
                platform_msi_write_msg
                mbigen_write_msg

Signed-off-by: Jianguo Chen <chenjianguo3@huawei.com>
[maz: massaged subject]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-mbigen.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 567b29c47608..98b6e1d4b1a6 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -161,6 +161,9 @@ static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 	void __iomem *base = d->chip_data;
 	u32 val;
 
+	if (!msg->address_lo && !msg->address_hi)
+		return;
+ 
 	base += get_mbigen_vec_reg(d->hwirq);
 	val = readl_relaxed(base);
 
-- 
2.19.1

