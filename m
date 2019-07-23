Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6733C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB22E21842
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbfGWIyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:54:40 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:2116 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbfGWIyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:54:40 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5d36cb319d5-faf59; Tue, 23 Jul 2019 16:54:10 +0800 (CST)
X-RM-TRANSID: 2eec5d36cb319d5-faf59
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45d36cb30958-8c1f5;
        Tue, 23 Jul 2019 16:54:10 +0800 (CST)
X-RM-TRANSID: 2ee45d36cb30958-8c1f5
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ptp: ptp_dte: remove redundant dev_err message
Date:   Tue, 23 Jul 2019 16:54:05 +0800
Message-Id: <1563872045-3692-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resource already contains error message, so remove
the redundant dev_err message

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/ptp/ptp_dte.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_dte.c b/drivers/ptp/ptp_dte.c
index 5b6393e..0dcfdc8 100644
--- a/drivers/ptp/ptp_dte.c
+++ b/drivers/ptp/ptp_dte.c
@@ -248,11 +248,8 @@ static int ptp_dte_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ptp_dte->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ptp_dte->regs)) {
-		dev_err(dev,
-			"%s: io remap failed\n", __func__);
+	if (IS_ERR(ptp_dte->regs))
 		return PTR_ERR(ptp_dte->regs);
-	}
 
 	spin_lock_init(&ptp_dte->lock);
 
-- 
1.9.1



