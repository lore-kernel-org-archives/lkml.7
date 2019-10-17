Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924DEFA3731
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB8421848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439182AbfJQI2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:28:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41500 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391402AbfJQI2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:28:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 08DF78AE15FCECDED770;
        Thu, 17 Oct 2019 16:28:20 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Thu, 17 Oct 2019 16:28:18 +0800
From:   Daode Huang <huangdaode@hisilicon.com>
To:     <jason@lakedaemon.net>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <tglx@linutronix.de>, <maz@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] irqchip: remove redundant semicolon after while
Date:   Thu, 17 Oct 2019 16:25:29 +0800
Message-ID: <1571300729-38822-1-git-send-email-huangdaode@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check drivers/irqchip with "make coccicheck M=drivers/irqchip/",
it will report unneeded semicolon like below, just remove them.

drivers/irqchip/irq-zevio.c:54:2-3: Unneeded semicolon
drivers/irqchip/irq-gic-v3.c:177:2-3: Unneeded semicolon
drivers/irqchip/irq-gic-v3.c:234:2-3: Unneeded semicolon

Signed-off-by: Daode Huang <huangdaode@hisilicon.com>
---
 drivers/irqchip/irq-gic-v3.c | 4 ++--
 drivers/irqchip/irq-zevio.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 422664a..58518e5 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -174,7 +174,7 @@ static void gic_do_wait_for_rwp(void __iomem *base)
 		}
 		cpu_relax();
 		udelay(1);
-	};
+	}
 }
 
 /* Wait for completion of a distributor change */
@@ -231,7 +231,7 @@ static void gic_enable_redist(bool enable)
 			break;
 		cpu_relax();
 		udelay(1);
-	};
+	}
 	if (!count)
 		pr_err_ratelimited("redistributor failed to %s...\n",
 				   enable ? "wakeup" : "sleep");
diff --git a/drivers/irqchip/irq-zevio.c b/drivers/irqchip/irq-zevio.c
index 5a7efeb..84163f1 100644
--- a/drivers/irqchip/irq-zevio.c
+++ b/drivers/irqchip/irq-zevio.c
@@ -51,7 +51,7 @@ static void __exception_irq_entry zevio_handle_irq(struct pt_regs *regs)
 	while (readl(zevio_irq_io + IO_STATUS)) {
 		irqnr = readl(zevio_irq_io + IO_CURRENT);
 		handle_domain_irq(zevio_irq_domain, irqnr, regs);
-	};
+	}
 }
 
 static void __init zevio_init_irq_base(void __iomem *base)
-- 
2.8.1

