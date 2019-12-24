Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4A5C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D0320706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577187692;
	bh=N8Stjl4nUs2uvZYdCFxNvUUGUUfG3C7C5gbRzWBKjJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1rsCXDiEvGARKF74geIxVgiDZUGS63H0m6rm2c/qcvc03vSUS6AL9K//N1TZiQRvx
	 rYAeZ5nBxPhl6a8nTCBewgMD0hJJVx6oH4ci9Lwhf59ZUn/TWHpL4axxeVVExpTOF7
	 l/UAs18qyJbaEt8AHP0QYjrgbuLtslGypLLvuYlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfLXLlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:41:31 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:44172 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbfLXLla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:41:30 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iji65-000169-Jr; Tue, 24 Dec 2019 12:11:29 +0100
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
Subject: [PATCH v3 20/32] irqchip/gic-v4.1: Plumb mask/unmask SGI callbacks
Date:   Tue, 24 Dec 2019 11:10:43 +0000
Message-Id: <20191224111055.11836-21-maz@kernel.org>
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

Implement mask/unmask for virtual SGIs by calling into the
configuration helper.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 9ca2ad6000d8..c13c889553c5 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3809,6 +3809,22 @@ static void its_configure_sgi(struct irq_data *d, bool clear)
 	its_send_single_vcommand(find_4_1_its(), its_build_vsgi_cmd, &desc);
 }
 
+static void its_sgi_mask_irq(struct irq_data *d)
+{
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+
+	vpe->sgi_config[d->hwirq].enabled = false;
+	its_configure_sgi(d, false);
+}
+
+static void its_sgi_unmask_irq(struct irq_data *d)
+{
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+
+	vpe->sgi_config[d->hwirq].enabled = true;
+	its_configure_sgi(d, false);
+}
+
 static int its_sgi_set_affinity(struct irq_data *d,
 				const struct cpumask *mask_val,
 				bool force)
@@ -3818,6 +3834,8 @@ static int its_sgi_set_affinity(struct irq_data *d,
 
 static struct irq_chip its_sgi_irq_chip = {
 	.name			= "GICv4.1-sgi",
+	.irq_mask		= its_sgi_mask_irq,
+	.irq_unmask		= its_sgi_unmask_irq,
 	.irq_set_affinity	= its_sgi_set_affinity,
 };
 
-- 
2.20.1

