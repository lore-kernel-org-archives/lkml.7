Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9E5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3059E21473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138988;
	bh=IXmJjoPPjrcVBEREx7Xsb5CJscxAl6a0+DIB1uUGc6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X/0Q3HxZBue6Rs1HVmM8cZnWFfkrae2RAlr73YC8C+bKt33C1rMZM0REfzYsP7FOB
	 h/N7rhXQ8QNJZ0KOIvHYQ0yvFYV+cXzDyzARoJBDDa6X5ff8ZVnVQaI5VHVO22NZFv
	 o5cL+6YxbIl8G1H4Kis1T4xMjCF8D7a5EpTsvggU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbfDARQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730603AbfDARQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:16:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1E7420856;
        Mon,  1 Apr 2019 17:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138980;
        bh=IXmJjoPPjrcVBEREx7Xsb5CJscxAl6a0+DIB1uUGc6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WibGTrdrQgqphUCtyAqyBxlM3rUv3oQckXk+Glh14EdIll056cKFXSokKXO24Trat
         dmYrFBGzEiwsghRMuTFCirvmrKQhbWo+rvX6oI23137X78FV72cP4t9LbRGA1lOvhA
         9rrfwdFGPcnM3wJBR/c/VRm9Vu1vJiyBzHqeyzoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Hurley <john.hurley@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 029/134] net: sched: fix cleanup NULL pointer exception in act_mirr
Date:   Mon,  1 Apr 2019 19:01:05 +0200
Message-Id: <20190401170047.305233006@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Hurley <john.hurley@netronome.com>

[ Upstream commit 064c5d6881e897077639e04973de26440ee205e6 ]

A new mirred action is created by the tcf_mirred_init function. This
contains a list head struct which is inserted into a global list on
successful creation of a new action. However, after a creation, it is
still possible to error out and call the tcf_idr_release function. This,
in turn, calls the act_mirr cleanup function via __tcf_idr_release and
__tcf_action_put. This cleanup function tries to delete the list entry
which is as yet uninitialised, leading to a NULL pointer exception.

Fix this by initialising the list entry on creation of a new action.

Bug report:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
PGD 8000000840c73067 P4D 8000000840c73067 PUD 858dcc067 PMD 0
Oops: 0002 [#1] SMP PTI
CPU: 32 PID: 5636 Comm: handler194 Tainted: G           OE     5.0.0+ #186
Hardware name: Dell Inc. PowerEdge R730/0599V5, BIOS 1.3.6 06/03/2015
RIP: 0010:tcf_mirred_release+0x42/0xa7 [act_mirred]
Code: f0 90 39 c0 e8 52 04 57 c8 48 c7 c7 b8 80 39 c0 e8 94 fa d4 c7 48 8b 93 d0 00 00 00 48 8b 83 d8 00 00 00 48 c7 c7 f0 90 39 c0 <48> 89 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad de 48 89 83 d0 00
RSP: 0018:ffffac4aa059f688 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff9dcd1b214d00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff9dcd1fa165f8 RDI: ffffffffc03990f0
RBP: ffff9dccf9c7af80 R08: 0000000000000a3b R09: 0000000000000000
R10: ffff9dccfa11f420 R11: 0000000000000000 R12: 0000000000000001
R13: ffff9dcd16b433c0 R14: ffff9dcd1b214d80 R15: 0000000000000000
FS:  00007f441bfff700(0000) GS:ffff9dcd1fa00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 0000000839e64004 CR4: 00000000001606e0
Call Trace:
tcf_action_cleanup+0x59/0xca
__tcf_action_put+0x54/0x6b
__tcf_idr_release.cold.33+0x9/0x12
tcf_mirred_init.cold.20+0x22e/0x3b0 [act_mirred]
tcf_action_init_1+0x3d0/0x4c0
tcf_action_init+0x9c/0x130
tcf_exts_validate+0xab/0xc0
fl_change+0x1ca/0x982 [cls_flower]
tc_new_tfilter+0x647/0x8d0
? load_balance+0x14b/0x9e0
rtnetlink_rcv_msg+0xe3/0x370
? __switch_to_asm+0x40/0x70
? __switch_to_asm+0x34/0x70
? _cond_resched+0x15/0x30
? __kmalloc_node_track_caller+0x1d4/0x2b0
? rtnl_calcit.isra.31+0xf0/0xf0
netlink_rcv_skb+0x49/0x110
netlink_unicast+0x16f/0x210
netlink_sendmsg+0x1df/0x390
sock_sendmsg+0x36/0x40
___sys_sendmsg+0x27b/0x2c0
? futex_wake+0x80/0x140
? do_futex+0x2b9/0xac0
? ep_scan_ready_list.constprop.22+0x1f2/0x210
? ep_poll+0x7a/0x430
__sys_sendmsg+0x47/0x80
do_syscall_64+0x55/0x100
entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: 4e232818bd32 ("net: sched: act_mirred: remove dependency on rtnl lock")
Signed-off-by: John Hurley <john.hurley@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_mirred.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -159,6 +159,9 @@ static int tcf_mirred_init(struct net *n
 	}
 	m = to_mirred(*a);
 
+	if (ret == ACT_P_CREATED)
+		INIT_LIST_HEAD(&m->tcfm_list);
+
 	spin_lock_bh(&m->tcf_lock);
 	m->tcf_action = parm->action;
 	m->tcfm_eaction = parm->eaction;


