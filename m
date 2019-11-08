Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2AEFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95433218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573232321;
	bh=Yq0WH1A3aBZ2qmcCt7kEOce3q5/xPlNmECeIChQ2Phw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NdQf/SxPC7hEIIdMiCvm3CVUwnCddbzcvreT3A3fKqi9xQljkGSBSkj7XK8LFCzEy
	 TrxNSSDYz0TCzURUnc2oMhNCp/b6lb5bpZlhHI9V1CE1lymoitkerluPygYpZKsZuh
	 U0ibcksEzltDU94os2jjjBFk/55Je81hJgY7fggg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfKHQ6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:58:11 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:37744 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726101AbfKHQ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:58:11 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iT7aM-0002sR-6H; Fri, 08 Nov 2019 17:58:10 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, lorenzo.pieralisi@arm.com,
        Andrew.Murray@arm.com, yuzenghui@huawei.com,
        Heyi Guo <guoheyi@huawei.com>
Subject: [PATCH v2 01/11] irqchip/gic-v3-its: Free collection mapping on device teardown
Date:   Fri,  8 Nov 2019 16:57:55 +0000
Message-Id: <20191108165805.3071-2-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108165805.3071-1-maz@kernel.org>
References: <20191108165805.3071-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com, guoheyi@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We allocate the collection mapping on device creation, but somehow
free it on the irqdomain free path, which is pretty inconsistent
and has led to bugs in the past.

Move it to the point where we teardown the device, making the
alloc/free symetric.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 787e8eec9a7f..cc6aea602a7a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2471,6 +2471,7 @@ static void its_free_device(struct its_device *its_dev)
 	raw_spin_lock_irqsave(&its_dev->its->lock, flags);
 	list_del(&its_dev->entry);
 	raw_spin_unlock_irqrestore(&its_dev->its->lock, flags);
+	kfree(its_dev->event_map.col_map);
 	kfree(its_dev->itt);
 	kfree(its_dev);
 }
@@ -2679,7 +2680,6 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 		its_lpi_free(its_dev->event_map.lpi_map,
 			     its_dev->event_map.lpi_base,
 			     its_dev->event_map.nr_lpis);
-		kfree(its_dev->event_map.col_map);
 
 		/* Unmap device/itt */
 		its_send_mapd(its_dev, 0);
-- 
2.20.1

