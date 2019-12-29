Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EECC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18A3206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641213;
	bh=p9hOrNf6ndXsGe6SBR4xfrSHCSiz+e033Ce3mV0k+2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DZR4vJ6N18Wjs2clOFjKo9d/oK1p+H+BiVzuhvM9glrtmS8m3mZxHnUZRGxOs/jyk
	 WL3az+GeswFSLwsILkREJhtKX6AzBwgtbYuCCJFuWd2VR17KzNBnbBd6X4Ybi9f8FN
	 vK+5naHfB+cmUd/s6GFSotL7bhpqQTz0Ah1Dp0vA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbfL2RkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729254AbfL2RcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:32:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A46FA20409;
        Sun, 29 Dec 2019 17:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640726;
        bh=p9hOrNf6ndXsGe6SBR4xfrSHCSiz+e033Ce3mV0k+2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wYuK2tmfgOAchCpeYq6+3NkhO4cCuq9q+WabM0G+BSj1dROo4kx6yC4qQ/s9p7Te8
         K5smEe0Rp1tQTQD/+x93F89+ckI75ZZsa7iZROvXlCVnWHpdJIdNzHQsLMur6fXMtk
         Y73EHjlUYvliTl5kKDrgIPUgmmbvzwD4sukp1oIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 113/219] pinctrl: amd: fix __iomem annotation in amd_gpio_irq_handler()
Date:   Sun, 29 Dec 2019 18:18:35 +0100
Message-Id: <20191229162525.747306464@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>

[ Upstream commit 10ff58aa3c2e2a093b6ad615a7e3d8bb0dc613e5 ]

The regs pointer in amd_gpio_irq_handler() should have __iomem
on it, so add that to fix the following sparse warnings:

drivers/pinctrl/pinctrl-amd.c:555:14: warning: incorrect type in assignment (different address spaces)
drivers/pinctrl/pinctrl-amd.c:555:14:    expected unsigned int [usertype] *regs
drivers/pinctrl/pinctrl-amd.c:555:14:    got void [noderef] <asn:2> *base
drivers/pinctrl/pinctrl-amd.c:563:34: warning: incorrect type in argument 1 (different address spaces)
drivers/pinctrl/pinctrl-amd.c:563:34:    expected void const volatile [noderef] <asn:2> *addr
drivers/pinctrl/pinctrl-amd.c:563:34:    got unsigned int [usertype] *
drivers/pinctrl/pinctrl-amd.c:580:34: warning: incorrect type in argument 1 (different address spaces)
drivers/pinctrl/pinctrl-amd.c:580:34:    expected void const volatile [noderef] <asn:2> *addr
drivers/pinctrl/pinctrl-amd.c:580:34:    got unsigned int [usertype] *
drivers/pinctrl/pinctrl-amd.c:587:25: warning: incorrect type in argument 2 (different address spaces)
drivers/pinctrl/pinctrl-amd.c:587:25:    expected void volatile [noderef] <asn:2> *addr
drivers/pinctrl/pinctrl-amd.c:587:25:    got unsigned int [usertype] *

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
Link: https://lore.kernel.org/r/20191022151154.5986-1-ben.dooks@codethink.co.uk
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-amd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index cd7a5d95b499..b1ffdd3f6d07 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -544,7 +544,8 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
 	irqreturn_t ret = IRQ_NONE;
 	unsigned int i, irqnr;
 	unsigned long flags;
-	u32 *regs, regval;
+	u32 __iomem *regs;
+	u32  regval;
 	u64 status, mask;
 
 	/* Read the wake status */
-- 
2.20.1



