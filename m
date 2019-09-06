Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7BAC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E052084F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392371AbfIFLIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:08:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47042 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392291AbfIFLI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:26 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6F-00075Y-65; Fri, 06 Sep 2019 13:08:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E45A61C0E20;
        Fri,  6 Sep 2019 13:08:15 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:15 -0000
From:   "tip-bot2 for Zenghui Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Remove the redundant set_bit for lpi_map
Cc:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156776809587.24167.5393741851076816633.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     342be1068d9b5b1fd364d270b4f731764e23de2b
Gitweb:        https://git.kernel.org/tip/342be1068d9b5b1fd364d270b4f731764e23de2b
Author:        Zenghui Yu <yuzenghui@huawei.com>
AuthorDate:    Sat, 27 Jul 2019 06:14:22 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 20 Aug 2019 10:34:34 +01:00

irqchip/gic-v3-its: Remove the redundant set_bit for lpi_map

We try to find a free LPI region in device's lpi_map and allocate them
(set them to 1) when we want to allocate LPIs for this device. This is
what bitmap_find_free_region() has done for us. The following set_bit
is redundant and a bit confusing (since we only set_bit against the first
allocated LPI idx). Remove it, and make the set_bit explicit by comment.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 8eeb0e2..9380aa4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2464,6 +2464,7 @@ static int its_alloc_device_irq(struct its_device *dev, int nvecs, irq_hw_number
 {
 	int idx;
 
+	/* Find a free LPI region in lpi_map and allocate them. */
 	idx = bitmap_find_free_region(dev->event_map.lpi_map,
 				      dev->event_map.nr_lpis,
 				      get_count_order(nvecs));
@@ -2471,7 +2472,6 @@ static int its_alloc_device_irq(struct its_device *dev, int nvecs, irq_hw_number
 		return -ENOSPC;
 
 	*hwirq = dev->event_map.lpi_base + idx;
-	set_bit(idx, dev->event_map.lpi_map);
 
 	return 0;
 }
