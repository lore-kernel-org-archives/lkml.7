Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E25EC04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250042133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfEYIFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 04:05:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58434 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726256AbfEYIFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 04:05:02 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C69EB89F2EF8727085CA;
        Sat, 25 May 2019 16:04:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Sat, 25 May 2019 16:04:49 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jeremy@azazel.net>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next v2] =?UTF-8?q?staging:=20kpc2000:=20Remove=20set=20b?= =?UTF-8?q?ut=20not=20used=20variable=20=E2=80=98status=E2=80=99?=
Date:   Sat, 25 May 2019 16:13:21 +0800
Message-ID: <20190525081321.121294-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525042642.78482-1-maowenan@huawei.com>
References: <20190525042642.78482-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/kpc2000/kpc_spi/spi_driver.c: In function
‘kp_spi_transfer_one_message’:
drivers/staging/kpc2000/kpc_spi/spi_driver.c:282:9: warning: variable
‘status’ set but not used [-Wunused-but-set-variable]
     int status = 0;
         ^~~~~~
The variable 'status' is not used any more, remve it.

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 v2: change the subject of the patch.
---
 drivers/staging/kpc2000/kpc_spi/spi_driver.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_spi/spi_driver.c b/drivers/staging/kpc2000/kpc_spi/spi_driver.c
index 86df16547a92..16f9518f8d63 100644
--- a/drivers/staging/kpc2000/kpc_spi/spi_driver.c
+++ b/drivers/staging/kpc2000/kpc_spi/spi_driver.c
@@ -279,7 +279,6 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
     struct kp_spi       *kpspi;
     struct spi_transfer *transfer;
     union kp_spi_config sc;
-    int status = 0;
     
     spidev = m->spi;
     kpspi = spi_master_get_devdata(master);
@@ -332,7 +331,6 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
     /* do the transfers for this message */
     list_for_each_entry(transfer, &m->transfers, transfer_list) {
         if (transfer->tx_buf == NULL && transfer->rx_buf == NULL && transfer->len) {
-            status = -EINVAL;
             break;
         }
         
@@ -370,7 +368,6 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
             m->actual_length += count;
             
             if (count != transfer->len) {
-                status = -EIO;
                 break;
             }
         }
-- 
2.20.1

