Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876CFC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E97214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565103454;
	bh=1CqX6n3DNZT7iJYNbvshb1Rj9b/SbG/dyYiyXD8blMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kkBUJgjjUnYCDitkm82ob5cUJPmCFtq3QJFCpv5QblLbX7TvvLPBpPd+NYWaYogQp
	 Mb15OGfnIbBs5XJCY0NKs84ho15c38FNrWcPQE8UsXJnyRxHnxfXvPakH/BgI4tGn3
	 d2Xe12G9IwBz1e0+K6otek6H83bnnYwo1nkQqVG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733172AbfHFO5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:57:33 -0400
Received: from foss.arm.com ([217.140.110.172]:34676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733146AbfHFO5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:57:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDD0A15A2;
        Tue,  6 Aug 2019 07:57:29 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FF913F706;
        Tue,  6 Aug 2019 07:57:28 -0700 (PDT)
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
Subject: [PATCH 1/8] irqchip/gic-v3: Register the distributor's PA instead of its VA in fwnode
Date:   Tue,  6 Aug 2019 15:57:09 +0100
Message-Id: <20190806145716.125421-2-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806145716.125421-1-maz@kernel.org>
References: <20190806145716.125421-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not expose the distributor's VA (it appears in debugfs). Instead,
record the PA, which at least can be used to precisely identify
the associated irqchip and domain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 96d927f0f91a..be961c261093 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1845,7 +1845,7 @@ gic_acpi_init(struct acpi_subtable_header *header, const unsigned long end)
 	if (err)
 		goto out_redist_unmap;
 
-	domain_handle = irq_domain_alloc_fwnode(acpi_data.dist_base);
+	domain_handle = irq_domain_alloc_fwnode(&dist->base_address);
 	if (!domain_handle) {
 		err = -ENOMEM;
 		goto out_redist_unmap;
-- 
2.20.1

