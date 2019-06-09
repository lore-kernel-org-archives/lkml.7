Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C233FC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AA1205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100456;
	bh=RXOYdZgAg8uBpOhZ2AXd+Mg9uicbVNKzUTZocOfzsvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A724OtlwPpTWBleHa4V1Pu7e6Bm8flO+5sPSS9TslSQOeDDUY0tvotutGuRZLWG4P
	 JSDWpTHgcdXMf84qrizhhNGAbBsv++cdomHZyxhDYnERCLCXDNquNwxJQT907o0e4u
	 OFQNffhScqENPxln3v+jYAUnUgPjjMtwiP32Fj0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733126AbfFIQ5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733109AbfFIQ5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:57:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A9BA204EC;
        Sun,  9 Jun 2019 16:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099428;
        bh=RXOYdZgAg8uBpOhZ2AXd+Mg9uicbVNKzUTZocOfzsvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cu82sS9puGfBf3EvwfxePINEHMHxJtsj8hslQ4KbAbm/ZD+i2X3Lb4wmu2Rt+y6FD
         LEJE5iqzEJWi+y80r2rVi0GT9bETLubcsv+nz8L2u3pPZ9mH1YVa7/WRGkTy2T6I0+
         kWoipZCRD5/YKEEiNstBwtcG9ma00cWT+y1WGLW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junwei Hu <hujunwei4@huawei.com>,
        Wang Wang <wangwang2@huawei.com>,
        Xiaogang Wang <wangxiaogang3@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 035/241] tipc: switch order of device registration to fix a crash
Date:   Sun,  9 Jun 2019 18:39:37 +0200
Message-Id: <20190609164148.789841113@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junwei Hu <hujunwei4@huawei.com>

[ Upstream commit 7e27e8d6130c5e88fac9ddec4249f7f2337fe7f8 ]

When tipc is loaded while many processes try to create a TIPC socket,
a crash occurs:
 PANIC: Unable to handle kernel paging request at virtual
 address "dfff20000000021d"
 pc : tipc_sk_create+0x374/0x1180 [tipc]
 lr : tipc_sk_create+0x374/0x1180 [tipc]
   Exception class = DABT (current EL), IL = 32 bits
 Call trace:
  tipc_sk_create+0x374/0x1180 [tipc]
  __sock_create+0x1cc/0x408
  __sys_socket+0xec/0x1f0
  __arm64_sys_socket+0x74/0xa8
 ...

This is due to race between sock_create and unfinished
register_pernet_device. tipc_sk_insert tries to do
"net_generic(net, tipc_net_id)".
but tipc_net_id is not initialized yet.

So switch the order of the two to close the race.

This can be reproduced with multiple processes doing socket(AF_TIPC, ...)
and one process doing module removal.

Fixes: a62fbccecd62 ("tipc: make subscriber server support net namespace")
Signed-off-by: Junwei Hu <hujunwei4@huawei.com>
Reported-by: Wang Wang <wangwang2@huawei.com>
Reviewed-by: Xiaogang Wang <wangxiaogang3@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/core.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -126,10 +126,6 @@ static int __init tipc_init(void)
 	if (err)
 		goto out_netlink_compat;
 
-	err = tipc_socket_init();
-	if (err)
-		goto out_socket;
-
 	err = tipc_register_sysctl();
 	if (err)
 		goto out_sysctl;
@@ -138,6 +134,10 @@ static int __init tipc_init(void)
 	if (err)
 		goto out_pernet;
 
+	err = tipc_socket_init();
+	if (err)
+		goto out_socket;
+
 	err = tipc_bearer_setup();
 	if (err)
 		goto out_bearer;
@@ -145,12 +145,12 @@ static int __init tipc_init(void)
 	pr_info("Started in single node mode\n");
 	return 0;
 out_bearer:
+	tipc_socket_stop();
+out_socket:
 	unregister_pernet_subsys(&tipc_net_ops);
 out_pernet:
 	tipc_unregister_sysctl();
 out_sysctl:
-	tipc_socket_stop();
-out_socket:
 	tipc_netlink_compat_stop();
 out_netlink_compat:
 	tipc_netlink_stop();
@@ -162,10 +162,10 @@ out_netlink:
 static void __exit tipc_exit(void)
 {
 	tipc_bearer_cleanup();
+	tipc_socket_stop();
 	unregister_pernet_subsys(&tipc_net_ops);
 	tipc_netlink_stop();
 	tipc_netlink_compat_stop();
-	tipc_socket_stop();
 	tipc_unregister_sysctl();
 
 	pr_info("Deactivated\n");


