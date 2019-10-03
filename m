Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5950FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7AB222CA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118453;
	bh=6OBD0aBevgYHmrpLYBQqh87qftSvBxuBak2GXZSsGdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W9WSR/FX0kfRG7k/peIivVJSZ8W9TeDgk7xjQLCSyt/C2xjrKvWjdVmD8/PpUYf8v
	 ++Dbet+PLk6k/WxzG5CTjgB6HUlaRnU+NB6L09t6OaYXNeWiddlUTuPI0Sjng3f36E
	 vZ6BFBpnHrc/xXe/I3gjbkutpLg4NUdzE7/JvMLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbfJCQAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730237AbfJCQAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:00:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5BE9215EA;
        Thu,  3 Oct 2019 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118449;
        bh=6OBD0aBevgYHmrpLYBQqh87qftSvBxuBak2GXZSsGdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MW6D0TlG70YY66eCwOOS/n2DUUgczkYVlP1j14dYWA+WVS2vLn6e95D9ZtqLEriae
         khMeZxSVUe0wKBIOsUkDVfZY6iE+DZZG+aDIAPpdhxSEvxOsm4lc8hAtpTWBtl+hig
         Xr8vdqSL2k8j31QQFXM3KqUqS+njgBJErljm28IY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiaxing Luo <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 016/129] irqchip/gic-v3-its: Fix LPI release for Multi-MSI devices
Date:   Thu,  3 Oct 2019 17:52:19 +0200
Message-Id: <20191003154325.823376892@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154318.081116689@linuxfoundation.org>
References: <20191003154318.081116689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit c9c96e30ecaa0aafa225aa1a5392cb7db17c7a82 ]

When allocating a range of LPIs for a Multi-MSI capable device,
this allocation extended to the closest power of 2.

But on the release path, the interrupts are released one by
one. This results in not releasing the "extra" range, leaking
the its_device. Trying to reprobe the device will then fail.

Fix it by releasing the LPIs the same way we allocate them.

Fixes: 8208d1708b88 ("irqchip/gic-v3-its: Align PCI Multi-MSI allocation on their size")
Reported-by: Jiaxing Luo <luojiaxing@huawei.com>
Tested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/f5e948aa-e32f-3f74-ae30-31fee06c2a74@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 83ca754250fb7..0c0cd2768d6e9 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1519,14 +1519,13 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	int i;
 
+	bitmap_release_region(its_dev->event_map.lpi_map,
+			      its_get_event_id(irq_domain_get_irq_data(domain, virq)),
+			      get_count_order(nr_irqs));
+
 	for (i = 0; i < nr_irqs; i++) {
 		struct irq_data *data = irq_domain_get_irq_data(domain,
 								virq + i);
-		u32 event = its_get_event_id(data);
-
-		/* Mark interrupt index as unused */
-		clear_bit(event, its_dev->event_map.lpi_map);
-
 		/* Nuke the entry in the domain */
 		irq_domain_reset_irq_data(data);
 	}
-- 
2.20.1



