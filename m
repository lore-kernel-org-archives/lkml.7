Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6ABC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3701720870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566496008;
	bh=UQ8Ck8beOoAG5unTjjmxqkGlgJyFjjAtdvlh3GDzJVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mpdAoVb4eFXPb/X1N2+W+TZM2YCYIkZqqR4XNZtLIZsoq4lsMImM6GR4EdK3uC5J5
	 uN0cPfGg5YLm+RmkfbCsVRJM8N/5IibQmb9aEHsAE8YDnu29kVmW6W1F3Q/esFa+xX
	 8Z1q2zY4/NyWci9CwxFTNw3mScjnv5CLOVko9jdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391452AbfHVRWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391414AbfHVRWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:22:38 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6212321743;
        Thu, 22 Aug 2019 17:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494558;
        bh=UQ8Ck8beOoAG5unTjjmxqkGlgJyFjjAtdvlh3GDzJVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lB4Gq688eNTG92IEuJHwyKP8xGL3Y3D9YB/tNICo8g2/WI7WQnA94BV3hzGHmUBx9
         0naGW1WNGxaUsSwiACXK8DYxKR5bDIj6Ftb9LRIfvEdYunpBpugWToN3UPFNQ3vhph
         ZOQoDpPbTAgW4suOVOmTWwQp/awn/Oi3urp84C68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 45/78] irqchip/irq-imx-gpcv2: Forward irq type to parent
Date:   Thu, 22 Aug 2019 10:18:49 -0700
Message-Id: <20190822171833.344979645@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171832.012773482@linuxfoundation.org>
References: <20190822171832.012773482@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 2d203b422129e..c56da0b13da5d 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -145,6 +145,7 @@ static struct irq_chip gpcv2_irqchip_data_chip = {
 	.irq_unmask		= imx_gpcv2_irq_unmask,
 	.irq_set_wake		= imx_gpcv2_irq_set_wake,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= irq_chip_set_type_parent,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 #endif
-- 
2.20.1



