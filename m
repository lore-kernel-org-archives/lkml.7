Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDCBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F07920C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565103469;
	bh=KSXYsUHI593N5vg/VOIQbiEWS945gHLnS2T7PyNBqpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dgDfnDJ7TJtzw5z8Fzaa8OLjbyBCRlA1cFe7/3q74jIZUWYvuc85YnKyAUGFrgA30
	 DdVF7Os45cr+qnRzQvs7KC3IYWDlFpaAp9ohODTz42g+ut8Gfrhb2zGTb0Fbrt2GAi
	 JNvWuBrrPmvj1J2Igjp1CUFyeK9GW5EouM4clnBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbfHFO5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:57:44 -0400
Received: from foss.arm.com ([217.140.110.172]:34748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733146AbfHFO5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:57:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D0461688;
        Tue,  6 Aug 2019 07:57:36 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F2B93F706;
        Tue,  6 Aug 2019 07:57:35 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] irqchip/ixp4xx: Register the base PA instead of its VA in fwnode
Date:   Tue,  6 Aug 2019 15:57:13 +0100
Message-Id: <20190806145716.125421-6-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806145716.125421-1-maz@kernel.org>
References: <20190806145716.125421-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not expose the base VA (it appears in debugfs). Instead,
record the PA, which at least can be used to precisely identify
the associated irqchip and domain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-ixp4xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ixp4xx.c b/drivers/irqchip/irq-ixp4xx.c
index 6751c35b7e1d..37e0749215c7 100644
--- a/drivers/irqchip/irq-ixp4xx.c
+++ b/drivers/irqchip/irq-ixp4xx.c
@@ -319,7 +319,7 @@ void __init ixp4xx_irq_init(resource_size_t irqbase,
 		pr_crit("IXP4XX: could not ioremap interrupt controller\n");
 		return;
 	}
-	fwnode = irq_domain_alloc_fwnode(base);
+	fwnode = irq_domain_alloc_fwnode(&irqbase);
 	if (!fwnode) {
 		pr_crit("IXP4XX: no domain handle\n");
 		return;
-- 
2.20.1

