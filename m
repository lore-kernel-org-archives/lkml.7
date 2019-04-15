Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3743C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD59920880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355126;
	bh=XIx9ARAKjIZ9JLOSw4XBCYpzVv7FyVXP5tEeOMQhOMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1yZXiiDjLQ3ug1u6jugJHrDhGFZfq5j0yaPUa0srMCbEoDELIVQp+nUJlrUH38hI7
	 z73mCCj0viBfP3YwaROJnHNu9QEgfn0et/UiHc+/iQFGLFXXv0Zzz32J39udhP7s92
	 /7wGBmg4pygiRzEkAjnVkCeVIeaCWMRyDgq3tWPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbfDOTFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729158AbfDOTFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:05:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 251092087C;
        Mon, 15 Apr 2019 19:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355116;
        bh=XIx9ARAKjIZ9JLOSw4XBCYpzVv7FyVXP5tEeOMQhOMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7NMQEjUh7BYYeyTTrnk4xNKfDEMWo2Tq3NMI0Ldl8DHzukvBhmiaTeZZuVcjcgXN
         H+XEdOnU4DyK4GMoJKo2jSr5oYvnQEYCIcBkjBEi4tcUpHGhpmLByPRpdi9D3BKb+1
         ujRe1FKyBTY55buQ5ylXUQnVtPz54ZxAed9PTmt8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        Jiri Slaby <jslaby@suse.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 009/101] kcm: switch order of device registration to fix a crash
Date:   Mon, 15 Apr 2019 20:58:07 +0200
Message-Id: <20190415183740.861754206@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3c446e6f96997f2a95bf0037ef463802162d2323 ]

When kcm is loaded while many processes try to create a KCM socket, a
crash occurs:
 BUG: unable to handle kernel NULL pointer dereference at 000000000000000e
 IP: mutex_lock+0x27/0x40 kernel/locking/mutex.c:240
 PGD 8000000016ef2067 P4D 8000000016ef2067 PUD 3d6e9067 PMD 0
 Oops: 0002 [#1] SMP KASAN PTI
 CPU: 0 PID: 7005 Comm: syz-executor.5 Not tainted 4.12.14-396-default #1 SLE15-SP1 (unreleased)
 RIP: 0010:mutex_lock+0x27/0x40 kernel/locking/mutex.c:240
 RSP: 0018:ffff88000d487a00 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 000000000000000e RCX: 1ffff100082b0719
 ...
 CR2: 000000000000000e CR3: 000000004b1bc003 CR4: 0000000000060ef0
 Call Trace:
  kcm_create+0x600/0xbf0 [kcm]
  __sock_create+0x324/0x750 net/socket.c:1272
 ...

This is due to race between sock_create and unfinished
register_pernet_device. kcm_create tries to do "net_generic(net,
kcm_net_id)". but kcm_net_id is not initialized yet.

So switch the order of the two to close the race.

This can be reproduced with mutiple processes doing socket(PF_KCM, ...)
and one process doing module removal.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/kcm/kcmsock.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 571d824e4e24..b919db02c7f9 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -2054,14 +2054,14 @@ static int __init kcm_init(void)
 	if (err)
 		goto fail;
 
-	err = sock_register(&kcm_family_ops);
-	if (err)
-		goto sock_register_fail;
-
 	err = register_pernet_device(&kcm_net_ops);
 	if (err)
 		goto net_ops_fail;
 
+	err = sock_register(&kcm_family_ops);
+	if (err)
+		goto sock_register_fail;
+
 	err = kcm_proc_init();
 	if (err)
 		goto proc_init_fail;
@@ -2069,12 +2069,12 @@ static int __init kcm_init(void)
 	return 0;
 
 proc_init_fail:
-	unregister_pernet_device(&kcm_net_ops);
-
-net_ops_fail:
 	sock_unregister(PF_KCM);
 
 sock_register_fail:
+	unregister_pernet_device(&kcm_net_ops);
+
+net_ops_fail:
 	proto_unregister(&kcm_proto);
 
 fail:
@@ -2090,8 +2090,8 @@ static int __init kcm_init(void)
 static void __exit kcm_exit(void)
 {
 	kcm_proc_exit();
-	unregister_pernet_device(&kcm_net_ops);
 	sock_unregister(PF_KCM);
+	unregister_pernet_device(&kcm_net_ops);
 	proto_unregister(&kcm_proto);
 	destroy_workqueue(kcm_wq);
 
-- 
2.19.1



