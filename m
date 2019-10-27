Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D57DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FEF21850
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572187551;
	bh=+d7xftlu27DKC9efu3TAF3L70PpcGl2ppDdh987PmKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qd4j1M5bWCe1HW0n9P3hLsMYaR6Wg7/4beSqhmBK6y0JrSdvDaXXeYnoyMuNk4RND
	 n/nnAI27RiJ+1hteMO7JAQ0UFJYoScoez7S0TmToHdoXiAkHr/4H4LRTKsHbWSM6Rb
	 v3sF2Nk95Fdt5QqemN+NcQhZIextxXho//tq0Jr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfJ0Opv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfJ0Opu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:45:50 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C034621E6F;
        Sun, 27 Oct 2019 14:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187549;
        bh=+d7xftlu27DKC9efu3TAF3L70PpcGl2ppDdh987PmKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XPxhgaada0GtxwxmuB4K16VMgxJm9poJTw5UygAeRcwy1uAFne6Yut2TC1nBggXk2
         v1NGrHB6DPvQZS1n5kvuducEJwyXhr7geC2SbNJ5QU9LAeJV5J29XPpWhEDyqeMDWZ
         Zxi2kVmpn7VFujoGB0sdrmV2voSFbn4JLm2NBDl8=
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
        Jayachandran C <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 26/36] irqchip/gic-v4.1: Plumb mask/unmask SGI callbacks
Date:   Sun, 27 Oct 2019 14:42:24 +0000
Message-Id: <20191027144234.8395-27-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index ef5988724aa3..b9cef419f006 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3667,6 +3667,22 @@ static void its_configure_sgi(struct irq_data *d, bool clear)
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
@@ -3676,6 +3692,8 @@ static int its_sgi_set_affinity(struct irq_data *d,
 
 static struct irq_chip its_sgi_irq_chip = {
 	.name			= "GICv4.1-sgi",
+	.irq_mask		= its_sgi_mask_irq,
+	.irq_unmask		= its_sgi_unmask_irq,
 	.irq_set_affinity	= its_sgi_set_affinity,
 };
 
-- 
2.20.1

