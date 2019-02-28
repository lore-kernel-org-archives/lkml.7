Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09261C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9202184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367008;
	bh=T50QTrDNAQdl0JCSa3u2cu3O1pu4oLRi+GHYDeLMo1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IY2xlkLX2MtKxf9l3eqO0O5jLHkqSej/V+R+cJ30mouRmnuD68jqMM9PeJh6/ZweO
	 yMPE3Z7itLLeHhIhIDQKGv1NCI7S2nS+2TWTYGHLENAa14C8Htp976EenP9PLPqOrE
	 bU+c5t8kUe8ltOenHctGRjB2l76magpzlGbpB3LA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389107AbfB1PQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:16:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389057AbfB1PQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:16:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9871A2184A;
        Thu, 28 Feb 2019 15:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366991;
        bh=T50QTrDNAQdl0JCSa3u2cu3O1pu4oLRi+GHYDeLMo1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLzi49lJWxWIf+U+t6WtksjvQ3EQetZhpFsxJz9SpNbW2/OfDHZQ6Rq2JePqDTheY
         Moeesu7s1+aDKbk1j/xg8njdFTzF6nqyqGCZ3CfDX3W4VDtXDJ8xYU1ArCeUwR9EPK
         PNQ/qig2O+HyDyH0PXS9yGRAAWClG0V/MzBe+mWA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 2/5] irqchip/mmp: Only touch the PJ4 IRQ & FIQ bits on enable/disable
Date:   Thu, 28 Feb 2019 10:16:24 -0500
Message-Id: <20190228151628.13364-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151628.13364-1-sashal@kernel.org>
References: <20190228151628.13364-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

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
index c0da57bdb89df..7924d21c86ecb 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -35,6 +35,9 @@
 #define SEL_INT_PENDING		(1 << 6)
 #define SEL_INT_NUM_MASK	0x3f
 
+#define MMP2_ICU_INT_ROUTE_PJ4_IRQ	(1 << 5)
+#define MMP2_ICU_INT_ROUTE_PJ4_FIQ	(1 << 6)
+
 struct icu_chip_data {
 	int			nr_irqs;
 	unsigned int		virq_base;
@@ -191,7 +194,8 @@ static struct mmp_intc_conf mmp_conf = {
 static struct mmp_intc_conf mmp2_conf = {
 	.conf_enable	= 0x20,
 	.conf_disable	= 0x0,
-	.conf_mask	= 0x7f,
+	.conf_mask	= MMP2_ICU_INT_ROUTE_PJ4_IRQ |
+			  MMP2_ICU_INT_ROUTE_PJ4_FIQ,
 };
 
 static void __exception_irq_entry mmp_handle_irq(struct pt_regs *regs)
-- 
2.19.1

