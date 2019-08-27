Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E998C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FC620828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfH0JRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:17:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35084 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbfH0JRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:17:16 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DA1F6BBEA7E83C558158;
        Tue, 27 Aug 2019 17:17:12 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 27 Aug 2019 17:17:07 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <yaohongbo@huawei.com>, <mchehab@kernel.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: v4l2-mem2mem: fix potential memory leak in  v4l2_m2m_register_media_controller
Date:   Tue, 27 Aug 2019 17:27:06 +0800
Message-ID: <20190827092706.29494-1-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I ran Syzkaller testsuite, I got this warning:

=====================================================================
SI: 0000000020000580 RDI: 0000000000000003
BUG: memory leak
unreferenced object 0xffff8881d6b0a270 (size 8):
  comm "syz-executor.0", pid 4859, jiffies 4296016954 (age 22.524s)
  hex dump (first 8 bytes):
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<0000000052b54061>] __media_entity_enum_init+0x40/0xb0 [mc]
    [<000000005c05c865>] media_device_register_entity+0x294/0x3a0 [mc]
    [<0000000070832883>] v4l2_m2m_register_entity+0x161/0x220
[v4l2_mem2mem]
    [<000000004952637a>] v4l2_m2m_register_media_controller+0x72/0x2d0
[v4l2_mem2mem]
    [<0000000047350ea2>] 0xffffffffc17c2c1a
    [<000000006c6d5c0a>] platform_drv_probe+0x7e/0x100
drivers/base/platform.c:616
    [<00000000f51bf5fc>] really_probe+0x342/0x4d0 drivers/base/dd.c:548
    [<000000006960ad55>] driver_probe_device+0x8c/0x170
drivers/base/dd.c:709
    [<000000005d3c0ee4>] device_driver_attach+0x99/0xa0
drivers/base/dd.c:983
    [<000000007516b430>] __driver_attach+0xc9/0x150
drivers/base/dd.c:1060
    [<00000000c3109efd>] bus_for_each_dev+0x115/0x180
drivers/base/bus.c:304
    [<00000000d6a6574c>] bus_add_driver+0x29e/0x340
drivers/base/bus.c:645
    [<000000002e9ed7c1>] driver_register+0xf7/0x210
drivers/base/driver.c:170
    [<00000000090ecd16>] 0xffffffffc17d0030
    [<0000000020dfefad>] do_one_initcall+0xd4/0x454 init/main.c:939
    [<00000000e7a758cd>] do_init_module+0xe0/0x330 kernel/module.c:3468

=====================================================================

When the first entity was created failed, m2m_dev->source->name will
never has chance to release.

Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 4f5176702937..c178aaf04b0f 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -791,7 +791,7 @@ int v4l2_m2m_register_media_controller(struct v4l2_m2m_dev *m2m_dev,
 	ret = v4l2_m2m_register_entity(mdev, m2m_dev,
 			MEM2MEM_ENT_TYPE_SOURCE, vdev, MEDIA_ENT_F_IO_V4L);
 	if (ret)
-		return ret;
+		goto err_rel_name;
 	ret = v4l2_m2m_register_entity(mdev, m2m_dev,
 			MEM2MEM_ENT_TYPE_PROC, vdev, function);
 	if (ret)
@@ -850,12 +850,13 @@ int v4l2_m2m_register_media_controller(struct v4l2_m2m_dev *m2m_dev,
 	media_entity_remove_links(m2m_dev->source);
 err_rel_entity2:
 	media_device_unregister_entity(&m2m_dev->proc);
-	kfree(m2m_dev->proc.name);
 err_rel_entity1:
 	media_device_unregister_entity(&m2m_dev->sink);
-	kfree(m2m_dev->sink.name);
+	kfree(m2m_dev->proc.name);
 err_rel_entity0:
 	media_device_unregister_entity(m2m_dev->source);
+	kfree(m2m_dev->sink.name);
+err_rel_name:
 	kfree(m2m_dev->source->name);
 	return ret;
 	return 0;
-- 
2.17.1

