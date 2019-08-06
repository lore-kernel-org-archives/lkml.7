Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECF5C32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EAD217D9
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127222;
	bh=SDgvjDR81+fPZOdTNC5f0V9NZfAQNRzqN+nYvN92QTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eFrfdRWF8E8Sb/Hu9ZHqpw45Mtsxe2RUhR82+JcAi28BimDBobOXINp2QnTafQ+sL
	 WaJmKrAoMuoOm9mEFD4c1KROrHYSWx9t2mrz6xLaaPTXJd2EbkY6a7bI397OmjVToY
	 R3wsH8vNVA8unmNOoWwRRTTuqhL/we37dERtMwzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfHFVdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbfHFVdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:33:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F23AF21880;
        Tue,  6 Aug 2019 21:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127216;
        bh=SDgvjDR81+fPZOdTNC5f0V9NZfAQNRzqN+nYvN92QTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wAVfILQ1FIiLfIk1nIhCexoQ78hlDg0Lp0FpJmffFtV9sgDvXQKlNQq8jJ8jMnf+U
         f1FnmWQywVDlD9I0zDAQidMWujql4JUel7E0srMewafagAvZzwAK7+74sWA9Wilwon
         +HRfZ5OnetEmKIVUq9hWEVYb8QCDhkIvu5Q267QU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 13/59] irqchip/irq-imx-gpcv2: Forward irq type to parent
Date:   Tue,  6 Aug 2019 17:32:33 -0400
Message-Id: <20190806213319.19203-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213319.19203-1-sashal@kernel.org>
References: <20190806213319.19203-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit 9a446ef08f3bfc0c3deb9c6be840af2528ef8cf8 ]

The GPCv2 is a stacked IRQ controller below the ARM GIC. It doesn't
care about the IRQ type itself, but needs to forward the type to the
parent IRQ controller, so this one can be configured correctly.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-imx-gpcv2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index bf2237ac5d091..4f74c15c47555 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -131,6 +131,7 @@ static struct irq_chip gpcv2_irqchip_data_chip = {
 	.irq_unmask		= imx_gpcv2_irq_unmask,
 	.irq_set_wake		= imx_gpcv2_irq_set_wake,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= irq_chip_set_type_parent,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 #endif
-- 
2.20.1

