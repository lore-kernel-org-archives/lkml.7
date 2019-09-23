Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACABEC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871CE20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569263322;
	bh=wb8MnmVIHroJM9PSk6o4I+88KKLW/wWOgZB5RORktF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TJQ93wS+lYe2dmKdHZ2vH1vG75xHDbXOX9dJdcEqs5mgbrewBe4kQrv7VazSA/c6A
	 UHoG4IMEI7PxxjyP7BrT7h2FXNPjA76ugt6y90z0GTSl44wUUGwf8I0Yw6NkmCbtwT
	 VhpCu8j80vy/gI7ciFlpPiTIpw1ZChgZnEY3b9H4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733065AbfIWS2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:28:23 -0400
Received: from foss.arm.com ([217.140.110.172]:47208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733006AbfIWS2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:28:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09DEF2972;
        Mon, 23 Sep 2019 11:28:18 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E8623F694;
        Mon, 23 Sep 2019 11:28:14 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>
Subject: [PATCH 30/35] irqchip/gic-v4.1: Add VSGI property setup
Date:   Mon, 23 Sep 2019 19:26:01 +0100
Message-Id: <20190923182606.32100-31-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923182606.32100-1-maz@kernel.org>
References: <20190923182606.32100-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SGI configuration entry point for KVM to use.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v4.c       | 13 +++++++++++++
 include/linux/irqchip/arm-gic-v4.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index a29a063861bc..b937e51a9178 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -324,6 +324,19 @@ int its_prop_update_vlpi(int irq, u8 config, bool inv)
 	return irq_set_vcpu_affinity(irq, &info);
 }
 
+int its_prop_update_vsgi(int irq, u8 priority, bool group)
+{
+	struct its_cmd_info info = {
+		.cmd_type = PROP_UPDATE_SGI,
+		{
+			.priority	= priority,
+			.group		= group,
+		},
+	};
+
+	return irq_set_vcpu_affinity(irq, &info);
+}
+
 int its_init_v4(struct irq_domain *domain,
 		const struct irq_domain_ops *vpe_ops,
 		const struct irq_domain_ops *sgi_ops)
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index 5578cbe7430b..b894796df9ab 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -127,6 +127,7 @@ int its_map_vlpi(int irq, struct its_vlpi_map *map);
 int its_get_vlpi(int irq, struct its_vlpi_map *map);
 int its_unmap_vlpi(int irq);
 int its_prop_update_vlpi(int irq, u8 config, bool inv);
+int its_prop_update_vsgi(int irq, u8 priority, bool group);
 
 struct irq_domain_ops;
 int its_init_v4(struct irq_domain *domain,
-- 
2.20.1

