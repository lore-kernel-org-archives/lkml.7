Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D392C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2211D21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254471;
	bh=74R3t0TU8cTYaLbO3Kk7y4e+sSvrCgw4Xg+xcbW1MPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=190FVFktSxMEEvgcG9Uit4YEL/cOKZPYJluDb+2QCfXJBaxVBygyFAns0KKZbFZ/M
	 ++5yKggv5NYg2IWIAVED3JOV5Ao9LCHH+fX8aKnUrCTUaPKK5+mfnS50TsW3ZpaCP/
	 WKyvJLzm11kvUUdjD+zOln90Kmz8dQI+1lDHwpLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbfCVLe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730405AbfCVLeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:34:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2FBF2183E;
        Fri, 22 Mar 2019 11:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254461;
        bh=74R3t0TU8cTYaLbO3Kk7y4e+sSvrCgw4Xg+xcbW1MPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSDxxwuZicnjfjdk6H4P0zkXMAp4SN/tlrQw2+zsmNkORVa8a6NmU5urI+/ps1VUT
         FO7uzfYm3+lB94vWbK/vjlIIRcm4CgZyoAcLJWcAltZGNCybOPXRIWWFIRYPVIIuCp
         xcMOcMe8q9bVcGmahpK5yEdCXFOvj6QalDEd5sFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Arvid Brodin <arvid.brodin@alten.se>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 143/230] net/hsr: fix possible crash in add_timer()
Date:   Fri, 22 Mar 2019 12:14:41 +0100
Message-Id: <20190322111246.684080249@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 1e027960edfaa6a43f9ca31081729b716598112b ]

syzbot found another add_timer() issue, this time in net/hsr [1]

Let's use mod_timer() which is safe.

[1]
kernel BUG at kernel/time/timer.c:1136!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 15909 Comm: syz-executor.3 Not tainted 5.0.0+ #97
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
kobject: 'loop2' (00000000f5629718): kobject_uevent_env
RIP: 0010:add_timer kernel/time/timer.c:1136 [inline]
RIP: 0010:add_timer+0x654/0xbe0 kernel/time/timer.c:1134
Code: 0f 94 c5 31 ff 44 89 ee e8 09 61 0f 00 45 84 ed 0f 84 77 fd ff ff e8 bb 5f 0f 00 e8 07 10 a0 ff e9 68 fd ff ff e8 ac 5f 0f 00 <0f> 0b e8 a5 5f 0f 00 0f 0b e8 9e 5f 0f 00 4c 89 b5 58 ff ff ff e9
RSP: 0018:ffff8880656eeca0 EFLAGS: 00010246
kobject: 'loop2' (00000000f5629718): fill_kobj_path: path = '/devices/virtual/block/loop2'
RAX: 0000000000040000 RBX: 1ffff1100caddd9a RCX: ffffc9000c436000
RDX: 0000000000040000 RSI: ffffffff816056c4 RDI: ffff88806a2f6cc8
RBP: ffff8880656eed58 R08: ffff888067f4a300 R09: ffff888067f4abc8
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88806a2f6cc0
R13: dffffc0000000000 R14: 0000000000000001 R15: ffff8880656eed30
FS:  00007fc2019bf700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000738000 CR3: 0000000067e8e000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 hsr_check_announce net/hsr/hsr_device.c:99 [inline]
 hsr_check_carrier_and_operstate+0x567/0x6f0 net/hsr/hsr_device.c:120
 hsr_netdev_notify+0x297/0xa00 net/hsr/hsr_main.c:51
 notifier_call_chain+0xc7/0x240 kernel/notifier.c:93
 __raw_notifier_call_chain kernel/notifier.c:394 [inline]
 raw_notifier_call_chain+0x2e/0x40 kernel/notifier.c:401
 call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1739
 call_netdevice_notifiers_extack net/core/dev.c:1751 [inline]
 call_netdevice_notifiers net/core/dev.c:1765 [inline]
 dev_open net/core/dev.c:1436 [inline]
 dev_open+0x143/0x160 net/core/dev.c:1424
 team_port_add drivers/net/team/team.c:1203 [inline]
 team_add_slave+0xa07/0x15d0 drivers/net/team/team.c:1933
 do_set_master net/core/rtnetlink.c:2358 [inline]
 do_set_master+0x1d4/0x230 net/core/rtnetlink.c:2332
 do_setlink+0x966/0x3510 net/core/rtnetlink.c:2493
 rtnl_setlink+0x271/0x3b0 net/core/rtnetlink.c:2747
 rtnetlink_rcv_msg+0x465/0xb00 net/core/rtnetlink.c:5192
 netlink_rcv_skb+0x17a/0x460 net/netlink/af_netlink.c:2485
 rtnetlink_rcv+0x1d/0x30 net/core/rtnetlink.c:5210
 netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
 netlink_unicast+0x536/0x720 net/netlink/af_netlink.c:1336
 netlink_sendmsg+0x8ae/0xd70 net/netlink/af_netlink.c:1925
 sock_sendmsg_nosec net/socket.c:622 [inline]
 sock_sendmsg+0xdd/0x130 net/socket.c:632
 sock_write_iter+0x27c/0x3e0 net/socket.c:923
 call_write_iter include/linux/fs.h:1869 [inline]
 do_iter_readv_writev+0x5e0/0x8e0 fs/read_write.c:680
 do_iter_write fs/read_write.c:956 [inline]
 do_iter_write+0x184/0x610 fs/read_write.c:937
 vfs_writev+0x1b3/0x2f0 fs/read_write.c:1001
 do_writev+0xf6/0x290 fs/read_write.c:1036
 __do_sys_writev fs/read_write.c:1109 [inline]
 __se_sys_writev fs/read_write.c:1106 [inline]
 __x64_sys_writev+0x75/0xb0 fs/read_write.c:1106
 do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457f29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc2019bec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457f29
RDX: 0000000000000001 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc2019bf6d4
R13: 00000000004c4a60 R14: 00000000004dd218 R15: 00000000ffffffff

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Arvid Brodin <arvid.brodin@alten.se>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/hsr/hsr_device.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -93,9 +93,8 @@ static void hsr_check_announce(struct ne
 	if ((hsr_dev->operstate == IF_OPER_UP) && (old_operstate != IF_OPER_UP)) {
 		/* Went up */
 		hsr->announce_count = 0;
-		hsr->announce_timer.expires = jiffies +
-				msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL);
-		add_timer(&hsr->announce_timer);
+		mod_timer(&hsr->announce_timer,
+			  jiffies + msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL));
 	}
 
 	if ((hsr_dev->operstate != IF_OPER_UP) && (old_operstate == IF_OPER_UP))
@@ -323,6 +322,7 @@ static void hsr_announce(unsigned long d
 {
 	struct hsr_priv *hsr;
 	struct hsr_port *master;
+	unsigned long interval;
 
 	hsr = (struct hsr_priv *) data;
 
@@ -337,14 +337,12 @@ static void hsr_announce(unsigned long d
 	}
 
 	if (hsr->announce_count < 3)
-		hsr->announce_timer.expires = jiffies +
-				msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL);
+		interval = msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL);
 	else
-		hsr->announce_timer.expires = jiffies +
-				msecs_to_jiffies(HSR_LIFE_CHECK_INTERVAL);
+		interval = msecs_to_jiffies(HSR_LIFE_CHECK_INTERVAL);
 
 	if (is_admin_up(master->dev))
-		add_timer(&hsr->announce_timer);
+		mod_timer(&hsr->announce_timer, jiffies + interval);
 
 	rcu_read_unlock();
 }


