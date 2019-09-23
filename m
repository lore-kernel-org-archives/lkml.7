Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6A6C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6657520665
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569263198;
	bh=XbLNgU9kPdlH8Fi9JQlXClvf4wOZdwwOaVg4Lg0NAEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tl41s021VAU33anUMZVcowLXU8ok8Hw7LaMYUvgHg8Fysk5cyuKcUB0Fl6cEVTh/N
	 eMi8hUMPjeC5WHcEgA36fGN95u7F1gBgjdEEarNjCwpwXNJyisinDQvqIdVjHm8Nez
	 S8F7kIn0beJIjcZU1jGWzMYvyX3hL+7/IaM7BsFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440448AbfIWS0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:26:37 -0400
Received: from foss.arm.com ([217.140.110.172]:46638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438244AbfIWS0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:26:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 260F31597;
        Mon, 23 Sep 2019 11:26:36 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C0493F694;
        Mon, 23 Sep 2019 11:26:33 -0700 (PDT)
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
Subject: [PATCH 02/35] irqchip/gic-v3-its: Factor out wait_for_syncr primitive
Date:   Mon, 23 Sep 2019 19:25:33 +0100
Message-Id: <20190923182606.32100-3-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923182606.32100-1-maz@kernel.org>
References: <20190923182606.32100-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiting for a redistributor to have performed an operation is a
common thing to do, and the idiom is already spread around.
As we're going to make even more use of this, let's have a primitive
that does just that.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 62e54f1a248b..58cb233cf138 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1075,6 +1075,12 @@ static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 		dsb(ishst);
 }
 
+static void wait_for_syncr(void __iomem *rdbase)
+{
+	while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
+		cpu_relax();
+}
+
 static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
@@ -2757,8 +2763,7 @@ static void its_vpe_db_proxy_move(struct its_vpe *vpe, int from, int to)
 
 		rdbase = per_cpu_ptr(gic_rdists->rdist, from)->rd_base;
 		gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_CLRLPIR);
-		while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
-			cpu_relax();
+		wait_for_syncr(rdbase);
 
 		return;
 	}
@@ -2914,8 +2919,7 @@ static void its_vpe_send_inv(struct irq_data *d)
 
 		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
 		gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_INVLPIR);
-		while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
-			cpu_relax();
+		wait_for_syncr(rdbase);
 	} else {
 		its_vpe_send_cmd(vpe, its_send_inv);
 	}
@@ -2957,8 +2961,7 @@ static int its_vpe_set_irqchip_state(struct irq_data *d,
 			gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_SETLPIR);
 		} else {
 			gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_CLRLPIR);
-			while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
-				cpu_relax();
+			wait_for_syncr(rdbase);
 		}
 	} else {
 		if (state)
-- 
2.20.1

