Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4420EC282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1272186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfDLEkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 00:40:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39580 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725769AbfDLEkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 00:40:42 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9BFC7B7F8FA0EC5C2B63;
        Fri, 12 Apr 2019 12:40:38 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Fri, 12 Apr 2019
 12:40:30 +0800
From:   Wang Hai <wanghai26@huawei.com>
To:     <davem@davemloft.net>, <idosch@mellanox.com>,
        <eric.dumazet@gmail.com>, <alexander.h.duyck@intel.com>,
        <tyhicks@canonical.com>, <f.fainelli@gmail.com>,
        <viro@zeniv.linux.org.uk>, <amritha.nambiar@intel.com>,
        <joe@perches.com>, <dmitry.torokhov@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <stephen@networkplumber.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wanghai26@huawei.com>
Subject: [PATCH 2/2] net-sysfs: Fix memory leak in netdev_register_kobject
Date:   Fri, 12 Apr 2019 16:36:34 -0400
Message-ID: <20190412203634.30392-3-wanghai26@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412203634.30392-1-wanghai26@huawei.com>
References: <20190412203634.30392-1-wanghai26@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When registering struct net_device, it will call
        register_netdevice ->
                netdev_register_kobject ->
                        device_initialize(dev);
                        dev_set_name(dev, "%s", ndev->name)
                        device_add(dev)
                        register_queue_kobjects(ndev)

In netdev_register_kobject(), if device_add(dev) or
register_queue_kobjects(ndev) failed. Register_netdevice()
will return error, causing netdev_freemem(ndev) to be
called to free net_device, however put_device(&dev->dev)->..->
kobject_cleanup() won't be called, resulting in a memory leak
which is alloced by dev_set_name()

syzkaller report this:
BUG: memory leak
unreferenced object 0xffff8881f4fad168 (size 8):
comm "syz-executor.0", pid 3575, jiffies 4294778002 (age 20.134s)
hex dump (first 8 bytes):
  77 70 61 6e 30 00 ff ff                          wpan0...
backtrace:
  [<000000006d2d91d7>] kstrdup_const+0x3d/0x50 mm/util.c:73
  [<00000000ba9ff953>] kvasprintf_const+0x112/0x170 lib/kasprintf.c:48
  [<000000005555ec09>] kobject_set_name_vargs+0x55/0x130 lib/kobject.c:281
  [<0000000098d28ec3>] dev_set_name+0xbb/0xf0 drivers/base/core.c:1915
  [<00000000b7553017>] netdev_register_kobject+0xc0/0x410 net/core/net-sysfs.c:1727
  [<00000000c826a797>] register_netdevice+0xa51/0xeb0 net/core/dev.c:8711
  [<00000000857bfcfd>] cfg802154_update_iface_num.isra.2+0x13/0x90 [ieee802154]
  [<000000003126e453>] ieee802154_llsec_fill_key_id+0x1d5/0x570 [ieee802154]
  [<00000000e4b3df51>] 0xffffffffc1500e0e
  [<00000000b4319776>] platform_drv_probe+0xc6/0x180 drivers/base/platform.c:614
  [<0000000037669347>] really_probe+0x491/0x7c0 drivers/base/dd.c:509
  [<000000008fed8862>] driver_probe_device+0xdc/0x240 drivers/base/dd.c:671
  [<00000000baf52041>] device_driver_attach+0xf2/0x130 drivers/base/dd.c:945
  [<00000000c7cc8dec>] __driver_attach+0x10e/0x210 drivers/base/dd.c:1022
  [<0000000057a757c2>] bus_for_each_dev+0x154/0x1e0 drivers/base/bus.c:304
  [<000000005f5ae04b>] bus_add_driver+0x427/0x5e0 drivers/base/bus.c:645

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
Signed-off-by: Wang Hai <wanghai26@huawei.com>
---
 net/core/net-sysfs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 8f8b7b6..095cdce 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1747,16 +1747,20 @@ int netdev_register_kobject(struct net_device *ndev)
 
 	error = device_add(dev);
 	if (error)
-		return error;
+		goto error_device_add;
 
 	error = register_queue_kobjects(ndev);
-	if (error) {
-		device_del(dev);
-		return error;
-	}
+	if (error)
+		goto error_register;
 
 	pm_runtime_set_memalloc_noio(dev, true);
 
+	return 0;
+
+error_register:
+	device_del(dev);
+error_device_add:
+	kfree_const(dev->kobj.name);
 	return error;
 }
 
-- 
1.8.3.1

