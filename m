Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FBDC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBC7218A4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfGDIFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:05:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfGDIFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:05:50 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E2ABDFE2A8D148F6F5BB;
        Thu,  4 Jul 2019 16:05:46 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 4 Jul 2019
 16:05:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <gregkh@linuxfoundation.org>, <linux@zary.sk>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] scsi: fdomain: Fix PCMCIA_FDOMAIN Kconfig warning
Date:   Thu, 4 Jul 2019 16:01:56 +0800
Message-ID: <20190704080156.52044-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Kconfig warning for PCMCIA_FDOMAIN symbol:

WARNING: unmet direct dependencies detected for SCSI_FDOMAIN
  Depends on [n]: SCSI_LOWLEVEL [=n] && SCSI [=y]
  Selected by [m]:
  - PCMCIA_FDOMAIN [=m] && SCSI_LOWLEVEL_PCMCIA [=y] && SCSI [=y] && PCMCIA [=m] && m && MODULES [=y]

Add SCSI_FDOMAIN and SCSI_LOWLEVEL dependency.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 8674a8aa2c39 ("scsi: fdomain: Add PCMCIA support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/pcmcia/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pcmcia/Kconfig b/drivers/scsi/pcmcia/Kconfig
index 2368f34..f23a572 100644
--- a/drivers/scsi/pcmcia/Kconfig
+++ b/drivers/scsi/pcmcia/Kconfig
@@ -22,7 +22,7 @@ config PCMCIA_AHA152X
 
 config PCMCIA_FDOMAIN
 	tristate "Future Domain PCMCIA support"
-	select SCSI_FDOMAIN
+	depends on SCSI_FDOMAIN && SCSI_LOWLEVEL
 	help
 	  Say Y here if you intend to attach this type of PCMCIA SCSI host
 	  adapter to your computer.
-- 
2.7.4


