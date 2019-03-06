Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8425CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C7C20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfCFH2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:28:13 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729123AbfCFH2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:28:12 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4D8BC25347E33E94876B;
        Wed,  6 Mar 2019 15:28:10 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Mar 2019
 15:28:03 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <joe@perches.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] appletalk: Correctly handle return value of register_snap_client
Date:   Wed, 6 Mar 2019 15:27:40 +0800
Message-ID: <20190306072740.18760-1-yuehaibing@huawei.com>
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

register_snap_client may return NULL, all the callers
check it, but only print a warning. This will result in
NULL pointer dereference in unregister_snap_client and other
places.

It has always been used like this since v2.6

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/atalk.h |  2 +-
 net/appletalk/aarp.c  | 10 ++++++----
 net/appletalk/ddp.c   | 20 ++++++++++++--------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/linux/atalk.h b/include/linux/atalk.h
index 5a90f28..0e5265a 100644
--- a/include/linux/atalk.h
+++ b/include/linux/atalk.h
@@ -108,7 +108,7 @@ static __inline__ struct elapaarp *aarp_hdr(struct sk_buff *skb)
 #define AARP_RESOLVE_TIME	(10 * HZ)
 
 extern struct datalink_proto *ddp_dl, *aarp_dl;
-extern void aarp_proto_init(void);
+extern int aarp_proto_init(void);
 
 /* Inter module exports */
 
diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
index 49a16ce..e047853 100644
--- a/net/appletalk/aarp.c
+++ b/net/appletalk/aarp.c
@@ -879,15 +879,17 @@ static struct notifier_block aarp_notifier = {
 
 static unsigned char aarp_snap_id[] = { 0x00, 0x00, 0x00, 0x80, 0xF3 };
 
-void __init aarp_proto_init(void)
+int __init aarp_proto_init(void)
 {
 	aarp_dl = register_snap_client(aarp_snap_id, aarp_rcv);
-	if (!aarp_dl)
-		printk(KERN_CRIT "Unable to register AARP with SNAP.\n");
+	if (!aarp_dl) {
+		pr_crit("Unable to register AARP with SNAP.\n");
+		return -ENOMEM;
+	}
 	timer_setup(&aarp_timer, aarp_expire_timeout, 0);
 	aarp_timer.expires  = jiffies + sysctl_aarp_expiry_time;
 	add_timer(&aarp_timer);
-	register_netdevice_notifier(&aarp_notifier);
+	return register_netdevice_notifier(&aarp_notifier);
 }
 
 /* Remove the AARP entries associated with a device. */
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 795fbc6..709d254 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1904,9 +1904,6 @@ static unsigned char ddp_snap_id[] = { 0x08, 0x00, 0x07, 0x80, 0x9B };
 EXPORT_SYMBOL(atrtr_get_dev);
 EXPORT_SYMBOL(atalk_find_dev_addr);
 
-static const char atalk_err_snap[] __initconst =
-	KERN_CRIT "Unable to register DDP with SNAP.\n";
-
 /* Called by proto.c on kernel start up */
 static int __init atalk_init(void)
 {
@@ -1921,17 +1918,22 @@ static int __init atalk_init(void)
 		goto out_proto;
 
 	ddp_dl = register_snap_client(ddp_snap_id, atalk_rcv);
-	if (!ddp_dl)
-		printk(atalk_err_snap);
+	if (!ddp_dl) {
+		pr_crit("Unable to register DDP with SNAP.\n");
+		goto out_sock;
+	}
 
 	dev_add_pack(&ltalk_packet_type);
 	dev_add_pack(&ppptalk_packet_type);
 
 	rc = register_netdevice_notifier(&ddp_notifier);
 	if (rc)
-		goto out_sock;
+		goto out_snap;
+
+	rc = aarp_proto_init();
+	if (rc)
+		goto out_dev;
 
-	aarp_proto_init();
 	rc = atalk_proc_init();
 	if (rc)
 		goto out_aarp;
@@ -1945,11 +1947,13 @@ static int __init atalk_init(void)
 	atalk_proc_exit();
 out_aarp:
 	aarp_cleanup_module();
+out_dev:
 	unregister_netdevice_notifier(&ddp_notifier);
-out_sock:
+out_snap:
 	dev_remove_pack(&ppptalk_packet_type);
 	dev_remove_pack(&ltalk_packet_type);
 	unregister_snap_client(ddp_dl);
+out_sock:
 	sock_unregister(PF_APPLETALK);
 out_proto:
 	proto_unregister(&ddp_proto);
-- 
2.7.0


