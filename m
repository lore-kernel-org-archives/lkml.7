Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B92C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09C027F56
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559553398;
	bh=+Y3RyFGuyeVzcTxPSIRnG+lKl/0OSsVEM+e1L0Exjys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s7tach7UiZxcGs29AI/QwXdED3/kxcQ+ZBg2UsXYS/x1tQXbs3X2IOs68nta5HfAB
	 EaNreufAzrmdlOpWLQS24C43LzIc3lWeGiQ5Bmy0HnX6mSnW8+Y96f5qYmQpONzAcJ
	 NbRP00lx9Uy69TqiSc+WoEG0kMZXiWuJHJjsgeE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfFCJQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbfFCJMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:12:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A15427E94;
        Mon,  3 Jun 2019 09:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559553138;
        bh=+Y3RyFGuyeVzcTxPSIRnG+lKl/0OSsVEM+e1L0Exjys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eh0wVQiijwhiJ4fxdXgaSnv/t3g6NpTgMouf6Jh5raKHEFpsv5NAoxkK+WeGCZ/Gk
         fqNOKMytZ5BVu5bvGiivz05gol/tPbkQM+faXcWDBAbw95FohPGBxcDqobyj0Kl4XZ
         UK7VL6PO9DUFq12Y9y5xvgh8bJLJvP4QiUzsVnLo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 35/36] Revert "tipc: fix modprobe tipc failed after switch order of device registration"
Date:   Mon,  3 Jun 2019 11:09:23 +0200
Message-Id: <20190603090523.290867372@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603090520.998342694@linuxfoundation.org>
References: <20190603090520.998342694@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David S. Miller <davem@davemloft.net>

commit 5593530e56943182ebb6d81eca8a3be6db6dbba4 upstream.

This reverts commit 532b0f7ece4cb2ffd24dc723ddf55242d1188e5e.

More revisions coming up.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tipc/core.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -66,10 +66,6 @@ static int __net_init tipc_init_net(stru
 	INIT_LIST_HEAD(&tn->node_list);
 	spin_lock_init(&tn->node_list_lock);
 
-	err = tipc_socket_init();
-	if (err)
-		goto out_socket;
-
 	err = tipc_sk_rht_init(net);
 	if (err)
 		goto out_sk_rht;
@@ -96,8 +92,6 @@ out_subscr:
 out_nametbl:
 	tipc_sk_rht_destroy(net);
 out_sk_rht:
-	tipc_socket_stop();
-out_socket:
 	return err;
 }
 
@@ -108,7 +102,6 @@ static void __net_exit tipc_exit_net(str
 	tipc_bcast_stop(net);
 	tipc_nametbl_stop(net);
 	tipc_sk_rht_destroy(net);
-	tipc_socket_stop();
 }
 
 static struct pernet_operations tipc_net_ops = {
@@ -144,6 +137,10 @@ static int __init tipc_init(void)
 	if (err)
 		goto out_pernet;
 
+	err = tipc_socket_init();
+	if (err)
+		goto out_socket;
+
 	err = tipc_bearer_setup();
 	if (err)
 		goto out_bearer;
@@ -151,6 +148,8 @@ static int __init tipc_init(void)
 	pr_info("Started in single node mode\n");
 	return 0;
 out_bearer:
+	tipc_socket_stop();
+out_socket:
 	unregister_pernet_subsys(&tipc_net_ops);
 out_pernet:
 	tipc_unregister_sysctl();
@@ -166,6 +165,7 @@ out_netlink:
 static void __exit tipc_exit(void)
 {
 	tipc_bearer_cleanup();
+	tipc_socket_stop();
 	unregister_pernet_subsys(&tipc_net_ops);
 	tipc_netlink_stop();
 	tipc_netlink_compat_stop();


