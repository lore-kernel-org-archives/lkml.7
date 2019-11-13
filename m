Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98149C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C35B21D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611998;
	bh=k5ZRh2ikyUYWBdoD1qh1lHWr6fCnKfqiDBwbD6/ssmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FBnt3jDTG0x1jhMmVvDeFTh+HpyAR1Fgzr9VZhrK2PYriA68pxg/KxVxUGsGDm2B4
	 Nal133Ec5TVJ8JJVbWH5l3AlgfOdX2R7i02mE4DCSOwrM8oIkZMxZ2rOWzgVq//j2R
	 qXCgnS4CxQRmhU20qEFRZVI4jEEPg3fGiR7F+gNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfKMC0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:26:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727743AbfKMBvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:51:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B062C222CE;
        Wed, 13 Nov 2019 01:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609874;
        bh=k5ZRh2ikyUYWBdoD1qh1lHWr6fCnKfqiDBwbD6/ssmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PM8t8VvaBwvqguNWkiWag13pgZwRhc25IQYKLbVytz3bSIchgIoiiDAISiUST+ntb
         5UcsU1I6YQPsIM4iGX0oyi3mnJXXoJImw+qM1XWCW9hzLnmcgvsEGfl7rCHAJSQtiP
         Z0M5H95GpthOtE0gD+6GvXC6Lun2VswVWQcueIq4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 037/209] irqchip/irq-mvebu-icu: Fix wrong private data retrieval
Date:   Tue, 12 Nov 2019 20:47:33 -0500
Message-Id: <20191113015025.9685-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 2b4dab69dcca13c5be2ddaf1337ae4accd087de6 ]

The irq_domain structure has an host_data pointer that just stores
private data. It is meant to not be touched by the IRQ core. However,
when it comes to MSI, the MSI layer adds its own private data there
with a structure that also has a host_data pointer.

Because this IRQ domain is an MSI domain, to access private data we
should do a d->host_data->host_data, also wrapped as
'platform_msi_get_host_data()'.

This bug was lying there silently because the 'icu' structure retrieved
this way was just called by dev_err(), only producing a
'(NULL device *):' output on the console.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-mvebu-icu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 13063339b416d..a2a3acd744911 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -105,7 +105,7 @@ static int
 mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
 			       unsigned long *hwirq, unsigned int *type)
 {
-	struct mvebu_icu *icu = d->host_data;
+	struct mvebu_icu *icu = platform_msi_get_host_data(d);
 	unsigned int icu_group;
 
 	/* Check the count of the parameters in dt */
-- 
2.20.1

