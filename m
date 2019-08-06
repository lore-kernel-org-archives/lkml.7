Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93715C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642AB20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565103462;
	bh=WmevIr8LIF+WixJIgrIrPkNHGLVjaR/ROGjQphUfTmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eRY0sdTV8AWtEPsWVlw7JnE14sN0q9QSHPesHEn3cp7UBjNqcq8lVHspFGXJLVdCT
	 kF/eX3I8fZ/GGFMTwmkN4DNqWoPBjtqn/wuJULToXJZxizLjbUFFcS0jvRmygiP+KO
	 uYlS11ng1EeC/f9Z79NmAjRidnLpiGBUrjfwpnmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbfHFO5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:57:41 -0400
Received: from foss.arm.com ([217.140.110.172]:34766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733177AbfHFO5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:57:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C1F6168F;
        Tue,  6 Aug 2019 07:57:38 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D26E03F706;
        Tue,  6 Aug 2019 07:57:36 -0700 (PDT)
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
Subject: [PATCH 6/8] gpio/ixp4xx: Register the base PA instead of its VA in fwnode
Date:   Tue,  6 Aug 2019 15:57:14 +0100
Message-Id: <20190806145716.125421-7-maz@kernel.org>
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
 drivers/gpio/gpio-ixp4xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-ixp4xx.c b/drivers/gpio/gpio-ixp4xx.c
index 670c2a85a35b..cc72c9aca5a1 100644
--- a/drivers/gpio/gpio-ixp4xx.c
+++ b/drivers/gpio/gpio-ixp4xx.c
@@ -400,7 +400,7 @@ static int ixp4xx_gpio_probe(struct platform_device *pdev)
 		g->fwnode = of_node_to_fwnode(np);
 	} else {
 		parent = ixp4xx_get_irq_domain();
-		g->fwnode = irq_domain_alloc_fwnode(g->base);
+		g->fwnode = irq_domain_alloc_fwnode(&res->start);
 		if (!g->fwnode) {
 			dev_err(dev, "no domain base\n");
 			return -ENODEV;
-- 
2.20.1

