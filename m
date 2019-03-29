Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1301C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AF6206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfC2LTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:19:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:35780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728689AbfC2LTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:19:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D46F4AC44;
        Fri, 29 Mar 2019 11:19:47 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH] kcm: switch order of device registration to fix a crash
Date:   Fri, 29 Mar 2019 12:19:46 +0100
Message-Id: <20190329111946.19061-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 net/kcm/kcmsock.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index c5c5ab6c5a1c..44fdc641710d 100644
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
2.21.0

