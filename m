Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6081EC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359C620863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639196;
	bh=7CsxQZnR9OEYV73h7mR3bBrUUkWb0cqJ/BNieI70RKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MMXcYWBB4DU3XZB4FenbBEOzYxpiuUDuYJwlAogWUAPV+SPp2j932cHS9LPhYd7Sm
	 bQYKU3Z5wJAS829Io232FblbVyWfxhJ8PYXOejQQ9N+i+/kvCS0SUKF2VDKJTvFEJN
	 alp9Me+o3q2wKkrUYEwjJtQNhW6/6rTzZGhI35pY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389943AbfEWTTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389928AbfEWTTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:19:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D617820863;
        Thu, 23 May 2019 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639191;
        bh=7CsxQZnR9OEYV73h7mR3bBrUUkWb0cqJ/BNieI70RKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjY8TMe28vwbY7YaMkN+LvChKkMQxfdU61d4cS9a29O73JL+Ve48Lo0FxcXBW81cB
         kiLh1tefbIVASP5XbchL2iVuKPykYxccaBtpJdBDuHzQCI2viOURd77SHc7Rmn1TfQ
         EpjL1JrzhJHsGz1+kwZL7AYTZG9SSjqmdkzHa5AQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junwei Hu <hujunwei4@huawei.com>,
        Wang Wang <wangwang2@huawei.com>,
        Kang Zhou <zhoukang7@huawei.com>,
        Suanming Mou <mousuanming@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 013/139] tipc: fix modprobe tipc failed after switch order of device registration
Date:   Thu, 23 May 2019 21:05:01 +0200
Message-Id: <20190523181722.193050896@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junwei Hu <hujunwei4@huawei.com>

[ Upstream commit 532b0f7ece4cb2ffd24dc723ddf55242d1188e5e ]

Error message printed:
modprobe: ERROR: could not insert 'tipc': Address family not
supported by protocol.
when modprobe tipc after the following patch: switch order of
device registration, commit 7e27e8d6130c
("tipc: switch order of device registration to fix a crash")

Because sock_create_kern(net, AF_TIPC, ...) is called by
tipc_topsrv_create_listener() in the initialization process
of tipc_net_ops, tipc_socket_init() must be execute before that.

I move tipc_socket_init() into function tipc_init_net().

Fixes: 7e27e8d6130c
("tipc: switch order of device registration to fix a crash")
Signed-off-by: Junwei Hu <hujunwei4@huawei.com>
Reported-by: Wang Wang <wangwang2@huawei.com>
Reviewed-by: Kang Zhou <zhoukang7@huawei.com>
Reviewed-by: Suanming Mou <mousuanming@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/core.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -66,6 +66,10 @@ static int __net_init tipc_init_net(stru
 	INIT_LIST_HEAD(&tn->node_list);
 	spin_lock_init(&tn->node_list_lock);
 
+	err = tipc_socket_init();
+	if (err)
+		goto out_socket;
+
 	err = tipc_sk_rht_init(net);
 	if (err)
 		goto out_sk_rht;
@@ -92,6 +96,8 @@ out_subscr:
 out_nametbl:
 	tipc_sk_rht_destroy(net);
 out_sk_rht:
+	tipc_socket_stop();
+out_socket:
 	return err;
 }
 
@@ -102,6 +108,7 @@ static void __net_exit tipc_exit_net(str
 	tipc_bcast_stop(net);
 	tipc_nametbl_stop(net);
 	tipc_sk_rht_destroy(net);
+	tipc_socket_stop();
 }
 
 static struct pernet_operations tipc_net_ops = {
@@ -137,10 +144,6 @@ static int __init tipc_init(void)
 	if (err)
 		goto out_pernet;
 
-	err = tipc_socket_init();
-	if (err)
-		goto out_socket;
-
 	err = tipc_bearer_setup();
 	if (err)
 		goto out_bearer;
@@ -148,8 +151,6 @@ static int __init tipc_init(void)
 	pr_info("Started in single node mode\n");
 	return 0;
 out_bearer:
-	tipc_socket_stop();
-out_socket:
 	unregister_pernet_subsys(&tipc_net_ops);
 out_pernet:
 	tipc_unregister_sysctl();
@@ -165,7 +166,6 @@ out_netlink:
 static void __exit tipc_exit(void)
 {
 	tipc_bearer_cleanup();
-	tipc_socket_stop();
 	unregister_pernet_subsys(&tipc_net_ops);
 	tipc_netlink_stop();
 	tipc_netlink_compat_stop();


