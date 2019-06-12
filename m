Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BC1C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB4F207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ubkLiEay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbfFLKaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:30:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35070 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfFLKaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:30:01 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5CATxjB062212;
        Wed, 12 Jun 2019 05:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560335399;
        bh=wwNbg1w9v5IkgOhwYOOeoAu3oTH9oE2LfzyI39Kb0+0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ubkLiEayWkRYVd3mfzWVQCNgLU8GbntEDtHR+4jlbpT1ECqu6BdE7H7z4JF4tDep6
         toRBMlCU7ANfsPkZG0GgUzVwKfE9ZflpwL/9niXwF6UoceEtiPFfIvr8qr+kZ5kfVT
         0ku7bCLoVRrwJGLoYDj2aZQt1uwIHykMgEJN86zs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5CATxdA085469
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jun 2019 05:29:59 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 12
 Jun 2019 05:29:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 12 Jun 2019 05:29:59 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5CATTJc128310;
        Wed, 12 Jun 2019 05:29:57 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] phy: tegra: xusb: Add Tegra210 PLL power supplies
Date:   Wed, 12 Jun 2019 15:58:03 +0530
Message-ID: <20190612102803.25398-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612102803.25398-1-kishon@ti.com>
References: <20190612102803.25398-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The Tegra210 SoC has four inputs that consume power in order to supply
the PLLs that drive the various USB, PCI and SATA pads.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/tegra/xusb-tegra210.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index 05bee32a3a4d..eb754baa8d71 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -2017,6 +2017,13 @@ static const struct tegra_xusb_padctl_ops tegra210_xusb_padctl_ops = {
 	.hsic_set_idle = tegra210_hsic_set_idle,
 };
 
+static const char * const tegra210_xusb_padctl_supply_names[] = {
+	"avdd-pll-utmip",
+	"avdd-pll-uerefe",
+	"dvdd-pex-pll",
+	"hvdd-pex-pll-e",
+};
+
 const struct tegra_xusb_padctl_soc tegra210_xusb_padctl_soc = {
 	.num_pads = ARRAY_SIZE(tegra210_pads),
 	.pads = tegra210_pads,
@@ -2035,6 +2042,8 @@ const struct tegra_xusb_padctl_soc tegra210_xusb_padctl_soc = {
 		},
 	},
 	.ops = &tegra210_xusb_padctl_ops,
+	.supply_names = tegra210_xusb_padctl_supply_names,
+	.num_supplies = ARRAY_SIZE(tegra210_xusb_padctl_supply_names),
 };
 EXPORT_SYMBOL_GPL(tegra210_xusb_padctl_soc);
 
-- 
2.17.1

