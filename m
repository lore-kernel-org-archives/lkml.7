Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137EEC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72DC218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610654;
	bh=+HSAIJn2BKwQh6KJhlYzv3t1vGt5wtHyLlJ4rBZhFI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j/0smBs2CI424DHONqtogTkuTKlCyARyOcYgdayiWdNANvaZ6HO7HXbpwLaD8hbPv
	 DP3W++COdiNBaUyCVmA2ppSpDMXEjF5JgNJTfXvko/1s/Qk8aUzyC3dwZxb7JS4EEu
	 +l9tgT4s0ojVYNdX35PDbsEFpKs4hTxf9Q2VVjKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391078AbfDRSEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390404AbfDRSEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:04:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB92D206B6;
        Thu, 18 Apr 2019 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610649;
        bh=+HSAIJn2BKwQh6KJhlYzv3t1vGt5wtHyLlJ4rBZhFI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D2QBdTd9W/quuISyBY62J/Ebw7sM2s2whoMz/X1QhT1yj3wsyc6q8udLBT6bwjPEs
         J1s0FrUmjEbHN7z2QySDT82NcfzVmj2zs8FQRNCdXVCbBIcn+yU8LvvndKifiCUrQY
         coFubQiBmG7SPbr1E4cQ28jAPhxmDT62BWMdRG5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianguo Chen <chenjianguo3@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 30/92] irqchip/mbigen: Dont clear eventid when freeing an MSI
Date:   Thu, 18 Apr 2019 19:56:48 +0200
Message-Id: <20190418160433.095383613@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fca269f201a8d9985c0a31fb60b15d4eb57cef80 ]

mbigen_write_msg clears eventid bits of a mbigen register
when free a interrupt, because msi_domain_deactivate memset
struct msg to zero. Then multiple mbigen pins with zero eventid
will report the same interrupt number.

The eventid clear call trace:
                free_irq
                __free_irq
                irq_shutdown
                irq_domain_deactivate_irq
                __irq_domain_deactivate_irq
                __irq_domain_deactivate_irq
                msi_domain_deactivate
                platform_msi_write_msg
                mbigen_write_msg

Signed-off-by: Jianguo Chen <chenjianguo3@huawei.com>
[maz: massaged subject]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-mbigen.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 567b29c47608..98b6e1d4b1a6 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -161,6 +161,9 @@ static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 	void __iomem *base = d->chip_data;
 	u32 val;
 
+	if (!msg->address_lo && !msg->address_hi)
+		return;
+ 
 	base += get_mbigen_vec_reg(d->hwirq);
 	val = readl_relaxed(base);
 
-- 
2.19.1



