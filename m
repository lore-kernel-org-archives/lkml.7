Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86485C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F4C208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfE2H2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:28:22 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:2495 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2H2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:28:22 -0400
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 03:28:19 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55cee326f7cd-dbd1a; Wed, 29 May 2019 15:19:11 +0800 (CST)
X-RM-TRANSID: 2ee55cee326f7cd-dbd1a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35cee326e9c7-1e858;
        Wed, 29 May 2019 15:19:11 +0800 (CST)
X-RM-TRANSID: 2ee35cee326e9c7-1e858
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: afs: remove unneeded NULL check
Date:   Wed, 29 May 2019 15:18:22 +0800
Message-Id: <1559114302-10507-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL check before kfree is unneeded, so remove it.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/mtd/parsers/afs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/parsers/afs.c b/drivers/mtd/parsers/afs.c
index 0c73002..972b260 100644
--- a/drivers/mtd/parsers/afs.c
+++ b/drivers/mtd/parsers/afs.c
@@ -383,8 +383,7 @@ static int parse_afs_partitions(struct mtd_info *mtd,
 
 out_free_parts:
 	while (i >= 0) {
-		if (parts[i].name)
-			kfree(parts[i].name);
+		kfree(parts[i].name);
 		i--;
 	}
 	kfree(parts);
-- 
1.9.1



