Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27432C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F046A206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732263AbfB1N7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:59:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:57052 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730687AbfB1N7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:59:11 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 66648E54007E58B5632D;
        Thu, 28 Feb 2019 21:59:05 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 28 Feb 2019
 21:58:56 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <joe@perches.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 1/2] appletalk: use remove_proc_subtree to simplify procfs code
Date:   Thu, 28 Feb 2019 21:56:26 +0800
Message-ID: <20190228135627.30408-2-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190228135627.30408-1-yuehaibing@huawei.com>
References: <20190228135627.30408-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Use remove_proc_subtree to remove the whole subtree
on cleanup.Also do some cleanup.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/appletalk/atalk_proc.c | 56 ++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 39 deletions(-)

diff --git a/net/appletalk/atalk_proc.c b/net/appletalk/atalk_proc.c
index 8006295..bd8734e 100644
--- a/net/appletalk/atalk_proc.c
+++ b/net/appletalk/atalk_proc.c
@@ -210,56 +210,34 @@ static const struct seq_operations atalk_seq_socket_ops = {
 	.show   = atalk_seq_socket_show,
 };
 
-static struct proc_dir_entry *atalk_proc_dir;
-
 int __init atalk_proc_init(void)
 {
-	struct proc_dir_entry *p;
-	int rc = -ENOMEM;
+	if (!proc_mkdir("atalk", init_net.proc_net))
+		return -ENOMEM;
 
-	atalk_proc_dir = proc_mkdir("atalk", init_net.proc_net);
-	if (!atalk_proc_dir)
+	if (!proc_create_seq("atalk/interface", 0444, init_net.proc_net,
+			    &atalk_seq_interface_ops))
 		goto out;
 
-	p = proc_create_seq("interface", 0444, atalk_proc_dir,
-			&atalk_seq_interface_ops);
-	if (!p)
-		goto out_interface;
-
-	p = proc_create_seq("route", 0444, atalk_proc_dir,
-			&atalk_seq_route_ops);
-	if (!p)
-		goto out_route;
+	if (!proc_create_seq("atalk/route", 0444, init_net.proc_net,
+			    &atalk_seq_route_ops))
+		goto out;
 
-	p = proc_create_seq("socket", 0444, atalk_proc_dir,
-			&atalk_seq_socket_ops);
-	if (!p)
-		goto out_socket;
+	if (!proc_create_seq("atalk/socket", 0444, init_net.proc_net,
+			    &atalk_seq_socket_ops))
+		goto out;
 
-	p = proc_create_seq_private("arp", 0444, atalk_proc_dir, &aarp_seq_ops,
-			sizeof(struct aarp_iter_state), NULL);
-	if (!p)
-		goto out_arp;
+	if (!proc_create_seq_private("atalk/arp", 0444, init_net.proc_net,
+				     &aarp_seq_ops,
+				     sizeof(struct aarp_iter_state), NULL))
+		goto out;
 
-	rc = 0;
 out:
-	return rc;
-out_arp:
-	remove_proc_entry("socket", atalk_proc_dir);
-out_socket:
-	remove_proc_entry("route", atalk_proc_dir);
-out_route:
-	remove_proc_entry("interface", atalk_proc_dir);
-out_interface:
-	remove_proc_entry("atalk", init_net.proc_net);
-	goto out;
+	remove_proc_subtree("atalk", init_net.proc_net);
+	return -ENOMEM;
 }
 
 void __exit atalk_proc_exit(void)
 {
-	remove_proc_entry("interface", atalk_proc_dir);
-	remove_proc_entry("route", atalk_proc_dir);
-	remove_proc_entry("socket", atalk_proc_dir);
-	remove_proc_entry("arp", atalk_proc_dir);
-	remove_proc_entry("atalk", init_net.proc_net);
+	remove_proc_subtree("atalk", init_net.proc_net);
 }
-- 
2.7.0


