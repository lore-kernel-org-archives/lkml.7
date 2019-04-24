Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCB5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E41E218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ySogtWNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfDXIJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:09:11 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34070 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726443AbfDXIJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:09:10 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3O86etE026280;
        Wed, 24 Apr 2019 10:08:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=gWhmMJfG4KCKGsbfm55+Bl3jiOH6AJEwnEp7zdS68zg=;
 b=ySogtWNZxpSiI9dOW7zUhAeM7zDWryiHYdNdwu0Sg/C9C9UFYLh5nVaQofDwjeN3j/Zi
 GC8s4RbNGyyzXb9jlaGpM2JVKuU4EMT1D/jblDj1TuDmY+8V8Ov0dDEVxOBHGmNhbhWf
 C7x14fTtBAauN3q6tblKgq+d3aeeV/+ALCObQNHlPNRLe2/MmGZtRzuAF7jhDgF57pNA
 cX+6J3tMgurBn09nzqQsBUtz7YKudLkcvCl+N/PdJEb5dIWamE+UNgM1Zyvc7i1/UbEj
 uj6dmwB5Xo39537kD/iyUZLX8kfL4kHFUXxs/vvFyrP4oHYKLNT/2G88hd75CfQQlbvl UQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ryrvxc55a-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 10:08:57 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C4F0B31;
        Wed, 24 Apr 2019 08:08:55 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 997211409;
        Wed, 24 Apr 2019 08:08:55 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 24 Apr
 2019 10:08:55 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr 2019 10:08:54
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH] pinctrl: stm32: check irq controller availability at probe
Date:   Wed, 24 Apr 2019 10:08:44 +0200
Message-ID: <1556093324-1008-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not guaranteed that the IRQ controller driver is probed before
the pin controller driver gets probed.
Considering this, check for the irq domain availability during probe
and return EPROBE_DEFER if needed.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 37 +++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 0aebc31..2317ccf 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1122,23 +1122,35 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 	return 0;
 }
 
+static struct irq_domain *stm32_pctrl_get_irq_domain(struct device_node *np)
+{
+	struct device_node *parent;
+	struct irq_domain *domain;
+
+	if (!of_find_property(np, "interrupt-parent", NULL))
+		return NULL;
+
+	parent = of_irq_find_parent(np);
+	if (!parent)
+		return ERR_PTR(-ENXIO);
+
+	domain = irq_find_host(parent);
+	if (!domain)
+		/* domain not registered yet */
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return domain;
+}
+
 static int stm32_pctrl_dt_setup_irq(struct platform_device *pdev,
 			   struct stm32_pinctrl *pctl)
 {
-	struct device_node *np = pdev->dev.of_node, *parent;
+	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct regmap *rm;
 	int offset, ret, i;
 	int mask, mask_width;
 
-	parent = of_irq_find_parent(np);
-	if (!parent)
-		return -ENXIO;
-
-	pctl->domain = irq_find_host(parent);
-	if (!pctl->domain)
-		return -ENXIO;
-
 	pctl->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
 	if (IS_ERR(pctl->regmap))
 		return PTR_ERR(pctl->regmap);
@@ -1264,6 +1276,11 @@ int stm32_pctl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pctl);
 
+	/* check for IRQ controller (may require deferred probe) */
+	pctl->domain = stm32_pctrl_get_irq_domain(np);
+	if (IS_ERR(pctl->domain))
+		return PTR_ERR(pctl->domain);
+
 	/* hwspinlock is optional */
 	hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
 	if (hwlock_id < 0) {
@@ -1294,7 +1311,7 @@ int stm32_pctl_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (of_find_property(np, "interrupt-parent", NULL)) {
+	if (pctl->domain) {
 		ret = stm32_pctrl_dt_setup_irq(pdev, pctl);
 		if (ret)
 			return ret;
-- 
2.7.4

