Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40D1C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947BE224F3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbfKTNWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:22:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56804 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbfKTNVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPv0-0007BD-C9; Wed, 20 Nov 2019 14:21:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F21441C1A18;
        Wed, 20 Nov 2019 14:21:04 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:04 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Factor out wait_for_syncr primitive
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191027144234.8395-3-maz@kernel.org>
References: <20191027144234.8395-3-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <157425606492.12247.5343904804762133353.tip-bot2@tip-bot2>
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

Commit-ID:     2f4f064b31315c7c8986522cf38ef6d11fb77986
Gitweb:        https://git.kernel.org/tip/2f4f064b31315c7c8986522cf38ef6d11fb77986
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 08 Nov 2019 16:57:56 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:47:50 

irqchip/gic-v3-its: Factor out wait_for_syncr primitive

Waiting for a redistributor to have performed an operation is a
common thing to do, and the idiom is already spread around.
As we're going to make even more use of this, let's have a primitive
that does just that.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20191027144234.8395-3-maz@kernel.org
Link: https://lore.kernel.org/r/20191108165805.3071-3-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d5d8f8f..78d3e73 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1093,6 +1093,12 @@ static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
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
@@ -2775,8 +2781,7 @@ static void its_vpe_db_proxy_move(struct its_vpe *vpe, int from, int to)
 
 		rdbase = per_cpu_ptr(gic_rdists->rdist, from)->rd_base;
 		gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_CLRLPIR);
-		while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
-			cpu_relax();
+		wait_for_syncr(rdbase);
 
 		return;
 	}
@@ -2932,8 +2937,7 @@ static void its_vpe_send_inv(struct irq_data *d)
 
 		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
 		gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_INVLPIR);
-		while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
-			cpu_relax();
+		wait_for_syncr(rdbase);
 	} else {
 		its_vpe_send_cmd(vpe, its_send_inv);
 	}
@@ -2975,8 +2979,7 @@ static int its_vpe_set_irqchip_state(struct irq_data *d,
 			gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_SETLPIR);
 		} else {
 			gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_CLRLPIR);
-			while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
-				cpu_relax();
+			wait_for_syncr(rdbase);
 		}
 	} else {
 		if (state)
