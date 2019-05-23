Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A761FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEEB217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558638673;
	bh=x6thWel1AU0LQgl9B8M1qfwthnSUJktIQxfj+isHwWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e5dOqfrZYArjT78++Pd0/IDS1unxLcUxEEj8tatymt9lSG4Z4lCJ/YZF2s9hfdT8k
	 FsqTlhJcCIDCsBncXdzZVq5x3APsQegBnAWhjYiZ8QQjbe71mdgxQxdqkZEapI7/m7
	 kQX/YYeZndbTq1AMEC1B/mHnhdJP6EzrhE3tvmHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388101AbfEWTLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388079AbfEWTLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:11:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7283217D7;
        Thu, 23 May 2019 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638667;
        bh=x6thWel1AU0LQgl9B8M1qfwthnSUJktIQxfj+isHwWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7TLqjq9nlen6IADBYXLeXof1RUYhbhBoQnNpaPNGK7Ee+Lb6anHbxkUNsNr/6wQ0
         uOsZkRC/tKCjmV1ovU75W0zLEzQ9IbSGN0eNXCFBThc8/z3y+8AR8+F5wywAOVRQKB
         M2i3Ag0NxsETnfRlE+uo43lXIiN1V6fHHS8ZzRM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junwei Hu <hujunwei4@huawei.com>,
        Wang Wang <wangwang2@huawei.com>,
        Xiaogang Wang <wangxiaogang3@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 06/77] tipc: switch order of device registration to fix a crash
Date:   Thu, 23 May 2019 21:05:24 +0200
Message-Id: <20190523181720.958407871@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181719.982121681@linuxfoundation.org>
References: <20190523181719.982121681@linuxfoundation.org>
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
@@ -125,10 +125,6 @@ static int __init tipc_init(void)
 	if (err)
 		goto out_netlink_compat;
 
-	err = tipc_socket_init();
-	if (err)
-		goto out_socket;
-
 	err = tipc_register_sysctl();
 	if (err)
 		goto out_sysctl;
@@ -137,6 +133,10 @@ static int __init tipc_init(void)
 	if (err)
 		goto out_pernet;
 
+	err = tipc_socket_init();
+	if (err)
+		goto out_socket;
+
 	err = tipc_bearer_setup();
 	if (err)
 		goto out_bearer;
@@ -144,12 +144,12 @@ static int __init tipc_init(void)
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
@@ -161,10 +161,10 @@ out_netlink:
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


