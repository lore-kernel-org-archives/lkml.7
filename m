Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD00C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B7F20815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfEPPza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:55:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbfEPPza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:55:30 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 877F9E94BECBF6786BB9;
        Thu, 16 May 2019 23:55:24 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 16 May 2019
 23:55:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <socketcan@hartkopp.net>,
        <mkl@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-can@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] can: gw: Fix error path of cgw_module_init
Date:   Thu, 16 May 2019 23:54:35 +0800
Message-ID: <20190516155435.42376-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix error path for cgw_module_init
to avoid possible crash if some error occurs.

Fixes: c1aabdf379bc ("can-gw: add netlink based CAN routing")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/can/gw.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 53859346..8b53ec7 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -1046,32 +1046,48 @@ static __init int cgw_module_init(void)
 	pr_info("can: netlink gateway (rev " CAN_GW_VERSION ") max_hops=%d\n",
 		max_hops);
 
-	register_pernet_subsys(&cangw_pernet_ops);
+	ret = register_pernet_subsys(&cangw_pernet_ops);
+	if (ret)
+		return ret;
+
+	ret = -ENOMEM;
 	cgw_cache = kmem_cache_create("can_gw", sizeof(struct cgw_job),
 				      0, 0, NULL);
-
 	if (!cgw_cache)
-		return -ENOMEM;
+		goto out_cache_create;
 
 	/* set notifier */
 	notifier.notifier_call = cgw_notifier;
-	register_netdevice_notifier(&notifier);
+	ret = register_netdevice_notifier(&notifier);
+	if (ret)
+		goto out_register_notifier;
 
 	ret = rtnl_register_module(THIS_MODULE, PF_CAN, RTM_GETROUTE,
 				   NULL, cgw_dump_jobs, 0);
-	if (ret) {
-		unregister_netdevice_notifier(&notifier);
-		kmem_cache_destroy(cgw_cache);
-		return -ENOBUFS;
-	}
-
-	/* Only the first call to rtnl_register_module can fail */
-	rtnl_register_module(THIS_MODULE, PF_CAN, RTM_NEWROUTE,
-			     cgw_create_job, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_CAN, RTM_DELROUTE,
-			     cgw_remove_job, NULL, 0);
+	if (ret)
+		goto out_rtnl_register1;
+
+	ret = rtnl_register_module(THIS_MODULE, PF_CAN, RTM_NEWROUTE,
+				   cgw_create_job, NULL, 0);
+	if (ret)
+		goto out_rtnl_register2;
+	ret = rtnl_register_module(THIS_MODULE, PF_CAN, RTM_DELROUTE,
+				   cgw_remove_job, NULL, 0);
+	if (ret)
+		goto out_rtnl_register2;
 
 	return 0;
+
+out_rtnl_register2:
+	rtnl_unregister_all(PF_CAN);
+out_rtnl_register1:
+	unregister_netdevice_notifier(&notifier);
+out_register_notifier:
+	kmem_cache_destroy(cgw_cache);
+out_cache_create:
+	unregister_pernet_subsys(&cangw_pernet_ops);
+
+	return ret;
 }
 
 static __exit void cgw_module_exit(void)
-- 
1.8.3.1


