Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4CCC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B79A20675
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbfFTKLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:11:40 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:2499 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfFTKLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:11:39 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55d0b5bc4b63-aacf5; Thu, 20 Jun 2019 18:11:17 +0800 (CST)
X-RM-TRANSID: 2ee55d0b5bc4b63-aacf5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35d0b5bc4b72-284b9;
        Thu, 20 Jun 2019 18:11:17 +0800 (CST)
X-RM-TRANSID: 2ee35d0b5bc4b72-284b9
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     rubini@gnudd.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] FMC: fix 'passing zero to PTR_ERR()' warning
Date:   Thu, 20 Jun 2019 18:10:21 +0800
Message-Id: <1561025421-19655-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a static code checker warning:
drivers/fmc/fmc-debug.c:155
	fmc_debug_init() warn: passing zero to 'PTR_ERR'

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/fmc/fmc-debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fmc/fmc-debug.c b/drivers/fmc/fmc-debug.c
index 1734c7c..dd33951 100644
--- a/drivers/fmc/fmc-debug.c
+++ b/drivers/fmc/fmc-debug.c
@@ -152,7 +152,7 @@ int fmc_debug_init(struct fmc_device *fmc)
 	fmc->dbg_dir = debugfs_create_dir(dev_name(&fmc->dev), NULL);
 	if (IS_ERR_OR_NULL(fmc->dbg_dir)) {
 		pr_err("FMC: Cannot create debugfs\n");
-		return PTR_ERR(fmc->dbg_dir);
+		return PTR_ERR_OR_ZERO(fmc->dbg_dir);
 	}
 
 	fmc->dbg_sdb_dump = debugfs_create_file(FMC_DBG_SDB_DUMP, 0444,
-- 
1.9.1



