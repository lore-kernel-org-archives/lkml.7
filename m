Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D02C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A69920706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577187758;
	bh=DkdF+K8e5AB2vm5wuoyhVJlYf3woZceAykVnDIr4i28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LddbFPXdz85/HiZZg3BecS3MBNABJ523oX+coS0rSz6jLNvD8sY2Q/g1xbTOal/Zg
	 LtudtmTKmbDeKJBIWKQ3yiFxRmUbkwVc1XZucRUv16r9zwOQHfv6ZMhIIcVy7lF+48
	 jNfbOmsuNLv0KZEyHw/9X7fvxYFVfZOl6L0RMWOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLXLmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:42:37 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:33496 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbfLXLmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:42:37 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iji61-000169-6D; Tue, 24 Dec 2019 12:11:26 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v3 17/32] irqchip/gic-v4.1: Map the ITS SGIR register page
Date:   Tue, 24 Dec 2019 11:10:40 +0000
Message-Id: <20191224111055.11836-18-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224111055.11836-1-maz@kernel.org>
References: <20191224111055.11836-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com, rrichter@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the new features of GICv4.1 is to allow virtual SGIs to be
directly signaled to a VPE. For that, the ITS has grown a new
64kB page containing only a single register that is used to
signal a SGI to a given VPE.

Add a second mapping covering this new 64kB range, and take this
opportunity to limit the original mapping to 64kB, which is enough
to cover the span of the ITS registers.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 48d7ee443544..2f94fae67dfd 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -97,6 +97,7 @@ struct its_node {
 	struct mutex		dev_alloc_lock;
 	struct list_head	entry;
 	void __iomem		*base;
+	void __iomem		*sgir_base;
 	phys_addr_t		phys_base;
 	struct its_cmd_block	*cmd_base;
 	struct its_cmd_block	*cmd_write;
@@ -4325,7 +4326,7 @@ static int __init its_probe_one(struct resource *res,
 	struct page *page;
 	int err;
 
-	its_base = ioremap(res->start, resource_size(res));
+	its_base = ioremap(res->start, SZ_64K);
 	if (!its_base) {
 		pr_warn("ITS@%pa: Unable to map ITS registers\n", &res->start);
 		return -ENOMEM;
@@ -4376,6 +4377,13 @@ static int __init its_probe_one(struct resource *res,
 
 		if (is_v4_1(its)) {
 			u32 svpet = FIELD_GET(GITS_TYPER_SVPET, typer);
+
+			its->sgir_base = ioremap(res->start + SZ_128K, SZ_64K);
+			if (!its->sgir_base) {
+				err = -ENOMEM;
+				goto out_free_its;
+			}
+
 			its->mpidr = readl_relaxed(its_base + GITS_MPIDR);
 
 			pr_info("ITS@%pa: Using GICv4.1 mode %08x %08x\n",
@@ -4389,7 +4397,7 @@ static int __init its_probe_one(struct resource *res,
 				get_order(ITS_CMD_QUEUE_SZ));
 	if (!page) {
 		err = -ENOMEM;
-		goto out_free_its;
+		goto out_unmap_sgir;
 	}
 	its->cmd_base = (void *)page_address(page);
 	its->cmd_write = its->cmd_base;
@@ -4456,6 +4464,9 @@ static int __init its_probe_one(struct resource *res,
 	its_free_tables(its);
 out_free_cmd:
 	free_pages((unsigned long)its->cmd_base, get_order(ITS_CMD_QUEUE_SZ));
+out_unmap_sgir:
+	if (its->sgir_base)
+		iounmap(its->sgir_base);
 out_free_its:
 	kfree(its);
 out_unmap:
-- 
2.20.1

