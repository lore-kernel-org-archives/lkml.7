Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D959DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED51205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413878;
	bh=kaNzTmgbZPKvVJEtQAML7F2xLRkcxEAnSObwDkdAsEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s6nFK3t/NnzdEycBV6OYa0f2PulQhKpe33iRSPTkYr3ausuFUPtL/i8BGhKkHjyma
	 wCfzkX66ANNEjIq2kXknKh21nohBkPRLFXjgvUS5xRpS/dbyFTofJiKazw5Ms1+3/v
	 OpvEZeC1s8eAsbeAGGSK8nxcPMf+4pa1UdUl2gMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfCLSEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:04:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfCLRMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:47 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 719E1217F4;
        Tue, 12 Mar 2019 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410766;
        bh=kaNzTmgbZPKvVJEtQAML7F2xLRkcxEAnSObwDkdAsEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B8+aTIWOKxuOzfSaT8WdAJ2N77nhpx91yi72MYiPuQyhPthNuWxd7SvL5xpGjgW5E
         37vySNrSRnPH8kIbgMoarS4auRCmbM7xs+R6ciUzI9Ge/8wR7Rphz0LhL4psb8roPH
         1OVKpdDMBVmIQ8VAicCPhMeAWWw/asjXRQw01IQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Pavel Machek <pavel@ucw.cz>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 100/171] irqchip/mmp: Only touch the PJ4 IRQ & FIQ bits on enable/disable
Date:   Tue, 12 Mar 2019 10:08:00 -0700
Message-Id: <20190312170356.677881563@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2380a22b60ce6f995eac806e69c66e397b59d045 ]

Resetting bit 4 disables the interrupt delivery to the "secure
processor" core. This breaks the keyboard on a OLPC XO 1.75 laptop,
where the firmware running on the "secure processor" bit-bangs the
PS/2 protocol over the GPIO lines.

It is not clear what the rest of the bits are and Marvell was unhelpful
when asked for documentation. Aside from the SP bit, there are probably
priority bits.

Leaving the unknown bits as the firmware set them up seems to be a wiser
course of action compared to just turning them off.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
[maz: fixed-up subject and commit message]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-mmp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 25f32e1d7764..3496b61a312a 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -34,6 +34,9 @@
 #define SEL_INT_PENDING		(1 << 6)
 #define SEL_INT_NUM_MASK	0x3f
 
+#define MMP2_ICU_INT_ROUTE_PJ4_IRQ	(1 << 5)
+#define MMP2_ICU_INT_ROUTE_PJ4_FIQ	(1 << 6)
+
 struct icu_chip_data {
 	int			nr_irqs;
 	unsigned int		virq_base;
@@ -190,7 +193,8 @@ static const struct mmp_intc_conf mmp_conf = {
 static const struct mmp_intc_conf mmp2_conf = {
 	.conf_enable	= 0x20,
 	.conf_disable	= 0x0,
-	.conf_mask	= 0x7f,
+	.conf_mask	= MMP2_ICU_INT_ROUTE_PJ4_IRQ |
+			  MMP2_ICU_INT_ROUTE_PJ4_FIQ,
 };
 
 static void __exception_irq_entry mmp_handle_irq(struct pt_regs *regs)
-- 
2.19.1



