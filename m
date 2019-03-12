Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF40AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C2C2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411319;
	bh=x6xC6Ww0FqmIaAXz+lnJFqxQPiOH/hOzoIyF8Qj9pBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MZcL/9H/ijvguIRsHrVziylO/hSm4QKZkkggU9xe/GDhrcAyDOYDkhR6ciBNtRxar
	 7dQZFgczkS3QWuWpond31YGrG8F23Se8L2Gg3gACCuDJPsspu67sKlALzTTIi7tm04
	 eYbioNenpS6BhcKaOaCtwQU1WSG1Jk+dutAjp2G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfCLRV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729962AbfCLRSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:18:11 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25CFC21741;
        Tue, 12 Mar 2019 17:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411090;
        bh=x6xC6Ww0FqmIaAXz+lnJFqxQPiOH/hOzoIyF8Qj9pBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AJfiAioGPXTgkc6icZtN6n/va/9b8ffAsmneMVeobpxtHJDM28Bzk2orhAlF7q5UD
         Sj+AXebVAvANIOXkpDFpi830TzSLOFUd1Ui3nSXLBV0tf6i1YvcflkPAlz9BuOVGts
         uB+OegkEwPn2iHafPGww8wCN5Kf7aKb1y0R0H6y8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Pavel Machek <pavel@ucw.cz>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 69/96] irqchip/mmp: Only touch the PJ4 IRQ & FIQ bits on enable/disable
Date:   Tue, 12 Mar 2019 10:10:27 -0700
Message-Id: <20190312171039.812847087@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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



