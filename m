Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA557C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826902070C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N8gFXNfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbfIDQDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:03:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46576 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731541AbfIDQDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:03:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so3927783lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qdkpjv/bZ2lIEk5X+tFdEgL+mJhBRPFpnDdvWwMX9Xc=;
        b=N8gFXNfwqngfpITkERemx7Ltu0Dlkimbs/trkm5uy96D6tIWPHX+pNnCgQH1JxBihu
         IUrf7jLBw1JFSWWDRnalf9mB+yNxxdG069bZzIjwJ4zwb/qe7WxIcKRgxPPfGKgR6AGk
         4cnEy7ibBSOP6zo70HU5OxGp7HUKh81yvJsJ2YsMSEHK6/LXkPSokNqCrVMYSD3+bB4e
         kS75lVIGNArGDrvZt0feVALLQxuzWS+xVJQxen3vpDfiaItT/4Y+cy1RBN1sxFZ96kAI
         E9/nkH2UsoZHaIdiXJmDlCysFakZHUVnixHRNlY6m99sKIXP1K2Iej7CxYqjC5k4ZoQJ
         d98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qdkpjv/bZ2lIEk5X+tFdEgL+mJhBRPFpnDdvWwMX9Xc=;
        b=Qa80BenDG4+gBaDdLh8e1waXmm3zptqv149IY3bLsGs43n3lWxUFBimAluIaKjSvhD
         /Z92eC/JKuRATcj3yp/5730aq0Veaq4iBa/LJ3OOXdQH4W5ZkR+WrzG3anj+vIsitR5g
         F+AmvsRlRipfsxyfPZj1KbBFEN1Mu8kv7eHhkLZM71BDb+sK2QDrKeE3yy5KxGLxzCs1
         O6KwqZvxAAtu46erw9k5+OcV60U/GSpaOQhcWVzPvpySg67whoMr6/Idr8s07H6SxSOp
         wTMagVXhHwVWitUA1xgaQPfCBE4CGM6zpUd8hVLQFbM83ueRBZMGSn1tysG9vBhpNGWd
         5NdQ==
X-Gm-Message-State: APjAAAUna2PIO4IoK6TppRgT04EGYRq0eL0b83ScTn0KXMyrj+cZuPKH
        xZf2dH/kuBVpOcSQlrm/xSY+FA==
X-Google-Smtp-Source: APXvYqxcl6N2Os+hsM2CmBabXDD2UjVXYfZOm8va/9JhvYkTJcOmfYODnBTLkrUxHpBd/2Gc/balpg==
X-Received: by 2002:a19:6549:: with SMTP id c9mr3188567lfj.99.1567613027790;
        Wed, 04 Sep 2019 09:03:47 -0700 (PDT)
Received: from localhost.localdomain (ua-84-219-138-247.bbcust.telenor.se. [84.219.138.247])
        by smtp.gmail.com with ESMTPSA id r8sm556064lfm.71.2019.09.04.09.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 09:03:47 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: dwc: fix find_next_bit() usage
Date:   Wed,  4 Sep 2019 18:03:38 +0200
Message-Id: <20190904160339.2800-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_next_bit() takes a parameter of size long, and performs arithmetic
that assumes that the argument is of size long.

Therefore we cannot pass a u32, since this will cause find_next_bit()
to read outside the stack buffer and will produce the following print:
BUG: KASAN: stack-out-of-bounds in find_next_bit+0x38/0xb0

Fixes: 1b497e6493c4 ("PCI: dwc: Fix uninitialized variable in dw_handle_msi_irq()")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d3156446ff27..45f21640c977 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -78,7 +78,8 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 {
 	int i, pos, irq;
-	u32 val, num_ctrls;
+	unsigned long val;
+	u32 status, num_ctrls;
 	irqreturn_t ret = IRQ_NONE;
 
 	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
@@ -86,14 +87,14 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 	for (i = 0; i < num_ctrls; i++) {
 		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS +
 					(i * MSI_REG_CTRL_BLOCK_SIZE),
-				    4, &val);
-		if (!val)
+				    4, &status);
+		if (!status)
 			continue;
 
 		ret = IRQ_HANDLED;
+		val = status;
 		pos = 0;
-		while ((pos = find_next_bit((unsigned long *) &val,
-					    MAX_MSI_IRQS_PER_CTRL,
+		while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
 					    pos)) != MAX_MSI_IRQS_PER_CTRL) {
 			irq = irq_find_mapping(pp->irq_domain,
 					       (i * MAX_MSI_IRQS_PER_CTRL) +
-- 
2.21.0

