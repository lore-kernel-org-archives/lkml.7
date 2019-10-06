Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC3EC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CB72173B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570382838;
	bh=rqIDfpoejZDcFJ9Lx/ILUg+s18yzaiLxAcuONLtaes8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QYpzVenFFaJ7pQSqR2B6nNrN3B8JvbHKSy3XTgXZ+GBh1Wl5hUZAOLxna/pD3LC15
	 pMi0nj9WyZlayAevM/NRZJQv/xswPC2O3ttFDz+NXJUlBUCGBjabTKmkFCdEMc5m77
	 rWApO3OJdIjpJrebX+YuSRyJ6Q0AFuPy1fdU2CFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfJFR1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbfJFR1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:27:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56C222077B;
        Sun,  6 Oct 2019 17:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382829;
        bh=rqIDfpoejZDcFJ9Lx/ILUg+s18yzaiLxAcuONLtaes8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETczuUAT9DaaecaOtI9S7vGXmRs5MKlgQcqsDgKlpiU1HJHr0j3FmES7WxE6Wwr9V
         d2lBQnHaMNClscaa0x/SRKkALxFJOr05MX1b7C7vmgwwNzdTxyRZSQYCPG23zkBvTW
         UrFZFXhHiYSae5wZGMZ6q6SJBYEj9wtK7xDWsfLI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 38/68] PCI: imx6: Propagate errors for optional regulators
Date:   Sun,  6 Oct 2019 19:21:14 +0200
Message-Id: <20191006171126.248622294@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171108.150129403@linuxfoundation.org>
References: <20191006171108.150129403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 2170a09fb4b0f66e06e5bcdcbc98c9ccbf353650 ]

regulator_get_optional() can fail for a number of reasons besides probe
deferral. It can for example return -ENOMEM if it runs out of memory as
it tries to allocate data structures. Propagating only -EPROBE_DEFER is
problematic because it results in these legitimately fatal errors being
treated as "regulator not specified in DT".

What we really want is to ignore the optional regulators only if they
have not been specified in DT. regulator_get_optional() returns -ENODEV
in this case, so that's the special case that we need to handle. So we
propagate all errors, except -ENODEV, so that real failures will still
cause the driver to fail probe.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: kernel@pengutronix.de
Cc: linux-imx@nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/dwc/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index 1f1069b70e45a..5509b6e2de94b 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -827,8 +827,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 
 	imx6_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
 	if (IS_ERR(imx6_pcie->vpcie)) {
-		if (PTR_ERR(imx6_pcie->vpcie) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(imx6_pcie->vpcie) != -ENODEV)
+			return PTR_ERR(imx6_pcie->vpcie);
 		imx6_pcie->vpcie = NULL;
 	}
 
-- 
2.20.1



