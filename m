Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79007C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F96206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgAHLeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:34:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbgAHLeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:34:07 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B56B0A47790FBF70B4DD;
        Wed,  8 Jan 2020 19:34:06 +0800 (CST)
Received: from huawei.com (10.69.192.56) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 8 Jan 2020
 19:33:59 +0800
From:   Luo Jiaxing <luojiaxing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <saravanak@google.com>,
        <jejb@linux.ibm.com>, <James.Bottomley@suse.de>,
        <James.Bottomley@HansenPartnership.com>, <john.garry@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <luojiaxing@huawei.com>,
        <linuxarm@huawei.com>
Subject: [PATCH v1] driver core: Use list_del_init to replace list_del at device_links_purge()
Date:   Wed, 8 Jan 2020 19:34:04 +0800
Message-ID: <1578483244-50723-1-git-send-email-luojiaxing@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found that enabling kernel compilation options CONFIG_SCSI_ENCLOSURE and
CONFIG_ENCLOSURE_SERVICES, repeated initialization and deletion of the same
SCSI device will cause system panic, as follows:
[72.425705] Unable to handle kernel paging request at virtual address
dead000000000108
...
[72.595093] Call trace:
[72.597532] device_del + 0x194 / 0x3a0
[72.601012] enclosure_remove_device + 0xbc / 0xf8
[72.605445] ses_intf_remove + 0x9c / 0xd8
[72.609185] device_del + 0xf8 / 0x3a0
[72.612576] device_unregister + 0x14 / 0x30
[72.616489] __scsi_remove_device + 0xf4 / 0x140
[72.620747] scsi_remove_device + 0x28 / 0x40
[72.624745] scsi_remove_target + 0x1c8 / 0x220

After analysis, we see that in the error scenario, the ses module has the
following calling sequence:
device_register() -> device_del() -> device_add() -> device_del().
The first call to device_del() is fine, but the second call to device_del()
will cause a system panic.

Through disassembly, we locate that panic happen when device_links_purge()
call list_del() to remove device_links.needs_suppliers from list, and
list_del() will set this list entry's prev and next pointers to poison.
So if INIT_LIST_HEAD() is not re-executed before the next list_del(), It
will cause the system to access a memory address which is posioned.

Therefore, replace list_del() with list_del_init() can avoid such issue.

Fixes: e2ae9bcc4aaa ("driver core: Add support for linking devices during device addition")
Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Reviewed-by: John Garry <john.garry@huawei.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 42a6724..7b9b0d6 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1103,7 +1103,7 @@ static void device_links_purge(struct device *dev)
 	struct device_link *link, *ln;
 
 	mutex_lock(&wfs_lock);
-	list_del(&dev->links.needs_suppliers);
+	list_del_init(&dev->links.needs_suppliers);
 	mutex_unlock(&wfs_lock);
 
 	/*
-- 
2.7.4

