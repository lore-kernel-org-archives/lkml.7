Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4243DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AFF20835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xMGgM+6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbfDXWYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:24:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41102 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfDXWYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:24:39 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3OMOYiO020824;
        Wed, 24 Apr 2019 17:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556144674;
        bh=unQq1+z0iNRuTfKra4LE6BoXbsmw8kudBXsZCBKVcGc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xMGgM+6oGMR3omHrFCFZr+ix6SUJh63cOCO2wPsSjK3ZEK/fafjuZmZKkO3IrnBXM
         iqSlWMFdQpmulS3JSjE2TM+EUyJ2D3w66ycIyX/emWlKT/FOO39DlalOIQMEHmHTfZ
         T+dHhuc79VO5kcYwLv5AML2WrqTAC0maQwtQ+GaA=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3OMOXOT110553
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Apr 2019 17:24:33 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 24
 Apr 2019 17:24:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 24 Apr 2019 17:24:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3OMOWCL049868;
        Wed, 24 Apr 2019 17:24:32 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Jiri Pirko <jiri@resnulli.us>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH v3 net-next 01/11] net: ethernet: ti: cpts: use devm_get_clk_from_child
Date:   Thu, 25 Apr 2019 01:24:17 +0300
Message-ID: <1556144667-27997-2-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_get_clk_from_child() instead of devm_clk_get() and this way allow
to group CPTS DT properties in sub-node for better code readability and
maintenance.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index 499806ce4cd5..aad118e71b61 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -572,7 +572,7 @@ struct cpts *cpts_create(struct device *dev, void __iomem *regs,
 	if (ret)
 		return ERR_PTR(ret);
 
-	cpts->refclk = devm_clk_get(dev, "cpts");
+	cpts->refclk = devm_get_clk_from_child(dev, node, "cpts");
 	if (IS_ERR(cpts->refclk)) {
 		dev_err(dev, "Failed to get cpts refclk\n");
 		return ERR_CAST(cpts->refclk);
-- 
2.17.1

