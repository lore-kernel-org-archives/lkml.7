Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D727BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B633F2251F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfKTNWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:22:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56782 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbfKTNVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:21 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPv2-0007BZ-Jt; Wed, 20 Nov 2019 14:21:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 22AC71C1A0B;
        Wed, 20 Nov 2019 14:21:05 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:05 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Free collection mapping on device
 teardown
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191108165805.3071-2-maz@kernel.org>
References: <20191108165805.3071-2-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <157425606507.12247.10617023526080442996.tip-bot2@tip-bot2>
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

Commit-ID:     898aa5ce6158c5ccfc256bfc17963bc81981eef8
Gitweb:        https://git.kernel.org/tip/898aa5ce6158c5ccfc256bfc17963bc81981eef8
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 08 Nov 2019 16:57:55 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:47:50 

irqchip/gic-v3-its: Free collection mapping on device teardown

We allocate the collection mapping on device creation, but somehow
free it on the irqdomain free path, which is pretty inconsistent
and has led to bugs in the past.

Move it to the point where we teardown the device, making the
alloc/free symetric.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20191108165805.3071-2-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 021e0c7..d5d8f8f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2474,6 +2474,7 @@ static void its_free_device(struct its_device *its_dev)
 	raw_spin_lock_irqsave(&its_dev->its->lock, flags);
 	list_del(&its_dev->entry);
 	raw_spin_unlock_irqrestore(&its_dev->its->lock, flags);
+	kfree(its_dev->event_map.col_map);
 	kfree(its_dev->itt);
 	kfree(its_dev);
 }
@@ -2682,7 +2683,6 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 		its_lpi_free(its_dev->event_map.lpi_map,
 			     its_dev->event_map.lpi_base,
 			     its_dev->event_map.nr_lpis);
-		kfree(its_dev->event_map.col_map);
 
 		/* Unmap device/itt */
 		its_send_mapd(its_dev, 0);
