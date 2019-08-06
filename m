Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAD3C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAEB21743
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565103482;
	bh=i6odL97IP34qUflLzELoGFQDsrLlHKrcYBsULBg3R78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tFAYjcu5aXkNlTQJ/OJtvo60nRuWDfewv2uu2/uCeIXGIU6hx9+C1YDRjkQwYPHln
	 g8pUcxtD93ft3xEzkmrppT35iXbAdtSsu5mzjUyRz1QQ7F1b34ulSKgy9ZcPRpieZI
	 tdXxa+mTaCzDgAIK7vu4m1+sEM9RNgL+r5fJLhcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733271AbfHFO6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:58:00 -0400
Received: from foss.arm.com ([217.140.110.172]:34696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733147AbfHFO5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:57:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D4DA1570;
        Tue,  6 Aug 2019 07:57:31 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F27C3F706;
        Tue,  6 Aug 2019 07:57:29 -0700 (PDT)
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
Subject: [PATCH 2/8] irqchip/gic-v3-its: Register the ITS' PA instead of its VA in fwnode
Date:   Tue,  6 Aug 2019 15:57:10 +0100
Message-Id: <20190806145716.125421-3-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806145716.125421-1-maz@kernel.org>
References: <20190806145716.125421-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not expose the ITS' VA (it appears in debugfs). Instead, record
the PA, which at least can be used to precisely identify the associated
irqchip and domain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1b5c3672aea2..8eeb0e284896 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3921,7 +3921,7 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
 	res.end = its_entry->base_address + ACPI_GICV3_ITS_MEM_SIZE - 1;
 	res.flags = IORESOURCE_MEM;
 
-	dom_handle = irq_domain_alloc_fwnode((void *)its_entry->base_address);
+	dom_handle = irq_domain_alloc_fwnode(&res.start);
 	if (!dom_handle) {
 		pr_err("ITS@%pa: Unable to allocate GICv3 ITS domain token\n",
 		       &res.start);
-- 
2.20.1

