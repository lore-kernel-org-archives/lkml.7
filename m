Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1601C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E18217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610475;
	bh=P88Dxkkupz82aY6q0wHvuVE2QQTacFfZ2pr4lYgjPBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QbNj7UR5qaeP6OPqV9giAu8TY8Wb7gMCycamSWRqNtleECCU6jig0l4YB1AM6Omni
	 RD7jWPY1/h9KMZOtP8UiwHEJXxL98w5dV+VqnUYEjf/MkBJixjCTNW4nHDEuq239SZ
	 vOt+ZUnOrjcAX4CYZASNE2P63jSeXs3GLs65hdSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390519AbfDRSBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390500AbfDRSBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:01:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3711217FA;
        Thu, 18 Apr 2019 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610471;
        bh=P88Dxkkupz82aY6q0wHvuVE2QQTacFfZ2pr4lYgjPBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1rcvNWjv2o2M37NTDkZvPvjSrrtkeCoufw6uWD6Ci+ODiSnDC9ULEkW9Csj3F48W
         U5C6v/A9pDwbUwkeN55Qg61YLr5YhlUP46uUQ8ILkneN5oFGycOLWhtrUHg0BwpTtN
         YlrOcCZnO2OhhHgFY81bDMeL1nBunewwc7fm3n74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 074/110] netfilter: nf_flow_table: remove flowtable hook flush routine in netns exit routine
Date:   Thu, 18 Apr 2019 19:57:03 +0200
Message-Id: <20190418160445.258212114@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b7f1a16d29b2e28d3dcbb070511bd703e306281b ]

When device is unregistered, flowtable flush routine is called
by notifier_call(nf_tables_flowtable_event). and exit callback of
nftables pernet_operation(nf_tables_exit_net) also has flowtable flush
routine. but when network namespace is destroyed, both notifier_call
and pernet_operation are called. hence flowtable flush routine in
pernet_operation is unnecessary.

test commands:
   %ip netns add vm1
   %ip netns exec vm1 nft add table ip filter
   %ip netns exec vm1 nft add flowtable ip filter w \
	{ hook ingress priority 0\; devices = { lo }\; }
   %ip netns del vm1

splat looks like:
[  265.187019] WARNING: CPU: 0 PID: 87 at net/netfilter/core.c:309 nf_hook_entry_head+0xc7/0xf0
[  265.187112] Modules linked in: nf_flow_table_ipv4 nf_flow_table nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink ip_tables x_tables
[  265.187390] CPU: 0 PID: 87 Comm: kworker/u4:2 Not tainted 4.19.0-rc3+ #5
[  265.187453] Workqueue: netns cleanup_net
[  265.187514] RIP: 0010:nf_hook_entry_head+0xc7/0xf0
[  265.187546] Code: 8d 81 68 03 00 00 5b c3 89 d0 83 fa 04 48 8d 84 c7 e8 11 00 00 76 81 0f 0b 31 c0 e9 78 ff ff ff 0f 0b 48 83 c4 08 31 c0 5b c3 <0f> 0b 31 c0 e9 65 ff ff ff 0f 0b 31 c0 e9 5c ff ff ff 48 89 0c 24
[  265.187573] RSP: 0018:ffff88011546f098 EFLAGS: 00010246
[  265.187624] RAX: ffffffff8d90e135 RBX: 1ffff10022a8de1c RCX: 0000000000000000
[  265.187645] RDX: 0000000000000000 RSI: 0000000000000005 RDI: ffff880116298040
[  265.187645] RBP: ffff88010ea4c1a8 R08: 0000000000000000 R09: 0000000000000000
[  265.187645] R10: ffff88011546f1d8 R11: ffffed0022c532c1 R12: ffff88010ea4c1d0
[  265.187645] R13: 0000000000000005 R14: dffffc0000000000 R15: ffff88010ea4c1c4
[  265.187645] FS:  0000000000000000(0000) GS:ffff88011b200000(0000) knlGS:0000000000000000
[  265.187645] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  265.187645] CR2: 00007fdfb8d00000 CR3: 0000000057a16000 CR4: 00000000001006f0
[  265.187645] Call Trace:
[  265.187645]  __nf_unregister_net_hook+0xca/0x5d0
[  265.187645]  ? nf_hook_entries_free.part.3+0x80/0x80
[  265.187645]  ? save_trace+0x300/0x300
[  265.187645]  nf_unregister_net_hooks+0x2e/0x40
[  265.187645]  nf_tables_exit_net+0x479/0x1340 [nf_tables]
[  265.187645]  ? find_held_lock+0x39/0x1c0
[  265.187645]  ? nf_tables_abort+0x30/0x30 [nf_tables]
[  265.187645]  ? inet_frag_destroy_rcu+0xd0/0xd0
[  265.187645]  ? trace_hardirqs_on+0x93/0x210
[  265.187645]  ? __bpf_trace_preemptirq_template+0x10/0x10
[  265.187645]  ? inet_frag_destroy_rcu+0xd0/0xd0
[  265.187645]  ? inet_frag_destroy_rcu+0xd0/0xd0
[  265.187645]  ? __mutex_unlock_slowpath+0x17f/0x740
[  265.187645]  ? wait_for_completion+0x710/0x710
[  265.187645]  ? bucket_table_free+0xb2/0x1f0
[  265.187645]  ? nested_table_free+0x130/0x130
[  265.187645]  ? __lock_is_held+0xb4/0x140
[  265.187645]  ops_exit_list.isra.10+0x94/0x140
[  265.187645]  cleanup_net+0x45b/0x900
[ ... ]

This WARNING means that hook unregisteration is failed because
all flowtables hooks are already unregistered by notifier_call.

Network namespace exit routine guarantees that all devices will be
unregistered first. then, other exit callbacks of pernet_operations
are called. so that removing flowtable flush routine in exit callback of
pernet_operation(nf_tables_exit_net) doesn't make flowtable leak.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 7d424fd27025..c06393fc716d 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7203,9 +7203,6 @@ static void __nft_release_tables(struct net *net)
 
 		list_for_each_entry(chain, &table->chains, list)
 			nf_tables_unregister_hook(net, table, chain);
-		list_for_each_entry(flowtable, &table->flowtables, list)
-			nf_unregister_net_hooks(net, flowtable->ops,
-						flowtable->ops_len);
 		/* No packets are walking on these chains anymore. */
 		ctx.table = table;
 		list_for_each_entry(chain, &table->chains, list) {
-- 
2.19.1



