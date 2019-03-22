Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF678C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02E320449
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254392;
	bh=dvxT1ZJo3SeR6+qNixqlYdeRORes1t2223B6b+Z4wrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b6Azqi9XsyMfz+z73JwPwEwBLfvkLIa3oPSNZWI/6S8eS65uFei4FiwD6S3kdM16j
	 iX3xuANWzpyGrLg6vcazc3M3snSB8WCZPDGuw9+Sql/gEAOvv3gJZNI6uwH9XCWtBN
	 kR5Yku3QQHDcksMlXD/U2mgp9sQfx5Gz6j88AxRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfCVLdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730237AbfCVLdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:33:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E12B020449;
        Fri, 22 Mar 2019 11:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254388;
        bh=dvxT1ZJo3SeR6+qNixqlYdeRORes1t2223B6b+Z4wrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ueGxXKrswvHb5OJIooZn/Uw1pRS6H2pvMMmnXnmwASIXouj54cawnSo6OF1UGjecl
         2I4TDO4lS5I57ADHlstPz7oN92BKamuFScJ0Xr+LWqgnFSWk5yfI1ldV/2zhEc17C+
         6NzX/KIRhlVD1ZUNdbsEhQxuHf+t/D/vgVCwxvgg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Pavel Machek <pavel@ucw.cz>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 106/230] irqchip/mmp: Only touch the PJ4 IRQ & FIQ bits on enable/disable
Date:   Fri, 22 Mar 2019 12:14:04 +0100
Message-Id: <20190322111244.032430406@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index 013fc9659a84..2fe2bcb63a71 100644
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
@@ -190,7 +193,8 @@ static struct mmp_intc_conf mmp_conf = {
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



