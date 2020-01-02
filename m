Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12468C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD89E20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004382;
	bh=b7tHW2NgMvOXfFf/n69XBqciRQFVnxAxVAbvvoN6EXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kJjQ6UTWx56LcGsc92kguHh6fVSmOPEV5qhLOM8F1J1qL8Lc2HQl29vxzOjWoY/Ex
	 RM8O9lQeunRRQYw5cF+uRAm7OsW23BO1W1NTU4IC9tV0+6md8QbyeTuSn8r0RF/Rsu
	 rN4atlbPBCv58rC6QV6k5YjD5h83U6bR8AdxDQ7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgABWdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:33:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730271AbgABWc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:32:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0C8F20863;
        Thu,  2 Jan 2020 22:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004378;
        bh=b7tHW2NgMvOXfFf/n69XBqciRQFVnxAxVAbvvoN6EXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oR1kY6UUFyYoMVrDDMSaBUAi3pC+YLnonX5/93SO8Wp70jpyZG16Yn4jMH5+8QeiV
         sQ1MMbR0Bs5+bb0c3xQ+opF2vIm7dc1lSIPY4a4j5edcNtiFiR73379R4tH9I6n9rm
         g6PXuK9Pkq7+dW0LJPGweMX934Bhylkdm483XEuI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 128/171] irqchip/irq-bcm7038-l1: Enable parent IRQ if necessary
Date:   Thu,  2 Jan 2020 23:07:39 +0100
Message-Id: <20200102220604.799769799@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 27eebb60357ed5aa6659442f92907c0f7368d6ae ]

If the 'brcm,irq-can-wake' property is specified, make sure we also
enable the corresponding parent interrupt we are attached to.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20191024201415.23454-4-f.fainelli@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-bcm7038-l1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 6e24facebb46..a571d9c6e42a 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -282,6 +282,10 @@ static int __init bcm7038_l1_init_one(struct device_node *dn,
 		pr_err("failed to map parent interrupt %d\n", parent_irq);
 		return -EINVAL;
 	}
+
+	if (of_property_read_bool(dn, "brcm,irq-can-wake"))
+		enable_irq_wake(parent_irq);
+
 	irq_set_chained_handler_and_data(parent_irq, bcm7038_l1_irq_handle,
 					 intc);
 
-- 
2.20.1



