Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EBCC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F2020C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565103460;
	bh=0jkKshoYjX/WP9djt6eTQ2nplOjMi5lFajagpmooeO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wySlXJy6LjyY2Zb1WQHoHtN+qjNNmygP81hW5lbvR11XJOCAl+T5FT0KKztivk3ah
	 xv+78G82PvHjLt3go1UCZg7n3gQhGSwzFgUdsUrS0+FP58frHcF1ANkT0lP4WUyWYt
	 L4mfjPxqn61tNpgsdDk7jSAGzHvcURN4s/3RI95A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733198AbfHFO5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:57:38 -0400
Received: from foss.arm.com ([217.140.110.172]:34732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733177AbfHFO5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:57:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDCD715BF;
        Tue,  6 Aug 2019 07:57:34 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 700BD3F706;
        Tue,  6 Aug 2019 07:57:33 -0700 (PDT)
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
Subject: [PATCH 4/8] irqchip/gic-v2m: Register the frame's PA instead of its VA in fwnode
Date:   Tue,  6 Aug 2019 15:57:12 +0100
Message-Id: <20190806145716.125421-5-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806145716.125421-1-maz@kernel.org>
References: <20190806145716.125421-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not expose the frame's VA (it appears in debugfs). Instead,
record the PA, which at least can be used to precisely identify
the associated irqchip and domain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 7338f90b2f9e..e88e75c22b6a 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -525,7 +525,7 @@ acpi_parse_madt_msi(union acpi_subtable_headers *header,
 			spi_start, nr_spis);
 	}
 
-	fwnode = irq_domain_alloc_fwnode((void *)m->base_address);
+	fwnode = irq_domain_alloc_fwnode(&res.start);
 	if (!fwnode) {
 		pr_err("Unable to allocate GICv2m domain token\n");
 		return -EINVAL;
-- 
2.20.1

