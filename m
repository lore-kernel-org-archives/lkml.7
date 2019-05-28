Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DA7C04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809BB2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfE1HyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 03:54:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17593 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726921AbfE1HyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:54:04 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1F21FD6DC32BF474A829;
        Tue, 28 May 2019 15:54:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Tue, 28 May 2019 15:53:51 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jeremy@azazel.net>
CC:     <thesven73@gmail.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <matt.sickler@daktronics.com>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next v3 1/2] staging: kpc2000: report error status to spi core
Date:   Tue, 28 May 2019 16:02:13 +0800
Message-ID: <20190528080214.18382-2-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528080214.18382-1-maowenan@huawei.com>
References: <20190525081321.121294-1-maowenan@huawei.com>
 <20190528080214.18382-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an error condition that's not reported to
the spi core in kp_spi_transfer_one_message().
It should restore status value to m->status, and
return it in error path.

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 075ae4fafa7d..628a447642ad 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -374,7 +374,7 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
     list_for_each_entry(transfer, &m->transfers, transfer_list) {
         if (transfer->tx_buf == NULL && transfer->rx_buf == NULL && transfer->len) {
             status = -EINVAL;
-            break;
+            goto error;
         }
         
         /* transfer */
@@ -412,7 +412,7 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
             
             if (count != transfer->len) {
                 status = -EIO;
-                break;
+                goto error;
             }
         }
         
@@ -430,6 +430,10 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
     /* done work */
     spi_finalize_current_message(master);
     return 0;
+
+ error:
+    m->status = status;
+    return status;
 }
 
 static void
-- 
2.20.1

