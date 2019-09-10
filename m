Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511A8C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3248F20872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfIJJ11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:27:27 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:2978 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfIJJ11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:27:27 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55d776c71e10-df552; Tue, 10 Sep 2019 17:27:13 +0800 (CST)
X-RM-TRANSID: 2ee55d776c71e10-df552
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75d776c6ed83-6fa8a;
        Tue, 10 Sep 2019 17:27:13 +0800 (CST)
X-RM-TRANSID: 2ee75d776c6ed83-6fa8a
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: remove redundant dev_err message
Date:   Tue, 10 Sep 2019 17:26:56 +0800
Message-Id: <1568107616-12755-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resource already contains error message, so remove
the redundant dev_err message

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/fpga/ts73xx-fpga.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index 9a17fe9..2888ff0 100644
--- a/drivers/fpga/ts73xx-fpga.c
+++ b/drivers/fpga/ts73xx-fpga.c
@@ -119,10 +119,8 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->io_base = devm_ioremap_resource(kdev, res);
-	if (IS_ERR(priv->io_base)) {
-		dev_err(kdev, "unable to remap registers\n");
+	if (IS_ERR(priv->io_base))
 		return PTR_ERR(priv->io_base);
-	}
 
 	mgr = devm_fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
 				   &ts73xx_fpga_ops, priv);
-- 
1.9.1



