Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1219C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF94F20879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfENPeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 11:34:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7645 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbfENPeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:34:23 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 18DD8EF5B46FE4019ED3;
        Tue, 14 May 2019 23:34:20 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 May 2019
 23:34:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <sudipm.mukherjee@gmail.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] parport: Fix mem leak in parport_register_dev_model
Date:   Tue, 14 May 2019 23:24:37 +0800
Message-ID: <20190514152437.35744-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: memory leak
unreferenced object 0xffff8881df48cda0 (size 16):
  comm "syz-executor.0", pid 5077, jiffies 4295994670 (age 22.280s)
  hex dump (first 16 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000d2d0d5fe>] parport_register_dev_model+0x141/0x6e0 [parport]
    [<00000000782f6dab>] 0xffffffffc15d1196
    [<00000000d2ca6ae4>] platform_drv_probe+0x7e/0x100
    [<00000000628c2a94>] really_probe+0x342/0x4d0
    [<000000006874f5da>] driver_probe_device+0x8c/0x170
    [<00000000424de37a>] __device_attach_driver+0xda/0x100
    [<000000002acab09a>] bus_for_each_drv+0xfe/0x170
    [<000000003d9e5f31>] __device_attach+0x190/0x230
    [<0000000035d32f80>] bus_probe_device+0x123/0x140
    [<00000000a05ba627>] device_add+0x7cc/0xce0
    [<000000003f7560bf>] platform_device_add+0x230/0x3c0
    [<000000002a0be07d>] 0xffffffffc15d0949
    [<000000007361d8d2>] port_check+0x3b/0x50 [parport]
    [<000000004d67200f>] bus_for_each_dev+0x115/0x180
    [<000000003ccfd11c>] __parport_register_driver+0x1f0/0x210 [parport]
    [<00000000987f06fc>] 0xffffffffc15d803e
	
After commit 4e5a74f1db8d ("parport: Revert "parport: fix
memory leak""), free_pardevice do not free par_dev->state,
we should free it in error path of parport_register_dev_model
before return.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 4e5a74f1db8d ("parport: Revert "parport: fix memory leak"")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/parport/share.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 5dc53d4..7b4ee33 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -895,6 +895,7 @@ parport_register_dev_model(struct parport *port, const char *name,
 	par_dev->devmodel = true;
 	ret = device_register(&par_dev->dev);
 	if (ret) {
+		kfree(par_dev->state);
 		put_device(&par_dev->dev);
 		goto err_put_port;
 	}
@@ -912,6 +913,7 @@ parport_register_dev_model(struct parport *port, const char *name,
 			spin_unlock(&port->physport->pardevice_lock);
 			pr_debug("%s: cannot grant exclusive access for device %s\n",
 				 port->name, name);
+			kfree(par_dev->state);
 			device_unregister(&par_dev->dev);
 			goto err_put_port;
 		}
-- 
2.7.4


