Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4927C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC3A218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfCUI0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:26:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbfCUI0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:26:50 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5049CA7E003927B2E734;
        Thu, 21 Mar 2019 16:26:47 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Mar 2019
 16:26:37 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <sudipm.mukherjee@gmail.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] parport_cs: Fix memory leak in parport_config
Date:   Thu, 21 Mar 2019 16:26:28 +0800
Message-ID: <20190321082628.14384-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

parport_probe() alloc parport device 'info',
but while parport_config failed it does not free it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/parport/parport_cs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/parport_cs.c b/drivers/parport/parport_cs.c
index e9b52e4..e77044c2 100644
--- a/drivers/parport/parport_cs.c
+++ b/drivers/parport/parport_cs.c
@@ -158,8 +158,9 @@ static int parport_config(struct pcmcia_device *link)
     return 0;
 
 failed:
-    parport_cs_release(link);
-    return -ENODEV;
+	parport_cs_release(link);
+	kfree(link->priv);
+	return -ENODEV;
 } /* parport_config */
 
 static void parport_cs_release(struct pcmcia_device *link)
-- 
2.7.0


