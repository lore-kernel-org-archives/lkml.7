Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2138CC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 06:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F8F206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 06:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfEDGy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 02:54:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbfEDGyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 02:54:54 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 208E47543CC32401C728;
        Sat,  4 May 2019 14:54:51 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Sat, 4 May 2019 14:54:43 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alastair D'Silva <alastair@d-silva.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ocxl: Fix return value check in afu_ioctl()
Date:   Sat, 4 May 2019 07:04:30 +0000
Message-ID: <20190504070430.57008-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function eventfd_ctx_fdget() returns ERR_PTR() and
never returns NULL. The NULL test in the return value check should be
replaced with IS_ERR().

This issue was detected by using the Coccinelle software.

Fixes: 060146614643 ("ocxl: move event_fd handling to frontend")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/misc/ocxl/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index 8aa22893ed76..2870c25da166 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -257,8 +257,8 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 			return -EINVAL;
 		irq_id = ocxl_irq_offset_to_id(ctx, irq_fd.irq_offset);
 		ev_ctx = eventfd_ctx_fdget(irq_fd.eventfd);
-		if (!ev_ctx)
-			return -EFAULT;
+		if (IS_ERR(ev_ctx))
+			return PTR_ERR(ev_ctx);
 		rc = ocxl_irq_set_handler(ctx, irq_id, irq_handler, irq_free, ev_ctx);
 		break;



