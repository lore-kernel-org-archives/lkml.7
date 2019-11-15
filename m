Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD6BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D448420732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jZrqmLNg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VKe75KfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfKOWRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:17:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47212 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfKOWRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:17:47 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5C1D861179; Fri, 15 Nov 2019 22:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573856266;
        bh=F779/xms42dBz8+/VvXsVTB8JWpMyODPFkAQ7rqjqMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZrqmLNgRuRvhJ/IVpJqvt/P/QcqO1aZu9OSgl9gX2k9jgQPk6yKCdrZZsxbaY403
         Dp7L9Ndo2pUT5kiKNmWb2CkGe18iJ2DWNdEkcy3+W7riCKxPjjqNDPyiZufv6AXKV5
         qe/8Sy4+0BECEcqNWwInMBSIrRrszJ88wEnu2LCA=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6A53260F80;
        Fri, 15 Nov 2019 22:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573856265;
        bh=F779/xms42dBz8+/VvXsVTB8JWpMyODPFkAQ7rqjqMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VKe75KfY/FeVCzMcE7Mx7MLCXfn5ei+Rza7nVtUFCeoXNaOGax19CnSFiiEtpEMjo
         Pc/3jFKaLT+Tzhf7RQAHRcSLuYDsjGPIq0PIzZZOx01XEDZbcAPkmnx1OqT5bxgIDU
         B23dAInhpwPtNMRVVJ+uUvKMEQWmVWZ8dmyMvh3o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A53260F80
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, maz@kernel.org, linus.walleij@linaro.org,
        bjorn.andersson@linaro.org
Cc:     evgreen@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, agross@kernel.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v2 03/12] drivers: irqchip: pdc: Do not toggle IRQ_ENABLE during mask/unmask
Date:   Fri, 15 Nov 2019 15:11:46 -0700
Message-Id: <1573855915-9841-4-git-send-email-ilina@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573855915-9841-1-git-send-email-ilina@codeaurora.org>
References: <1573855915-9841-1-git-send-email-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an interrupt is to be serviced, the convention is to mask the
interrupt at the chip and unmask after servicing the interrupt. Enabling
and disabling the interrupt at the PDC irqchip causes an interrupt storm
due to the way dual edge interrupts are handled in hardware.

Skip configuring the PDC when the IRQ is masked and unmasked, instead
use the irq_enable/irq_disable callbacks to toggle the IRQ_ENABLE
register at the PDC. The PDC's IRQ_ENABLE register is only used during
the monitoring mode when the system is asleep and is not needed for
active mode detection.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/irqchip/qcom-pdc.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 690cf10..527c29e 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -63,15 +63,25 @@ static void pdc_enable_intr(struct irq_data *d, bool on)
 	raw_spin_unlock(&pdc_lock);
 }
 
-static void qcom_pdc_gic_mask(struct irq_data *d)
+static void qcom_pdc_gic_disable(struct irq_data *d)
 {
 	pdc_enable_intr(d, false);
+	irq_chip_disable_parent(d);
+}
+
+static void qcom_pdc_gic_enable(struct irq_data *d)
+{
+	pdc_enable_intr(d, true);
+	irq_chip_enable_parent(d);
+}
+
+static void qcom_pdc_gic_mask(struct irq_data *d)
+{
 	irq_chip_mask_parent(d);
 }
 
 static void qcom_pdc_gic_unmask(struct irq_data *d)
 {
-	pdc_enable_intr(d, true);
 	irq_chip_unmask_parent(d);
 }
 
@@ -148,6 +158,8 @@ static struct irq_chip qcom_pdc_gic_chip = {
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_mask		= qcom_pdc_gic_mask,
 	.irq_unmask		= qcom_pdc_gic_unmask,
+	.irq_disable		= qcom_pdc_gic_disable,
+	.irq_enable		= qcom_pdc_gic_enable,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_type		= qcom_pdc_gic_set_type,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND |
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

